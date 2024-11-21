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
			                <input type="text" name="username" id="login_id" placeholder="아이디" required />
		                </div>
		                <div class="loginInput">
			                <p>비밀번호</p>
			                <input type="password" name="password" id="login_password" placeholder="비밀번호" required />
		                </div>
		                <button class="submitbtn"  onclick="login(event)" type="submit">로그인</button>
		                <div class="letsjoin">회원이 아니신가요?</div>
		                <div class="returnbtn" onclick="showSignup()">--- 회원가입 하러가기 &gt;</div>
		            </form>
		        </div>
		
		        <!-- 회원가입 폼 -->
		        <div class="form-container" id="signupContainer" style="display: none;">
		            <form id="signupForm" method="post">
		                <h2>회원가입</h2>
		                <div class="signupInput">
		                	<p>닉네임</p>
		                	<input type="text" name="nickname" id="nickname" placeholder="닉네임" required />
		                </div>
		                <div class="signupInput">
		                	<p>아이디</p>
		                	<input type="text" name="id" id="id" placeholder="아이디" required />
		                	<button type="button" onclick="checkIdAvailability()">중복 확인</button>
		                </div>
		                <div class="signupInput">
		                	<p>비밀번호</p>
		                	<input type="password" name="password" id="password" placeholder="비밀번호" required />
		                </div>
		                <div class="signupInput">
		                	<p>비밀번호 확인</p>
		                	<input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호를 다시 입력해주세요" required />
		                </div>
		                <div class="signupInput">
		                	<p>이메일</p>
		                	<input type="email" name="email" id="email" placeholder="chaek@sample.com" required />
		                </div>
		                <button class="submitbtn" onclick="validateForm(event)" type="submit">회원가입</button>
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
	    
	    function validateForm(event) {
	        event.preventDefault(); // 기본 폼 제출 방지

	        
	        const password = document.getElementById('password').value.trim();
	        const confirmPassword = document.getElementById('confirmPassword').value.trim();
	        const userId = document.getElementById('id').value.trim();
	        const nickname = document.getElementById('nickname').value.trim();
	        const email = document.getElementById('email').value.trim();
	        
	        // 빈칸 검사
	        if (!nickname || !userId || !password || !confirmPassword || !email) {
	            alert("올바르게 입력해주세요.");
	            return;
	        }
	        if (password.length < 8) {
	            alert("비밀번호는 8자 이상이어야 합니다.");
	            return;
	        }
	        
	        // 비밀번호 확인
	        else if (password !== confirmPassword) {
	            alert("비밀번호가 일치하지 않습니다.");
	            return false;
	        }
	        
	        fetch('signup.jsp?id='+userId+'&password='+password+'&nickname='+nickname+'&email='+email)
	            .then((response) => response.json())
	            .then((data) => {
	                if (data.isSuccess) {
	                    alert("회원가입에 성공하였습니다!");
	                    window.location.href = 'loginSignupPage.jsp';
	                } else {
	                    alert("회원가입에 실패하였습니다. 다시 시도해주세요.");
	                }
	                
	            })
	            .catch((error) => {
	            	
	                console.error("Error:", error);
	                alert("서버 오류가 발생했습니다.");
	            });

	        return false;
	    }
	    // 로그인 
	    function login(event) {
	    	
	        event.preventDefault(); // 기본 폼 제출 방지

	        // 변수선언
	        const password = document.getElementById('login_password').value.trim();
	        const userId = document.getElementById('login_id').value.trim();
	        if (!userId || !password ) {
	            alert("올바르게 입력해주세요.");
	            return;
	        }
	        
	     	
	        
	        
	        fetch('login.jsp?id='+userId+'&password='+password)
	            .then((response) => response.json())
	            .then((data) => {
	                if (data.isSuccess) {
	                    alert("로그인에 성공하였습니다!");
	                    window.location.href = '../index.jsp';
	                } else {
	                    alert("ID나 비밀번호가 올바르지 않습니다.");
	                }
	            })
	            .catch((error) => {
	            	
	                console.error("Error:", error);
	                alert("서버 오류가 발생했습니다.");
	            });

	        return false;
	    }
	    
	 // ID 중복 확인
	    function checkIdAvailability() {
	        const userId = document.getElementById('id').value;
	        const str = /^[a-zA-Z0-9]+$/;
	        if (userId.trim() === "") {
	            alert("아이디를 입력해주세요.");
	            return;
	        }
	     	// 아이디 유효성 검사
	        if (!str.test(userId)) {
	            alert("아이디는 공백 및 특수문자를 포함할 수 없습니다.");
	            return;
	        }
	     	if(userId.length < 8) {
	     		alert("아이디는 8자 이상이어야 합니다.");
	     		return;
	     	}
	     	
	        
	        fetch("checkId.jsp?id="+userId)
	            .then((response) => response.json())
	            .then((data) => {
	                if (data.isDuplicate) {
	                    alert("이미 사용 중인 아이디입니다.");
	                } else {
	                    alert("사용 가능한 아이디입니다.");
	                }
	            })
	            .catch((error) => {
	                console.error("Error:", error);
	                alert("서버 오류가 발생했습니다.");
	            });
	    }
	    
	    
    </script>
</body>
</html>
