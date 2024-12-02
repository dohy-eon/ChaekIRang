import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import userinfo.UserDTO;
import userinfo.UserDAO;


@ServerEndpoint("/chat")
public class ChatServlet {
    private static Set<Session> clients = new CopyOnWriteArraySet<>();
    UserDAO ua = new UserDAO();
    UserDTO ud = new UserDTO();

    @OnOpen
    public void onOpen(Session session) {
        // 클라이언트에서 idKey를 받은 후 세션에 저장

        clients.add(session);
        System.out.println("웹소켓 연결됨: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            // JSON 파싱
            JsonObject jsonMessage = JsonParser.parseString(message).getAsJsonObject();
            String id = jsonMessage.get("id").getAsString(); // id 추출
            String textMessage = jsonMessage.get("message").getAsString(); // message 추출

            System.out.println("받은 메시지: " + textMessage);
            System.out.println("보낸 ID: " + id);

            // id로 사용자 정보 가져오기
            ud = ua.getUserInfo(id);
            if (ud == null) {
                ud = new UserDTO();
                ud.setNickname("Guest");
            }

            String sender = ud.getNickname();
            System.out.println("Nickname: " + sender);

            // 받은 메시지를 연결된 모든 클라이언트에게 전송
            for (Session client : clients) {
                try {
                    client.getBasicRemote().sendText(sender + " : " + textMessage);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        System.out.println("웹소켓 연결 종료됨: " + session.getId());
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        throwable.printStackTrace();
    }
}
