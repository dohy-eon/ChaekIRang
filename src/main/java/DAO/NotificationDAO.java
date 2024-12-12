package DAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import DTO.NotificationDTO;
import db.JDBCUtil;

public class NotificationDAO {
    // 알림 추가 메서드
    public void addNotification(NotificationDTO notification) {
        String query = "INSERT INTO alarm (user_id, disc_id, message, alarm_created) VALUES (?, ?, ?, ?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, notification.getUserId());
            stmt.setInt(2, notification.getDiscId());
            stmt.setString(3, notification.getMessage());
            stmt.setTimestamp(4, notification.getAlarmCreated());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // user_id로 알림 가져오는 메서드
    public List<NotificationDTO> getNotificationsByUserId(String userId) {
        List<NotificationDTO> notifications = new ArrayList<>();
        String query = "SELECT alarm_id, user_id, disc_id, message, alarm_created, status " +
                "FROM alarm WHERE user_id = ? ORDER BY alarm_created DESC";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, userId);
    

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    NotificationDTO notification = new NotificationDTO();
                    notification.setAlarmId(rs.getInt("alarm_id"));
                    notification.setUserId(rs.getString("user_id"));
                    notification.setDiscId(rs.getInt("disc_id"));
                    notification.setMessage(rs.getString("message"));
                    notification.setAlarmCreated(rs.getTimestamp("alarm_created"));
                    notification.setStatus(rs.getBoolean("status"));

                    notifications.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }
}
