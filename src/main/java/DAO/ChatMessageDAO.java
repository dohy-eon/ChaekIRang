package DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DTO.ChatMessageDTO;
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
    public int getComment(String discId) {
	    String query = "SELECT COUNT(*) FROM comments c JOIN discussions d ON c.disc_id = d.disc_id where d.disc_id = ?";
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        pstmt.setString(1, discId); // discId
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int count = rs.getInt(1);
	            System.out.println("조인된 레코드 갯수: " + count); // 디버깅
	            
	            String updateQuery = "UPDATE discussions SET comment = ? WHERE disc_id = ?";
	            PreparedStatement updatePstmt = conn.prepareStatement(updateQuery);
	            updatePstmt.setInt(1, count);
	            updatePstmt.setString(2, discId);
	            updatePstmt.executeUpdate();
	            return count;
	        } else {
	            
	            System.out.println("댓글이 존재하지 않는 discId 입니다 : " + discId);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return 0; // 실패시.
	}
}