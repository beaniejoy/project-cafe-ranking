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
	int start = 0;
	int len = 5;
	int pageLength = 3;
	int totalRows = 0;
	int totalPage = 0;
	int startPage = 0;
	int endPage = 0;
	int cPage = 1;
	
	String tempPage = request.getParameter("page");

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

	ShopInfoDao infoDao = ShopInfoDao.getInstance();
	ShopInfoDto infoDto = infoDao.select(shopName);

	TotalRateDao totalDao = TotalRateDao.getInstance();
	TotalRateDto totalDto = null;

	// view에서 totalrate table에 해당 매장이 없는 경우 대비
	if (totalDao.isTotalShopName(shopName)) {
		totalDto = totalDao.select(shopName);

	} else {
		// totalrate table에 해당 매장이 없는 경우 모든 점수 0으로 출력
		totalDto = new TotalRateDto(shopName, 0.0, 0.0, 0.0, 0.0);
	}

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

<div class="jumbotron" id="jumbo"
	style="background-image:url('<%=infoDto.getThumb()%>');">
	<h2 style="margin-bottom: 50px;"><%=infoDto.getSname().replaceAll("_", " ")%></h2>
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
		<a href="<%=contextPath%>/main.jsp" type="button"
			class="btn btn-outline-secondary">메인</a>
		<%
			if (mdto != null && shopRatingDao.isAlreadyRated(infoDto.getSname(), mdto.getId())) {
		%>
		<a href="writeProcess.jsp?shop=<%=infoDto.getSname()%>" type="button"
			class="btn btn-outline-success">수정하기</a>
		<%
			} else {
		%>
		<a href="writeProcess.jsp?shop=<%=infoDto.getSname()%>"
			class="btn btn-outline-info">평가하기</a>
		<%
			}
		%>
	</div>
	
	<%-- Comment start --%>
	<iframe src="<%=contextPath%>/view_comm.jsp?shop=<%=shopName%>" 
	width="100%" height="<%=120*list.size() + 200%>" frameborder="0"></iframe>
	<%-- Comment end --%>
</div>



<%@ include file="../inc/footer.jsp"%>

<script>

$(function(){
	
})
<%--
const ajax_button = function(category) {
	$
			.ajax({
				type : 'GET',
				url : '/cafe/main/main_total_ajax.jsp?index='
						+ category + '&start=0&length=5',
				dataType : 'json',
				error : function() {
					alert('error');
				},
				success : function(obj) {
					console.log(obj);
					const listArray = obj.items;
					let rate = category;
					for (let i = 0; i < listArray.length; i++) {
						let name = listArray[i].sname;
						let value = listArray[i][rate];
						let url = listArray[i].thumb;
						let linkName = "#link" + i;
						let imgName = "#shop-img" + i;
						let shopName = "#shop" + i;
						let rateId = "#rate-no" + i;
						$(linkName).attr('href',
								'/cafe/view.jsp?shop=' + name);
						$(imgName).attr('src', url);
						$(shopName).html(name);
						$(rateId).html(value);
					}
				}
			});
}
--%>
</script>

