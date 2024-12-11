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
            const userDatalist = document.querySelector(".user-datalist");
            data.forEach(item => {
                const chatroom = document.createElement("div");
                chatroom.className = "user-chatroom";
                
                const discId = item.disc_id;
                chatroom.addEventListener("click", function() {
                    window.location.href = "/Chaek/pages/chat.jsp?disc_id=" + discId;
                });

                const bookCoverDiv = document.createElement("div");
                bookCoverDiv.classList.add("user-bookcover");

                const bookCoverImg = document.createElement("img");
                bookCoverImg.setAttribute("alt", "책 커버");
                bookCoverImg.setAttribute("src", item.book_image);
                bookCoverDiv.appendChild(bookCoverImg);

                const chatroomTextDiv = document.createElement("div");
                chatroomTextDiv.classList.add("user-chatroom-text");

                const chatroomTitle = document.createElement("div");
                chatroomTitle.classList.add("user-chatroom-title");
                chatroomTitle.textContent = item.title;
                chatroomTextDiv.appendChild(chatroomTitle);

                const chatroomDetail = document.createElement("div");
                chatroomDetail.classList.add("user-chatroom-detail");
                chatroomDetail.textContent = item.description;
                chatroomTextDiv.appendChild(chatroomDetail);

                chatroom.appendChild(bookCoverDiv);
                chatroom.appendChild(chatroomTextDiv);

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