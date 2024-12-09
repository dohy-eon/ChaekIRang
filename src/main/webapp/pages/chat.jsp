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
    String idSession = (String)session.getAttribute("idSession");
    String profileImg = (String)session.getAttribute("userProfile");
    String nickname = (String)session.getAttribute("userNickname");
    
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
  System.out.println(profileImg);
%>

    <meta charset="UTF-8">
    <% 
        String discId = request.getParameter("disc_id");  // URL에서 disc_id 파라미터 가져오기
    %>
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
    <h1>JSP 채팅 (토론 ID: <%= discId %>)</h1>
    <div id="chatWindow"><!-- 여기에 채팅 --></div>
    <form id="chatForm">
        <input type="text" id="message" placeholder="메시지를 입력하세요" />
        <button type="submit">전송</button>
    </form>

    <script>
        const discId = "<%= discId %>";
        const idKey = "<%= idSession %>";
        const nickname = "<%= nickname %>";
        console.log("토론아이디체크: ", discId);  // 디버깅용

        // WebSocket 서버 URL에 discId 포함
        const ws = new WebSocket('ws://localhost:8081/Chaek/chat');

        ws.onmessage = function(event) {
            const data = JSON.parse(event.data);
            console.log(data);
            const message = data.message;
            const createdAt = data.createdAt;
            const chatMessage = document.createElement("div");
            chatMessage.className = "chat-message";

            const img = document.createElement("img");
            console.log(data.profileImg); //프로필이미지 체크용
            img.src = data.profileImg;
            img.alt = "프로필 이미지";
            img.className = "profile-img";

            const text = document.createElement("p");
            text.className = "chat-text";
            text.textContent = data.nickname+":"+ message;

            const timestamp = document.createElement("span"); // 타임스탬프 출력
            timestamp.className = "timestamp";
            timestamp.textContent = "시간: " + createdAt;
            
            chatMessage.appendChild(img);
            chatMessage.appendChild(text);
            chatMessage.appendChild(timestamp);
            document.getElementById("chatWindow").appendChild(chatMessage);
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
    </script>
</body>
