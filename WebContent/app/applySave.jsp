<%@page import="dao.ApplyDao"%>
<%@page import="dto.ApplyDto"%>
<%@page import="dto.MemDto"%>
<%@page import="dao.MemDao"%>
<%@ page pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>

<%MemDto memdto = (MemDto)session.getAttribute("member");
  if(memdto == null){%>

<% }else{ 
	String id = memdto.getId();
	String cmm = request.getParameter("cmm");
	ApplyDao appDao = ApplyDao.getInstance();
	int Ano = appDao.getMaxNextNo();
	
	ApplyDto appDto = new ApplyDto(Ano,id,cmm,0);
	boolean isSuccess = appDao.insert(appDto);
	if (isSuccess) {
%>
<script>
	location.href = "<%=request.getContextPath() %>/app/apply.jsp?page=1";
</script>

<%
	} else {
%>
<script>
	alert('DB ERROR : 입력 사항을 다시 확인해주세요.');
	history.back(-1);
</script>
<%
	}
}
%>