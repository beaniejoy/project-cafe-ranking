<%@page import="dao.ShopInfoDao"%>
<%@page import="dao.TotalRateDao"%>
<%@ page pageEncoding='utf-8'%>

<%
	
	request.setCharacterEncoding("utf-8");
	TotalRateDao dao = TotalRateDao.getInstance();
	ShopInfoDao infoDao = ShopInfoDao.getInstance();
	String rate = request.getParameter("index");
	int start = Integer.parseInt(request.getParameter("start"));
	int length = Integer.parseInt(request.getParameter("length"));
	
	out.print(dao.selectJson(start, length, rate));
%>