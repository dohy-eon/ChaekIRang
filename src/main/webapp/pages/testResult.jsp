<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
</head>
<body>
    <h1>Google Books 검색 결과</h1>
    <div>
        <c:forEach var="book" items="${bookList}">
            <p>
                <b>Title:</b> ${book.title} <br>
                <b>Authors:</b> ${book.authors}
            </p>
            <hr>
        </c:forEach>
    </div>
    <a href="search.jsp">다시 검색하기</a>
</body>
</html>
