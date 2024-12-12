package Controller;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import DAO.UserDAO;
import DTO.BookInfo;

@WebServlet("/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {
    private static final String API_KEY = "AIzaSyAq4XgMsdLzOoAdR4x4HlRxq-PNqfJfjKw"; // Google Books API 키
    private static final String BASE_URL = "https://www.googleapis.com/books/v1/volumes";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String query = request.getParameter("search");
        String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8.toString());
        String url = String.format("%s?q=%s&key=%s", BASE_URL, encodedQuery, API_KEY);
        
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        try {
            HttpResponse<String> httpResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
            JsonObject jsonResponse = JsonParser.parseString(httpResponse.body()).getAsJsonObject();
            
            JsonArray items = jsonResponse.getAsJsonArray("items");
            JsonArray bookList = new JsonArray();

            if (items != null) {
                for (int i = 0; i < items.size(); i++) {
                    JsonObject book = items.get(i).getAsJsonObject();
                    JsonObject volumeInfo = book.getAsJsonObject("volumeInfo");
                    JsonObject saleInfo = book.getAsJsonObject("saleInfo");
                    
                    if (saleInfo != null && saleInfo.has("saleability") && "FOR_SALE".equals(saleInfo.get("saleability").getAsString())) {
                        JsonObject bookInfo = new JsonObject();
                        bookInfo.addProperty("title", volumeInfo.has("title") ? volumeInfo.get("title").getAsString() : "제목 없음");
                        bookInfo.addProperty("authors", volumeInfo.has("authors") ? volumeInfo.getAsJsonArray("authors").toString() : "저자 정보 없음");
                        bookInfo.addProperty("img", volumeInfo.has("imageLinks") && volumeInfo.getAsJsonObject("imageLinks").has("thumbnail")
                                ? volumeInfo.getAsJsonObject("imageLinks").get("thumbnail").getAsString() : null);
                        bookInfo.addProperty("isEbook", saleInfo.has("isEbook") && saleInfo.get("isEbook").getAsBoolean());
                        
                        bookList.add(bookInfo);
                    }
                }
            }
            
            // JSON 결과 반환
            response.getWriter().write(bookList.toString());
            
        } catch (InterruptedException | IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Google Books API 호출 중 오류 발생");
            response.getWriter().write(errorResponse.toString());
        }
    }
}
