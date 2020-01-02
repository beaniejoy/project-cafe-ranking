<%@page import="dao.ApplyDao"%>
<%@page import="dto.ApplyDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%request.setCharacterEncoding("utf-8");%>

<%--paging --%>
<%
	int len = 5;
	int pageLength = 5;//한 줄에 페이지 몇개까지 보여줄지(언제 prev next시킬지)
	int start = 0;
	int totalRows = 0;
	int totalPage = 0;
	int startPage = 0;
	int endPage = 0;
	int pageNum = 0;
	int cPage = 0;
	String temPage = request.getParameter("page");
	if (temPage == null || temPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(temPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	ApplyDao dao = ApplyDao.getInstance();
	
	//이전에 작성한 코멘트가 있을 경우의 추가 부분
	/*ApplyDto appdto =(ApplyDto)session.getAttribute("comment");
	if((mdto != null) && (appdto == null) ){
	 MemDto mdto = (MemDto)session.getAttribute("member");
	String id = request.getParameter("id");
	String comment = request.getParameter("cmm");*/
	//여기까지
	
	totalRows = dao.getTotalRows();
	totalPage = totalRows % len == 0 ? totalRows / len : totalRows / len + 1;
	if (totalPage == 0) {
		totalPage = 1;
	}
	if (cPage > totalPage) {
		cPage = totalPage;
	}
	start = (cPage - 1) * len;
	pageNum = totalRows - (cPage - 1) * len;
	ArrayList<ApplyDto> list = dao.select(start, len);
	int currentBlock = cPage % pageLength == 0 ? (cPage / pageLength) : ((cPage / pageLength) + 1);
	int totalBlock = totalPage % pageLength == 0 ? (totalPage / pageLength) : ((totalPage / pageLength) + 1);
	startPage = 1 + (currentBlock - 1) * pageLength;
	endPage = pageLength + (currentBlock - 1) * pageLength;
	if (currentBlock == totalBlock) {
		endPage = totalPage;
	}
%>
<%--end of paging --%>

<div class="container">
<div class="row">
<div class="col-lg-12">
	<h3>추천 카페 신청 </h3>
	<%if(mdto != null) { //헤더의 member dto %>
	<form name="f" method="post">
										<%--/apply.jsp?page=1" --%>
		<div class="text-right">
				<button type="button" id="saveApply" class="btn btn-outline-success">신청</button>
		</div>
		
		<div class="form-group">
 		 <textarea class="form-control rounded-0" id="cmm" name="cmm" rows="3" placeholder="최소 1자,최대 300자까지 작성 가능"></textarea>
 		 <input type="hidden" id="checkCmm" value="no" />
 		 <div id="cmmMessage"></div>
 		 <span id="counter">(0 / 300)</span>
		</div>
	</form>
	<%}%>
	<div class="list-group">
		<%if(list.size() != 0) {%>
			<%for (ApplyDto appdto : list){%>
		<div class="d-flex w-100 justify-content-between">
					<small id = "Ano" class = "<%=appdto.getNo()%>" ><%=appdto.getNo()%></small>
						<div class="text-right">
					<%if(mdto!=null && mdto.getId().equals(appdto.getId())) { %>
					<button type="button" class="btn btn-primary" name="delcmm" id= "<%=appdto.getNo()%>" name = "delcmm" > 삭제 </button>
					<% }%>
					<button type="button" class="btn btn-primary" name="thmup" id= "<%=appdto.getNo()%>" name = "thmup" > Up
						<span class="badge badge-light" ><%=appdto.getThmup()%></span>
					</button>
						</div>
		</div>
				 <p id="comm"><%=appdto.getCmm()%></p>
				 <small>작성자 : <%=appdto.getId()%></small>
		
			<%}%>
		<%} %>
</div>
</div>
</div>

<%--paging --%>
<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">

		<%
			if (currentBlock == 1) {
		%>
		<li class="page-item disabled"><a class="page-link" href="#"
			tabindex="-1" aria-disabled="true">Previous</a></li>
		<%
			} else {
		%>
		<li class="page-item"><a class="page-link"
			href="<%=contextPath %>/app/apply.jsp?page=<%=startPage - 1%>">Previous</a></li>
		<%
			}
		%>
		
		
		<%
			for (int i = startPage; i <= endPage; i++) {
		%>
		<li class="page-item <%if (cPage == i) {%>active<%}%>"><a
			class="page-link" href="<%=contextPath %>/app/apply.jsp?page=<%=i%>"><%=i%></a></li>
		<%
			}
		%>
		
		<%
			if (currentBlock == totalBlock) {
		%>
		<li class="page-item disabled"><a class="page-link" href="#"
			tabindex="-1" aria-disabled="true">Next</a></li>
		<%
			} else {
		%>
		<li class="page-item"><a class="page-link" href="<%=contextPath %>/app/apply.jsp?page=<%=endPage + 1%>">Next</a></li>
		<%
			}
		%>

	</ul>
</nav>
<%--end of paging --%>

<%@ include file="../inc/footer.jsp"%>

<script>
$(function() {
		$("#saveApply").click(function() {
			if ($("#cmm").val().length == 0) {
				$("#cmm").addClass("is-invalid");
				$("#cmmMessage").html("<span class='text-danger'>최소 1글자 이상은 입력해주세요.</span>");
				$("#cmm").focus();
				
				return;
			}
				<%-- mdto.getId(); 
				$("#cmm").val();--%>
				f.action = "/cafe/app/applySave.jsp";
				f.submit();
		});
		
		$("#cmm").keyup(function() {
			$("#cmm").removeClass("is-invalid");
			$("#cmmMessage").html('');
			
			var content = $(this).val();
			$('#counter').html('('+content.length + '/300)');
		});
	
	 $('[name="thmup"]').click(function(){
		<%if(mdto!=null){%>
		$.ajax({
			type : 'GET',
			url : '/cafe/app/thmup_ajax.jsp?Ano='
					+$(this).attr('id'),
			dataType : 'json',
			error : function() {
				alert('error');
			},
			success : function(json) {
				if(json.result=="ok") {
					location.href = "/cafe/app/apply.jsp?page=1";
				} else {
					alert('에이젝스 오류');
				}
			}
		});
		<%}%>
		f.submit();
	});
	 
	 $('[name="delcmm"]').click(function(){
			$.ajax({
				type : 'GET',
				url : '/cafe/app/appDel_ajax.jsp?Ano='
					+$(this).attr('id'),
				dataType : 'json',
				error : function() {
					alert('error');
				},
				success : function(json) {
					if(json.result=="ok") {
						location.href = "/cafe/app/apply.jsp?page=1";
					} else {
						alert('에이젝스 오류');
					}
				}
			});
			f.submit();
		});
});
</script>