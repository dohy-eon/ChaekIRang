<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="DTO.BookInfo" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonObject" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새로운 토론 주제 만들기</title>
    <link rel="stylesheet" href="../css/default.css" />
    <link rel="stylesheet" href="../css/discussForm.css" />
    <script>
        // 검색된 책을 클릭하면 제목과 이미지 데이터를 폼에 설정
        function selectBook(title, img) {
            document.getElementById("bookName").value = title; // 책 제목 설정
            document.getElementById("bookImage").value = img; // 책 이미지 경로 설정
        }
    </script>
</head>
<body>
    <div class="div-wrapper">
        <div class="div">
            <%@ include file="../modules/header.jsp" %>
			
			<div class="discussForm-page">
            <!-- 검색 및 결과 영역 -->
            <div class="form-and-results">
                <!-- 검색 입력 -->
                <div class="search-input">
                    <form id="searchForm">
                        <input type="text" id="searchInput" name="search" placeholder="책 검색" required />
                        <button type="submit">
                            <img src="../img/search/search-icon.svg" alt="Search" />
                        </button>
                    </form>
                </div>

                <!-- 검색 결과 -->
                <div class="search-results">
                    <div id="searchResults">
                        <p>검색 결과</p>
                        <ul class="searchResult-detail">
                            <% 
                                JsonArray bookList = (JsonArray) request.getAttribute("bookList");
                                if (bookList != null && bookList.size() > 0) {
                                    for (int i = 0; i < bookList.size(); i++) {
                                        JsonObject book = bookList.get(i).getAsJsonObject();
                                        String title = book.has("title") ? book.get("title").getAsString() : "제목 없음";
                                        String authors = book.has("authors") ? book.get("authors").getAsString() : "저자 정보 없음";
                                        String img = book.has("img") && !book.get("img").isJsonNull() ? book.get("img").getAsString() : "";
                            %>
                            <li onclick="selectBook('<%= title %>', '<%= img %>')">
                                <% if (!img.isEmpty()) { %>
                                    <img src="<%= img %>" alt="Book Cover" />
                                <% } %>
                                <div>
                                    <strong><%= title %></strong>
                                    <p><%= authors %></p>
                                </div>
                            </li>
                            <% 
                                    }
                                }
                            %>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 토론 주제 만들기 폼 -->
            <div class="discussForm">
                <h1>새로운 토론 주제 만들기</h1>
                <form method="post" action="<%= request.getContextPath() %>/CreateDiscussionServlet">
                    <label for="title">토론 제목:</label>
                    <input type="text" id="title" name="title" required />

                    <label for="bookName">책 이름:</label>
                    <input type="text" id="bookName" name="bookName" required />

                    <!-- 숨겨진 입력 필드로 이미지 경로 전달 -->
                    <input type="hidden" id="bookImage" name="bookImage" />

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
                        <option value="사회">사회</option>
                        <option value="취미">취미</option>
                        <option value="시/희곡">시/희곡</option>
                    </select>

                    <button type="submit">제출</button>
                </form>
            </div>
            </div>
            <%@ include file="../modules/footer.jsp" %>
        </div>
    </div>

<!-- AJAX 처리 스크립트 -->
<script>
    document.getElementById("searchForm").addEventListener("submit", function (e) {
        e.preventDefault(); // 폼 제출 기본 동작 방지

        const query = document.getElementById("searchInput").value;
        if (!query) {
            alert("검색어를 입력하세요.");
            return;
        }

        // AJAX 요청 (서버에 검색어 보내기)
        fetch("<%= request.getContextPath() %>/SearchBookServlet?search=" + encodeURIComponent(query))
            .then(response => response.json())
            .then(data => {
                const resultsContainer = document.getElementById("searchResults").querySelector("ul");
                resultsContainer.innerHTML = ""; // 기존 결과 삭제

                if (data.length > 0) {
                    data.forEach(book => {
                        const li = document.createElement("li");
                        li.onclick = () => selectBook(book.title, book.img || ""); // 제목과 이미지를 설정

                        if (book.img) {
                            const img = document.createElement("img");
                            img.src = book.img;
                            img.alt = "Book Cover";
                            li.appendChild(img);
                        }

                        const div = document.createElement("div");
                        const title = document.createElement("strong");
                        title.textContent = book.title;
                        div.appendChild(title);

                        const authors = document.createElement("p");
                        authors.textContent = book.authors ? book.authors.replace(/[\[\]"]/g, '') : "저자 정보 없음";
                        div.appendChild(authors);

                        li.appendChild(div);
                        resultsContainer.appendChild(li);
                    });
                } else {
                    resultsContainer.innerHTML = "<p>검색 결과가 없습니다.</p>";
                }
            })
            .catch(error => console.error("Error fetching books:", error));
    });
</script>
</body>
</html>
