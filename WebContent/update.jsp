<%@page import="dto.ShopRatingDto"%>
<%@page import="dao.ShopRatingDao"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="<%=contextPath %>/main.jsp">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">매장 평가</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<%
	request.setCharacterEncoding("utf-8");
	int cPage = 0;
	
	String shopName = request.getParameter("shop");
	// 매장이름 파라미터값이 넘어오지 않은 경우
	if(shopName == null || shopName.length() == 0){
		response.sendRedirect(contextPath + "/main.jsp");
		return;
	}
	
	ShopRatingDao dao = ShopRatingDao.getInstance();
	// update페이지에 직접 접근할시 돌려보냄 
	if (mdto == null || dao.isAlreadyRated(shopName, mdto.getId()) == false) {
		response.sendRedirect(contextPath + "/main.jsp");
		return;
	}
	
	String tempPage = request.getParameter("page");
	if (tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	
	ShopRatingDto dto = dao.select(shopName, mdto.getId());
%>

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3><%=shopName %> 리뷰</h3>
			<br>
			<form name="f" method="post" action="saveRating.jsp">
				<div class="form-group row">
					<label for="reviewer" class="col-sm-2 col-form-label">평가자</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="reviewer"
							name="reviewer" readonly="readonly" value="<%=mdto.getId()%>">
					</div>
				</div>
				<div class="form-group row">
					<label for="shop" class="col-sm-2 col-form-label">평가매장</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="shop" name="shop"
							readonly="readonly" value="<%=shopName%>">
					</div>
				</div>
				<br>
				
				<h4>분위기</h4>
				<div class="star-box">
					<%	int mood = (int)(dto.getMood() * 2);
						for(int i = 1; i <= 10; i++ ){
							if(i % 2 == 1){
					%>
					<span class="star star_left mood <%if(i <= mood){%>on<%}%>"></span>
					<%} else{%> 
					<span class="star star_right mood <%if(i <= mood){%>on<%}%>"></span>
					<%} %>
					<%} %>
				</div>
				<h4>조명</h4>
				<div class="star-box">
					<%	int light = (int)(dto.getLight() * 2);
						for(int i = 1; i <= 10; i++ ){
							if(i % 2 == 1){
					%>
					<span class="star star_left light <%if(i <= light){%>on<%}%>"></span>
					<%} else{%> 
					<span class="star star_right light <%if(i <= light){%>on<%}%>"></span>
					<%} %>
					<%} %>
				</div>
				<h4>가격</h4>
				<div class="star-box">
					<%	int price = (int)(dto.getPrice() * 2);
						for(int i = 1; i <= 10; i++ ){
							if(i % 2 == 1){
					%>
					<span class="star star_left price <%if(i <= price){%>on<%}%>"></span>
					<%} else{%> 
					<span class="star star_right price <%if(i <= price){%>on<%}%>"></span>
					<%} %>
					<%} %>
				</div>
				<h4>맛</h4>
				<div class="star-box">
					<%	int taste = (int)(dto.getTaste() * 2);
						for(int i = 1; i <= 10; i++ ){
							if(i % 2 == 1){
					%>
					<span class="star star_left taste <%if(i <= taste){%>on<%}%>"></span>
					<%} else{%> 
					<span class="star star_right taste <%if(i <= taste){%>on<%}%>"></span>
					<%} %>
					<%} %>
				</div>

				<br>

				<div>
					<label for="time">추천 시간대</label>
					<div class='form-group row'>
						<div class="col-5">
							<fieldset>
								<select class='form-control' name="valueA" id="valueA">
									<option value="6am">오전 6 : 00</option>
									<option value="7am">오전 7 : 00</option>
									<option value="8am">오전 8 : 00</option>
									<option value="9am" selected="selected">오전 9 : 00</option>
									<option value="10am">오전 10 : 00</option>
									<option value="11am">오전 11 : 00</option>
									<option value="12pm">오후 12 : 00</option>
									<option value="1pm">오후 01 : 00</option>
									<option value="2pm">오후 02 : 00</option>
									<option value="3pm">오후 03 : 00</option>
									<option value="4pm">오후 04 : 00</option>
									<option value="5pm">오후 05 : 00</option>
									<option value="6pm">오후 06 : 00</option>
									<option value="7pm">오후 07 : 00</option>
									<option value="8pm">오후 08 : 00</option>
									<option value="9pm">오후 09 : 00</option>
									<option value="10pm">오후 10 : 00</option>
									<option value="11pm">오후 11 : 00</option>
									<option value="12am">오전 00 : 00</option>
								</select>
							</fieldset>
						</div>
						<div class="col">
							<label for="valueA">부터</label>
						</div>
						<div class="col-5">
							<fieldset>
								<select class='form-control' name="valueB" id="valueB">
									<option value="6am">오전 6 : 00</option>
									<option value="7am">오전 7 : 00</option>
									<option value="8am">오전 8 : 00</option>
									<option value="9am">오전 9 : 00</option>
									<option value="10am">오전 10 : 00</option>
									<option value="11am">오전 11 : 00</option>
									<option value="12pm">오후 12 : 00</option>
									<option value="1pm">오후 01 : 00</option>
									<option value="2pm">오후 02 : 00</option>
									<option value="3pm">오후 03 : 00</option>
									<option value="4pm">오후 04 : 00</option>
									<option value="5pm">오후 05 : 00</option>
									<option value="6pm">오후 06 : 00</option>
									<option value="7pm">오후 07 : 00</option>
									<option value="8pm">오후 08 : 00</option>
									<option value="9pm" selected="selected">오후 09 : 00</option>
									<option value="10pm">오후 10 : 00</option>
									<option value="11pm">오후 11 : 00</option>
									<option value="12am">오전 00 : 00</option>
								</select>
							</fieldset>
						</div>
						<div class="col">
							<label for="valueB">까지</label>
						</div>
					</div>
				</div>
				<br>

				<div class="form-group">
					<label for="cmm">한줄 평가</label>
					<textarea class="form-control" id="cmm" name="cmm" rows="3"><%=dto.getComm()%></textarea>
				</div>
				<input type="hidden" name="moodRate" id="moodRate" value="" />
				<input type="hidden" name="lightRate" id="lightRate" value="" />
				<input type="hidden" name="priceRate" id="priceRate" value="" />
				<input type="hidden" name="tasteRate" id="tasteRate" value="" />
			</form>
			<br>
			<div class='text-right'>
				<a href='<%=contextPath %>/search.jsp?page=<%=cPage%>' type="button"
					class="btn btn-secondary btn-md">취소</a>
				<button type="button" id='updateCafe' class="btn btn-primary btn-md">등록</button>
			</div>


		</div>
	</div>
</div>
<!-- main end -->

<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {
		$("#cmm").focus();

		$('.starRev span').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			return false;
		});
		$("#updateCafe").click(function() {
			f.action = "updateRating.jsp"
			f.submit();
		});

		
		$(".mood").on('click', function() {
			var idx = $(this).index();
			$("#moodRate").val(idx);
			$(".mood").removeClass("on");
			for (var i = 0; i <= idx; i++) {
				$(".mood").eq(i).addClass("on");
			}
		});
		
		$(".light").on('click', function() {
			var idx = $(this).index();
			$("#lightRate").val(idx);
			$(".light").removeClass("on");
			for (var i = 0; i <= idx; i++) {
				$(".light").eq(i).addClass("on");
			}
		});
		
		$(".price").on('click', function() {
			var idx = $(this).index();
			console.log(idx);
			$("#priceRate").val(idx);
			$(".price").removeClass("on");
			for (var i = 0; i <= idx; i++) {
				$(".price").eq(i).addClass("on");
			}
		});
		
		$(".taste").on('click', function() {
			var idx = $(this).index();
			console.log(idx);
			$("#tasteRate").val(idx);
			$(".taste").removeClass("on");
			for (var i = 0; i <= idx; i++) {
				$(".taste").eq(i).addClass("on");
			}
		});
	});
</script>