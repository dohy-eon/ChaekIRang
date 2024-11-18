<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->

<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/convertPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>EPUB to PDF Converter</title>
    <style>
        /* 로딩바 스타일 */
        #loadingSpinner {
            width: 50px;
            height: 50px;
            border: 5px solid #3AB8EB;
            border-top: 5px solid black; /* 상단 테두리 색상 */
            border-radius: 50%; /* 원형으로 만들기 */
            margin: 30px auto;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    <script>
        function startConversion() {
            const fileInput = document.querySelector('input[name="file"]');
            // 파일이 선택되지 않은 경우 경고 메시지 표시
            if (!fileInput.files || fileInput.files.length === 0) {
                alert("파일을 업로드해주세요!");
                return;
            }
        	
            // 로딩바 표시
            document.getElementById("loadingSpinner").style.display = "block";

            // 파일 업로드 및 변환 요청을 보낼 form을 제출
            document.getElementById("uploadForm").submit();
        }

        function hideLoadingSpinner() {
            // 로딩바 숨김
            document.getElementById("loadingSpinner").style.display = "none";
        }
    </script>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
    
	  <%@ include file="../modules/header.jsp" %>
	  <div class="convert-page">
	    <div class="convert-title">EPUB to PDF</div>
	    <div class="convert-subtitle">당신의 편안한 독서경험을 위하여</div>
	    <form id="uploadForm" action="${pageContext.request.contextPath}/convert" method="post" enctype="multipart/form-data" target="uploadFrame">
	      <div class="convert-uploadform">
	        <label for="file">EPUB 파일 업로드</label><br>
	        <input type="file" name="file" id="file" accept=".epub" required>
	        <span id="file-name">선택된 파일 없음</span>
	        <!-- 로딩바 -->
	    	<div id="loadingSpinner"></div>
	      </div>
	      <br>
	      <button class="convert-btn" type="submit" onclick="startConversion()">변환하기</button>
	    </form>
	
	    <!-- iframe을 사용하여 form 제출 후 로딩바를 숨김 -->
	    <iframe name="uploadFrame" style="display:none;" onload="hideLoadingSpinner()"></iframe>
      </div>
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
  
  <script>
    document.getElementById('file').addEventListener('change', function() {
        const fileName = this.files[0] ? this.files[0].name : '선택된 파일 없음';
        document.getElementById('file-name').textContent = fileName;
    });
  </script>
</body>
</html>
