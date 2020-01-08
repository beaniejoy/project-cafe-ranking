<%@page import="dto.ShopRatingDto"%>
<%@page import="dao.ShopRatingDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	int start = 0;
	int len = 5;
	int pageLength = 3;
	int totalRows = 0;
	int totalPage = 0;
	int startPage = 0;
	int endPage = 0;
	int cPage = 1;
	
	String tempPage = request.getParameter("page");
	
	String uri = request.getRequestURI();
	String contextPath = request.getContextPath();
	
	// 항상 예외처리 중요시 하자
	// 쿼리에 page 값이 아예 없는 경우
	if (tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	// page 값은 있는데 숫자형식이 아닌경우
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	String shopName = request.getParameter("shop");

	ShopRatingDao shopRatingDao = ShopRatingDao.getInstance();

	// 총 데이터수 구하기
	totalRows = shopRatingDao.getTotalRows(shopName);

	totalPage = totalRows % len == 0 ? totalRows / len : totalRows / len + 1;
	// totalRows가 0일 때 문제 발생
	if (totalPage == 0) {
		totalPage = 1;
	}

	if (cPage > totalPage) {
		cPage = 1;
	}

	start = (cPage - 1) * len;
	ArrayList<ShopRatingDto> list = shopRatingDao.select(start, len, shopName);

	int currentBlock = cPage % pageLength == 0 ? (cPage / pageLength) : (cPage / pageLength + 1);
	int totalBlock = totalPage % pageLength == 0 ? (totalPage / pageLength) : (totalPage / pageLength + 1);
	startPage = 1 + (currentBlock - 1) * pageLength;
	endPage = pageLength + (currentBlock - 1) * pageLength;
	if (currentBlock == totalBlock) {
		endPage = totalPage;
	}
	int pageNum = totalRows - start;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=contextPath %>/css/write.css">
<link rel="stylesheet" href="<%=contextPath %>/css/rank.css">
</head>
<body>
<form style="margin-bottom: 50px;">
		<%
			if (list.size() != 0) {
		%>
		<%
			for (ShopRatingDto ratingDto : list) {
		%>
		<div class="form-group">
			<label for="exampleFormControlTextarea1"><%=ratingDto.getId()%></label>
			<textarea class="form-control" rows="3" readonly="readonly"> <%=ratingDto.getComm()%></textarea>
		</div>
		<%
			}
		%>
		<%
			} else {
		%>
		<div>
			<h4>리뷰가 존재하지 않습니다.</h4>
		</div>
		<%
			}
		%>
	</form>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<%
				if (currentBlock == 1) {
			%>
			<li class="page-item disabled"><a class="page-link" href="#"
				tabindex="-1" aria-disabled="true">Previous </a></li>
			<%
				} else {
			%>
			<li class="page-item"><a class="page-link"
				href="view_comm.jsp?shop=<%=shopName %>&page=<%=startPage - 1%>">Previous</a></li>
			<%
				}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<li class="page-item <%if (cPage == i) {%>active<%}%>"><a
				class="page-link" href="view_comm.jsp?shop=<%=shopName %>&page=<%=i%>"><%=i%></a></li>
			<%
				}
			%>
			<%
				if (currentBlock == totalBlock) {
			%>
			<li class="page-item disabled"><a class="page-link" href="#"
				tabindex="-1" aria-disabled="true">Next</a></li>
			<%
				} else {
			%>
			<li class="page-item"><a class="page-link"
				href="view_comm.jsp?shop=<%=shopName %>&page=<%=endPage + 1%>">Next</a></li>
			<%
				}
			%>
		</ul>
	</nav>
</body>
<script>



</script>
</html>



