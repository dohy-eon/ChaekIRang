<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <% 
        String idSession = (String) session.getAttribute("idSession");
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

        /* 알림 배지 스타일 */
        #notificationBadge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: red;
            color: white;
            border-radius: 50%;
            padding: 5px 10px;
            font-size: 14px;
            display: none;
        }
    </style>
</head>
<body>
    <h1>JSP 채팅 (토론 ID: <%= discId %>)</h1>
    <div id="chatWindow"></div>
    <form id="chatForm">
        <input type="text" id="message" placeholder="메시지를 입력하세요" />
        <button type="submit">전송</button>
    </form>

    <script>
        const discId = "<%= discId %>";  
        const idKey = "<%= idSession %>";  
        console.log("토론아이디체크: ", discId);  // 디버깅용

        // WebSocket 서버 URL에 discId 포함
        const ws = new WebSocket('ws://localhost:8082/Chaek/chat/' + discId);

        // 메시지 수신 시 처리
        ws.onmessage = (event) => {
        	const chatWindow = document.getElementById("chatWindow");
    		chatWindow.innerHTML += "<div>" + event.data + "</div>";
    		chatWindow.scrollTop = chatWindow.scrollHeight; // 스크롤 자동으로 내려가게
		};


        // 채팅방을 나갈 때 알림 보내기 (디버깅용)
        window.addEventListener("beforeunload", () => {
            ws.send(JSON.stringify({ id: idKey, message: '채팅방나감' }));
        });

        // 메시지 전송
        document.getElementById("chatForm").onsubmit = (e) => {
            e.preventDefault();
            const messageInput = document.getElementById("message");
            ws.send(JSON.stringify({ id: idKey, message: messageInput.value }));
            messageInput.value = "";
        };

        ws.onerror = (error) => {
            console.error("WebSocket 에러 발생:", error);
        };
    </script>
</body>
