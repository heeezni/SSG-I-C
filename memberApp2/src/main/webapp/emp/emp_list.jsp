
<%@page import="com.sinse.memberapp2.model.Dept"%>
<%@page import="com.sinse.memberapp2.model.Emp"%>
<%@page import="java.util.List"%>
<%@page import="com.sinse.memberapp2.repository.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	EmpDAO empDAO=new EmpDAO();
	List<Emp> empList =empDAO.selectAll();

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
			<th>EMPNO</th>
			<th>ENAME</th>
			<th>JOB</th>
			<th>MGR</th>		
			<th>HIREDATE</th>		
			<th>SAL</th>		
			<th>COMM</th>		
			<th>Dept의 부서명</th>		
			<th>Dept의 부서위치</th>		
		</tr>
		
		<%for(Emp e: empList ){ %>
		<% Dept dept=e.getDept(); %>
		<tr>
			<td><%=e.getEmpno() %></td>
			<td><%=e.getEname() %></td>
			<td><%=e.getJob() %></td>
			<td><%=e.getMgr() %></td>
			<td><%=e.getHiredate() %></td>
			<td><%=e.getSal() %></td>
			<td><%=e.getComm() %></td>
			<td><%=dept.getDname() %></td>
			<td><%=dept.getLoc() %></td>
		</tr>
		<%} %>
	</table>
</body>
</html>