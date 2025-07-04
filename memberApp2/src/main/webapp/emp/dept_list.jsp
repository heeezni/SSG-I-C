<%@page import="com.sinse.memberapp2.model.Dept"%>
<%@page import="java.util.List"%>
<%@page import="com.sinse.memberapp2.repository.DeptDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DeptDAO deptDAO=new DeptDAO();

	List<Dept> list=deptDAO.selectAll();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="100%">
		<tr>
			<th>DEPTNO</th>
			<th>DNAME</th>
			<th>LOC</th>
			<th>근무자 수</th>		
		</tr>
		
		<%for(Dept d:list){ %>
		<tr>
			<td><%=d.getDeptno() %></td>
			<td><%=d.getDname() %></td>
			<td><%=d.getLoc() %></td>
			<td><%=d.getEmpList().size() %></td>
		</tr>
		<%} %>
	</table>
</body>
</html>