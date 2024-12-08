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
            //String profileImg = jsonMessage.get("profileImg").getAsString();

            System.out.println("받은 메시지: " + textMessage);
            System.out.println("보낸 ID: " + id);
            //System.out.println("받은 프로필 이미지 : "+profileImg);

            // id로 사용자 정보 가져오기
            ud = ua.getUserInfo(id);
            if (ud == null) {
                ud = new UserDTO();
                ud.setNickname("Guest");
            }

            String sender = ud.getNickname();
            System.out.println("Nickname: " + sender);
            /////////////////////////////////////////////////////////
         // JSON 형태로 메시지 구성
            JsonObject responseMessage = new JsonObject();
            //responseMessage.addProperty("profileImg", profileImg);
            responseMessage.addProperty("sender", sender);
            responseMessage.addProperty("message", textMessage);
            //////////////////////////////////////////////////////////
            
            
            // 받은 메시지를 연결된 모든 클라이언트에게 전송
            for (Session client : clients) {
                try {
                    //client.getBasicRemote().sendText(profileImg+sender + " : " + textMessage);
                	client.getBasicRemote().sendText(responseMessage.toString());
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
