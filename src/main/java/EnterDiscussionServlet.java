import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EnterDiscussionServlet")
public class EnterDiscussionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        int discId = Integer.parseInt(request.getParameter("discId"));
        request.getSession().setAttribute("userId", userId);
        
        NotificationDTO notification = new NotificationDTO();
        notification.setUserId(userId);
        notification.setDiscId(discId);
        notification.setMessage(userId + "입장");
        notification.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
        
        // 알림 db에 보내기
        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.addNotification(notification);
    }
}
