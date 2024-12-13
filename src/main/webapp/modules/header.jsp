<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.logo-text {
  position: absolute;
  width: 40px;
  height: 118px;
  top: 53px;
  left: 1351px;
}

.logo-text-wrapper {
  position: relative;
  width: 34px;
  height: 118px;
}

.logo-text-Chaek {
  top: 0;
  left: 0;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
}

.logo-text-I {
  top: 37px;
  left: 2px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
}

.logo-text-Rang {
  top: 76px;
  left: 1px;
  font-family: "HS봄바람체 2.1-Regular", Arial, sans-serif;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.header-text-main {
  top: 88px;
  left: 476px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-text-discussion {
  top: 88px;
  left: 667px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-text-search {
  top: 88px;
  left: 852px;
  font-family: "HS봄바람체 2.1-Regular", Helvetica;
  font-weight: 400;
  color: var(--gray-800);
  font-size: 32px;
  line-height: normal;
  position: absolute;
  letter-spacing: 0;
  width: 65px;
}

.header-line1 {
  width: 1119px;
  top: 54px;
  left: 137px;
  position: absolute;
  height: 1px;
}

.header-line2 {
  width: 1176px;
  top: 152px;
  left: 80px;
  position: absolute;
  height: 1px;
  object-fit: cover;
}

.header-logo-img {
  position: absolute;
  width: 28px;
  height: 24px;
  top: 43px;
  left: 79px;
}

.header-profile-icon {
  position: absolute;
  width: 26px;
  height: 26px;
  top: 92px;
  left: 1205px;
}

.header-alarm-icon {
  position: absolute;
  width: 24px;
  height: 27px;
  top: 93px;
  left: 1154px;
}

.header-a-tag {
  text-decoration: none;
  color: black;
}

.alarm-modal {
  font-family: "GmarketSansLight", Helvetica;
  position: fixed;
  top: 110px;
  right: 530px;
  width: 350px;
  background: #ffffff;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
  border-radius: 8px;
  overflow: hidden;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-20px);
  transition: all 0.3s ease-in-out;
  z-index: 1000;
}
.alarm-modal-header {
  background-color: #f4f4f4;
  padding: 12px 16px;
  font-size: 16px;
  font-weight: bold;
  color: black;
  border-bottom: 1px solid #D9D9D9;
}
.alarm-modal-header p {
  margin: 0;
}
.alarm-modal-content {
  max-height: 200px;
  overflow-y: auto; /* 스크롤 */
  padding: 10px 16px;
}
.alarm-modal-detail {
  margin: 10px 0;
  padding: 5px 15px;
  border: solid 1px #D9D9D9;
  border-radius: 5px;
  box-shadow: 1px 1px 2px #D9D9D9;
  cursor: pointer;
}
.alarm-modal-content p {
  font-size: 14px;
  margin: 10px 0;
}
.alarm-modal-detail-title {
  font-weight: bold;
}
.alarm-modal.show {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}
/* 알림창 스크롤바 */
		.alarm-modal-content::-webkit-scrollbar {
		    width: 8px;
		    height: 8px;
		}
		 /* 스크롤바 색상 */
		.alarm-modal-content::-webkit-scrollbar-thumb {
		    background: #888;
		    border-radius: 10px;
		}
		.alarm-modal-content::-webkit-scrollbar-thumb:hover {
		    background: #555;
		}
		 /* 스크롤 트랙 배경 */
		.alarm-modal-content::-webkit-scrollbar-track {
		    background: #f0f0f0;
		    border-radius: 10px;
		}
		.alarm-modal-content::-webkit-scrollbar-track:hover {
		    background: #e0e0e0;
		}

</style>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const alarmIcon = document.querySelector(".header-alarm-icon");
            const alarmModal = document.getElementById("alarm-modal");
            const alarmModalContent = alarmModal.querySelector(".alarm-modal-content");

            // 알림 아이콘 클릭 시 알림 모달 열기/닫기
            alarmIcon.addEventListener("click", () => {
                alarmModal.classList.toggle("show");
                fetchNotifications();  // 알림 데이터 가져오기
            });

            // 알림 모달 외부 클릭 시 모달 닫기
            window.addEventListener("click", (event) => {
                if (!alarmModal.contains(event.target) && !alarmIcon.contains(event.target)) {
                    alarmModal.classList.remove("show");
                }
            });

            // 서버에서 알림 데이터를 가져오는 함수
            function fetchNotifications() {
    fetch('/Chaek/NotificationServlet')
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 요청 실패');
            }
            return response.json();
        })
        .then(notifications => {
            console.log('알람:', notifications);
            displayNotifications(notifications);
        })
        .catch(error => {
            console.error('Error fetching notifications:', error);
        });
}


         // 알림 모달에 알림 데이터 표시
            function displayNotifications(notifications) {
                alarmModalContent.innerHTML = '';

                if (notifications.length === 0) {
                    const noNotifications = document.createElement('p');
                    noNotifications.textContent = '새로운 알림이 없습니다.';
                    alarmModalContent.appendChild(noNotifications);
                } else {
                    notifications.forEach(notification => {
                        const notificationElement = document.createElement('div');
                        notificationElement.classList.add('alarm-modal-detail');

                        // 제목 부분
                        const titleElement = document.createElement('div');
                        titleElement.classList.add('alarm-modal-detail-title');
                        titleElement.textContent = notification.title;

                        // 설명 부분
                        const descriptionElement = document.createElement('div');
                        descriptionElement.textContent = notification.message;

                        // 요소들 추가
                        notificationElement.appendChild(titleElement);
                        notificationElement.appendChild(descriptionElement);

                        alarmModalContent.appendChild(notificationElement);
                    });
                }
            }


        });
    </script>
</head>

<% 
    // idSession 처리 부분은 서블릿에서 처리되므로 JSP에서는 제거
    String isGuest;
    String idSession = (String) session.getAttribute("idSession");

    if (idSession == null) {
        isGuest = "/Chaek/pages/loginSignupPage.jsp";
    } else if (idSession.equals("admin")) {
        isGuest = "/Chaek/pages/adminPage.jsp";
    } else {
        isGuest = "/Chaek/pages/profilePage.jsp";
    }
%>

<body>
    <header>
        <div class="logo-text">
            <div class="logo-text-wrapper">
                <div class="logo-text-Chaek">책</div>
                <div class="logo-text-I">이</div>
                <div class="logo-text-Rang">랑</div>
            </div>
        </div>
        
        <img class="header-logo-img" src="/Chaek/img/book-open.svg" />
        <img class="header-line1" src="/Chaek/img/line-1.svg" />
        <div class="header-text-main"><a class="header-a-tag" href="/Chaek">메인</a></div>
        <div class="header-text-discussion"><a class="header-a-tag" href="/Chaek/pages/discussMainPage.jsp">토론</a></div>
        <div class="header-text-search"><a class="header-a-tag" href="/Chaek/pages/searchPage.jsp">검색</a></div>
        
        <a class="header-a-tag" href="<%= isGuest %>"><img class="header-profile-icon" src="/Chaek/img/headerProfile.svg" /></a>
        <img class="header-alarm-icon" src="/Chaek/img/headerAlarm.svg" />
        <img class="header-line2" src="/Chaek/img/line-1.svg" />
        
        <!-- 알림 모달 -->
        <div id="alarm-modal" class="alarm-modal">
            <div class="alarm-modal-header">
                <p>알림</p>
            </div>
            <div class="alarm-modal-content">
                <!-- 서버에서 동적으로 추가되는 알림이 여기에 들어감 -->
            </div>
        </div>
    </header>
</body>
</html>