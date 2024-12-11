import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/chatHistory")
public class ChatHistory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트에서 전달된 토론방 ID 가져오기
        String discId = request.getParameter("disc_id");

        // Content-Type 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 결과를 담을 변수
        PrintWriter out = response.getWriter();

        // disc_id가 null인 경우 에러 반환
        if (discId == null || discId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"error\": \"disc_id is required\"}");
            return;
        }

        try {
            // DAO를 통해 메시지 목록 가져오기
            ChatMessageDAO dao = new ChatMessageDAO();
            List<ChatMessageDTO> messages = dao.getMessagesByDiscId(discId);

            // Gson 라이브러리를 이용해 JSON으로 변환
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(messages);

            // JSON 응답 보내기
            response.setStatus(HttpServletResponse.SC_OK);
            out.write(jsonResponse);

        } catch (Exception e) {
            // 에러 처리
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Failed to load chat history\"}");
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}
