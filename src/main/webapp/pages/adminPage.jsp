<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/adminPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-관리자페이지</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  
	  <div class="adminPage">
    	<div class="title admin-only">관리자 전용</div>
    	<div class="title discussion-management"><a href="discussionManagement.jsp">토론 관리</a></div>
    	<div class="title member-management"><a href="userManagement.jsp">회원 관리</a></div>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>