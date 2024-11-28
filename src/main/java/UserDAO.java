import java.io.File;
import java.io.PrintWriter;
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
            pstmt.setString(5, "0");
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


}
