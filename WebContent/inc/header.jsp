<%@page import="dto.MemDto"%>
<%@ page pageEncoding="utf-8"%>


<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<link rel="stylesheet" href="/cafe/css/main.css">
<link rel="stylesheet" href="/cafe/css/write.css">
<title>카공도르</title>
</head>

<body>
	<!-- navbar start    -->

	<nav class="navbar navbar-expand-lg navbar-dark"
		style="background-color: #6F4E37;">
		<a class="navbar-brand" href="/cafe/main.jsp">카공도르</a>
		<!-- /는 최상위 인덱스 (webcontent를 의미)   -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo02"
			aria-controls="navbarTogglerDemo02" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<%
			// /dept/list.jsp,   /emp/list.jsp ,  /notice/list.jsp    url에 있는 패스만 뽑아줌.
			String uri = request.getRequestURI();
			String contextPath = request.getContextPath();
		%>
		<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li
					class="nav-item <%if (uri.startsWith("/member")) {%>active <%}%>">
					<a class="nav-link" href="/member/list.jsp">회원관리</a>
				</li>

				<li class="nav-item" <%if (uri.startsWith("/file")) {%> active <%}%>>
					<a class="nav-link" href="/file/index.jsp">파일업로드</a>
				</li>

			</ul>
			<ul class="navbar-nav">

				<%
					MemDto mdto = (MemDto) session.getAttribute("member");
					if (mdto == null) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=contextPath%>/mem/regst.jsp">회원가입 </a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=contextPath%>/mem/login.jsp">로그인</a></li>

				<%
					} else {
				%>
				<%-- 나중에 아이디 버튼 누르면 자기 정보 나오게 할 수 있을듯(수정까지도) --%>
				<li class="nav-item"><a class="nav-link" href="#"><%=mdto.getId()%>님
						환영합니다.</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=contextPath%>/mem/logout.jsp">로그아웃 </a></li>
				<form name="f" class="form-inline my-2 my-lg-0" method="post" action="<%=contextPath%>/search.jsp">
					<input class="form-control mr-sm-2" type="search" placeholder="카페명을 입력해주세요" id = "search" name = "search" aria-label="Search">
					<button class="btn btn-info" type="button">카페찾기</button>
				</form>

				<%
					}
				%>

			</ul>
		</div>
	</nav>
	<!-- navbar end-->