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
            <input id="search-input" type="text" placeholder="토론 주제를 검색하거나 이름을 입력하세요." />
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
    // 더미데이터(json)
    const data = {
        "latestDiscussions": [
            {
                "title": "운명과 인간의 선택: 네메시스",
                "description": "\"네메시스\"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다. 이번 독서 토론에서는 이야기 속에서...",
                "thumbnail": "https://via.placeholder.com/100x150",
                "comments": 56
            },
            {
                "title": "미래 기술과 윤리: AI의 도전",
                "description": "AI의 발달이 우리의 삶과 도덕적 선택에 미치는 영향을 논의합니다.",
                "thumbnail": "https://via.placeholder.com/100x150",
                "comments": 42
            }
        ],
        "popularDiscussions": [
            {
                "title": "운명과 인간의 선택: 네메시스",
                "thumbnail": "https://via.placeholder.com/50x75"
            },
            {
                "title": "미래 기술과 윤리: AI의 도전",
                "thumbnail": "https://via.placeholder.com/50x75"
            },
            {
                "title": "기후 변화와 우리의 역할",
                "thumbnail": "https://via.placeholder.com/50x75"
            },
            
        ]
    };

    // 최신 토론 주제 렌더링
    const latestContainer = document.getElementById("latest-discussions");
    data.latestDiscussions.forEach(discussion => {
        const card = document.createElement("div");
        card.className = "discussion-card";

        const thumbnail = document.createElement("img");
        thumbnail.src = discussion.thumbnail;
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
        comments.textContent = discussion.comments ? "💬 " + discussion.comments : "💬 댓글 없음";

        details.append(title, description, comments);
        card.append(thumbnail, details);
        latestContainer.appendChild(card);
    });

    // 인기 토론 렌더링
    const popularContainer = document.querySelector("#popular-discussions .discussion-list");
    data.popularDiscussions.forEach(discussion => {
        const listItem = document.createElement("li");

        const thumbnail = document.createElement("img");
        thumbnail.src = discussion.thumbnail;
        thumbnail.alt = `${discussion.title} 이미지`;
        thumbnail.className = "discussion-thumbnail";

        const title = document.createElement("span");
        title.textContent = discussion.title;

        listItem.append(thumbnail, title);
        popularContainer.appendChild(listItem);
    });
  </script>
</body>
</html>
