<%@ page pageEncoding="utf-8"%>
<%@ include file="/inc/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-2" style="padding: 0px;">
			<div class="title">
				<h4>Cafe Ranking</h4>
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
				<%-- 
				<div class="navigation">
					<div class="text-left" id="btns">
						<button type="button" id="mood" class="btn btn-outline-success">분위기</button>
						<button type="button" id="light" class="btn btn-outline-success">조명</button>
						<button type="button" id="price" class="btn btn-outline-success">가격</button>
						<button type="button" id="taste" class="btn btn-outline-success">맛</button>
					</div>
				</div>
				--%>
			</div>
		</div>
		<div class="col-10" style="padding: 0px;">
			<div class="content">
				<div class="carousel slide title-description" id="carouselExampleInterval" data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active" data-interval="10000">
							<img src="..." class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item" data-interval="2000">
							<img src="..." class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="..." class="d-block w-100" alt="...">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleInterval"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleInterval"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
				<div class="title-rating" style="display: none;">
					<h4>
						<span>Rate - </span><span id="subtitle"></span>
					</h4>

					<div class="result-content">
						<div class="card-deck">
							<%
								for (int i = 0; i < 5; i++) {
							%>
							<div class="card" style="width: 200px;">
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
	});
</script>