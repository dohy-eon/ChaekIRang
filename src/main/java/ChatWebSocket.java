import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import db.JDBCUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import userinfo.UserDAO;
import userinfo.UserDTO;

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
//        sendNotificationToLeavingUser(discId, leavingUserId, leavingUserId + "님이 채팅방을 떠났습니다.");

        // 해당 채팅방에 더 이상 사용자가 없으면 채팅방 삭제
        if (chatRooms.get(discId).isEmpty()) {
            chatRooms.remove(discId);
        }
        
        System.out.println("Connection closed: " + session.getId() + " from chat room: " + discId);
    }

//    // 채팅방을 떠난 사용자에게만 알림 전송하는 메서드
//    private void sendNotificationToLeavingUser(String discId, String leavingUserId, String notificationMessage) {
//        // 떠난 사용자에게만 알림 전송
//        NotificationDTO notificationDTO = new NotificationDTO();
//        notificationDTO.setUserId(leavingUserId);
//        notificationDTO.setDiscId(Integer.parseInt(discId));
//        notificationDTO.setMessage(notificationMessage);
//        notificationDTO.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
//        notificationDTO.setStatus(false);  // 아직 읽지 않은 상태
//
//        // 알림을 DB에 추가
//        notificationDAO.addNotification(notificationDTO);
//
//        // 떠난 사용자에게 알림을 보내기
//        try {
//            // 채팅방을 떠난 사용자에게만 알림 메시지를 전송
//            for (Session client : chatRooms.get(discId)) {
//                if (client.getId().equals(leavingUserId)) {
//                    client.getBasicRemote().sendText("알림: " + notificationMessage);
//                }
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

    @OnMessage
    public void onMessage(Session session, String message, @PathParam("discId") String discId) {
        // 채팅 메시지에서 사용자 정보를 파싱
        JsonObject jsonMessage = JsonParser.parseString(message).getAsJsonObject();
        String userIdFromMessage = jsonMessage.get("id").getAsString();
        String commentText = jsonMessage.get("message").getAsString();

        // 사용자의 nickname과 profileImg, user_id를 DB에서 불러오기
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUserInfo(userIdFromMessage);  // userIdFromMessage에 해당하는 user 정보 가져오기
        
        // nickname과 profileImg, user_id 가져오기
        String nickname = user.getNickname();
        String profileImg = user.getProfile_img() != null ? user.getProfile_img() : "../img/profile/profilepic.jpg";  // 기본 이미지 설정
        String userId = user.getUser_id();
        
        // 현재 시간 구하기 (created_at)
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());

        // 메시지에 user_id, nickname, profileImg, createdAt 추가
        JsonObject responseMessage = new JsonObject();
        responseMessage.addProperty("user_id", userId);
        responseMessage.addProperty("nickname", nickname);
        responseMessage.addProperty("profileImg", profileImg);
        responseMessage.addProperty("message", commentText);
        responseMessage.addProperty("createdAt", createdAt.toString());  // created_at 추가

        // 채팅방에 있는 모든 세션에 메시지 전송
        for (Session s : chatRooms.get(discId)) {
            try {
                s.getBasicRemote().sendText(responseMessage.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // DB에 메시지 추가 (필요 시)
        addComment(discId, userIdFromMessage, commentText, createdAt, nickname, profileImg);
    }



    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }

    private void addComment(String discId, String userIdFromMessage, String commentText, Timestamp createdAt, String nickname, String profileImg) {
        String query = "INSERT INTO comments (disc_id, user_id, comment_text, created_at, nickname, profile_img) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, Integer.parseInt(discId));   // disc_id
            stmt.setString(2, userIdFromMessage);       // user_id (JSON에서 가져온 id)
            stmt.setString(3, commentText);            // comment_text (JSON에서 가져온 message)
            stmt.setTimestamp(4, createdAt);
            stmt.setString(5, nickname);             // nickname
            stmt.setString(6, profileImg);              // profile_img
            

            stmt.executeUpdate();

            System.out.println("Comment added successfully to disc_id " + discId + " for user: " + userIdFromMessage);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }




    // 알림 전송 메서드
//    private void sendNotificationToUser(String userId, String notificationMessage, int discId) {
//        NotificationDTO notificationDTO = new NotificationDTO();
//        notificationDTO.setUserId(userId);
//        notificationDTO.setDiscId(discId);
//        notificationDTO.setMessage(notificationMessage);
//        notificationDTO.setAlarmCreated(new Timestamp(System.currentTimeMillis()));
//        notificationDTO.setStatus(false);  // 아직 읽지 않은 상태
//
//        // 알림 저장
//        notificationDAO.addNotification(notificationDTO);
//
//        // 해당 유저에게 알림 전송
//        for (Session client : chatRooms.get(String.valueOf(discId))) {
//            if (client.getId().equals(userId)) {
//                try {
//                    client.getBasicRemote().sendText("새로운 알림: " + notificationMessage);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
}
