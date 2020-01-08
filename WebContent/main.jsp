<%@page import="dao.ShopInfoDao"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/inc/header.jsp"%>

<%
	ShopInfoDao infoDao = ShopInfoDao.getInstance();
	
%>


<div class="container">
	<div class="mainShow">
		<div id="mainTitle">카공도르</div>
		<p id="mainDescription">현재 등록되어 있는 <%=infoDao.getTotalRows() %>개의 매장에 대해서 개인의 경험을 바탕으로 평가해보세요.</p>
		<nav class="navbar navbar-light" id="mainSearch">
			<form class="form-inline" method="post"
				action="<%=contextPath%>/search.jsp">
				<input class="form-control mr-sm-2" type="text"
					placeholder="카페명을 입력해주세요" id="search" name="search"
					aria-label="Search">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">카페찾기</button>
			</form>
		</nav>
		
		<button type="button" class="btn btn-warning" id="showRank">카페 Rank 보기</button>
	</div>


	<div class="row" id="main_row" style="display: none">
		<div class="col-2" style="padding: 0px;">
			<div class="title">
				<h4 style="font-size:40px;">Cafe Rank</h4>
				<div class="list-group">
					<button type="button"
						class="list-group-item list-group-item-action" id="mood">분위기</button>
					<button type="button"
						class="list-group-item list-group-item-action" id="light">조명</button>
					<button type="button"
						class="list-group-item list-group-item-action" id="price">가격</button>
					<button type="button"
						class="list-group-item list-group-item-action" id="taste">맛</button>
				</div>
				
			</div>
		</div>
		<div class="col-10" style="padding: 0px;">
			<div class="content">
				<div class="title-rating" style="display: none;">
					<h4>
						<span>Rate  </span><span id="subtitle" style="font-size:40px;"></span>
					</h4>

					<div class="result-content">
						<div class="card-deck">
							<%
								for (int i = 0; i < 5; i++) {
							%>
							<div class="card">
								<a id="link<%=i%>"><img class="card-img-top"
									id="shop-img<%=i%>"></a>
								<div class="card-body">
									<h6 class="card-title" id="shop<%=i%>"></h6>
									<p class="card-text" id="rate-no<%=i%>"></p>
								</div>

							</div>
							<%
								}
							%>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>

</div>
<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {
		// 중복제거를 위한 함수변수 설정
		const ajax_button = function(category) {
			$
					.ajax({
						type : 'GET',
						url : '/cafe/main/main_total_ajax.jsp?index='
								+ category + '&start=0&length=5',
						dataType : 'json',
						error : function() {
							alert('error');
						},
						success : function(obj) {
							console.log(obj);
							const listArray = obj.items;
							let rate = category;
							for (let i = 0; i < listArray.length; i++) {
								let name = listArray[i].sname;
								let value = listArray[i][rate];
								let url = listArray[i].thumb;
								let linkName = "#link" + i;
								let imgName = "#shop-img" + i;
								let shopName = "#shop" + i;
								let rateId = "#rate-no" + i;
								$(linkName).attr('href',
										'/cafe/view.jsp?shop=' + name);
								$(imgName).attr('src', url);
								$(shopName).html(name);
								$(rateId).html(value);
							}
						}
					});
		}
		$(".list-group-item").click(function() {
			$(".title-description").hide();
			$(".title-rating").show();
			$(".list-group-item").removeClass("active");
		});

		$("#mood").click(function() {
			$("#subtitle").html("분위기");
			ajax_button("mood");
			$("#mood").addClass("active");
		});
		$("#light").click(function() {
			$("#subtitle").html("조명");
			ajax_button("light");
			$("#light").addClass("active");
		});
		$("#price").click(function() {
			$("#subtitle").html("가격");
			ajax_button("price");
			$("#price").addClass("active");
		});
		$("#taste").click(function() {
			$("#subtitle").html("맛");
			ajax_button("taste");
			$("#taste").addClass("active");
		});
		
		$("#showRank").click(function(){
			$(".mainShow").hide();
			$(".row").css({"animation-duration": "3s", "antimation-name": "fadeInUp"});
			$(".row").show();
			$("#activeBack").attr("style", "background:none");
		})
	});
</script>