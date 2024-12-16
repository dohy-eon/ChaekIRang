package DiscussionController;
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

import DAO.UserDAO;
import DAO.ChatMessageDAO;
import DAO.DiscDAO;
import DTO.DiscussInfo;

@WebServlet("/dMainList")
public class DMainList extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // DAO 인스턴스 생성
        UserDAO DAO = new UserDAO();
        DiscDAO DDAO = new DiscDAO();
        ChatMessageDAO CDAO = new ChatMessageDAO();

        // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");


        // DAO를 통해 토론 데이터 가져오기
        List<DiscussInfo> discussionDetails = DDAO.getDisc();
        
        // 최신 순 정렬
        Collections.sort(discussionDetails, new Comparator<DiscussInfo>() {
            @Override
            public int compare(DiscussInfo d1, DiscussInfo d2) {
                return d2.getTime_created().compareTo(d1.getTime_created());
            }
        });
        

        // JSON 배열 생성
        JsonArray jsonArray = new JsonArray();

        // 각 DiscussInfo 객체를 JsonObject로 변환하여 JSON 배열에 추가
        for (DiscussInfo discussInfo : discussionDetails) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.addProperty("disc_id", discussInfo.getDisc_id());
            jsonObject.addProperty("title", discussInfo.getTitle());
            jsonObject.addProperty("book_name", discussInfo.getBook_name());
            jsonObject.addProperty("book_image", discussInfo.getBook_image());
            jsonObject.addProperty("description", discussInfo.getDescription());
            jsonObject.addProperty("genre", discussInfo.getGenre());
            jsonObject.addProperty("time_created", discussInfo.getTime_created());
            jsonObject.addProperty("comment", CDAO.getComment(discussInfo.getDisc_id()));

            jsonArray.add(jsonObject); // JSON 배열에 추가
        }

        // JSON 배열을 String으로 변환하여 JSP로 전달
        String json = jsonArray.toString();
         
        
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(json);
        

    }
}