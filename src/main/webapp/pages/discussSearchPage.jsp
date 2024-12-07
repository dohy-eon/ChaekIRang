<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, discussion.DiscussInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="./css/discussSearchPage.css" />
    <link rel="stylesheet" href="./css/default.css"/>
    <title>검색 결과 - 토론 주제</title>
</head>
<body>
    <div class="div-wrapper">
        <div class="div">
            <%@ include file="../modules/header.jsp" %>

            <div class="discussion-page">
                <!-- 검색된 토론 리스트 -->
                <section class="discussion-section">
                    <div id="latest-discussions" class="latest-discussions">
                        <h2>'<%= request.getAttribute("searchKeyword") %>'에 대한 검색 결과</h2>
                        <ul class="discussion-list" id="discussion-list">
                            <%
                                // 서블릿에서 전달한 discussionList를 받음
                                ArrayList<DiscussInfo> discussions = (ArrayList<DiscussInfo>) request.getAttribute("discussionList");

                                if (discussions != null && !discussions.isEmpty()) {
                                    for (DiscussInfo discussion : discussions) {
                            %>
                                        <li class="discussion-item" data-disc-id="<%= discussion.getDisc_id() %>">
                                            <img src="<%= discussion.getBook_image() != null ? discussion.getBook_image() : "https://via.placeholder.com/100x150" %>" alt="<%= discussion.getTitle() %>" class="discussion-thumbnail">
                                            <div class="text-container">
                                                <span class="discussion-title"><%= discussion.getTitle() %></span>
                                                <p class="discussion-description"><%= discussion.getDescription() %></p>
                                            </div>
                                        </li>
                            <%
                                    }
                                } else {
                            %>
                                    <p>검색된 토론 주제가 없습니다.</p>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </section>
            </div>

            <%@ include file="../modules/footer.jsp" %>
        </div>
    </div>

    <!-- JavaScript 추가 -->
    <script>
        // 페이지가 로드된 후에 이벤트 리스너를 추가합니다.
        document.addEventListener("DOMContentLoaded", function() {
            // 모든 토론 항목을 선택
            const discussionItems = document.querySelectorAll('.discussion-item');
            
            discussionItems.forEach(function(item) {
                // 각 항목에 클릭 이벤트 리스너 추가
                item.addEventListener("click", function() {
                    const discId = item.getAttribute('data-disc-id');
                    alert("테스트용: " + discId);
                    // 예를 들어, 특정 토론에 대한 세부 정보를 다른 페이지에서 로드하거나, 
                    // 해당 토론의 세부 정보를 화면에 표시하는 추가적인 작업을 할 수 있습니다.
                });
            });
        });
    </script>
</body>
</html>
