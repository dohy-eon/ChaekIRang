import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userinfo.UserDAO;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import discussion.DiscussInfo;

@WebServlet("/dList")
public class DList extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // DAO 인스턴스 생성
        UserDAO DAO = new UserDAO();

        // 요청 인코딩 설정x
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // 세션에서 user_id 가져오기
        String userId = (String) session.getAttribute("idSession");
        if (userId == null) {
            // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
            response.sendRedirect("/Chaek/pages/loginSignupPage.jsp");
            return;
        }

        // DAO를 통해 토론 데이터 가져오기
        List<DiscussInfo> discussionDetails = DAO.getFavoDetails(userId);

        // JSON 배열 생성
        JsonArray jsonArray = new JsonArray();

        // 각 DiscussInfo 객체를 JsonObject로 변환하여 JSON 배열에 추가
        for (DiscussInfo discussInfo : discussionDetails) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("title", discussInfo.getTitle());
            jsonObject.addProperty("book_name", discussInfo.getBook_name());
            jsonObject.addProperty("book_image", discussInfo.getBook_image());
            jsonObject.addProperty("description", discussInfo.getDescription());
            jsonObject.addProperty("genre", discussInfo.getGenre());
            jsonObject.addProperty("time_created", discussInfo.getTime_created());
            jsonObject.addProperty("comment", discussInfo.getComment());
            jsonObject.addProperty("disc_id", discussInfo.getDisc_id());
            

            jsonArray.add(jsonObject); // JSON 배열에 추가
        }

        // JSON 배열을 String으로 변환하여 JSP로 전달
        String json = jsonArray.toString();
         
        
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(json);
        

    }
}