<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/searchPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-책검색</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/headerSearch.jsp" %>
	  
	  <div class="search-page">
	    <div class="search-leftpart">
          <p class="search-title">무엇을 찾고 있나요?</p>
          <p class="search-subtitle">책이랑에서 다음 읽을거리를 탐험해보는 건 어때요?</p>
          <div class="search-inputbox">
       	    <div class="search-input">
       	    <form action="<%= request.getContextPath() %>/bookSearch" method="get" >
       	  	  <input type="text" name="search"> <button type="submit"> <img src="../img/search/search-icon.svg"></button>
       	  	  </form>
       	    </div>
       	    <div class="search-input-shadow"></div>
          </div>
        </div>
        <div class="search-banner">
          <img class="search-banner-img" src="../img/search/banner.svg">
          <img class="search-banner-shadowimg" src="../img/search/banner-shadow.svg">
        </div>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>
