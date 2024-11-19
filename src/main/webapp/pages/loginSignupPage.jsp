<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/loginSignupPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑</title>
</head>
<body>
	<div class="div-wrapper">
    	<div class="div">
	  		<%@ include file="../modules/header.jsp" %>
	  

		    <div class="login-page" id="container">
		
		        <div class="logo">
		       	  <img class="part1-logo" src="../img/book-open.svg" />
		          <div class="part1-title">
		            <div class="part1-title-background">
		              <div class="part1-title-text">책이랑</div>
		            </div>
		          </div>
		        <div class="part1-subtitle">읽고, 생각하고, 공유하고</div>
		        </div>
		
		        <!-- 로그인 폼 -->
		        <div class="form-container" id="loginContainer">
		            <form method="post" action="/login">
		                <h2>로그인</h2>
		                <div class="loginInput">
			                <p>아이디</p>
			                <input type="text" name="username" placeholder="아이디" required />
		                </div>
		                <div class="loginInput">
			                <p>비밀번호</p>
			                <input type="password" name="password" placeholder="비밀번호" required />
		                </div>
		                <button class="submitbtn" type="submit">로그인</button>
		                <div class="letsjoin">회원이 아니신가요?</div>
		                <div class="returnbtn" onclick="showSignup()">--- 회원가입 하러가기 &gt;</div>
		            </form>
		        </div>
		
		        <!-- 회원가입 폼 -->
		        <div class="form-container" id="signupContainer" style="display: none;">
		            <form method="post" action="/signup">
		                <h2>회원가입</h2>
		                <div class="signupInput">
		                	<p>닉네임</p>
		                	<input type="text" name="nickname" placeholder="닉네임" required />
		                </div>
		                <div class="signupInput">
		                	<p>아이디</p>
		                	<input type="text" name="id" placeholder="아이디" required />
		                </div>
		                <div class="signupInput">
		                	<p>비밀번호</p>
		                	<input type="password" name="password" placeholder="비밀번호" required />
		                </div>
		                <div class="signupInput">
		                	<p>비밀번호 확인</p>
		                	<input type="password" name="password" placeholder="비밀번호를 다시 입력해주세요" required />
		                </div>
		                <div class="signupInput">
		                	<p>이메일</p>
		                	<input type="email" name="email" placeholder="chaek@sample.com" required />
		                </div>
		                <button class="submitbtn" type="submit">회원가입</button>
		                <div class="returnbtn" onclick="showLogin()">&lt; 로그인으로 돌아가기</div>
		            </form>
		        </div>
		    </div>
		    
		    <%@ include file="../modules/footer.jsp" %>
		</div>
	  </div>

    <script>
	 	// 애니메이션 전환 로직
	    const container = document.getElementById('container');
	    const loginContainer = document.getElementById('loginContainer');
	    const signupContainer = document.getElementById('signupContainer');
	
	    function showSignup() {
	        container.classList.add('signup');
	        setTimeout(() => {
	            loginContainer.style.display = 'none';
	            signupContainer.style.display = 'flex';
	        }, 600); // 애니메이션 지속 시간
	    }
	
	    function showLogin() {
	        container.classList.remove('signup');
	        setTimeout(() => {
	            signupContainer.style.display = 'none';
	            loginContainer.style.display = 'flex';
	        }, 600); // 애니메이션 지속 시간
	    }
    </script>
</body>
</html>
