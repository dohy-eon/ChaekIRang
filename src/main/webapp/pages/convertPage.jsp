<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->

<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/convertPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>EPUB to PDF Converter</title>
</head>
<body>
  <div class="div-wrapper">
    <div class="div">
    
	  <%@ include file="../modules/header.jsp" %>
	  <div class="convert-page">
	      <h2 class="convert-title">Convert EPUB to PDF</h2>
	      <form action="${pageContext.request.contextPath}/convert" method="post" enctype="multipart/form-data">
	        <label for="file">Select EPUB file:</label>
	        <input type="file" name="file" id="file" accept=".epub" required>
	        <br><br>
	        <button type="submit">Convert to PDF</button>
	      </form>
      </div>
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  </div>
</body>
</html>
