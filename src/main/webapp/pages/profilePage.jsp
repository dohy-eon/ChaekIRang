<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="discussion.DiscussInfo" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="userinfo.UserDAO" %>
<%@ page import="java.util.Base64" %>
    

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
	String admin = (String)session.getAttribute("userAdmin");
	String id = (String)session.getAttribute("idSession");
	
	
	String imageSrc;

	
    UserDAO userDAO = new UserDAO();
	byte[] profileImgData = userDAO.loadProfileImg(id);
	
	 if (profileImgData != null) {
         imageSrc  = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profileImgData);
	 } else {
		 imageSrc = "../img/profile/profilepic.jpg";
		 
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
				    <img alt="프로필사진" src="<%=imageSrc%>">
				    <div class="pic-uploadbtn">
				        <label for="profilePic">
				            <img src="../img/profile/pic-upload-icon.svg" alt="업로드 아이콘">
				        </label>
				        <form id="uploadForm" action="/Chaek/profileUpload" method="post" enctype="multipart/form-data" style="display: none;">
				            <input type="file" name="profilePic" id="profilePic" accept="image/*">
				        </form>
				    </div>
				</div>
			<div class="user-nickname">
				<div class="nickname"><%=nickname%></div>
				<a href="nicknameUpdatePage.jsp"><img class="nickname-pencil" alt="수정" src="../img/profile/pencil.svg"></a>    	
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
	      			<!-- user-datalist -->
	      			
	      		</div>
	      	</div>
	      	<div class="user-datalistbox">
	      		<p>나의 관심 토론</p>
	      		<div class="user-datalist2">
	      			<!-- user-datalist2 -->
	    			
	      		</div>
	      	</div>
	      </div>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
  
  <script>
  
	// 관심 토론 하트 토글 - 이제 토글할 필요 없어서 테스트 후 지워도 됨
	function toggleHeart(button) {
	    var img = button.querySelector('img');
	    if (img.src.includes('heart-icon.svg')) {
	        img.src = '../img/profile/heart-colored-icon.svg'; // 클릭 시 하트 색상 변경
	    } else {
	        img.src = '../img/profile/heart-icon.svg'; // 다시 기본 하트로 변경
	    }
	}
	
	// 나의 eBook 목록
	document.addEventListener("DOMContentLoaded", function () {
	    fetch("/Chaek/fileList")
	        .then(response => response.json())
	        .then(data => {
	            var dataList = document.querySelector(".user-datalist");
	            dataList.innerHTML = ""; // 기존 내용 초기화

	            data.forEach(function (file) {
	               

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
	
	
	//나의 관심 토론
	document.addEventListener("DOMContentLoaded", function () {
	    // 서블릿을 호출하여 데이터 가져오기
	    fetch("/Chaek/dList")  // 서블릿 URL
	        .then(response => response.json())  // JSON 형식으로 응답 받기
	        .then(data => {  // 'discussionDetails' 대신 'data' 사용
	            if (Array.isArray(data)) {  // 'discussionDetails' 대신 'data'
	                var container = document.querySelector('.user-datalist2');
	                data.forEach(function(discussInfo) {  // 'discussionDetails' 대신 'data'
	                    var chatroomDiv = document.createElement('div');
	                    chatroomDiv.classList.add('user-chatroom');

	                    // 책 커버 이미지
	                    var bookcoverDiv = document.createElement('div');
	                    bookcoverDiv.classList.add('user-bookcover');
	                    var img = document.createElement('img');
	                    img.alt = '책커버';
	                    img.src = discussInfo.book_image;
	                    bookcoverDiv.appendChild(img);

	                    // 텍스트 내용
	                    var chatroomTextDiv = document.createElement('div');
	                    chatroomTextDiv.classList.add('user-chatroom-text');

	                    var titleDiv = document.createElement('div');
	                    titleDiv.classList.add('user-chatroom-title');
	                    titleDiv.textContent = discussInfo.title;

	                    var detailDiv = document.createElement('div');
	                    detailDiv.classList.add('user-chatroom-detail');
	                    detailDiv.textContent = discussInfo.description;

	                    chatroomTextDiv.appendChild(titleDiv);
	                    chatroomTextDiv.appendChild(detailDiv);
						
	                    
	                    console.log(discussInfo.disc_id)
	                    // 하트 버튼
	                    var heartButtonDiv = document.createElement('div');
	                    heartButtonDiv.classList.add('heart-button');
	                    var heartImg = document.createElement('img');
	                    heartImg.alt = '하트';
	                    heartImg.src = "../img/profile/heart-colored-icon.svg";
	                    heartButtonDiv.appendChild(heartImg);
	                    
	                    heartButtonDiv.addEventListener('click', function () {
	                        const data = {
	                            userId: "<%=id%>",  // 사용자 ID
	                            discId: discussInfo.disc_id   // 게시물 ID
	                        };

	                        fetch('/Chaek/disableFavo', {
	                            method: 'POST',
	                            headers: {
	                                'Content-Type': 'application/json' // JSON 데이터 전송
	                            },
	                            body: JSON.stringify(data) // 데이터를 JSON 형식으로 전송
	                        })
	                        .then(response => response.json()) // JSON 응답 처리
	                        .then(result => {
	                            if (result.success) {
	                                console.log("요청 성공:", result.message);
	                                // UI 업데이트
	                                const chatroomDiv = heartButtonDiv.closest('.user-chatroom');
            						if (chatroomDiv) {
						                chatroomDiv.remove(); // DOM에서 해당 요소 삭제
						            }
	                            } else {
	                                console.error("요청 실패:", result.message);
	                            }
	                        })
	                        .catch(error => {
	                            console.error("에러 발생:", error);
	                        });
	                    });

	                    // 최종적으로 .user-datalist에 추가
	                    chatroomDiv.appendChild(bookcoverDiv);
	                    chatroomDiv.appendChild(chatroomTextDiv);
	                    chatroomDiv.appendChild(heartButtonDiv);
	                    container.appendChild(chatroomDiv);
	                });
	            } else {
	                console.error("데이터 형식이 잘못되었습니다.");
	            }
	        })
	        .catch(error => {
	            console.error('Error fetching data:', error);
	        });
	});
	
	
	// 프로필 사진 업로드
	document.getElementById('profilePic').addEventListener('change', function() {
	    const file = this.files[0];
	    if (file) {
	        if (file.size > 1024 * 1024 * 5) { // 5MB 제한
	            alert('파일 크기는 5MB를 초과할 수 없습니다.');
	        } else {
	            document.getElementById('uploadForm').submit();
	        }
	    }
	});



  </script>
  
</body>
</html>
