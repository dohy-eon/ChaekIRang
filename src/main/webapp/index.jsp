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
	            <div class="part2-user-name">회원B</div>
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

          
          document.addEventListener("DOMContentLoaded", function () {
        	    // 서블릿을 호출하여 데이터 가져오기
        	    fetch("/Chaek/dMainListPop") // 서블릿 URL
        	        .then(response => response.json()) // JSON 형식으로 응답 받기
        	        .then(data => {
        	            if (Array.isArray(data)) {
        	                var container = document.getElementById('part2-popular-list');
        	                data.slice(0, 3).forEach(function (discussInfo) {
        	                    var card = document.createElement('div');
        	                    card.classList.add('discussion-card'); // 수정된 클래스 이름

        	                    // 책 커버 이미지
        	                    var thumbnail = document.createElement('img');
        	                    thumbnail.alt = '책커버';
        	                    thumbnail.src = discussInfo.book_image;
        	                    thumbnail.classList.add('discussion-thumbnail'); // 수정된 클래스 이름

        	                    // 텍스트 내용
        	                    var details = document.createElement('div');
        	                    details.classList.add('discussion-details'); // 수정된 클래스 이름

        	                    var title = document.createElement('p');
        	                    title.classList.add('discussion-title'); // 수정된 클래스 이름
        	                    title.textContent = discussInfo.title;

        	                    var description = document.createElement('p');
        	                    description.classList.add('discussion-description'); // 수정된 클래스 이름
        	                    description.textContent = discussInfo.description;

        	                    var comments = document.createElement('div');
        	                    comments.classList.add('engagement-count'); // 하트 대신 댓글 관련 클래스
        	                    comments.textContent = discussInfo.comment
        	                        ? "💬 " + discussInfo.comment
        	                        : "💬 댓글 없음";

        	                    details.appendChild(title);
        	                    details.appendChild(description);
        	                    details.appendChild(comments);

        	                    // 최종적으로 카드에 추가
        	                    card.appendChild(thumbnail);
        	                    card.appendChild(details);
        	                    container.appendChild(card);
        	                });
        	            } else {
        	                console.error("데이터 형식이 잘못되었습니다.");
        	            }
        	        })
        	        .catch(error => {
        	            console.error('Error fetching data:', error);
        	        });
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
