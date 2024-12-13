package Controller;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;
import com.google.gson.Gson;

import DAO.NotificationDAO;
import DTO.NotificationDTO;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idSession = (String) request.getSession().getAttribute("idSession");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (idSession != null) {
            NotificationDAO notificationDAO = new NotificationDAO();
            List<NotificationDTO> notifications = notificationDAO.getNotificationsByUserId(idSession);

            Gson gson = new Gson();
            String jsonResponse = gson.toJson(notifications);  // 알림 데이터를 JSON 배열로 변환

            response.getWriter().print(jsonResponse);  // JSON 데이터를 클라이언트에 반환
        } else {
            // 세션이 없으면 빈 JSON 배열 반환
            response.getWriter().print("[]");
        }
        
        
        
    }
}
