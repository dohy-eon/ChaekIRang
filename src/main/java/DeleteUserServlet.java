import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import userinfo.UserDAO;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSON 데이터 읽기
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        // JSON 문자열 출력 (디버깅용)
        String jsonData = sb.toString();
        System.out.println("Received JSON Data: " + jsonData);

        // JSON 파싱
        JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();
        String userId = jsonObject.get("user_id").getAsString();

        // DB 처리
        UserDAO dao = new UserDAO();
        boolean result = dao.deleteUser(userId);

        response.setContentType("application/json");
        if (result) {
            response.getWriter().write("{\"message\": \"회원이 삭제되었습니다.\"}");
        } else {
            response.getWriter().write("{\"error\": \"삭제 실패\"}");
        }
    }
}
