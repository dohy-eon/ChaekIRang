package AlarmController;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.annotation.WebServlet;

import DAO.NotificationDAO;
import DTO.NotificationDTO;
import db.JDBCUtil;

@WebServlet("/MessageService")
public class MessageService {
    private NotificationService notificationService;

    public MessageService() {
        this.notificationService = new NotificationService();
    }

    // 메시지 저장 및 알림 처리
    public void handleNewMessage(String discId, String senderId, String message) {
        // 메시지 처리 로직
        System.out.println("채팅방 ID: " + discId + ", 보낸 사람: " + senderId + ", 메시지: " + message);
        
        // 알림 생성 + 저장
        NotificationDTO notification = new NotificationDTO();
        notification.setUserId(senderId);
        notification.setDiscId(Integer.parseInt(discId)); 
        notification.setMessage(message); 
        notification.setAlarmCreated(new Timestamp(System.currentTimeMillis())); 
        
        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.addNotification(notification); 
    }
   

    private void saveMessage(int discId, String senderId, String message) {
        String query = "INSERT INTO messages (disc_id, sender_id, message, created_at) VALUES (?, ?, ?, NOW())";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, discId);
            stmt.setString(2, senderId);
            stmt.setString(3, message);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
