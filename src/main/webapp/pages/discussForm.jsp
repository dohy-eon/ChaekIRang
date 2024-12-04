<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새로운 토론 주제 만들기</title>
    <link rel="stylesheet" href="../css/default.css" />
    <link rel="stylesheet" href="../css/discussForm.css" />
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
      <%@ include file="../modules/header.jsp" %>
      <div class="discussForm">
        <h1>새로운 토론 주제 만들기</h1>
        <form method="post" action="<%= request.getContextPath() %>/CreateDiscussionServlet">
            <label for="title">토론 제목:</label>
            <input type="text" id="title" name="title" required />

            <label for="bookName">책 이름:</label>
            <input type="text" id="bookName" name="bookName" required />

            <label for="description">토론 소개:</label>
            <textarea id="description" name="description" rows="5" required></textarea>

            <label for="genre">장르:</label>
            <select id="genre" name="genre" required>
                <option value="">장르 선택</option>
                <option value="추리">추리</option>
                <option value="로맨스">로맨스</option>
                <option value="판타지">판타지</option>
                <option value="과학">과학</option>
                <option value="역사">역사</option>
                <option value="소설">소설</option>
                <option value="사회">사회</option>
                <option value="시/희곡">시/희곡</option>
            </select>

            <button type="submit">제출</button>
        </form>
      </div>
      <%@ include file="../modules/footer.jsp" %>
    </div>
  </div>
</body>
</html>
