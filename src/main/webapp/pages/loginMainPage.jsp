<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/loginMainPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-로그인</title>
    <script>
    	function goToLoginPage() {
	      window.location.href = 'loginPage.jsp';
	    }
    	function goToSignUpPage() {
  	      window.location.href = 'signUpPage.jsp';
  	    }
    </script>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  
	  <div class="loginmain-page">

	      <div class="part1">
	        <img class="part1-logo" src="../img/book-open.svg" />
	        <div class="part1-title">
	          <div class="part1-title-background">
	          	<div class="part1-title-text">책이랑</div>
	          </div>
	        </div>
	        <div class="part1-subtitle">읽고, 생각하고, 공유하고</div>
	      </div>
	      
	      <div class="loginMain-btns">
		      <div class="loginbtn" onclick="goToLoginPage()">
		      	로그인
		      </div>
		      <div class="loginbtn" onclick="goToSignUpPage()">
		      	회원가입
		      </div>
	      </div>
	      
	      
	      
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>
