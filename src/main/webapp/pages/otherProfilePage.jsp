<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/otherProfilePage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑</title>
    <%
	    String userId = request.getParameter("userId"); // 전달받은 userId
	    // userId로 데이터베이스에서 해당 사용자 정보를 가져옵니다.
	%>
</head>
<body>
	<div class="div-wrapper">
    <div class="div">
	    <%@ include file="../modules/header.jsp" %>
	    <div class="otherProfile-page">
	    
		    <div class="user-info">
				<div class="user-pic">
					<img alt="프로필사진" src="../img/profile/profilepic.jpg">
				</div>
				<div class="user-nickname">
					<div class="nickname"><%= userId %></div>
				</div>
			</div>
			
			<div class="user-datalistbox">
	      		<p>관심 토론</p>
	      		<div class="user-datalist">
	      			<!-- 여기도 map -->
	      			<div class="user-chatroom">
	      				<div class="user-bookcover">
	      					<img alt="책커버" src="">
	      				</div>
	      				<div class="user-chatroom-text">
		      				<div class="user-chatroom-title">토론방 이름이름이름이름이름이름이름이름이름</div>
		      				<div class="user-chatroom-detail">
		      					토론방 주제설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명</div>
	    				</div>
	    			</div>
	    			<div class="user-chatroom">
	      				<div class="user-bookcover">
	      					<img alt="책커버" src="">
	      				</div>
	      				<div class="user-chatroom-text">
		      				<div class="user-chatroom-title">토론방 이름이름이름이름이름이름이름이름이름</div>
		      				<div class="user-chatroom-detail">
		      					토론방 주제설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명</div>
	    				</div>
	    			</div>
	    			<div class="user-chatroom">
	      				<div class="user-bookcover">
	      					<img alt="책커버" src="">
	      				</div>
	      				<div class="user-chatroom-text">
		      				<div class="user-chatroom-title">토론방 이름이름이름이름이름이름이름이름이름</div>
		      				<div class="user-chatroom-detail">
		      					토론방 주제설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
		      					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명</div>
	    				</div>
	    			</div>
	      		</div>
	      	</div>
	    
	    </div>
	    <%@ include file="../modules/footer.jsp" %>
    </div>
    </div>
</body>
</html>