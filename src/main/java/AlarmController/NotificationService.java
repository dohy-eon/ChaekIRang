package AlarmController;
import java.sql.*;
import java.util.*;

import javax.servlet.annotation.WebServlet;

import db.JDBCUtil;

@WebServlet("/NotificationService")
public class NotificationService {
    private static Map<Integer, List<String>> leftUsers = new HashMap<>();

    // 나간 사용자 추가
    public void addLeftUser(int discId, String userId) {
        leftUsers.computeIfAbsent(discId, k -> new ArrayList<>()).add(userId);
    }

    // 나간 사용자 가져오기
    public List<String> getLeftUsers(int discId) {
        return leftUsers.getOrDefault(discId, new ArrayList<>());
    }
    public void createAlarm(String userId, int discId, String message) {
        // disc_id가 discussions 테이블에 존재하는지 확인
        if (!isValidDiscId(discId)) {
            System.out.println("Invalid disc_id: " + discId);
            return;  // 유효하지 않은 disc_id면 알림을 생성하지 않음
        }

        String query = "INSERT INTO alarm (user_id, disc_id, message, alarm_created, status) VALUES (?, ?, ?, NOW(), FALSE)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, userId);
            stmt.setInt(2, discId);
            stmt.setString(3, message);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }    
    }

    // disc_id가 discussions 테이블에 존재하는지 확인하는 건데 왜안되냐진짜정신병걸리겟네
    private boolean isValidDiscId(int discId) {
        String query = "SELECT COUNT(*) FROM discussions WHERE disc_id = ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, discId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;  // 존재하면 true, 아니면 false
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;  // 예외 발생 시 false 반환
    }

}
