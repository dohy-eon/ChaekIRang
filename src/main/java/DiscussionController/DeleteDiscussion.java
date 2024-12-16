package DiscussionController;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import db.JDBCUtil;

@WebServlet("/DeleteDiscussion")
public class DeleteDiscussion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 본문에서 JSON 데이터 읽기
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
        }

        // JSON 파싱
        String requestBody = stringBuilder.toString();
        JsonObject jsonObject = new JsonObject();
        
        try {
            jsonObject = com.google.gson.JsonParser.parseString(requestBody).getAsJsonObject();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 JSON 요청
            return;
        }

        String discId = jsonObject.get("disc_id").getAsString();

        if (discId == null || discId.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 잘못된 요청
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = JDBCUtil.getConnection();

            // 토론 삭제 SQL
            String sql = "DELETE FROM discussions WHERE disc_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, discId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // 성공
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 토론 없음
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 서버 오류
        } finally {
            JDBCUtil.close(null, stmt, conn);
        }
    }
}
