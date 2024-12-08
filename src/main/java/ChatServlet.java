import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import db.JDBCUtil;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@ServerEndpoint("/chat")
public class ChatServlet {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
    private static Map<String, Integer> userDiscMap = new HashMap<>();  // 사용자와 채팅방 ID 매핑
    private static NotificationDAO notificationDAO = new NotificationDAO();

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        String userId = session.getId();
        userDiscMap.put(userId, null);  // 초기 채팅방은 null
    }

    @OnClose
    public void onClose(Session session) {
        String userId = session.getId();
        clients.remove(session);

        // 채팅방을 나간 유저에게 알림 추가
        Integer discId = userDiscMap.get(userId);
        if (discId != null) {
            String notificationMessage = "사용자가 채팅방을 나갔습니다.";
            sendNotificationToUser(userId, notificationMessage, discId);
        }
    }

    @OnMessage
    public void onMessage(Session session, String message) {
        String userId = session.getId();
        Integer discId = userDiscMap.get(userId);

        if (discId != null) {
            // 메시지를 comments 테이블에 저장
            addComment(discId, userId, message);

            // 알림 생성
            String notificationMessage = "새로운 메시지가 도착했습니다.";
            sendNotificationToUser(userId, notificationMessage, discId);
        }

        // 모든 유저에게 메시지 전송이왜안되냐고지나ㅉ
        broadcastMessage(message);
    }

    private void broadcastMessage(String message) {
        // 모든 유저에게 메시지 전송
        for (Session client : clients) {
            try {
                client.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void sendNotificationToUser(String userId, String notification, int discId) {
        NotificationDTO notificationDTO = new NotificationDTO();
        notificationDTO.setUserId(userId);
        notificationDTO.setDiscId(discId);
        notificationDTO.setMessage(notification);
        notificationDTO.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
        notificationDTO.setStatus(false);  // 아직 읽지 않은 상태

        // 알림 저장
        notificationDAO.addNotification(notificationDTO);

        // 해당 유저에게 알림 전송
        for (Session client : clients) {
            if (client.getId().equals(userId)) {
                try {
                    client.getBasicRemote().sendText("새로운 알림: " + notification);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // 댓글 추가 메서드
    public void addComment(int discId, String userId, String commentText) {
        String query = "INSERT INTO comments (disc_id, comment_text) VALUES (?, ?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, discId);
            stmt.setString(2, commentText);

            // 댓글 추가 후, 알림 생성
            stmt.executeUpdate();

            // 알림 전송
            String notificationMessage = "새로운 댓글이 추가되었습니다.";
            sendNotificationToUser(userId, notificationMessage, discId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
