<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    request.setCharacterEncoding("UTF-8");
    String jdbcurl = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useSSL=false&useUnicode=true&characterEncoding=utf-8";
    String nickname = request.getParameter("nickname");
    String userId = request.getParameter("id");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    boolean isSuccess = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcurl, "root", "root");

        // 회원가입 로직
        String insertSql = "INSERT INTO user (user_id, user_pw, nickname, email, profile_img, is_admin) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);
        pstmt.setString(3, nickname);
        pstmt.setString(4, email);
        pstmt.setString(5, "0");
        pstmt.setString(6, "0");

        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            isSuccess = true;
        }
       

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.setContentType("application/json");
    response.getWriter().write("{\"isSuccess\": " + isSuccess + "}");
%>