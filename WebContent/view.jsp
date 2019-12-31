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
	String sname = request.getParameter("shop");

	ShopRatingDao shopRatingDao = ShopRatingDao.getInstance();
	ArrayList<ShopRatingDto> list = shopRatingDao.select(sname);

	ShopInfoDao infoDao = ShopInfoDao.getInstance();
	ShopInfoDto infoDto = infoDao.select(sname);

	TotalRateDao totalDao = TotalRateDao.getInstance();
	TotalRateDto totalDto = totalDao.select(sname);
%>

<div class="jumbotron">
	<h2 style="margin-bottom: 50px;"><%=infoDto.getSname()%></h2>
	<p class="lead"></p>
	<p></p>
	
</div>
<div class="container">
	<div style="margin-bottom: 50px">
		<ul class="list-group">
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Location</b></span><%=infoDto.getLoc()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Tel.</b></span><%=infoDto.getPhone()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Time</b></span><%=infoDto.getOperTime()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Menu</b></span><%=infoDto.getMenu()%></li>
		</ul>
	</div>
	<div style="margin-bottom: 50px">
		<ul class="list-group">
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Mood</b></span><%=totalDto.getMood()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Light</b></span><%=totalDto.getLight()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Price</b></span><%=totalDto.getPrice()%></li>
			<li class="list-group-item"><span
				style="width: 100px; display: inline-block; margin-right: 20px"><b>Taste</b></span><%=totalDto.getTaste()%></li>
		</ul>
	</div>

	<div class="text-right">
		<a href="<%=contextPath %>/main.jsp" type="button" class="btn btn-outline-secondary">메인</a>
		<%
			if (mdto != null && shopRatingDao.isAlreadyRated(infoDto.getSname(), mdto.getId())) {
		%>
		<a href="update.jsp?shop=<%=infoDto.getSname()%>" type="button" class="btn btn-outline-success">수정하기</a>
		<%
			} else {
		%>
		<a href="writeProcess.jsp?shop=<%=infoDto.getSname()%>"
			class="btn btn-outline-info">평가하기</a>
		<%
			}
		%>
	</div>
	<form style="margin-bottom:50px;">
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

</div>

<%@ include file="../inc/footer.jsp"%>


