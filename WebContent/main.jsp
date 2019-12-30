<%@ page pageEncoding="utf-8"%>
<%@ include file="/inc/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-2" style="padding: 0px;">
			<div class="title">
				<h4>Cafe Ranking</h4>
				<div class="navigation">
					<div class="text-left" id="btns">
						<button type="button" id="mood" class="btn btn-outline-success">분위기</button>
						<button type="button" id="light" class="btn btn-outline-success">조명</button>
						<button type="button" id="price" class="btn btn-outline-success">가격</button>
						<button type="button" id="taste" class="btn btn-outline-success">맛</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-10" style="padding: 0px;">
			<div class="content">
				<div class="title-description">
					<h4>Description</h4>
					<p>description_description</p>
				</div>
				<div class="title-rating" style="display: none;">
					<h4>Rating</h4>
					<h5 id="subtitle"></h5>
					<div class="result-content">
						<div class="card-deck">
							<%
								for (int i = 0; i < 5; i++) {
							%>
							<div class="card">
								<img src="..." class="card-img-top" id="shop-img<%=i%>"
									alt="...">
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
				$.ajax({
					type : 'GET',
					url : '/cafe/main/main_total_ajax.jsp?index=' + category
							+ '&start=0&length=5',
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
							let url = listArray[i].imgurl;
							let imgName = "#shop-img" + i;
							let shopName = "#shop" + i;
							let rateId = "#rate-no" + i;
							$(imgName).attr('src', url);
							$(shopName).html(name);
							$(rateId).html(value);
						}
					}
				});
			}
			$(".btn").click(function() {
				$(".title-description").hide();
				$(".title-rating").show();
			});

			$("#mood").click(function() {
				$("#subtitle").html("분위기");
				ajax_button("mood");
			});
			$("#light").click(function() {
				$("#subtitle").html("조명");
				ajax_button("light");
			});
			$("#price").click(function() {
				$("#subtitle").html("가격");
				ajax_button("price");
			});
			$("#taste").click(function() {
				$("#subtitle").html("맛");
				ajax_button("taste");
			});
		});
	</script>