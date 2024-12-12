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

public class DiscDAO {
	
	public List<DiscussInfo> getDisc() {
	    List<DiscussInfo> discussionDetails = new ArrayList<>(); // 결과를 저장할 리스트

	    String query = "SELECT disc_id, title, book_name, book_image, description, genre, time_created, comment FROM discussions ORDER BY time_created ASC"; // time_created로 오름차순 정렬

	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query);
	         ResultSet rs = pstmt.executeQuery()) {

	        // 결과 처리
	        while (rs.next()) {
	            // DiscussInfo 객체 생성
	            DiscussInfo discussInfo = new DiscussInfo(
	                rs.getString("disc_id"),  
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
	        System.out.println("예외 발생: " + ex.getMessage());
	        ex.printStackTrace();
	    }

	    return discussionDetails; // DiscussInfo 리스트 반환
	}
	
	public List<DiscussInfo> getPopDisc() {
	    List<DiscussInfo> discussionDetails = new ArrayList<>(); // 결과를 저장할 리스트

	    String query = "SELECT disc_id, title, book_name, book_image, description, genre, time_created, comment FROM discussions ORDER BY comment DESC"; // comment로 오름차순 정렬

	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query);
	         ResultSet rs = pstmt.executeQuery()) {

	        // 결과 처리
	        while (rs.next()) {
	            // DiscussInfo 객체 생성
	            DiscussInfo discussInfo = new DiscussInfo(
	                rs.getString("disc_id"),  
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
	        System.out.println("예외 발생: " + ex.getMessage());
	        ex.printStackTrace();
	    }

	    return discussionDetails; // DiscussInfo 리스트 반환
	}
	// chat.jsp로 보내는 토론정보
		public List<DiscussInfo> getDiscById(String discId) {
		    List<DiscussInfo> discussionDetails = new ArrayList<>();
		    String query = "SELECT disc_id, title, book_name, book_image, description, genre, time_created, comment " +
		                   "FROM discussions WHERE disc_id = ?";

		    try (Connection conn = JDBCUtil.getConnection();
		         PreparedStatement pstmt = conn.prepareStatement(query)) {

		        pstmt.setString(1, discId);
		        try (ResultSet rs = pstmt.executeQuery()) {
		            while (rs.next()) {
		                DiscussInfo discussInfo = new DiscussInfo(
		                    rs.getString("disc_id"),
		                    rs.getString("title"),
		                    rs.getString("book_name"),
		                    rs.getString("book_image"),
		                    rs.getString("description"),
		                    rs.getString("genre"),
		                    rs.getString("time_created"),
		                    rs.getInt("comment")
		                );
		                discussionDetails.add(discussInfo);
		            }
		        }
		    } catch (Exception ex) {
		        System.out.println("예외 발생: " + ex.getMessage());
		        ex.printStackTrace();
		    }

		    return discussionDetails;
		}
	
}