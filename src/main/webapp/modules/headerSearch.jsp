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
  left: 176px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}
.header-search-input {
  position: absolute;
  top: 84px;
  left: 296px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
}
.header-search-input input {
  width: 880px;
  height: 40px;
  border-radius: 15px;
  font-family: "GmarketSansMedium", Helvetica;
  font-weight: 500;
  font-size: 20px;
  background-color: #D9D9D9;
  border: none;
  padding-left: 20px;
  margin-right: 20px;
}
.header-search-input input:focus {
  outline: none;
}
.header-search-input img {
  width: 24px;
  height: 24px;
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
      <form class="header-search-input" method="post" action="<%= request.getContextPath() %>/bookSearch"> 
      	<input type="text" name="search"> <button type="submit"> <img src="../img/search/search-icon.svg" > </button>
      </form>
      <img class="header-line2" src="../img/line-1.svg" />
    </header>
</body>
</html>