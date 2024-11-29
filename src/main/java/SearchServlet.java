import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import bookInfo.BookInfo;

@WebServlet("/bookSearch")
public class SearchServlet extends HttpServlet {
    private static final String API_KEY = "AIzaSyAq4XgMsdLzOoAdR4x4HlRxq-PNqfJfjKw"; // Google Books API 키
    private static final String BASE_URL = "https://www.googleapis.com/books/v1/volumes";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO DAO = new UserDAO();
        
        request.setCharacterEncoding("UTF-8");
        String query = request.getParameter("search"); // 사용자 입력값
        String url = String.format("%s?q=%s&key=%s", BASE_URL, query, API_KEY);
        
        // HTTP 요청 보내기
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        try {
            // API 응답 받기
            HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
            JsonObject jsonResponse = JsonParser.parseString(httpResponse.body()).getAsJsonObject();

            // JSON 파싱: 검색 결과 추출
            JsonArray items = jsonResponse.getAsJsonArray("items");
            ArrayList<BookInfo> bookList = new ArrayList<>();

            if (items != null) {
                for (int i = 0; i < items.size(); i++) {
                    JsonObject book = items.get(i).getAsJsonObject();
                    JsonObject volumeInfo = book.getAsJsonObject("volumeInfo");
                    JsonObject saleInfo = book.getAsJsonObject("saleInfo");

                    // 책 제목과 저자 추출
                    String title = volumeInfo.has("title") ? volumeInfo.get("title").getAsString() : "제목 없음";
                    String authors = volumeInfo.has("authors")
                            ? volumeInfo.getAsJsonArray("authors").toString()
                            : "저자 정보 없음";

                    // 이미지 링크 추출 (썸네일 이미지)
                    String img = null;
                    if (volumeInfo.has("imageLinks") && volumeInfo.getAsJsonObject("imageLinks").has("thumbnail")) {
                        img = volumeInfo.getAsJsonObject("imageLinks").get("thumbnail").getAsString();
                    }

                    // eBook 여부 추출
                    boolean isEbook = saleInfo != null && saleInfo.has("isEbook") && saleInfo.get("isEbook").getAsBoolean();

                    // 가격 정보 추출
                    int price = 0;
                    if (saleInfo != null && saleInfo.has("retailPrice") && saleInfo.getAsJsonObject("retailPrice").has("amount")) {
                        price = saleInfo.getAsJsonObject("retailPrice").get("amount").getAsInt();
                    }

                    // BookInfo 객체 생성
                    bookList.add(new BookInfo(title, authors, img, isEbook, price));
                }
            }

            // JSP로 리스트 전달
            request.setAttribute("bookList", bookList);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/searchResultPage.jsp");
            dispatcher.forward(request, response);
            
        } catch (InterruptedException | IOException e) {
            throw new ServletException("Google Books API 호출 중 오류 발생", e);
        }
    }
}
