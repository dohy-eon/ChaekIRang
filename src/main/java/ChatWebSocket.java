import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import db.JDBCUtil;

@ServerEndpoint("/chat/{discId}")
public class ChatWebSocket {

    private static Map<String, Set<Session>> chatRooms = new HashMap<>();  // discId별 채팅방 관리
    private static NotificationDAO notificationDAO = new NotificationDAO(); // NotificationDAO 추가

    @OnOpen
    public void onOpen(Session session, @PathParam("discId") String discId) {
        // 해당 disc_id에 채팅방이 없으면 새로 생성
        chatRooms.putIfAbsent(discId, new HashSet<>());
        
        // 해당 채팅방에 새 세션 추가
        chatRooms.get(discId).add(session);

        System.out.println("New connection: " + session.getId() + " to chat room: " + discId);
    }

    @OnClose
    public void onClose(Session session, @PathParam("discId") String discId) {
        // 채팅방에서 해당 세션 제거
        chatRooms.get(discId).remove(session);
        
        // 채팅방을 떠난 사용자 ID
        String leavingUserId = session.getId();

        // 해당 채팅방에서 떠난 사용자에게 알림 전송
        sendNotificationToLeavingUser(discId, leavingUserId, leavingUserId + "님이 채팅방을 떠났습니다.");

        // 해당 채팅방에 더 이상 사용자가 없으면 채팅방 삭제
        if (chatRooms.get(discId).isEmpty()) {
            chatRooms.remove(discId);
        }
        
        System.out.println("Connection closed: " + session.getId() + " from chat room: " + discId);
    }

    // 채팅방을 떠난 사용자에게만 알림 전송하는 메서드
    private void sendNotificationToLeavingUser(String discId, String leavingUserId, String notificationMessage) {
        // 떠난 사용자에게만 알림 전송
        NotificationDTO notificationDTO = new NotificationDTO();
        notificationDTO.setUserId(leavingUserId);
        notificationDTO.setDiscId(Integer.parseInt(discId));
        notificationDTO.setMessage(notificationMessage);
        notificationDTO.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
        notificationDTO.setStatus(false);  // 아직 읽지 않은 상태

        // 알림을 DB에 추가
        notificationDAO.addNotification(notificationDTO);

        // 떠난 사용자에게 알림을 보내기
        try {
            // 채팅방을 떠난 사용자에게만 알림 메시지를 전송
            for (Session client : chatRooms.get(discId)) {
                if (client.getId().equals(leavingUserId)) {
                    client.getBasicRemote().sendText("알림: " + notificationMessage);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(Session session, String message, @PathParam("discId") String discId) {
        // 채팅방에 있는 모든 세션에 메시지를 전송
        for (Session s : chatRooms.get(discId)) {
            try {
                s.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 메시지를 DB에 추가
        String userId = session.getId();
        addComment(discId, userId, message);

        // 떠난 사용자에게만 알림 보내기
        sendNotificationToLeavingUser(discId, userId, message);
    }


    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }

    // 댓글 추가 메서드
    private void addComment(String discId, String userId, String commentText) {
        String query = "INSERT INTO comments (disc_id, user_id, comment_text) VALUES (?, ?, ?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, Integer.parseInt(discId));
            stmt.setString(2, userId);
            stmt.setString(3, commentText);

            stmt.executeUpdate();

            // 댓글 추가 후, 알림 생성
            System.out.println("Comment added successfully");
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 알림 전송 메서드
    private void sendNotificationToUser(String userId, String notificationMessage, int discId) {
        NotificationDTO notificationDTO = new NotificationDTO();
        notificationDTO.setUserId(userId);
        notificationDTO.setDiscId(discId);
        notificationDTO.setMessage(notificationMessage);
        notificationDTO.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
        notificationDTO.setStatus(false);  // 아직 읽지 않은 상태

        // 알림 저장
        notificationDAO.addNotification(notificationDTO);

        // 해당 유저에게 알림 전송
        for (Session client : chatRooms.get(String.valueOf(discId))) {
            if (client.getId().equals(userId)) {
                try {
                    client.getBasicRemote().sendText("새로운 알림: " + notificationMessage);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
