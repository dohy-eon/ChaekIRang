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
            <div class="part2-user-postTime">1시간 전</div>
            <div class="part2-user-commentNum">2</div>
          </div>
          <img class="part2-user-commentIcon" src="img/image-2.svg" />
        </div>
        
        <div class="part2-userB">
          <div class="part2-userB-post">
            <p class="part2-user-text">
              저는 네메시스가 단순한 운명이라기보다는 주인공이 선택한 행동에 대한 필연적인 결과였다고 생각해요. 그가
              내렸던 결정들이 모두 어떤 식으로든 후에 부메랑처럼 돌아오는 느낌이었어요.
            </p>
            <div class="part2-user-profilePic"></div>
            <div class="part2-user-name"><a href="./pages/adminPage.jsp">회원B</a></div>
            <div class="part2-user-postTime">1시간 전</div>
            <div class="part2-user-commentNum">1</div>
          </div>
          <img class="part2-user-commentIcon" src="img/image-2.svg" />
        </div>
        
        <img class="part2-user-line" src="img/line-8.svg" />
        <div class="part2-user-reply">답글</div>
        
        <div class="part2-book-overlap">
          <div class="part2-book-title">네메시스(Nemesis)</div>
          <p class="part2-book-author">저자 : 필립 로스(Philip Roth)</p>
          <p class="part2-book-postTitle">운명과 인간의 선택: 네메시스의 메타포</p>
          <p class="part2-book-postDetail">
            &#34;네메시스&#34;는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다. <br /><br />이번 독서
            토론에서는 이야기 속에서 네메시스가 어떻게 등장하며, 인물들이 직면하는 고난과 그들이 내리는 선택이 어떻게
            연관되는지 탐구합니다. <br /><br />&#39;네메시스&#39;가 운명으로서 나타나는 순간들과 그에 대한 인물들의
            <br />대응이 우리 현실과 어떻게 닮았는지, 그리고 이들이 던지는 철학적 질문이 우리에게 어떤 의미를 가지는지
            함께 논의해봅시다.
          </p>
          <img class="part2-book-image" src="img/image-1.svg" />
          <img class="part2-book-line" src="img/line-5.svg" />
        </div>
      </div>
        
        
      <div class="part3">
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
