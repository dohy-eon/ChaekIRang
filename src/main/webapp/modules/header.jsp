<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.logo-text {
  position: absolute;
  width: 40px;
  height: 118px;
  top: 53px;
  left: 1351px;
}

.logo-text-wrapper {
  position: relative;
  width: 34px;
  height: 118px;
}

.logo-text-Chaek {
  top: 0;
  left: 0;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
}

.logo-text-I {
  top: 37px;
  left: 2px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
}

.logo-text-Rang {
  top: 76px;
  left: 1px;
  font-family: "HS봄바람체 2.1-Regular", Arial, sans-serif;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.header-text-main {
  top: 88px;
  left: 476px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-text-discussion {
  top: 88px;
  left: 667px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-text-search {
  top: 88px;
  left: 852px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-line1 {
  width: 1119px;
  top: 54px;
  left: 137px;
  position: absolute;
  height: 1px;
}

.header-line2 {
  width: 1176px;
  top: 152px;
  left: 80px;
  position: absolute;
  height: 1px;
  object-fit: cover;
}

.header-logo-img {
  position: absolute;
  width: 28px;
  height: 24px;
  top: 43px;
  left: 79px;
}

.header-profile-icon {
  position: absolute;
  width: 26px;
  height: 26px;
  top: 92px;
  left: 1205px;
}

.header-alarm-icon {
  position: absolute;
  width: 24px;
  height: 27px;
  top: 93px;
  left: 1154px;
}

.header-a-tag {
  text-decoration: none;
  color: black;
}

</style>
</head>
<body>
	<header>
      <div class="logo-text">
        <div class="logo-text-wrapper">
          <div class="logo-text-Chaek">책</div>
          <div class="logo-text-I">이</div>
          <div class="logo-text-Rang">랑</div>
        </div>
      </div>
      
      <img class="header-logo-img" src="../img/book-open.svg" />
      <img class="header-line1" src="../img/line-1.svg" />
      <div class="header-text-main"><a class="header-a-tag" href="/Chaek">메인</a></div>
      <div class="header-text-discussion"><a class="header-a-tag" href="/Chaek/pages/discussMainPage.jsp">토론</a></div>
      <div class="header-text-search"><a class="header-a-tag" href="/Chaek/pages/searchPage.jsp">검색</a></div>
      <a class="header-a-tag" href="/Chaek/pages/profilePage.jsp"><img class="header-profile-icon" src="../img/headerProfile.svg" /></a>
      <img class="header-alarm-icon" src="../img/headerAlarm.svg" />
      <img class="header-line2" src="../img/line-1.svg" />
    </header>
</body>
</html>