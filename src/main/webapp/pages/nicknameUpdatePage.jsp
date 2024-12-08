<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/passwordUpdatePage.css" />
<link rel="stylesheet" href="../css/default.css"/>
<title>책이랑-닉네임 수정</title>
</head>
<body>
	<div class="div-wrapper">
    <div class="div">
	  	<%@ include file="../modules/header.jsp" %>
		<div class="password-update">
	    	<h2>닉네임 변경</h2>
			<form action="<%= request.getContextPath() %>/nickUpdate" method="post">
			
		        <label for="newNickname">새 닉네임</label>
		        <input type="text" id="newNickname" name="newNickname" placeholder="새로운 닉네임을 입력하세요." required>
		
		        <button type="submit">닉네임 변경</button>
		    </form>
	    </div>
	    <%@ include file="../modules/footer.jsp" %>
    </div>
    </div>
</body>
</html>