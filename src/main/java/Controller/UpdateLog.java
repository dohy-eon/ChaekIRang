package Controller;
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


import DAO.NotificationDAO;
import DAO.UserDAO;


@WebServlet("/updateLog")
public class UpdateLog extends HttpServlet {

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  request.setCharacterEncoding("UTF-8");
      
      NotificationDAO NDAO = new NotificationDAO();
      
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
      int discIdInt = Integer.parseInt(discId);
      
      
      
      boolean isSuccess = NDAO.updateAccess(userId, discIdInt);
      
      if (isSuccess) {
    	    System.out.println("접속 기록이 성공적으로 업데이트되었습니다.");
    	} else {
    	    System.out.println("접속 기록 업데이트 중 오류가 발생했습니다.");
    	}
      
      JsonObject responseJson = new JsonObject();
      responseJson.addProperty("isSuccess", isSuccess);

      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      response.getWriter().write(responseJson.toString());
      
      
   }
}