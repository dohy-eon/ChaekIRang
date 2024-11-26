<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/passwordUpdatePage.css" />
<link rel="stylesheet" href="../css/default.css"/>
<title>책이랑-비밀번호 수정</title>
</head>
<body>
	<div class="div-wrapper">
    <div class="div">
	  	<%@ include file="../modules/header.jsp" %>
		<div class="password-update">
	    	<h2>비밀번호 변경</h2>
			<form action="<%= request.getContextPath() %>/passUpdate" method="post">
		        <label for="currentPassword">현재 비밀번호</label>
		        <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호를 입력해주세요." required>
		
		        <label for="newPassword">새 비밀번호</label>
		        <input type="password" id="newPassword" name="newPassword" placeholder="비밀번호는 8자 이상이어야 합니다." required>
		
		        <label for="confirmNewPassword">새 비밀번호 확인</label>
		        <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호를 다시 입력해주세요." required>
		
		        <button type="submit">비밀번호 변경</button>
		    </form>
	    </div>
	    <%@ include file="../modules/footer.jsp" %>
    </div>
    </div>
</body>
</html>