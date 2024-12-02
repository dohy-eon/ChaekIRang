<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.footer {
  position: absolute;
  width: 1302px;
  height: 97px;
  bottom: 50px;
  left: 70px;
  background-color: transparent;
}

.footer-dash-line {
  position: absolute;
  width: 1300px;
  height: 2px;
  top: -2px;
  left: 0;
}

.footer-teamName {
  top: 57px;
  left: 0;
  font-family: "GmarketSansMedium", Helvetica;
  font-weight: 500;
  color: var(--gray-600);
  font-size: 20px;
  line-height: normal;
  white-space: nowrap;
  position: absolute;
  letter-spacing: 0;
}

.footer-sns {
  position: absolute;
  width: 128px;
  height: 56px;
  top: 41px;
  left: 586px;
}

.footer-github {
  position: absolute;
  width: 50px;
  height: 50px;
  top: 0;
  left: 75px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.footer-sns-figmaImg {
  width: 18px;
  height: 27px;
  z-index: 3;
}

.footer-figma {
  position: absolute;
  width: 50px;
  height: 50px;
  top: 0;
  left: 0px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.footer-sns-outline {
  position: absolute;
  width: 50px;
  height: 50px;
  top: 0;
  left: 0;
  background-color: #ffffff;
  border-radius: 25px;
  border: 2px solid;
  border-color: var(--gray-600);
  z-index: 2;
}

.footer-sns-githubImg {
  width: 24px;
  height: 26px;
  z-index: 3;
}

.footer-img-shadow1 {
  position: absolute;
  width: 50px;
  height: 50px;
  top: 7px;
  left: 7px;
  z-index: 1;
}

.div-wrapper .footer-img-shadow2 {
  position: absolute;
  width: 50px;
  height: 50px;
  top: 7px;
  left: 83px;
  z-index: 1;
}

.footer-sns-link {
  z-index: 3;
}
</style>
</head>
<body>
	<footer class="footer">
      <img class="footer-dash-line" src="<%=request.getContextPath()%>/img/dash-line.svg" />
      <div class="footer-teamName">백엔드 실습 5조</div>
      
      <div class="footer-sns">
        <div class="footer-figma">
          <div class="footer-sns-outline"></div>
          <a class="footer-sns-link" target='_blank' href="https://www.figma.com/design/bC8VYGTCKIHv2kokT9hLey/Backend?node-id=0-1&t=xjMW7POYoRXMje70-1">
            <img class="footer-sns-figmaImg" src="<%=request.getContextPath()%>/img/FIGMALOGO.svg" />
          </a>
        </div>   
        <img class="footer-img-shadow1" src="<%=request.getContextPath()%>/img/icon-shadow.svg" />
        
        <div class="footer-github">
          <div class="footer-sns-outline"></div>
          <a class="footer-sns-link" target='_blank' href="https://github.com/titeotty/ChaekIRang.git">
            <img class="footer-sns-githubImg" src="<%=request.getContextPath()%>/img/GITHUBLOGO.svg"/>
          </a>
        </div>
        <img class="footer-img-shadow2" src="<%=request.getContextPath()%>/img/icon-shadow.svg" />
      </div>
    </footer>
</body>
</html>