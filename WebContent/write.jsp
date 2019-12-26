<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">매장 평가</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<%
	int cPage = 0;
	String tempPage = request.getParameter("page");
	if (tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
%>

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>스타벅스 종로DT점 리뷰</h3>
			<br>
			<form name="f" method="post" action="saveRating.jsp">
				<div class="form-group row">
					<label for="reviewer" class="col-sm-2 col-form-label">평가자</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="reviewer"
							name="reviewer" readonly="readonly" value="qwewew">
					</div>
				</div>
				<div class="form-group row">
					<label for="shop" class="col-sm-2 col-form-label">평가매장</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="shop" name="shop"
							readonly="readonly" value="스타벅스 종로DT점">
					</div>
				</div>
				<br>
				
				<h4>분위기</h4>
				<div class="star-box">
					<span class="star star_left mood"></span> <span class="star star_right mood"></span>
					<span class="star star_left mood"></span> <span class="star star_right mood"></span>
					<span class="star star_left mood"></span> <span class="star star_right mood"></span>
					<span class="star star_left mood"></span> <span class="star star_right mood"></span>
					<span class="star star_left mood"></span> <span class="star star_right mood"></span>
				</div>
				<h4>조명</h4>
				<div class="star-box">
					<span class="star star_left light"></span> <span class="star star_right light"></span>
					<span class="star star_left light"></span> <span class="star star_right light"></span>
					<span class="star star_left light"></span> <span class="star star_right light"></span>
					<span class="star star_left light"></span> <span class="star star_right light"></span>
					<span class="star star_left light"></span> <span class="star star_right light"></span>
				</div>
				<h4>가격</h4>
				<div class="star-box">
					<span class="star star_left price"></span> <span class="star star_right price"></span>
					<span class="star star_left price"></span> <span class="star star_right price"></span>
					<span class="star star_left price"></span> <span class="star star_right price"></span>
					<span class="star star_left price"></span> <span class="star star_right price"></span>
					<span class="star star_left price"></span> <span class="star star_right price"></span>
				</div>
				<h4>맛</h4>
				<div class="star-box">
					<span class="star star_left taste"></span> <span class="star star_right taste"></span>
					<span class="star star_left taste"></span> <span class="star star_right taste"></span>
					<span class="star star_left taste"></span> <span class="star star_right taste"></span>
					<span class="star star_left taste"></span> <span class="star star_right taste"></span>
					<span class="star star_left taste"></span> <span class="star star_right taste"></span>
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
					<textarea class="form-control" id="cmm" name="cmm" rows="3"></textarea>
				</div>
				<input type="hidden" name="moodRate" id="moodRate" value="" />
				<input type="hidden" name="lightRate" id="lightRate" value="" />
				<input type="hidden" name="priceRate" id="priceRate" value="" />
				<input type="hidden" name="tasteRate" id="tasteRate" value="" />
			</form>
			<br>
			<div class='text-right'>
				<a href='list.jsp?page=<%=cPage%>' type="button"
					class="btn btn-secondary btn-md">취소</a>
				<button type="button" id='saveCafe' class="btn btn-primary btn-md">등록</button>
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
		$("#saveCafe").click(function() {
			f.action = "saveRating.jsp"
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
			console.log(idx);
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