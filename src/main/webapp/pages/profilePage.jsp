<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/profilePage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-마이페이지</title>
</head>
<%
	String nickname = (String)session.getAttribute("userNickname");
	String email = (String)session.getAttribute("userEmail");
	String profile = (String)session.getAttribute("userProfile");
	String admin = (String)session.getAttribute("userAdmin");
	String id = (String)session.getAttribute("idSession");

	if(profile.equals("0")) { // 프로필 사진 설정 안했을 경우
		profile = "../img/profile/profilepic.jpg";
	}

	
	
%>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  
	  <div class="profile-page">
	      <div class="user-info">
			<div class="user-pic">
				<!-- 프사등록을 안했을 경우에 default로 쓸 사진 설정해야 됨 -->
				<img alt="프로필사진" src="<%=profile%>">
				<div class="pic-uploadbtn">
					<img src="../img/profile/pic-upload-icon.svg">
				</div>
			</div>
			<div class="user-nickname">
				<div class="nickname"><%=nickname%></div>
				<img class="nickname-pencil" alt="수정" src="../img/profile/pencil.svg">    	
			</div>
			<div class="user-joininfo">
				<div class="user-joininfo-detail">
					<p>아이디</p>
					<p><%=idSession%></p>
				</div>
				<div class="user-joininfo-detail">
					<p>이메일</p>
					<p><%=email%></p>
				</div>
				<div class="user-passwordupdate"><a href="passwordUpdatePage.jsp">비밀번호 수정</a></div>
				<form method="post" action="<%= request.getContextPath() %>/logout">
					<button class="user-logout" type="submit">로그아웃</button>
				</form>
			</div>
	      </div>
	      <div class="user-bookchatdata">
	      	<div class="user-datalistbox">
	      		<p>나의 eBook 목록</p>
	      		<div class="user-datalist">
	      			
	      			
	      		</div>
	      	</div>
	      	<div class="user-datalistbox">
	      		<p>나의 관심 토론</p>
	      		<div class="user-datalist">
	      			<!-- 여기도 map -->
	      			<div class="user-chatroom">
	      				<div class="user-bookcover">
	      					<img alt="책커버" src="">
	      				</div>
	      				<div class="user-chatroom-text">
		      				<div class="user-chatroom-title">토론방 이름이름이름이름이름이름이름이름이름</div>
		      				<div class="user-chatroom-detail">
		      					토론방 주제설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명</div>
	    				</div>
	    				<div class="heart-button" onclick="toggleHeart(this)">
				            <img alt="하트" src="../img/profile/heart-colored-icon.svg">
				        </div>
	    			</div>
	    			<div class="user-chatroom">
	      				<div class="user-bookcover">
	      					<img alt="책커버" src="">
	      				</div>
	      				<div class="user-chatroom-text">
		      				<div class="user-chatroom-title">토론방 이름이름이름이름이름이름이름이름이름</div>
		      				<div class="user-chatroom-detail">
		      					토론방 주제설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명</div>
	    				</div>
	    				<div class="heart-button" onclick="toggleHeart(this)">
				            <img alt="하트" src="../img/profile/heart-colored-icon.svg">
				        </div>
	    			</div>
	      		</div>
	      	</div>
	      </div>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
  
  <script>
	function toggleHeart(button) { // 나중에 토글이 아니라 빨간하트 눌러서 관심토론에서 제외되면 리스트에서 삭제되도록
	    var img = button.querySelector('img');
	    if (img.src.includes('heart-icon.svg')) {
	        img.src = '../img/profile/heart-colored-icon.svg'; // 클릭 시 하트 색상 변경
	    } else {
	        img.src = '../img/profile/heart-icon.svg'; // 다시 기본 하트로 변경
	    }
	}
	
	
	document.addEventListener("DOMContentLoaded", function () {
	    fetch("/Chaek/fileList")
	        .then(response => response.json())
	        .then(data => {
	            var dataList = document.querySelector(".user-datalist");
	            dataList.innerHTML = ""; // 기존 내용 초기화

	            data.forEach(function (file) {
	                console.log(file.downloadUrl);

	                // <div class="user-ebooktitle"> 생성
	                var item = document.createElement("div");
	                item.className = "user-ebooktitle";

	                // <p>파일 이름</p> 생성
	                var fileNameElement = document.createElement("p");
	                fileNameElement.textContent = file.fileName;

	                // <a> 다운로드 링크 생성
	                var linkElement = document.createElement("a");
	                linkElement.href = "/Chaek/" + file.downloadUrl;

	                // <img> 다운로드 아이콘 생성
	                var imgElement = document.createElement("img");
	                imgElement.alt = "다운";
	                imgElement.src = "../img/profile/ebook-download-icon.svg";

	                // <a>에 <img> 추가
	                linkElement.appendChild(imgElement);

	                // <div>에 <p>와 <a> 추가
	                item.appendChild(fileNameElement);
	                item.appendChild(linkElement);

	                // 리스트에 <div> 추가
	                dataList.appendChild(item);
	            });
	        })
	        .catch(error => console.error("Error loading files:", error));
	});


  </script>
  
</body>
</html>
