<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="discussion.DiscussInfo" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="userinfo.UserDAO" %>
<%@ page import="java.util.Base64" %>
 
<%
    //String idSession = (String)session.getAttribute("idSession"); 헤더에서 이미 선언했음
    String nickname = (String)session.getAttribute("userNickname");
     
	String discId = request.getParameter("disc_id");  // URL에서 disc_id 파라미터 가져오기
%>

    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/discussChatPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-토론방</title>
</head>
<body>
	<div class="div-wrapper">
      <div class="div">
      	<%@ include file="../modules/header.jsp" %>
      	
      	<div class="discusschat-page">
	  
	  	    <!-- 토론 정보 영역 -->
	  	    <div class="discSection">
		      <div class="book-info">
		      	  <img class="book-cover" src="" alt="bookcover"/>
		      	  <div class="book-detail">
		      		  <p class="book-title"><!-- book_name --></p>
		      		  <p class="book-genre"><!-- genre --></p>
		      	  </div>
		      </div>
		      <div class="line"></div>
		      <div class="discuss-info">
		      	  <p class="discuss-title"><!-- title --></p>
		      	  <pre class="discuss-detail"><!-- description --></pre>
			  </div>
			  <div onclick="toggleHeart(this)" class="heart-btn">
			  	<img src="../img/profile/heart-icon.svg" alt="관심토론"/>
		  	  </div>
	        </div>
	        
	        <!-- 채팅영역 -->
			<div class="chatSection">
			    <div id="chatWindow"><!-- 여기에 채팅 --></div>
			    <form id="chatForm">
			        <textarea id="message" placeholder="메시지를 입력하세요"></textarea>
		        	<div class="chat-buttons">
				        <button id="scrollToTop" type="button">맨 위로</button>
				        <button class="chat-submitbtn" type="submit">전송</button>
			    	</div>
			    </form>
		    </div>
    	</div>
    	
    	<%@ include file="../modules/footer.jsp" %>
   	  </div>
 	</div>
	
	    <script>
	        const discId = "<%= discId %>";
	        const idKey = "<%= idSession %>";
	        const nickname = "<%= nickname %>";
	        console.log("토론아이디체크: ", discId);  // 디버깅용
	        
	        // 하트 토글
			function toggleHeart(button) {
			    var img = button.querySelector('img');
			    if (img.src.includes('heart-icon.svg')) {
			        img.src = '../img/profile/heart-colored-icon.svg'; // 클릭 시 하트 색상 변경
			    } else {
			        img.src = '../img/profile/heart-icon.svg'; // 다시 기본 하트로 변경
			    }
			}
	        
	        // 맨 위로 버튼
	        document.getElementById("scrollToTop").addEventListener("click", () => {
			    const chatWindow = document.getElementById("chatWindow");
			    chatWindow.scrollTop = 0; // 채팅창 맨 위로 감 채팅 처음부터 읽기용
			});
	        
	        // 토론 정보 가져오기
	        fetch("/Chaek/chatDiscInfo?disc_id="+discId)
		    .then(response => response.json())
		    .then(data => {
		    	if (data.length > 0) {
		            const book = data[0];	
		            
		            document.querySelector(".book-cover").src = book.book_image || ""; // 이미지 URL
		            document.querySelector(".book-title").textContent = book.book_name || "제목 정보 없음";
		            document.querySelector(".book-genre").textContent = "장르 : "+ book.genre || "장르 정보 없음";
		            document.querySelector(".discuss-title").textContent = book.title || "토론 제목 없음";
		            document.querySelector(".discuss-detail").textContent = book.description || "설명 정보 없음";
		        }
		    })
		    .catch(error => {
		        console.error("토론 정보 로드 중 오류:", error);
		    });
	
	        document.addEventListener("DOMContentLoaded", () => {
	            const chatWindow = document.getElementById("chatWindow");

	            // 기존 채팅 데이터 가져오기
	            fetch("/Chaek/chatHistory?disc_id="+discId)
	                .then((response) => response.json())
	                .then((data) => {
	                	console.log("서버 응답 데이터:", data); // 디버깅용
	                    if (Array.isArray(data)) {
	                        data.forEach((message) => {
	                            const chatMessage = document.createElement("div");
	                            chatMessage.className = "chat-message";

	                            const chatUserInfo = document.createElement("div");
	                            chatUserInfo.className = "chat-userInfo";

	                            const sendUser = document.createElement("p");
	                            sendUser.className = "chat-user";
	                            sendUser.textContent = message.nickname;

	                            const text = document.createElement("pre");
	                            text.className = "chat-text";
	                            if (message.CommentText) {
	                                text.textContent = message.CommentText.replace(/\n/g, "<br>");
	                              }

	                            const timestamp = document.createElement("p");
	                            timestamp.className = "chat-time";
	                            timestamp.textContent = message.createdAt.split('.')[0]; // 초단위 소숫점 제거

	                            chatUserInfo.appendChild(sendUser);
	                            chatUserInfo.appendChild(timestamp);
	                            chatMessage.appendChild(chatUserInfo);
	                            chatMessage.appendChild(text);

	                            chatWindow.appendChild(chatMessage);
	                        });

	                        // 채팅창을 가장 아래로 스크롤
	                        chatWindow.scrollTop = chatWindow.scrollHeight;
	                    } else {
	                        console.warn("데이터포맷다름");
	                    }
	                })
	                .catch((error) => {
	                    console.error("불러오는중오류:", error);
	                });

	            // WebSocket 서버 URL에 discId 포함
	            const ws = new WebSocket('ws://localhost:8081/Chaek/chat/' + discId);

	            ws.onmessage = function(event) {
	                const data = JSON.parse(event.data);
	                const message = data.commentText;
	                const createdAt = data.createdAt;
	                const prettyCreatedAt = createdAt.split('.')[0]; // 초단위 소숫점 제거
	                const chatMessage = document.createElement("div");
	                chatMessage.className = "chat-message";

	                const chatUserInfo = document.createElement("div");
	                chatUserInfo.className = "chat-userInfo";

	                const sendUser = document.createElement("p");
	                sendUser.className = "chat-user";
	                sendUser.textContent = data.nickname;

	                const text = document.createElement("pre");
	                text.className = "chat-text";
	                text.innerHTML = message.replace(/\n/g, "<br>");

	                const timestamp = document.createElement("p");
	                timestamp.className = "chat-time";
	                timestamp.textContent = prettyCreatedAt;

	                chatUserInfo.appendChild(sendUser);
	                chatUserInfo.appendChild(timestamp);
	                chatMessage.appendChild(chatUserInfo);
	                chatMessage.appendChild(text);
	                chatWindow.appendChild(chatMessage);

	                chatWindow.scrollTop = chatWindow.scrollHeight; // 메세지 전송 시 최신 메세지 보이도록 자동스크롤
	            };

	            // 메시지 전송
	            document.getElementById("chatForm").onsubmit = (e) => {
	                e.preventDefault();
	                const messageInput = document.getElementById("message");
	                ws.send(JSON.stringify({ id: idKey, message: messageInput.value, nickname: nickname }));
	                messageInput.value = ""; // 입력창 초기화
	                location.reload(); //새로고침 해야지 새 텍스트 보이길래 채팅 보내면 바로 새로고침하게 만듦
	            };

	            ws.onerror = (error) => {
	                console.error("WebSocket 에러 발생:", error);
	            };

	            // keydown event 추가
	            document.getElementById("message").addEventListener("keydown", (event) => {
	                const messageInput = event.target;

	                // Shift + Enter로 줄바꿈
	                if (event.key === "Enter" && event.shiftKey) {
	                    return;
	                }

	                // Enter로 메시지 전송
	                if (event.key === "Enter" && !event.shiftKey) {
	                    event.preventDefault();
	                    document.getElementById("chatForm").dispatchEvent(new Event("submit")); // Form submit 이벤트 호출
	                }
	            });
	        });
	    </script>
</body>
