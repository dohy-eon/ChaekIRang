<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/discussMainPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-토론</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  <div class="discussion-page">
        <!-- 검색 바 -->
        <div class="search-bar">
            <label for="search-input" class="search-label">이런 토론 주제는 어떠세요?</label>
            <!-- 수정: 검색어 전송 버튼 -->
            <form id="search-form" method="GET" action="/Chaek/SearchDiscussions">
                <input id="search-input" type="text" name="keyword" placeholder="검색어" value="<%= request.getParameter("keyword") %>" />
                <button type="submit">검색</button>
                </form>
        </div>

        <!-- 최신 토론 주제 -->
        <section class="discussion-section">
            <div id="latest-discussions" class="latest-discussions">
                <h2>최신 토론 주제</h2>
                <!-- JavaScript로 데이터 렌더링 -->
            </div>

            <!-- 인기 토론 -->
            <div id="popular-discussions" class="popular-discussions">
                <div class="discussion-container">
                    <div class="no-discussion-text">원하는 토론을 찾지 못하셨나요?</div>
                    <button 
                    class="create-discussion-btn" 
                    tabindex="0" 
                    aria-label="새로운 토론 주제 만들기 버튼" 
                    onclick="window.location.href='discussForm.jsp'">새로운 토론 주제 만들기
                    </button>
                </div>
                <div class="popular-section">
                    <h2>인기 토론</h2>
                    <ul class="discussion-list">
                        <!-- JavaScript로 데이터 렌더링 -->
                    </ul>
                </div>
            </div>
        </section>
	  </div>

	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>

  <script>

  document.addEventListener("DOMContentLoaded", function () {
	    // 서버에서 최신 토론 데이터를 가져오기
	    fetch("/Chaek/dMainList")  // 서버에서 최신 토론 데이터를 가져오는 URL (예시)
	        .then(response => response.json())  // JSON 형태로 응답받기
	        .then(data => {
	            // 최신 토론 주제 렌더링
	            const latestContainer = document.getElementById("latest-discussions");

	            // 데이터가 존재하고, 배열일 경우 처리
	            if (Array.isArray(data) && data.length > 0) {
	                // 첫 3개 항목만 처리
	                data.slice(0, 3).forEach(discussion => {
	                    const card = document.createElement("div");
	                    card.className = "discussion-card";

	                    const thumbnail = document.createElement("img");
	                    thumbnail.src = discussion.book_image || "https://via.placeholder.com/100x150"; // 기본 이미지
	                    thumbnail.alt = "토론 이미지";
	                    thumbnail.className = "discussion-thumbnail";

	                    const details = document.createElement("div");
	                    details.className = "discussion-details";

	                    const title = document.createElement("h3");
	                    title.className = "discussion-title";
	                    title.textContent = discussion.title;

	                    const description = document.createElement("p");
	                    description.className = "discussion-description";
	                    description.textContent = discussion.description;

	                    const comments = document.createElement("div");
	                    comments.className = "engagement-count";
	                    comments.textContent = discussion.comment ? "💬"+discussion.comment : "💬 댓글 없음"; // 댓글 수가 없는 경우 기본 텍스트

	                    details.append(title, description, comments);
	                    card.append(thumbnail, details);
	                    latestContainer.appendChild(card);
	                });
	            } else {
	                // 데이터가 없을 경우 처리
	                latestContainer.innerHTML = "<p>최신 토론 주제가 없습니다.</p>";
	            }
	        })
	        .catch(error => {
	            console.error('데이터를 가져오는 중 오류 발생:', error);
	        });
	});


  document.addEventListener("DOMContentLoaded", function () {
	    // 서버에서 인기 토론 데이터를 가져오기
	  fetch("/Chaek/dMainListPop")  // 서버에서 인기 토론 데이터를 가져오는 URL
	    .then(response => response.json())  // JSON 형태로 응답받기
	    .then(data => {
	        const popularContainer = document.querySelector(".popular-section .discussion-list");

	        if (Array.isArray(data) && data.length > 0) {
	            data.slice(0, 3).forEach(discussion => {
	                const listItem = document.createElement("li");

	                const thumbnail = document.createElement("img");
	                thumbnail.src = discussion.book_image || "https://via.placeholder.com/100x150";
	                thumbnail.alt = `${discussion.title} 이미지`;
	                thumbnail.className = "discussion-thumbnail";

	                const textContainer = document.createElement("div");
	                textContainer.className = "text-container";

	                const title = document.createElement("span");
	                title.textContent = discussion.title;
	                title.className = "discussion-title";

	                const description = document.createElement("p");
	                description.textContent = discussion.description;
	                description.className = "discussion-description";

	                // 텍스트 구성 요소를 컨테이너에 추가
	                textContainer.append(title, description);

	                // 리스트 아이템에 이미지와 텍스트 컨테이너 추가
	                listItem.append(thumbnail, textContainer);

	                // 리스트 컨테이너에 추가
	                popularContainer.appendChild(listItem);
	            });
	        } else {
	            popularContainer.innerHTML = "<p>인기 토론 주제가 없습니다.</p>";
	        }
	    })
	    .catch(error => {
	        console.error('데이터를 가져오는 중 오류 발생:', error);
	    });

	});


  </script>
</body>
</html>
