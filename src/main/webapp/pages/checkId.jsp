<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
    String jdbcurl = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useSSL=false&useUnicode=true&characterEncoding=utf-8";
    String userId = request.getParameter("id");
    System.out.println(userId);

    boolean isDuplicate = false;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcurl, "root", "root");
        String checkSql = "SELECT * FROM user WHERE user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            isDuplicate = true; // ID가 이미 존재
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.setContentType("application/json");
    response.getWriter().write("{\"isDuplicate\": " + isDuplicate + "}");
%>
