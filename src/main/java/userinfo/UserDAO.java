package userinfo;
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

import db.JDBCUtil;
import discussion.DiscussInfo;


public class UserDAO {
	
	public boolean userInsert(UserDTO mDTO) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into user values(?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, mDTO.getUser_id());
            pstmt.setString(2, mDTO.getUser_pw());
            pstmt.setString(3, mDTO.getEmail());
            pstmt.setString(4, mDTO.getNickname());
            pstmt.setString(5, null);
            pstmt.setString(6, "0");

            int count = pstmt.executeUpdate();

            if (count == 1) {
                flag = true;
                // 사용자 아이디로 폴더 생성
                createUserFolder(mDTO.getUser_id());
            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close( pstmt, conn);
        }
        return flag;
    }	
	// 사용자 아이디 폴더 생성 메서드
	private void createUserFolder(String userId) {
	    // 기본 폴더 경로: C 드라이브의 Book 폴더
	    String baseFolderPath = "C:\\Book";
	    File baseFolder = new File(baseFolderPath);

	    // Book 폴더가 없으면 생성
	    if (!baseFolder.exists()) {
	        if (baseFolder.mkdir()) {
	            System.out.println("Book 폴더 생성 성공: " + baseFolderPath);
	        } else {
	            System.out.println("Book 폴더 생성 실패");
	            return;
	        }
	    }

	    // 사용자 아이디 폴더 생성
	    File userFolder = new File(baseFolderPath + "\\" + userId);
	    if (!userFolder.exists()) {
	        if (userFolder.mkdir()) {
	            System.out.println("사용자 폴더 생성 성공: " + userFolder.getPath());
	        } else {
	            System.out.println("사용자 폴더 생성 실패");
	        }
	    }
		/*
		 * // 사용자 폴더 내 profile 폴더 생성 File profileFolder = new File(userFolder.getPath()
		 * + "\\profile"); if (!profileFolder.exists()) { if (profileFolder.mkdir()) {
		 * System.out.println("프로필 폴더 생성 성공: " + profileFolder.getPath()); } else {
		 * System.out.println("프로필 폴더 생성 실패"); } }
		 */
	}
	public boolean checkId(String id) { // 아이디 중복검사
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select * from user where user_id = ?";
            
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
            
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
    }

		
	
	public boolean userLogin(String id, String password) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select * from user where user_id = ? and user_pw = ?";
            
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
            if(loginCon) {
            	String userId = rs.getString("user_id");
                String nickname = rs.getString("nickname");
                String email = rs.getString("email");
                String profileImg = rs.getString("profile_img");
                
                boolean isAdmin = rs.getBoolean("is_admin");          
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
    }
	
	public void passUpdate(String id, String newPassword) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "update user set user_pw = ? where user_id = ?";
            
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, id);
            pstmt.executeUpdate();
            


        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
    }
	public void nickUpdate(String id, String newNickname) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "update user set nickname = ? where user_id = ?";
            
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, newNickname);
            pstmt.setString(2, id);
            pstmt.executeUpdate();
            


        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
    }
	
	public UserDTO getUserInfo(String id) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    UserDTO user = null;

	    try {
	        // 데이터베이스 연결
	        conn = JDBCUtil.getConnection();
	        String strQuery = "SELECT * FROM user WHERE user_id = ?";

	        pstmt = conn.prepareStatement(strQuery);
	        pstmt.setString(1, id); // ID 설정
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            // ResultSet에서 데이터 읽기
	            user = new UserDTO();
	            user.setUser_id(rs.getString("user_id"));
	            user.setUser_pw(rs.getString("user_pw")); 
	            user.setNickname(rs.getString("nickname"));
	            user.setEmail(rs.getString("email"));
	            user.setProfile_img(rs.getString("profile_img"));
	            user.setIs_admin(rs.getString("is_admin"));
	        }
	    } catch (Exception ex) {
	        System.out.println("Exception: " + ex);
	    } finally {
	        // 리소스 정리
	        JDBCUtil.close(rs, pstmt, conn);
	    }

	    return user;
	}
	
	public static boolean isValidId(String id) {
        // 아이디는 영문 대소문자와 숫자만 포함하며, 길이는 8자 이상 20자 이하
        String regex = "^[a-zA-Z0-9]+$";
        if (id == null || id.trim().isEmpty()) {
            return false; // 빈 값 또는 null은 유효하지 않음
        }
        return id.matches(regex);
    }
	public static void alert(HttpServletResponse response, String msg) { // alert 창 띄우기
	    try {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter w = response.getWriter();
			w.write("<script>alert('"+msg+"');</script>");
			w.flush();
			w.close();
	    } catch(Exception e) {
			e.printStackTrace();
	    }
	}
	public static void alertAndGo(HttpServletResponse response, String msg, String url) { // alert 창 띄우고 화면 이동
	    try {
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter w = response.getWriter();
	        w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	        w.flush();
	        w.close();
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public static void alertAndBack(HttpServletResponse response, String msg) {
	    try {
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter w = response.getWriter();
	        w.write("<script>alert('"+msg+"');history.go(-1);</script>");
	        w.flush();
	        w.close();
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}
	public List<UserDTO> getUsers(String search) {
	    List<UserDTO> usersList = new ArrayList<>();

	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(
	             "SELECT * FROM user WHERE user_id LIKE ? OR nickname LIKE ?")) {

	        pstmt.setString(1, "%" + search + "%");
	        pstmt.setString(2, "%" + search + "%");

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUser_id(rs.getString("user_id"));
	            user.setNickname(rs.getString("nickname"));
	            user.setEmail(rs.getString("email"));
	            user.setProfile_img(rs.getString("profile_img"));
	            usersList.add(user);
	            
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return usersList;
	}

	public boolean updateUserInfo(UserDTO user) {
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(
	             "UPDATE user SET nickname = ?, email = ? WHERE user_id = ?")) {
	        
	        System.out.println("User Info: " + user.getNickname() + ", " + user.getEmail() + ", " + user.getUser_id());
	        
	        pstmt.setString(1, user.getNickname());
	        pstmt.setString(2, user.getEmail());
	        pstmt.setString(3, user.getUser_id());
	        
	        int updatedRows = pstmt.executeUpdate();
	        System.out.println("업데이트 완료: " + updatedRows);
	        
	        return updatedRows > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public boolean deleteUser(String userId) {
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement("DELETE FROM user WHERE user_id = ?")) {
	    	pstmt.setString(1, userId);
	        return pstmt.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
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
	public boolean updateProfilePicture(String userId, InputStream profilePicture) {
	    String query = "UPDATE user SET profile_img = ? WHERE user_id = ?";
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setBlob(1, profilePicture);
	        pstmt.setString(2, userId);

	        int rowsUpdated = pstmt.executeUpdate();
	        
	        return rowsUpdated > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public InputStream getProfilePicture(String userId) {
	    String query = "SELECT profile_img FROM user WHERE user_id = ?";
	    try (Connection conn = JDBCUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {

	        pstmt.setString(1, userId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getBinaryStream("profile_img");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	public byte[] loadProfileImg(String userId) {
        String query = "SELECT profile_img FROM user WHERE user_id = ?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                InputStream profileImgStream = rs.getBinaryStream("profile_img");
                if (profileImgStream != null) {
                    byte[] imgData = profileImgStream.readAllBytes(); // InputStream을 바이트 배열로 변환
                    return imgData;
                }
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
        return null; // 이미지 로드 실패 시 null 반환
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

		
	



}