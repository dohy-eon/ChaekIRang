<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->


<head>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="discussion.DiscussInfo" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="userinfo.UserDAO" %>
<%@ page import="java.util.Base64" %>
 
<%
    String idSession = (String)session.getAttribute("idSession");
    String profileImg = (String)session.getAttribute("userProfile");
    
    if (idSession != null) {
        UserDAO userDAO = new UserDAO();
        byte[] profileImgData = userDAO.loadProfileImg(idSession);
        
        if (profileImgData != null) {
            // Base64 인코딩을 사용하여 이미지 데이터를 문자열로 변환
            profileImg = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profileImgData);
        } else {
            profileImg = "../img/profile/profilepic.jpg"; // 기본 프로필 이미지
        }
    } else {
        profileImg = "../img/profile/profilepic.jpg"; // 세션이 없는 경우 기본 프로필 이미지 사용
    }
    
  //  profileImg = "../img/profile/profilepic.jpg";
%>

    <meta charset="UTF-8">
    <title>채팅</title>
    <style>
        #chatWindow {
            border: 1px solid #ccc;
            height: 300px;
            overflow-y: scroll;
            padding: 10px;
            margin-bottom: 10px;
        }
        #message {
            width: 80%;
        }
        .profile-img {
        width: 50px; /* 원하는 너비 */
        height: 50px; /* 원하는 높이 */
        object-fit: cover; /* 비율 유지하면서 자르기 */
        border-radius: 50%; /* 원형으로 만들기 */
    }
    </style>
</head>
<body>
    <h1>JSP 채팅</h1>
    <div id="chatWindow"></div>
    <form id="chatForm">
        <input type="text" id="message" placeholder="메시지를 입력하세요" />
        <button type="submit">전송</button>
    </form>
    <script>
        // WebSocket 연결 설정
        const ws = new WebSocket('ws://localhost:8081/Chaek/chat');
		const idKey = "<%=idSession%>";
		

		
        // 메시지 수신 시 처리
        /* ws.onmessage = (event) => {
            const chatWindow = document.getElementById("chatWindow");
            chatWindow.innerHTML += "<div>"+event.data+"</div>";
            chatWindow.scrollTop = chatWindow.scrollHeight; // 스크롤 자동으로 내려가기
        }; */
        ws.onmessage = function(event) {
            const data = JSON.parse(event.data);
            //const profileImgData = data.profileImgData;
            const sender = data.sender;
            const message = data.message;
			//console.log("img :"+profileImgData+"\n"+"sender :"+sender+"\n"+"message :"+message+"\n")
            const chatMessage = document.createElement("div");
            chatMessage.className = "chat-message";

            const img = document.createElement("img");
            img.src = "<%=profileImg%>";
            img.alt = "프로필 이미지";
            img.className = "profile-img";

            const text = document.createElement("p");
            text.className = "chat-text";
            text.textContent = sender+":"+ message;

            chatMessage.appendChild(img);
            chatMessage.appendChild(text);
            document.getElementById("chatWindow").appendChild(chatMessage);
        };

        // 메시지 전송
		document.getElementById("chatForm").onsubmit = (e) => {
		    e.preventDefault();
		    const messageInput = document.getElementById("message");
		    const idKey = "<%= idSession %>";  // JSP에서 idSession 값을 가져옴
		    ws.send(JSON.stringify({ id: idKey, message: messageInput.value }));
		   // ws.send(JSON.stringify({ id: idKey, message: messageInput.value, profileImgData: profileImg })); // id와 메시지, 프사를 JSON 형식으로 전송
		    messageInput.value = ""; // 입력창 초기화
		};
        ws.onerror = (error) => {
            console.error("WebSocket 에러 발생:", error);
        };
    </script>
</body>