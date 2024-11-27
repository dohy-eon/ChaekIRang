<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h1>회원 관리</h1>
<div>
    <input type="text" id="search-input" placeholder="회원 검색 (ID, 닉네임)">
    <button id="search-btn">검색</button>
</div>
<br>
<table id="member-table">
    <thead>
        <tr>
            <th>아이디</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>프로필 이미지</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <!-- 여기에서 데이터관리 -->
    </tbody>
</table>

<script>
    // 회원 데이터 로드
    function loadMembers(query = '') {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/Chaek/getMembers?search=' + encodeURIComponent(query), true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onload = function() {
        if (xhr.status === 200) {
            const data = JSON.parse(xhr.responseText);
            console.log(data); // 데이터 확인용

            const tbody = document.querySelector('#member-table tbody');
            tbody.innerHTML = '';

            if (Array.isArray(data) && data.length > 0) {
            	data.forEach(member => {
            	    console.log(member); // 체크용

            	    let profileImgSrc = '/img/profile/profilepic.jpg'; // 기본 이미지 URL

            	    if (member.profile_img !== "0") {
            	        profileImgSrc = '/images/' + member.profile_img;
            	    }

            	    console.log("프사위치: ", profileImgSrc);

            	    // HTML 출력
            	    const row = document.createElement('tr');
            	    row.innerHTML = `
            	        <td>${member.user_id}</td>
            	        <td>${member.nickname}</td>
            	        <td>${member.email}</td>
            	        <td><img src="${profileImgSrc}" alt="프로필" width="50"></td>
            	        <td>
            	            <button onclick="editMember('${member.user_id}')">수정</button>
            	            <button onclick="deleteMember('${member.user_id}')">삭제</button>
            	        </td>
            	    `;
            	    tbody.appendChild(row);
            	});
            } else {
                // 데이터가 없는 경우
                tbody.innerHTML = '<tr><td colspan="5">회원 정보가 없습니다.</td></tr>';
            }
        } else {
            console.error('Error: ' + xhr.status); // 실패 시 에러 로그
        }
    };

    xhr.onerror = function() {
        console.error('Request failed');
    };

    xhr.send();
}

    document.getElementById('search-btn').addEventListener('click', function() {
        const query = document.getElementById('search-input').value;
        loadMembers(query);
    });

    // 회원 수정
    function editMember(userId) {
        const newNickname = prompt('새 닉네임을 입력하세요:');
        const newEmail = prompt('새 이메일을 입력하세요:');
        if (newNickname && newEmail) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/EditUserServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert('회원 정보가 수정되었습니다.');
                    loadMembers(); 
                }
            };
            xhr.send(JSON.stringify({ user_id: userId, nickname: newNickname, email: newEmail }));
        }
    }

    // 회원 삭제
    function deleteMember(userId) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/DeleteUserServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert('회원이 삭제되었습니다.');
                    loadMembers(); // 리로드
                }
            };
            xhr.send(JSON.stringify({ user_id: userId }));
        }
    }

    // 기본 데이터 로드
    window.addEventListener('DOMContentLoaded', function() {
        loadMembers();
    });
    
</script>
</body>
</html>