<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/signupSuccessPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-회원가입 성공</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  
	  <div class="signupsuccess-page">
	      <h2>회원가입 완료</h2>
	      <p>회원가입이 성공적으로 완료되었습니다.</p>
	      <p>나의 회원정보는 로그인 후 마이페이지에서 확인하실 수 있습니다.</p>
		  <a href="loginSignupPage.jsp">로그인하기</a>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>