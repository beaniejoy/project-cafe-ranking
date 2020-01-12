# Project cafe ranking :coffee:

jsp와 mariadb를 이용한 web서비스 구현 실습을 위한 미니 프로젝트입니다. 

### Concept
카페에서 공부하거나 작업하는 사람들(일명 카공족)이 많아지면서 카페가 우후죽순 많아진 것은 사실입니다. 그래서 jsp 실습겸 공부를 하기 좋은 카페인지 아닌지 평가하고 그 결과를 점수화해서 main page에 보여주는 웹페이지를 만들어 보았습니다.

## Collaborators


## Content

main.jsp

search.jsp

write.jsp

update.jsp

view.jsp

apply.jsp


<b>view.jsp</b>: 
→ show the information about a selected cafe, and averaged rate of the cafe.
(used table)
- shopinfo
   sname, opertime, loc, phone, menu, thumb
- totalrate
   mood, light, price, taste
- selected cafe table
   id, comm

## Database, Tables

![image](https://user-images.githubusercontent.com/41675375/72217965-7e53f300-3578-11ea-9922-550407d6e225.png)


shopinfo, each_shop_rating, totalrate, apply, member, 



***
  
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
