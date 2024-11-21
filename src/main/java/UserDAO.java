import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;


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
            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close( pstmt, conn);
        }
        return flag;
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
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
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

}
