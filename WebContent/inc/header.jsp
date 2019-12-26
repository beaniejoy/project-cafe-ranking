<%@ page pageEncoding="utf-8"%>


<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	
	<link rel="stylesheet" href="/cafe/css/main.css">
	<link rel="stylesheet" href="/cafe/css/write.css">
  <title>카공도르</title>
</head>

<body>
  <!-- navbar start    -->
  
  <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#6F4E37;">
    <a class="navbar-brand" href="/index.jsp">카공도르</a>    <!-- /는 최상위 인덱스 (webcontent를 의미)   -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02"
      aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
	<%
		// /dept/list.jsp,   /emp/list.jsp ,  /notice/list.jsp    url에 있는 패스만 뽑아줌.
		String uri = request.getRequestURI();
	
		
	%>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      	<li class="nav-item <%if(uri.startsWith("/member")){ %>active <%}%>">
      	<a class="nav-link" href="/member/list.jsp">회원관리</a>
        </li>
       
        <li class="nav-item" <%if(uri.startsWith("/file")){ %>active <%}%>>
        <a class="nav-link" href="/file/index.jsp">파일업로드</a>
        </li>

      </ul>
      <ul class="navbar-nav">
       <%--  <%
      	
      	MemberDto memberDto = (MemberDto)session.getAttribute("member");
      	if(memberDto == null){
      		
     
      	
      %>
       --%>
       
       <li class="nav-item">
          <a class="nav-link" href="/member/write.jsp">회원가입</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="/member/login.jsp">로그인</a>
        </li> 
      <%--    <%} else {%> --%>
        <li class="nav-item">
         <a class="nav-link" href="#"><%-- <%=memberDto.getEmail()  %> --%>서봉석님 환영합니다.</a>
         </li>
         <li class="nav-item">
          <a class="nav-link" href="/member/logout.jsp">로그아웃</a>
        </li> 
        <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="카페명을 입력해주세요" id = "search" name = "search" aria-label="Search">
      <button class="btn btn-info" type="submit">카페찾기</button>
  	  </form>
           <%-- <%} %> --%>
       </ul>
     </div>
  </nav>
  <!-- navbar end-->
  