import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import discussion.DiscussInfo;
import userinfo.UserDAO;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/disableFavo")
public class DisableFavo extends HttpServlet {

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      UserDAO DAO = new UserDAO();
      HttpSession session = request.getSession();
		
      request.setCharacterEncoding("UTF-8");
      
      StringBuilder sb = new StringBuilder();
      try (BufferedReader reader = request.getReader()) {
          String line;
          while ((line = reader.readLine()) != null) {
              sb.append(line);
          }
      }
      
      String jsonData = sb.toString();
      
      JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();
      String userId = jsonObject.get("userId").getAsString();
      String discId = jsonObject.get("discId").getAsString();
      
      boolean isDeleted = DAO.delFavo(userId, discId);
      
      // JSON 응답 작성
      JsonObject jsonResponse = new JsonObject();
      jsonResponse.addProperty("success", isDeleted);
      jsonResponse.addProperty("message", isDeleted ? "삭제 성공" : "삭제 실패");

      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      response.getWriter().write(jsonResponse.toString());
      
   }
}