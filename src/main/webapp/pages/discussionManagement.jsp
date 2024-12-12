<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,DTO.DiscussInfo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="../css/discussionManagement.css" />
    <link rel="stylesheet" href="../css/default.css" />
    <title>관리자 - 토론 관리</title>
</head>
<body>
    <div class="div-wrapper">
        <div class="div">
            <%@ include file="../modules/header.jsp" %>

            <div class="admin-page">
                <h1>토론 관리</h1>

                <table id="discussion-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>제목</th>
                            <th>작성 시간</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody id="discussion-list">
                        <!-- 여기서 JavaScript로 토론 데이터를 삽입할 예정 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // DMainList 서블릿 썻는데 맞겠지
            fetch('/Chaek/dMainList')
                .then(response => response.json())
                .then(data => {
                    const discussionList = document.getElementById('discussion-list');
                    
                    if (data.length > 0) {
                    	console.log(data);
                        data.forEach(discussion => {
                            const row = document.createElement('tr');
                            row.setAttribute('data-disc-id', discussion.disc_id); 

                            const tdId = document.createElement('td');
                            tdId.textContent = discussion.disc_id;

                            const tdTitle = document.createElement('td');
                            tdTitle.textContent = discussion.title;

                            const tdTimeCreated = document.createElement('td');
                            tdTimeCreated.textContent = discussion.time_created;

                            const tdDelete = document.createElement('td');
                            const deleteButton = document.createElement('button');
                            deleteButton.classList.add('delete-btn');
                            deleteButton.textContent = '삭제';

                            deleteButton.addEventListener('click', function () {
                                if (confirm("정말 이 토론을 삭제하시겠습니까?")) {
                                    const discId = discussion.disc_id; 
                                    
                                    fetch("/Chaek/DeleteDiscussion", {
                                        method: "POST",
                                        headers: {
                                            "Content-Type": "application/json",
                                        },
                                        body: JSON.stringify({ disc_id: discId }) // 삭제할 토론 ID를 JSON 형식으로 보냄
                                    })
                                    .then(response => {
                                        if (response.ok) {
                                            alert("토론이 삭제되었습니다.");
                                            row.remove();
                                        } else {
                                            alert("토론 삭제 중 오류가 발생했습니다.");
                                        }
                                    })
                                    .catch(error => {
                                        console.error("삭제 요청 실패:", error);
                                        alert("서버와의 통신 중 문제가 발생했습니다.");
                                    });
                                }
                            });

                            // <td>에 삭제 버튼 추가
                            tdDelete.appendChild(deleteButton);

                            // row에 td들 추가
                            row.appendChild(tdId);
                            row.appendChild(tdTitle);
                            row.appendChild(tdTimeCreated);
                            row.appendChild(tdDelete);

                            discussionList.appendChild(row);
                        });
                    } else {
                        const noDataRow = document.createElement('tr');
                        const noDataCell = document.createElement('td');
                        noDataCell.setAttribute('colspan', '4');
                        noDataCell.textContent = '등록된 토론이 없습니다.';
                        noDataRow.appendChild(noDataCell);
                        discussionList.appendChild(noDataRow);
                    }
                })
                .catch(error => {
                    console.error('Error fetching discussions:', error);
                });
        });
    </script>
</body>
</html>
