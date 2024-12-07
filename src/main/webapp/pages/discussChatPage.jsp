<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<%
    String idSession = (String)session.getAttribute("idSession");
    String profile = (String)session.getAttribute("userProfile");
%>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/discussChatPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-토론</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <!-- 헤더 왜 오류나 망할 -->
	  
	  <div class="discusschat-page">
	  
	  	  <!-- 책 및 토론 정보 -->
	  	  <div class="info">
		      <div class="book-info">
		      	  <img class="book-cover"/>
		      	  <div class="book-detail">
		      		  <p class="book-title"></p>
		      		  <p class="book-author"></p>
		      	  </div>
		      </div>
		      <div class="line"></div>
		      <div class="discuss-info">
		      	  <p class="discuss-title"></p>
		      	  <pre class="discuss-detail"></pre>
		      </div>
	      </div>
	      
	      <!-- 채팅 -->
	      <div class="chat-room">
	      	<div id="chatWindow"></div>
	      	<form id="chatForm">
		        <input type="text" id="message" placeholder="메시지를 입력하세요" />
		        <button type="submit">전송</button>
		    </form>
	      </div>
	      
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
  
  <script>
    // WebSocket 연결 설정
    const ws = new WebSocket('ws://localhost:8081/Chaek/chat');
	const idKey = "<%=idSession%>";
	const profileImg = "<%=profile%>";

	
    // 메시지 수신 시 처리
    /* ws.onmessage = (event) => {
        const chatWindow = document.getElementById("chatWindow");
        chatWindow.innerHTML += "<div>"+event.data+"</div>";
        chatWindow.scrollTop = chatWindow.scrollHeight; // 스크롤 자동으로 내려가기
    }; */
    ws.onmessage = function(event) {
        const data = JSON.parse(event.data);
        const profileImg = data.profileImg;
        const sender = data.sender;
        const message = data.message;
	    console.log("img :"+profileImg+"sender :"+sender+"\n"+"message :"+message+"\n")
        const chatMessage = document.createElement("div");
        chatMessage.className = "chat-message";
        const chatUserInfo = document.createElement("div");
        chatUserInfo.className = "chat-userInfo";

        const img = document.createElement("img");
        img.src = profileImg;
        img.alt = "profileImg";
        img.className = "profile-img";
        
        const sendUser = document.createElement("p");
        sendUser.className = "chat-user";
        sendUser.textContent = sender;
        
        const now = new Date();
        const year = now.getFullYear();
        const month = (now.getMonth() + 1).toString().padStart(2, '0');
        const date = now.getDate().toString().padStart(2, '0');
        const hours = now.getHours().toString().padStart(2, '0');
        const minutes = now.getMinutes().toString().padStart(2, '0');
        const seconds = now.getSeconds().toString().padStart(2, '0');
        
        const sendTime = document.createElement("p");
        sendTime.className = "chat-time";
        sendTime.textContent = year + ":" + month + ":" + date + " " + hours + ":" + minutes + ":" + seconds;

        const text = document.createElement("pre");
        text.className = "chat-text";
        text.textContent = message;

        
        chatUserInfo.appendChild(img);
        chatUserInfo.appendChild(sendUser);
        chatUserInfo.appendChild(sendTime);
        chatMessage.appendChild(chatUserInfo);
        chatMessage.appendChild(text);
        document.getElementById("chatWindow").appendChild(chatMessage);
        
        chatWindow.scrollTop = chatWindow.scrollHeight;
    };

    // 메시지 전송
	document.getElementById("chatForm").onsubmit = (e) => {
	    e.preventDefault();
	    const messageInput = document.getElementById("message");
	    const idKey = "<%= idSession %>";  // JSP에서 idSession 값을 가져옴
	    ws.send(JSON.stringify({ id: idKey, message: messageInput.value, profileImg: profileImg })); // id와 메시지, 프사를 JSON 형식으로 전송
	    messageInput.value = ""; // 입력창 초기화
	};
    ws.onerror = (error) => {
        console.error("WebSocket 에러 발생:", error);
    };
   </script>
</body>
</html>