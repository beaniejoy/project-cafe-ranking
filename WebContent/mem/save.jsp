<%@page import="dto.MemDto"%>
<%@page import="dao.MemDao"%>
<%@ page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	String phone = request.getParameter("phone");
	String loc = request.getParameter("loc");
	MemDao memDao = MemDao.getInstance();
	MemDto memDto = new MemDto(id, pwd, phone, loc);
	boolean isSuccess = memDao.insert(memDto);
	if (isSuccess) {
%>
<script>
	alert('회원 가입이 성공했습니다,메인 페이지에서 다시 로그인해주세요.');
	// 로컬호스트 메인 경로가 project마다 다르기에 그 때 그때의 환경에 맞게 경로 조정
	location.href = "<%=request.getContextPath()%>/main.jsp";
</script>

<%
	} else {
%>
<script>
	alert('회원 가입에 이상이 발생했습니다. 다시 한번 확인해주세요!');
	history.back(-1);
</script>
<%
	}
%>