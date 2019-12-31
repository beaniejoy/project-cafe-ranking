## Project cafe ranking

html, css, javascript(jQuery), jsp



login.jsp :

<%
String tempback = response.sendRedirect(request.getHeader("referer"));
	// mem/login.jsp 을 url에 직접 입력하고 들어오는 경우 돌려보내기 위함 
	if (mdto != null) {
		response.sendRedirect("/cafe/main.jsp");
		return;
	}
%>
~
<div class="form-group row">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password"
							name="password">
							<input type="hidden" name="back_url" value=<%=tempback %>>
					</div>
  
  
check_login.jsp : if(memdto != null){
	session.setMaxInactiveInterval(60*60*24);
	session.setAttribute("member", memdto);
	%>
	<script>
	alert('로그인 성공');
	location.href="<%=backURL%>";
	</script>
	<%
