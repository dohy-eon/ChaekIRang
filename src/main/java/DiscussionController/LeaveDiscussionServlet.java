package DiscussionController;
import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NotificationDAO;
import DTO.NotificationDTO;

@WebServlet("/LeaveDiscussionServlet")
public class LeaveDiscussionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = (String) request.getSession().getAttribute("userId");
        int discId = Integer.parseInt(request.getParameter("discId"));
        request.getSession().invalidate();
        
        NotificationDTO notification = new NotificationDTO();
        notification.setUserId(userId);
        notification.setDiscId(discId);
        notification.setMessage(userId + "토론방 퇴장");
        notification.setAlarmCreated(new Timestamp(System.currentTimeMillis()));

        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.addNotification(notification);
        
    }
}
