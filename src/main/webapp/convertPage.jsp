<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->

<!DOCTYPE html>
<html>
<head>
 	<meta charset="utf-8" />
    <title>EPUB to PDF Converter</title>
</head>
<body>
    <h2>Convert EPUB to PDF</h2>
    <form action="convert" method="post" enctype="multipart/form-data">
        <label for="file">Select EPUB file:</label>
        <input type="file" name="file" id="file" accept=".epub" required>
        <br><br>
        <button type="submit">Convert to PDF</button>
    </form>
</body>
</html>
