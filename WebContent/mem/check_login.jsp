<%@page import="dto.MemDto"%>
<%@page import="dao.MemDao"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String referer = request.getParameter("url");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	MemDao memdao = MemDao.getInstance();
	MemDto memdto = new MemDto(id, password, null, null);
	memdto = memdao.getMember(memdto);
	
	
	if (memdto != null) {
		session.setMaxInactiveInterval(60 * 60 * 24);
		session.setAttribute("member", memdto);
%>
<script>
	alert('로그인 성공');
	location.href="<%=referer%>";
</script>
<%
	} else {
%>
<script>
	alert('로그인 정보가 잘못 되었습니다.');
	history.back(-1);
</script>
<%
	}
%>