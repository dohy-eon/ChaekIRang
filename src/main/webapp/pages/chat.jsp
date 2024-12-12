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
           document.addEventListener("DOMContentLoaded", function () {
              const chatWindow = document.getElementById("chatWindow");
               const data = {
                  userId: "<%= idSession %>",  
               discId: "<%= discId %>"
               };

               fetch('/Chaek/favoState', {
                   method: 'POST',
                   headers: {
                       'Content-Type': 'application/json'
                   },
                   body: JSON.stringify(data)
               })
               .then(response => {
                   if (!response.ok) {
                       throw new Error('서버 요청 실패');
                   }
                   return response.json();
               })
               .then(state => {
                   const heartButton = document.querySelector('.heart-btn'); // 버튼 셀렉터
                   const img = heartButton.querySelector('img');

                   // 서버에서 받은 상태를 기반으로 하트 아이콘 업데이트
                   if (state.isFavorited) {
                       img.src = '../img/profile/heart-colored-icon.svg'; // 즐겨찾기 상태
                   } else {
                       img.src = '../img/profile/heart-icon.svg'; // 비활성화 상태
                   }
               })
               .catch(error => console.error('에러:', error));
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
                             
	                            const sendUser = document.createElement("a");
	                            sendUser.className = "chat-user";
	                            sendUser.textContent = message.nickname;
	                            sendUser.href = "/Chaek/pages/otherProfilePage.jsp?userId="+message.userId;

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
           });

           // 하트 토글
         function toggleHeart(button) {
              const data = {
                    userId: "<%= idSession %>",  
                        discId: "<%= discId %>"   
	        	};
			    var img = button.querySelector('img');
			    if (img.src.includes('heart-icon.svg')) {
			        img.src = '../img/profile/heart-colored-icon.svg'; // 클릭 시 하트 색상 변경
			        fetch('/Chaek/enableFavo', {
			            method: 'POST',
			            headers: {
			                'Content-Type': 'application/json'
			            },
			            body: JSON.stringify(data)
			        })
			        .then(response => {
			            if (!response.ok) {
			                throw new Error('서버 요청 실패');
			            }
			            console.log('즐겨찾기 활성화 완료');
			        })
			        .catch(error => console.error('에러:', error));
			    } else {
			        img.src = '../img/profile/heart-icon.svg'; // 다시 기본 하트로 변경
			        fetch('/Chaek/disableFavo', {
			            method: 'POST',
			            headers: {
			                'Content-Type': 'application/json'
			            },
			            body: JSON.stringify(data)
			        })
			        .then(response => {
			            if (!response.ok) {
			                throw new Error('서버 요청 실패');
			            }
			            console.log('즐겨찾기 비활성화 완료');
			        })
			        .catch(error => console.error('에러:', error));
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
	
	        // WebSocket 서버 URL에 discId 포함
	        const ws = new WebSocket('ws://localhost:8081/Chaek/chat/' + discId);
	
	        ws.onmessage = function(event) {
	            const data = JSON.parse(event.data);
	            //console.log(data);
	            const message = data.message;
	            const createdAt = data.createdAt;
	            const prettyCreatedAt = createdAt.split('.')[0]; // 초단위 소숫점 제거
	            const chatMessage = document.createElement("div");
	            chatMessage.className = "chat-message";
	            const chatUserInfo = document.createElement("div");
	            chatUserInfo.className = "chat-userInfo";
	
	         	// 닉넴 클릭하면 otherProfile 연결
	            const sendUser = document.createElement("a");
	            sendUser.className = "chat-user";
	            sendUser.href = "/Chaek/pages/otherProfilePage.jsp?userId="+data.user_id;
	            sendUser.textContent = data.nickname
	            
	            const text = document.createElement("pre");
	            text.className = "chat-text";
	            text.innerHTML = message.replace(/\n/g, "<br>");
	
	            const timestamp = document.createElement("p"); // 타임스탬프 출력
	            timestamp.className = "chat-time";
	            timestamp.textContent = prettyCreatedAt;
	            
	            chatUserInfo.appendChild(sendUser);
	            chatUserInfo.appendChild(timestamp);
	            chatMessage.appendChild(chatUserInfo);
	            chatMessage.appendChild(text);
	            document.getElementById("chatWindow").appendChild(chatMessage);
	        
	            chatWindow.scrollTop = chatWindow.scrollHeight; // 메세지 전송 시 그... 최신 메세지 보이도록 자동스크롤
	        };
	
	        // 메시지 전송
			document.getElementById("chatForm").onsubmit = (e) => {
			    e.preventDefault();
			    const messageInput = document.getElementById("message");
			    const idKey = "<%= idSession %>";
			    console.log(idKey);
			    ws.send(JSON.stringify({ id: idKey, message: messageInput.value, nickname: nickname }));
			    messageInput.value = ""; // 입력창 초기화
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
       </script>
</body>