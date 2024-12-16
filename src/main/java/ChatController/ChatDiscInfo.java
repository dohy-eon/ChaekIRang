package ChatController;
import java.io.IOException;
import java.util.ArrayList;  // ArrayList 임포트
import java.util.HashMap;   // HashMap 임포트
import java.util.List; 
import java.util.Collections;
import java.util.Comparator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import DAO.DiscDAO;
import DAO.UserDAO;
import DTO.DiscussInfo;


@WebServlet("/chatDiscInfo")
public class ChatDiscInfo extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    UserDAO DAO = new UserDAO();
	    DiscDAO DDAO = new DiscDAO();
	    request.setCharacterEncoding("UTF-8");
	    List<DiscussInfo> discussionDetails=null;
	    
	    String discId = request.getParameter("disc_id");
	    
	    // DAO에서 필터링
	    discussionDetails = DDAO.getDiscById(discId);
	
	    // JSON 배열 생성
	    JsonArray jsonArray = new JsonArray();
	
	    for (DiscussInfo discussInfo : discussionDetails) {
	        JsonObject jsonObject = new JsonObject();
	        jsonObject.addProperty("disc_id", discussInfo.getDisc_id());
	        jsonObject.addProperty("title", discussInfo.getTitle());
	        jsonObject.addProperty("book_name", discussInfo.getBook_name());
	        jsonObject.addProperty("book_image", discussInfo.getBook_image());
	        jsonObject.addProperty("description", discussInfo.getDescription());
	        jsonObject.addProperty("genre", discussInfo.getGenre());
	        jsonObject.addProperty("time_created", discussInfo.getTime_created());
	        jsonObject.addProperty("comment", discussInfo.getComment());
	        jsonArray.add(jsonObject);
	    }
	
	    // JSON 배열을 String으로 변환하여 응답
	    String json = jsonArray.toString();
	    response.setContentType("application/json;charset=UTF-8");
	    response.getWriter().write(json);
	}
}