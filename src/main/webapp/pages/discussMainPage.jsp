<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/discussMainPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-토론</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  <div class="discussion-page">
<div class="discussion-list">
  <form class="search-container" role="search">
    <label for="searchInput" class="visually-hidden">이런 토론 주제는 어떠세요?</label>
    <input 
      type="search"
      id="searchInput"
      class="search-input"
      placeholder="토론 주제 혹은 책 이름을 입력해주세요"
      aria-label="Search discussions or books"
    />
    <button type="submit" aria-label="Search">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/3b947452-32e1-401f-a368-4c5d1d5736a7?placeholderIfAbsent=true&apiKey=45195689119146fb9f36ffe6a1d7e50b" alt="" class="search-icon" />
    </button>
  </form>

  <main class="content-grid">
    <article class="discussion-card">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/e6289527f2846af50645a82debafa5581338067b92785e20bd9e27b17a788ccd?placeholderIfAbsent=true&apiKey=45195689119146fb9f36ffe6a1d7e50b" alt="Book cover for 네메시스" class="book-cover" />
      <div class="card-content">
        <h2 class="card-title">운명과 인간의 선택: 네메시스의 메타포</h2>
        <p class="card-description">
          "네메시스"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다.
          이번 독서 토론에서는 이야기 속에서 네메시스가 어떻게 등장하며,
          인물들이 직면하는 고난과 그들이 내리는 선택이 어떻게 연관되는지 탐구합니다.
        </p>
        <div class="engagement">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/2e5d9045bb6476bc1e03a9ae6a42ee4262535653d737b2c816582f727e575c03?placeholderIfAbsent=true&apiKey=45195689119146fb9f36ffe6a1d7e50b" alt="Comments" class="icon" />
          <span>56</span>
        </div>
      </div>
    </article>

    <article class="discussion-card">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/e6289527f2846af50645a82debafa5581338067b92785e20bd9e27b17a788ccd?placeholderIfAbsent=true&apiKey=45195689119146fb9f36ffe6a1d7e50b" alt="Book cover for 네메시스" class="book-cover" />
      <div class="card-content">
        <h2 class="card-title">운명과 인간의 선택: 네메시스의 메타포</h2>
        <p class="card-description">
          "네메시스"는 인간의 운명과 선택에 대한 깊은 질문을 던지는 소설입니다.
          이번 독서 토론에서는 이야기 속에서 네메시스가 어떻게 등장하며,
          인물들이 직면하는 고난과 그들이 내리는 선택이 어떻게 연관되는지 탐구합니다.
        </p>
        <div class="engagement">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/2e5d9045bb6476bc1e03a9ae6a42ee4262535653d737b2c816582f727e575c03?placeholderIfAbsent=true&apiKey=45195689119146fb9f36ffe6a1d7e50b" alt="Comments" class="icon" />
          <span>56</span>
        </div>
      </div>
    </article>
  </main>
</div>
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>
