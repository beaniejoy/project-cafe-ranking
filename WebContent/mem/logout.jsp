<%@ page pageEncoding="utf-8" %>
<%
session.invalidate();
response.sendRedirect("/cafe/main.jsp");
//이부분은 어쩔 수 없는듯...
%>