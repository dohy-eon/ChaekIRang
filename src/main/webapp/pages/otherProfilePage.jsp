<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<%@ page import="userinfo.UserDAO" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/otherProfilePage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑</title>
    <%
	    String userId = request.getParameter("userId"); // 전달받은 userId
	    
	    String imageSrc;

	    UserDAO userDAO = new UserDAO();
		byte[] profileImgData = userDAO.loadProfileImg(userId);
		
		if (profileImgData != null) {
		       imageSrc  = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profileImgData);
		} else {
		 imageSrc = "../img/profile/profilepic.jpg";
		 
		}
	%>
</head>
<body>
	<div class="div-wrapper">
    <div class="div">
	    <%@ include file="../modules/header.jsp" %>
	    <div class="otherProfile-page">
	    
		    <div class="user-info">
				<div class="user-pic">
					<img class="user-profilepic" alt="프로필사진" src="<%=imageSrc%>">
				</div>
				<div class="user-nickname">
					<div class="nickname"><!-- nickname --></div>
				</div>
			</div>
			
			<div class="user-datalistbox">
	      		<p>관심 토론</p>
	      		<div class="user-datalist">
	      			<!-- 관심 토론 리스트 -->
	      		</div>
	      	</div>
	    
	    </div>
	    <%@ include file="../modules/footer.jsp" %>
    </div>
    </div>
    
    <script>
    	const userId = "<%= userId %>";
    	
    	//유저 닉네임 가져오기
	    fetch("/Chaek/getUserInfo?user_id="+userId)
	    .then(response => response.json())
	    .then(data => {	
            console.log(data);
            document.querySelector(".nickname").textContent = data.nickname;
	    })
	    .catch(error => {
	        console.error("토론 정보 로드 중 오류:", error);
	    });
	    
	    //유저 관심토론 가져오기
	    fetch("/Chaek/dListOther?user_id=" + userId)
        .then(response => response.json())
        .then(data => {
            console.log(data);

            // 관심 토론 데이터가 들어갈 컨테이너 선택
            const userDatalist = document.querySelector(".user-datalist");

            // JSON 데이터를 기반으로 HTML 요소 생성 및 삽입
            data.forEach(item => {
                const chatroom = document.createElement("div");
                chatroom.className = "user-chatroom";

                // 책 커버를 담을 div 생성
                const bookCoverDiv = document.createElement("div");
                bookCoverDiv.classList.add("user-bookcover");

                // 책 커버 이미지 추가
                const bookCoverImg = document.createElement("img");
                bookCoverImg.setAttribute("alt", "책 커버");
                bookCoverImg.setAttribute("src", item.book_image);
                bookCoverDiv.appendChild(bookCoverImg);

                // 채팅방 텍스트를 담을 div 생성
                const chatroomTextDiv = document.createElement("div");
                chatroomTextDiv.classList.add("user-chatroom-text");

                // 채팅방 제목 추가
                const chatroomTitle = document.createElement("div");
                chatroomTitle.classList.add("user-chatroom-title");
                chatroomTitle.textContent = item.title;
                chatroomTextDiv.appendChild(chatroomTitle);

                // 채팅방 설명 추가
                const chatroomDetail = document.createElement("div");
                chatroomDetail.classList.add("user-chatroom-detail");
                chatroomDetail.textContent = item.description;
                chatroomTextDiv.appendChild(chatroomDetail);

                // 부모 div에 자식 요소 추가
                chatroom.appendChild(bookCoverDiv);
                chatroom.appendChild(chatroomTextDiv);

                // 필요한 위치에 chatroom 추가
                document.querySelector(".user-datalist").appendChild(chatroom);
                
                userDatalist.appendChild(chatroom);
            });
        })
        .catch(error => {
            console.error("관심 토론 데이터 로드 중 오류:", error);
        });
    </script>
</body>
</html>