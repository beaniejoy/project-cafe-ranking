<%@page import="dao.TotalRateDao"%>
<%@page import="dto.TotalRateDto"%>
<%@page import="dao.ShopRatingDao"%>
<%@page import="dto.ShopRatingDto"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("reviewer");
	String shopName = request.getParameter("shop");
	shopName = shopName.replace(" ", "_");
	
	double moodRate = Double.parseDouble(request.getParameter("moodRate"));
	double lightRate = Double.parseDouble(request.getParameter("lightRate"));
	double priceRate = Double.parseDouble(request.getParameter("priceRate"));
	double tasteRate = Double.parseDouble(request.getParameter("tasteRate"));
	
	moodRate = ++moodRate / (double)2;
	lightRate = ++lightRate / (double)2;
	priceRate = ++priceRate / (double)2;
	tasteRate = ++tasteRate / (double)2;
	
	String comm = request.getParameter("cmm");

	ShopRatingDto dto = new ShopRatingDto(id, moodRate, lightRate, priceRate, tasteRate, comm);
	ShopRatingDao dao = ShopRatingDao.getInstance();
	TotalRateDao totalDao = TotalRateDao.getInstance();
	TotalRateDto totalDto = null;
	
	boolean isSuccess = false;
	// 해당 매장에 평가가 1개도 없는 경우(table이 아예 없는 경우)
	if (dao.isShopName(shopName)) {
		// 기존에 평가가 있으면 바로 insert
		isSuccess = dao.insert(dto, shopName);
	} else {
		// 없으면 create table 후 insert
		dao.create(shopName);
		isSuccess = dao.insert(dto, shopName);
	}

	if (isSuccess) {
		// 평균 계산해서
		 totalDto = dao.average(shopName);
		// totalrate table에 매장이 있으면 update/ 없으면 insert
		if (totalDao.isTotalShopName(shopName)) {
			totalDao.update(totalDto, shopName);
		} else {
			// insert할 때 url도 집어넣어야 한다.
			totalDao.insert(totalDto, shopName);
		}
%>
<script>
	alert("소중한 평가 감사드립니다.");
	location.href = "view.jsp"
</script>
<%
	} else {
%>
<script>
	alert("평가 등록에 오류가 발생했습니다.");
	history.back(-1);
</script>
<%
	}
%>