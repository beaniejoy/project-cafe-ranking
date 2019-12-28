<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%request.setCharacterEncoding("utf-8");%>
<%--임시 헤더 임포트 --%>


<div class="container">
<div class="row">
<div class="col-lg-12">
	<h3>회원 가입</h3>
		<form name="f" method="post" action="save.jsp">
			<div class="form-group row">
				<label for="id" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="id" name="id">
				</div>
				<div id="idMessage"></div>
			</div>
			
			<div class="form-group row">
				<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="password" name="password">
				</div>
				<div id="passwordMessage"></div>
			</div>
			<div class="form-group row">
				<label for="repassword" class="col-sm-2 col-form-label">비밀번호 확인</label>
				<div class="col-sm-10">
						<input type="password" class="form-control" id="repassword" name="repassword">
				</div>
				<div id="repasswordMessage"></div>
			</div>
			<div class="form-group row">
				<label for="phone" class="col-sm-2 col-form-label">핸드폰</label>
				<div class="col-sm-10">
					<input type="tel" class="form-control" id="phone" name="phone" placeholder="000-0000-0000">
				</div>
				<div id="phoneMessage"></div>
			</div>
			<input type="hidden" id="checkPhone" value="no" />
			<div class="form-group row">
				<label for="loc" class="col-sm-2 col-form-label">위치</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="loc" name="loc">
				</div>
				<div id="locMessage"></div>
			</div>
			
			<input type="hidden" id="checkId" value="no" />
		</form>
		
		<div class="text-right">
			<button type="button" id="backMember" class="btn btn-outline-success">취소</button>
			<button type="button" id="saveMember" class="btn btn-outline-success">확인</button>
		
		</div>
</div>
</div>
</div>

<%@ include file="/inc/footer.jsp"%>
<%--임시 푸터 임포트 --%>

<script>
	$(function() {
		$("#id").focus();
		
		$("#backMember").click(function(){
			history.back(-1);
		});
		
		$("#saveMember").click(function() {
			if ($("#id").val().length == 0) {
					$("#id").addClass("is-invalid");
					$("#idMessage").html("<span class='text-danger'>아이디를 입력하세요</span>");
					$("#id").focus();
					return;
				}
			if ($("#password").val().length == 0) {
					$("#password").addClass("is-invalid");
					$("#passwordMessage").html("<span class='text-danger'>비밀번호를 입력하세요</span>");
					$("#password").focus();
					return;
				}
			if ($("#repassword").val().length == 0) {
					$("#repassword").addClass("is-invalid");
					$("#repasswordMessage").html("<span class='text-danger'>비밀번호 확인을 입력하세요</span>");
					$("#repassword").focus();
					return;
				}
			if ($("#password").val() != $("#repassword").val()) {
					$("#repassword").addClass("is-invalid");
					$("#repasswordMessage").html("<span class='text-danger'>비밀번호가 일치 하지 않습니다.</span>");
					$("#password").val("");
					$("#repassword").focus();
					return;
				}
			if ($("#phone").val().length == 0) {
				$("#phone").addClass("is-invalid");
				$("#phoneMessage").html("<span class='text-danger'>핸드폰을 입력하세요</span>");
				$("#phone").focus();
				return;
			}else{
				$.ajax({
					type : 'GET',
					url : 'check_phone_ajax.jsp?phone='
							+ $("#phone").val(),
					dataType : 'json',
					error : function() {
						alert('error');
					},
					success : function(json) {
						if(json.result=="ok" && $("#phone").val().length != 0) {
							$("#phoneMessage").html("<span class='text-success'>등록 가능한 번호입니다.</span>");
							$("#checkPhone").val("yes");
						} else if($("#phone").val().length != 0) {
							$("#phone").addClass("is-invalid");
							$("#phoneMessage").html("<span class='text-danger'>이미 등록된 번호입니다.</span>");
						}
					}
				});
			}
			if ($("#loc").val().length == 0) {
					$("#loc").addClass("is-invalid");
					$("#locMessage").html("<span class='text-danger'>위치를 입력하세요</span>");
					$("#loc").focus();
					return;
			}
			
			f.submit();
		});
		
		$("#id").keyup(function() {
			$("#id").removeClass("is-invalid");
			$("#idMessage").html('');
			
			$.ajax({
				type : 'GET',
				url : 'check_id_ajax.jsp?id='
						+ $("#id").val(),
				dataType : 'json',
				error : function() {
					alert('error');
				},
				success : function(json) {
					if(json.result=="ok" && $("#id").val().length != 0) {
						$("#idMessage").html("<span class='text-success'>등록 가능한 아이디입니다.</span>");
						$("#checkId").val("yes");
					} else if($("#id").val().length != 0) {
						$("#id").addClass("is-invalid");
						$("#idMessage").html("<span class='text-danger'>이미 등록된 아이디입니다.</span>");
						
					}
				}
			});
		});
		$("#password").keyup(function() {
			$("#password").removeClass("is-invalid");
			$("#passwordMessage").html('');
		});
		$("#repassword").keyup(function() {
			$("#repassword").removeClass("is-invalid");
			$("#repasswordMessage").html('');
		});
		
		<%--if(regPhone.test( $("#phone").val() )){--%>
		$("#phone").keyup(function() {
			var temp = $("#phone").val();
			$("#phone").val(temp.replace( /(^02.{0}|^01.{1}|[0-9]{3})([0-9]{4})([0-9]{4})/, "$1-$2-$3" ));
			
			$("#phone").removeClass("is-invalid");
			$("#phoneMessage").html('');
			
		});
		<%--}--%>
		
		$("#loc").keyup(function() {
			$("#loc").removeClass("is-invalid");
			$("#locMessage").html('');
		});
		
	});
</script>