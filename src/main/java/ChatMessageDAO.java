import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.JDBCUtil;

public class ChatMessageDAO {

    // 메시지 리스트 가져오기
    public List<ChatMessageDTO> getMessagesByDiscId(String discId) {
        List<ChatMessageDTO> messages = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String query = "SELECT user_id, nickname, comment_text, created_at FROM comments WHERE disc_id = ? ORDER BY created_at ASC";

        try {
            conn = JDBCUtil.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, discId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	ChatMessageDTO message = new ChatMessageDTO();
            	message.setUserId(rs.getString("user_id"));
                message.setNickname(rs.getString("nickname"));
                message.setCommentText(rs.getString("comment_text"));
                message.setCreatedAt(rs.getTimestamp("created_at").toString());
                messages.add(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, pstmt, conn);
        }

        return messages;
    }
}