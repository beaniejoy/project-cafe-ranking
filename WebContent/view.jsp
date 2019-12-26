<%@page import="dao.ShopInfoDao"%>
<%@page import="dto.ShopInfoDto"%>
<%@page import="dto.ShopRatingDto"%>
<%@page import="dao.ShopRatingDao"%>
<%@page import="dao.TotalRateDao"%>
<%@page import="dto.TotalRateDto"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../inc/header.jsp"%>


<%
	/*  String sname = request.getParameter("sname"); */
	String sname = "스타벅스_을지로점";

	ShopRatingDao shopRatingDao = ShopRatingDao.getInstance();
	ArrayList<ShopRatingDto> list = shopRatingDao.select(sname);

	ShopInfoDao infoDao = ShopInfoDao.getInstance();
	ShopInfoDto infoDto = infoDao.select(sname);

	TotalRateDao totalDao = TotalRateDao.getInstance();
	TotalRateDto totalDto = totalDao.select(sname);
%>
<style>
img {
	display: block;
	margin: 0px auto;
}

textarea {
	display: block;
	margin: 0px auto;
}
</style>

<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="#">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">Library</li>
	</ol>
</nav>

<div class="card bg-dark text-white">
	<img src="../image/cafe.jpg" style="width: 1200px; height: 700px;"
		class="card-img" alt="...">
	<div class="card-img-overlay">
		<h5 class="card-title">Card title</h5>
		<p class="card-text">This is a wider card with supporting text
			below as a natural lead-in to additional content. This content is a
			little bit longer.</p>
		<p class="card-text">Last updated 3 mins ago</p>
	</div>
</div>

<!-- 
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  Indicators
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  Wrapper for slides
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="../image/cafe.jpg" alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    <div class="item">
      <img src="..." alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    ...
  </div>

  Controls
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
 -->

<table class="table table-borderless">
	<colgroup>
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />

	</colgroup>
	<thead>
		<%
			if (infoDto != null) {
		%>

		<tr>
			<th scope="col"><h2>
					<%=infoDto.getSname()%></h2></th>
			<td></td>
		</tr>
		<tr>
			<th scope="col">opertime</th>
			<td><%=infoDto.getOperTime()%></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th scope="col">location</th>
			<td><%=infoDto.getLoc()%></td>
		</tr>
		<tr>
			<th scope="col">phone</th>
			<td><%=infoDto.getPhone()%></td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<td colspan="4">데이터가 존재하지 않습니다.</td>
		</tr>
		<%
			}
		%>


	</thead>
</table>
<table class="table table-borderless">
	<thead>
		<tr>

		</tr>
	</thead>
	<tbody>
		<%
			if (totalDto != null) {
		%>
		<tr>
			<th scope="col">mood</th>
			<td><%=totalDto.getMood()%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th scope="col">light</th>
			<td><%=totalDto.getLight()%></td>

		</tr>
		<tr>
			<th scope="col">price</th>

			<td><%=totalDto.getPrice()%></td>
		</tr>
		<tr>
			<th scope="col">taste</th>

			<td><%=totalDto.getTaste()%></td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<td colspan="4">데이터가 존재하지 않습니다.</td>
		</tr>
		<%
			}
		%>
	</tbody>

</table>
<div class="text-right">
	<a href="index.jsp" type="button" class="btn btn-outline-secondary">메인</a>
	<%--  <%
      	
      	MemberDto memberDto = (MemberDto)session.getAttribute("member");
      	if(memberDto == null){
      		
     
      	
      %>
       --%>
	<a href="write.jsp?sname=<%=sname %>" class="btn btn-outline-secondary">글작성</a>
	<%--    <%} else {%> --%>
	<a href="update.jsp<%=sname %>" class="btn btn-outline-secondary">내글
		수정하기</a>
	<%-- <%} %> --%>

</div>
<form>
	<!-- MemberDto memberDto = (MemberDto)session.getAttribute("member"); 
	MemberDto.getId();
-->

	<%
		if (list.size() != 0) {
	%>
	<%
		for (ShopRatingDto ratingDto : list) {
	%>
	<%-- <%if(MemberDto.getId() == comdto.getId()){ %> --%>
	<div class="form-group" readonly="readonly">
		<label for="exampleFormControlTextarea1"><%=ratingDto.getId()%></label>
		<textarea class="form-control" style="width: 1570px;"
			id="exampleFormControlTextarea1" rows="3" readonly="readonly"> <%=ratingDto.getComm()%></textarea>
	</div>	
	<%
		}
	%>
	<%
		} else {
	%>
	<tr>
		<td colspan="3">리뷰가 존재하지 않습니다.</td>
	</tr>
	<%
		}
	%>

</form>

<div class="text-right">
	<a href="index.jsp" type="button" class="btn btn-outline-secondary"
		style="width: 80px;">메인</a> <a href="view.jsp" type="button"
		class="btn btn-outline-secondary" style="width: 95px;">맨 위로</a>

</div>



<!-- <div class="card text-center">
  <div class="card-header">
    Featured
  </div>
  <div class="card-body">
    <h5 class="card-title">Special title treatment</h5>
    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
  <div class="card-footer text-muted">
    2 days ago
  </div>
</div>
 -->
<%-- 
<%@ include file="../inc/footer.jsp"%>
 --%>


