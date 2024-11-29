<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>-->
<%@ page import="java.util.ArrayList,book.BookInfo,userinfo.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8" />
 	<link rel="stylesheet" href="../css/searchResultPage.css" />
 	<link rel="stylesheet" href="../css/default.css"/>
    <title>책이랑-책검색결과</title>
</head>
<%
	ArrayList<BookInfo> bookList = (ArrayList<BookInfo>) request.getAttribute("bookList");
	int size = bookList.size(); // 검색결과 갯수
	int count = 0;
	// 제목과 저자를 저장할 배열 선언
	String[] titles = new String[size];
	String[] authors = new String[size];
	String[] img = new String[size];
	boolean[] isEbook = new boolean[size];
	int[] price = new int[size];
	String[] description = new String[size];
	String[] buyLink = new String[size];
	// bookList가 null이 아니고, 비어있지 않다면
	if (bookList != null && !bookList.isEmpty()) {
	    // bookList를 순회하면서 배열에 데이터 저장
	    for (int i = 0; i < size; i++) {
	        BookInfo book = bookList.get(i);
	        titles[i] = book.getTitle();    // 제목 저장
	        authors[i] = book.getAuthors(); // 저자 저장
	        img[i] = book.getImg();
	        isEbook[i] = book.getIsEbook();
	        price[i] = book.getPrice();
	        description[i] = book.getDescription();
	        buyLink[i] = book.getBuyLink();
	    }
	}
	else { 
		UserDAO.alertAndBack(response, "검색 결과가 없습니다.");
	}
%>
<body>
  <div class="div-wrapper">
    <div class="div">
	  <%@ include file="../modules/header.jsp" %>
	  
	  <div class="searchresult-page">
	       <h1>Search Results</h1>

                <p>
                    <b>Title:</b> <%= titles[count] %> <br>
                    <b>Authors:</b> <%= authors[count] %> <br>
                    <b>image:</b> <img src=<%= img[count] %> > </img><br>
                    <b>isEbook:</b> <%= isEbook[count] %> <br>
                    <b>price:</b> <%=price[count] %> <br>
                    <b>description:</b> <%=description[count] %><br>
                    <a href=<%=buyLink[count] %> target="_blank"><b>Buylink </b> </a>
                </p>
                <hr>

        <p>No books found!</p>
    </div>
	      
      </div>
      
	  <%@ include file="../modules/footer.jsp" %>
	</div>
  
</body>
</html>
