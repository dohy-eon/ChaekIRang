<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="css/index.css" />
  </head>
  <body>
    <div class="div-wrapper">
      <div class="div">
      
      
      <%@ include file="modules/header.jsp" %>
      
      
      <div class="part1">
        <img class="part1-logo" src="img/book-open.svg" />
        <div class="part1-title">
          <div class="part1-title-background"></div>
          <div class="part1-title-text">책이랑</div>
        </div>
        <div class="part1-subtitle">읽고, 생각하고, 공유하고</div>
      </div>
      
      
      <div class="part2">
      	<div class="part2-left">
	      	<div class="part2-title">의미있는 대화속으로 -</div>
	      	<div class="part2-subtitle">책이랑에서 토론과 친해지기</div>
	        
	        <div class="part2-userA">
	          <div class="part2-userA-post">
	            <p class="part2-user-text">
	              네메시스가 이야기 속에서 주인공의 선택에 영향을 미친 건 단순한 운명일까요, 아니면 그가 스스로 만든
	              결과일까요?
	            </p>
	            <div class="part2-user-profilePic"></div>
	            <div class="part2-user-name">회원A</div>
	            <div class="part2-user-postTime">2024-12-11 20:20:36</div>
	          </div>
	        </div>
	        
	        <div class="part2-userB">
	          <div class="part2-userB-post">
	            <p class="part2-user-text">
	              저는 네메시스가 단순한 운명이라기보다는 주인공이 선택한 행동에 대한 필연적인 결과였다고 생각해요. 그가
	              내렸던 결정들이 모두 어떤 식으로든 후에 부메랑처럼 돌아오는 느낌이었어요.
	            </p>
	            <div class="part2-user-profilePic"></div>
	            <div class="part2-user-name"><a href="./pages/adminPage.jsp">회원B</a></div>
	            <div class="part2-user-postTime">2024-12-11 20:22:01</div>
	          </div>
            </div>
            
            <div class="part2-chaekuser">
	          <div class="part2-chaekuser-post">
		        <a href="/Chaek/pages/discussMainPage.jsp">
		          <p class="part2-chaekuser-textbox">저는...</p>
		        </a>
	            <script>
				 	// hover 시 텍스트 바뀜
				    const textbox = document.querySelector('.part2-chaekuser-textbox');
				    textbox.addEventListener('mouseover', () => {
				      textbox.textContent = '토론하러 가기';
				    });
				    textbox.addEventListener('mouseout', () => {
				      textbox.textContent = '저는...';
				    });
			    </script>
	            <a href="/Chaek/pages/discussMainPage.jsp" class="part2-chaekuser-submitbtn">등록</a>
	            <div class="part2-user-profilePic"></div>
	            <div class="part2-user-name">책이랑</div>
	          </div>
            </div>
        </div>
        
        <div class="part2-discuss-recommend">
          <div class="part2-discuss-head">
            <div class="part2-popular-discussions">인기 토론</div>
            <div class="part2-morebtn"><a href="/Chaek/pages/discussMainPage.jsp">토론 더보기</a></div>
          </div>
          <div class="part2-popular-list" id="part2-popular-list"></div>
          <script>
          const data = {
	          "popularDiscussions": [
	              {
	                  "title": "운명과 인간의 선택: 네메시스",
	                  "thumbnail": "https://via.placeholder.com/50x75",
                	  "description": "\"네메시스\"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다. 이번 독서 토론에서는 이야기 속에서...",
	               	  "comments": 94
	              },
	              {
	                  "title": "미래 기술과 윤리: AI의 도전",
	                  "thumbnail": "https://via.placeholder.com/50x75",
                	  "description": "\"네메시스\"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다. 이번 독서 토론에서는 이야기 속에서...",
	               	  "comments": 66
	              },
	              {
	                  "title": "기후 변화와 우리의 역할",
	                  "thumbnail": "https://via.placeholder.com/50x75",
	                  "description": "\"네메시스\"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다. 이번 독서 토론에서는 이야기 속에서...",
	               	  "comments": 54
	              },
	              
	          ]
          }
          const popularContainer = document.getElementById("part2-popular-list");
          data.popularDiscussions.forEach(discussion => {
              const card = document.createElement("div");
              card.className = "discussion-card";

              const thumbnail = document.createElement("img");
              thumbnail.src = discussion.thumbnail;
              thumbnail.alt = "토론 이미지";
              thumbnail.className = "discussion-thumbnail";

              const details = document.createElement("div");
              details.className = "discussion-details";

              const title = document.createElement("p");
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
              popularContainer.appendChild(card);
          });
          </script>
        </div>
      </div>
        
        
      <div class="part3"><a href="/Chaek/pages/convertPage.jsp">
        <div class="part3-epub-title">업로드된 파일 이름.epub</div>
        <div class="part3-pdf-title">변환된 파일 이름.pdf</div>
        <div class="part3-upload-wrapper">
          <div class="part3-btn-outline"><div class="part3-btn-text">변환하기</div></div>
        </div>
        
        <div class="part3-download-wrapper">
          <div class="part3-btn-outline"><div class="part3-btn-text">다운로드</div></div>
        </div>
        <div class="part3-title"><a class="index-a-tag" href="/Chaek/pages/convertPage.jsp">eBook to PDF</a></div>
        <div class="part3-subtitle">당신의 편안한 독서경험을 위하여</div>
      </a>
      </div>
        
      <footer class="footer">
        <img class="footer-dash-line" src="img/dash-line.svg" />
        <div class="footer-teamName">백엔드 실습 5조</div>
        
        <div class="footer-sns">
          <div class="footer-figma">
            <div class="footer-sns-outline"></div>
            <a class="footer-sns-link" target='_blank' href="https://www.figma.com/design/bC8VYGTCKIHv2kokT9hLey/Backend?node-id=0-1&t=xjMW7POYoRXMje70-1">
              <img class="footer-sns-figmaImg" src="img/FIGMALOGO.svg" />
            </a>
          </div>   
          <img class="footer-img-shadow1" src="img/icon-shadow.svg" />
          
          <div class="footer-github">
            <div class="footer-sns-outline"></div>
            <a class="footer-sns-link" target='_blank' href="https://github.com/titeotty/ChaekIRang.git">
              <img class="footer-sns-githubImg" src="img/GITHUBLOGO.svg"/>
            </a>
          </div>
          <img class="footer-img-shadow2" src="img/icon-shadow.svg" />
        </div>
      </footer>
        
      </div>
    </div>
  </body>
</html>
