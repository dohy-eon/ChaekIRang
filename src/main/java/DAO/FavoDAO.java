package DAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DTO.DiscussInfo;
import DTO.UserDTO;
import db.JDBCUtil;

public class FavoDAO {

	public List<DiscussInfo> getFavoDetails(String userId) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<DiscussInfo> discussionDetails = new ArrayList<>(); // 결과를 저장할 리스트

	    try {
	        // 데이터베이스 연결
	        conn = JDBCUtil.getConnection();
	        

	        // favoD와 discussions를 조인하여 데이터 조회
	        String strQuery = 
	            "SELECT d.disc_id, d.title, d.book_name, d.book_image, d.description, d.genre, d.time_created, d.comment " +
	            "FROM favoD f " +
	            "JOIN discussions d ON f.disc_id = d.disc_id " +
	            "WHERE f.user_id = ?"; 
	        pstmt = conn.prepareStatement(strQuery);
	        pstmt.setString(1, userId);
	        rs = pstmt.executeQuery();

	        // 결과 처리
	        while (rs.next()) {
	            // DiscussInfo 객체 생성
	            DiscussInfo discussInfo = new DiscussInfo(
	                rs.getString("disc_id"),  // 만약 'disc_id'를 DiscussInfo 클래스에 추가했다면
	                rs.getString("title"),
	                rs.getString("book_name"),
	                rs.getString("book_image"),
	                rs.getString("description"),
	                rs.getString("genre"),
	                rs.getString("time_created"),
	                rs.getInt("comment")
	            );

	            discussionDetails.add(discussInfo); // 리스트에 DiscussInfo 객체 추가
	        }


	    } catch (Exception ex) {
	        System.out.println("Exception: " + ex.getMessage());
	        ex.printStackTrace();
	    } finally {
	        // 리소스 정리
	        JDBCUtil.close(rs, pstmt, conn);
	    }

	    return discussionDetails; // DiscussInfo 리스트 반환
	}
	public boolean addFavo(String userId, String discId) {
	    String query = "INSERT INTO favoD (user_id, disc_id) VALUES (?, ?)";
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, userId);
	        pstmt.setString(2, discId);
	        int insertState = pstmt.executeUpdate();

	        return insertState > 0;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public boolean delFavo(String userId, String discId) {
		String query = "delete from favoD where user_id = ? and disc_id = ?";
		try (Connection conn = JDBCUtil.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(query)) {

	            pstmt.setString(1, userId);
	            pstmt.setString(2, discId);
	            int delState = pstmt.executeUpdate();
		        
		        return delState > 0;
	            
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
		
	}
	public boolean checkFavoState(String userId, String discId) {
	    String query = "SELECT COUNT(*) FROM favoD WHERE user_id = ? AND disc_id = ?";
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, userId);
	        pstmt.setString(2, discId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}