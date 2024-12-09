
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import db.JDBCUtil;

public class NotificationDAO {
	
	// 알림 추가 메서드
    public void addNotification(NotificationDTO notification) {
        String query = "INSERT INTO alarm (user_id, disc_id, message, alarm_created) VALUES (?, ?, ?, ?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // 알림에 대한 정보 설정
            stmt.setString(1, notification.getUserId());  // user_id
            stmt.setInt(2, notification.getDiscId());    // disc_id (채팅방 ID나 알림 관련 ID)
            stmt.setString(3, notification.getMessage()); // 메시지
            stmt.setTimestamp(4, notification.getAlarmCreated()); // 알림 시간

            // 쿼리 실행
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 알림 데이터를 user_id로 가져오는 메소드
    public List<NotificationDTO> getNotificationsByUserId(String userId) {
        List<NotificationDTO> notifications = new ArrayList<>();
        String query = "SELECT alarm_id, user_id, disc_id, message, alarm_created, status " +
                "FROM alarm WHERE user_id = ? ORDER BY alarm_created DESC";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(query);
            stmt.setString(1, userId);  // user_id 파라미터 설정

            rs = stmt.executeQuery();

            while (rs.next()) {
                NotificationDTO notification = new NotificationDTO();
                notification.setAlarmId(rs.getInt("alarm_id"));
                notification.setUserId(rs.getString("user_id"));
                notification.setDiscId(rs.getInt("disc_id"));
                notification.setMessage(rs.getString("message"));
                notification.setAlarmCreated(rs.getTimestamp("alarm_created"));
                notification.setStatus(rs.getBoolean("status"));

                notifications.add(notification);
                System.out.println("알람쳌: " + notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);  // 리소스 정리
        }

        return notifications;
    }
}