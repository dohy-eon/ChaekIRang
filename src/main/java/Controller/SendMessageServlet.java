package Controller;
import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NotificationDAO;
import DTO.NotificationDTO;

@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = (String) request.getSession().getAttribute("userId");
        int discId = Integer.parseInt(request.getParameter("discId"));
        String message = request.getParameter("message");

        // 메시지를 DB에 저장하거나 처리하는 로직 (필요에 따라)
        
        // 알림 객체 생성
        NotificationDTO notification = new NotificationDTO();
        notification.setUserId(userId);
        notification.setDiscId(discId);
        notification.setMessage(userId + "님이 메시지를 보냈습니다: " + message);
        notification.setAlarmCreated(new Timestamp(System.currentTimeMillis()));

        // 알림을 DB에 저장
        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.addNotification(notification);
        
    }
}
