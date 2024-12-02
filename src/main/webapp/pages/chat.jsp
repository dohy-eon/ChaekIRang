<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->


<head>
<%
//String nickname = (String)session.getAttribute("userNickname");
String idSession = (String)session.getAttribute("idSession");
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
        ws.onmessage = (event) => {
            const chatWindow = document.getElementById("chatWindow");
            chatWindow.innerHTML += "<div>"+event.data+"</div>";
            chatWindow.scrollTop = chatWindow.scrollHeight; // 스크롤 자동으로 내려가기
        };

        // 메시지 전송
		document.getElementById("chatForm").onsubmit = (e) => {
		    e.preventDefault();
		    const messageInput = document.getElementById("message");
		    const idKey = "<%= idSession %>";  // JSP에서 idSession 값을 가져옴
		    ws.send(JSON.stringify({ id: idKey, message: messageInput.value })); // id와 메시지를 JSON 형식으로 전송
		    messageInput.value = ""; // 입력창 초기화
		};
        ws.onerror = (error) => {
            console.error("WebSocket 에러 발생:", error);
        };
    </script>
</body>