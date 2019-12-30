<%@page import="dao.ShopRatingDao"%>
<%@page import="dto.ShopInfoDto"%>
<%@page import="dao.ShopInfoDao"%>
<%@ page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="inc/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	int cPage = 0;
	int start = 0;
	int len = 5;
	int totalRows = 0;
	int totalPage = 0;
	int startPage = 0;
	int endPage = 0;
	int pageLength = 5;
	int pageNum = 0;
	String name = null;
	String keyword = request.getParameter("search");
	String tempPage = request.getParameter("page");
	
	if (tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}

	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	// 카페 정보를 담고있는 table dao
	ShopInfoDao dao = ShopInfoDao.getInstance();
	ShopRatingDao ratingDao = ShopRatingDao.getInstance();
	if (keyword == null || keyword.length() == 0) {
		totalRows = dao.getTotalRows();
	} else {
		totalRows = dao.getTotalRows(keyword);
	}

	totalPage = totalRows % len == 0 ? totalRows / len : totalRows / len + 1;
	if (totalPage == 0) {
		totalPage = 1;
	}

	if (cPage > totalPage) {
		cPage = 1;
	}

	start = (cPage - 1) * len;
	pageNum = totalRows + (cPage - 1) * (-len);

	ArrayList<ShopInfoDto> list = null;

	if (keyword == null || keyword.length() == 0) {
		list = dao.search(start, len);
	} else {
		list = dao.search(start, len, keyword);
	}

	int currentBlock = cPage % pageLength == 0 ? (cPage / pageLength) : (cPage / pageLength + 1);
	int totalBlock = totalPage % pageLength == 0 ? (totalPage / pageLength) : (totalPage / pageLength + 1);

	startPage = 1 + (currentBlock - 1) * pageLength;
	endPage = pageLength + (currentBlock - 1) * pageLength;

	if (currentBlock == totalBlock) {
		endPage = totalPage;
	}
%>
<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="<%=contextPath%>/main.jsp">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">카페검색</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>카페 리스트</h3>
			<div class="row row-cols-1 row-cols-md-2">
			<%
				for (ShopInfoDto infoDto : list) {
			%>
				<div class="col mb-4">
					<div class="card">
						<a href="<%=contextPath%>/view.jsp?shop=<%=infoDto.getSname()%>"><img
							src="#" class="card-img-top" alt="alternative"></a>
						<div class="card-body">
							<h5 class="card-title"><%=infoDto.getSname()%></h5>
							<p class="card-text"></p>
						</div>
						<div class="card-body">
							<% if (mdto != null && ratingDao.isAlreadyRated(infoDto.getSname(), mdto.getId())) {%>
							<a href="update.jsp?shop=<%=infoDto.getSname() %>" class="card-link">수정하기</a>
							<%} else {%>
							<a href="writeProcess.jsp?shop=<%=infoDto.getSname() %>" class="card-link">평가하기</a>
							<%} %>
						</div>
					</div>
				</div>
			<%
				}
			%>
			</div>

			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<%
						if (currentBlock == 1) {
					%>
					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1" aria-disabled="true">Previous</a></li>
					<%
						} else {
					%>
					<li class="page_item"><a class="page-link"
						href="search.jsp?page=<%=startPage - 1%>">Previous</a></li>
					<%
						}
					%>
					<%
						for (int i = startPage; i <= endPage; i++) {
					%>
					<li class="page-item <%if (cPage == i) {%>active<%}%>"><a
						class="page-link" href="search.jsp?page=<%=i%>"><%=i%></a></li>
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
						href="search.jsp?page=<%=endPage + 1%>">Next</a></li>
					<%
						}
					%>
				</ul>
			</nav>


		</div>
	</div>
</div>
<!-- main end -->

<%@ include file="inc/footer.jsp"%>

