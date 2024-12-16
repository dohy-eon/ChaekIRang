package AlarmController;
import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import DAO.FavoDAO;
import DAO.UserDAO;


@WebServlet("/favoState")
public class FavoState extends HttpServlet {

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      UserDAO DAO = new UserDAO();
      FavoDAO FDAO = new FavoDAO();
      
      // 요청 본문 읽기
      BufferedReader reader = request.getReader();
      StringBuilder jsonBuilder = new StringBuilder();
      String line;
      while ((line = reader.readLine()) != null) {
          jsonBuilder.append(line);
      }
      String jsonData = jsonBuilder.toString();


      // JSON 파싱
      JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();
      String userId = jsonObject.get("userId").getAsString();
      String discId = jsonObject.get("discId").getAsString();

      // 즐겨찾기 상태 확인
      boolean isFavorited = FDAO.checkFavoState(userId, discId);

      // JSON 응답 작성
      JsonObject responseJson = new JsonObject();
      responseJson.addProperty("isFavorited", isFavorited);

      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      response.getWriter().write(responseJson.toString());
   }
}