<%@page import="dto.MemDto"%>
<%@page import="dao.TotalRateDao"%>
<%@page import="dto.TotalRateDto"%>
<%@page import="dao.ShopRatingDao"%>
<%@page import="dto.ShopRatingDto"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	MemDto memDto = (MemDto)session.getAttribute("member");
	String contextPath = request.getContextPath();
	
	String shopName = request.getParameter("shop");
	
	// shopName 파라미터를 못받아온 경우
	if(shopName == null || shopName.length() == 0){
		response.sendRedirect(contextPath + "/main.jsp");
		return;
	}
	// 로그인 안된 상태로 강제로 들어오는 경우
	if(memDto == null){
		response.sendRedirect(contextPath + "/main.jsp");
		return;
	}
	
	shopName = shopName.replace(" ", "_");
	
	double moodRate = 0;
	double lightRate = 0;
	double priceRate = 0;
	double tasteRate = 0;
	
	// 별점 평가가 double형태로 제대로 들어오지 못한 경우
	// update.jsp를 통하지 않고 직접 들어오는 경우가 대부분
	try{
		moodRate = Double.parseDouble(request.getParameter("moodRate"));
		lightRate = Double.parseDouble(request.getParameter("lightRate"));
		priceRate = Double.parseDouble(request.getParameter("priceRate"));
		tasteRate = Double.parseDouble(request.getParameter("tasteRate"));
	} catch (NumberFormatException e){
		response.sendRedirect(contextPath + "/main.jsp");
		return;
	}
	// 0부터 index 시작해서 ++
	moodRate = ++moodRate / (double)2;
	lightRate = ++lightRate / (double)2;
	priceRate = ++priceRate / (double)2;
	tasteRate = ++tasteRate / (double)2;
	
	String comm = request.getParameter("cmm");
	
	ShopRatingDto dto = new ShopRatingDto(memDto.getId(), moodRate, lightRate, priceRate, tasteRate, comm);
	ShopRatingDao dao = ShopRatingDao.getInstance();
	TotalRateDao totalDao = TotalRateDao.getInstance();
	TotalRateDto totalDto = null;
	
	boolean isSuccess = false;
	
	if(dao.update(dto, shopName, memDto.getId())){
		isSuccess = true;
	}
	
	if (isSuccess) {
		// 평균 계산해서
		 totalDto = dao.average(shopName);
		// totalrate table에 매장이 있으면 update 없으면 insert
		if (totalDao.isTotalShopName(shopName)) {
			totalDao.update(totalDto, shopName);
		} else {
			// insert할 때 url도 집어넣어야 한다.
			totalDao.insert(totalDto, shopName);
		}
%>
<script>
	alert("평가가 성공적으로 수정되었습니다. 감사드립니다.");
	location.href = "view.jsp?shop=<%=shopName%>"
</script>
<%
	} else {
%>
<script>
	alert("평가 수정에 오류가 발생했습니다.");
	history.back(-1);
</script>
<%
	}
%>