<%@page import="dao.MemDao"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="appllication/json;charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");%>

<%
String id = request.getParameter("id");
MemDao memdao = MemDao.getInstance();
boolean isntExisted = (memdao.select(id) == null);
JSONObject obj = new JSONObject();
if(isntExisted){
	obj.put("result","ok");
}else{
	obj.put("result","fail");
}
out.print(obj.toString());
%>