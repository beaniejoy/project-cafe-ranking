<%@page import="dao.ShopRatingDao"%>
<%@page import="dto.MemDto"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String contextPath = request.getContextPath();
	String shopName = request.getParameter("shop");
	MemDto mDto = (MemDto) session.getAttribute("member");
	ShopRatingDao dao = ShopRatingDao.getInstance();
	if(mDto == null){
		%>
		<script>
			alert("카공도르 회원만 이용할 수 있습니다. 로그인 페이지로 돌아갑니다.");
			location.href = "<%=contextPath%>/mem/login.jsp?shop=<%=shopName%>";
		</script>
		<%
	} else if(dao.isAlreadyRated(shopName, mDto.getId()) == false){
		%>
		<script>
			location.href = "<%=contextPath%>/write.jsp?shop=<%=shopName%>";			
		</script>
		<%
	}
	
%>