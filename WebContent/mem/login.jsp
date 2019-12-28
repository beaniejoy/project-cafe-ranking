<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>


<%
	// mem/login.jsp 을 url에 직접 입력하고 들어오는 경우 돌려보내기 위함 
	if (mdto != null) {
		response.sendRedirect("/cafe/main.jsp");
		return;
	}
%>
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/cafe/main.jsp">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">로그인</li>
	</ol>
</nav>

<!--main start-->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>로그인</h3>

			<form name="f" method="post" action="check_login.jsp">

				<div class="form-group row">
					<label for="id" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="id" name="id">
					</div>
					<div id="emailMessage"></div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password"
							name="password">
					</div>
					<div id="passwordMessage"></div>
				</div>
			</form>
			<div class="text-right">
				<button type="button" id="loginMember"
					class="btn btn-outline-success">로그인</button>
			</div>
		</div>
	</div>
</div>


<!--main end-->


<%@ include file="../inc/footer.jsp"%>
<!-- 여기부터 script... -->

<script>
	$(function() {
		$("#id").focus();
		$("#loginMember")
				.click(
						function() {
							if ($("#id").val().length == 0) {
								$("#id").addClass("is-invalid");
								$("#idMessage")
										.html(
												"<span class='text-danger'>아이디를 입력하세요</span>");
								$("#id").focus();
								return;
							}
							if ($("#password").val().length == 0) {
								$("#password").addClass("is-invalid");
								$("#passwordMessage")
										.html(
												"<span class='text-danger'>비밀번호를 입력하세요</span>");
								$("#password").focus();
								return;
							}
							f.submit();

						});

		$("#email").keyup(function() {
			$("#email").removeClass("is-invalid");
			$("#emailMessage").html('');
		});

		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
		});

	});
</script>