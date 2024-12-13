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
		/*
		 * String query = "SELECT alarm_id, user_id, disc_id, message, alarm_created " +
		 * "FROM alarm WHERE user_id = ? ORDER BY alarm_created DESC";
		 */
        String query = "SELECT a.alarm_id, a.user_id, a.disc_id, a.message, a.alarm_created, d.title " +
                "FROM alarm a " +
                "JOIN discussions d ON a.disc_id = d.disc_id " +
                "WHERE a.user_id = ? " +
                "ORDER BY a.alarm_created DESC";

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
                    notification.setTitle(rs.getString("title"));
                    

                    notifications.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }
    
    
    // 접속시간 기록 메서드
    public boolean updateAccess(String userId, int discId) {
    	String query = "INSERT INTO access (user_id, disc_id) " +
                "VALUES (?, ?) " +
                "ON DUPLICATE KEY UPDATE access_time = CURRENT_TIMESTAMP";
    	 try (Connection conn = JDBCUtil.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(query)) {

                pstmt.setString(1, userId);
                pstmt.setInt(2, discId);
                pstmt.executeUpdate();
                
                return true;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
    }
    public boolean deleteAlarm(String userId, int discId) {
    	String query = "DELETE FROM alarm WHERE user_id = ? and disc_id = ?";
    	try (Connection conn = JDBCUtil.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(query)) {

               
               pstmt.setString(1, userId);
               pstmt.setInt(2, discId);

               int rowsAffected = pstmt.executeUpdate();
               if (rowsAffected > 0) {
                   System.out.println("알림 정보 업데이트 성공: " + userId);
                   return true;
               } else {
                   System.out.println("알림 정보 업데이트 실패: " + userId);
                   return false;
               }
           } catch (Exception e) {
               e.printStackTrace();
               return false;
           }
    }
    // 나간시간 기록 메서드
    public boolean updateExitTime(String userId, int discId) {
        String query = "UPDATE access SET exit_time = ? " +
                       "WHERE user_id = ? AND disc_id = ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
            pstmt.setString(2, userId);
            pstmt.setInt(3, discId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("로그아웃 시간 업데이트 성공: " + userId);
                return true;
            } else {
                System.out.println("로그아웃 시간 업데이트 실패: " + userId);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public void sendNotificationToFavoUsers(int discId, String message, String sendUser) {
        String query = "SELECT f.user_id, a.access_time, a.exit_time " +
                       "FROM favoD f " +
                       "LEFT JOIN access a ON f.user_id = a.user_id AND f.disc_id = a.disc_id " +
                       "WHERE f.disc_id = ? AND a.exit_time < NOW()" +
                       "AND f.user_id != ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, discId);
            ps.setString(2, sendUser);

            try (ResultSet rs = ps.executeQuery()) {
                List<String> favoUserIds = new ArrayList<>();
                if (rs.next()) {
                    String userId = rs.getString("user_id");
                    Timestamp exitTime = rs.getTimestamp("exit_time");
                    Timestamp accessTime = rs.getTimestamp("access_time");

                    // exit_time이 알림 추가 시간보다 과거일 경우 (접속 중이 아님)
                    //if ((exitTime == null || exitTime.before(new Timestamp(System.currentTimeMillis()))) && accessTime.before(exitTime)) {
                    if (exitTime == null  || accessTime.before(exitTime)) {
                        addAlarm(discId, message, sendUser);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addAlarm(int discId, String message, String sendUser) {
        String query = "INSERT INTO alarm (user_id, disc_id, message, alarm_created) " +
                       "SELECT f.user_id, f.disc_id, ?, NOW() " +
                       "FROM favoD f " +
                       "LEFT JOIN access a ON f.user_id = a.user_id AND f.disc_id = a.disc_id " +
                       "WHERE f.disc_id = ? AND (a.access_time < a.exit_time OR a.exit_time IS NULL)" +
                       "AND f.user_id != ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, message);
            ps.setInt(2, discId);
            ps.setString(3, sendUser);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("선호 유저들에 대한 알람 추가 완료 토론 아이디 : " + discId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
