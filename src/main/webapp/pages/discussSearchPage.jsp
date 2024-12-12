<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,DTO.DiscussInfo" %>
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

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 모든 토론 항목을 선택
            const discussionItems = document.querySelectorAll('.discussion-item');
            
            discussionItems.forEach(function(item) {
                // 각 항목에 클릭 이벤트 리스너 추가
                item.addEventListener("click", function() {
                    const discId = item.getAttribute("data-disc-id");
                    // 클릭된 토론 ID를 기반으로 discussChatPage.jsp로 이동 (나중에 수정해야함 일단chat으로 넘김)
                    window.location.href = "/Chaek/pages/chat.jsp?disc_id=" + discId;
                });
            });
        });
    </script>
</body>
</html>
