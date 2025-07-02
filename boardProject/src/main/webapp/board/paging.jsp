<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	int totalRecord = 324; //DB연동 시 DB반영하기
	int pageSize = 10;
	int blockSize = 10;
	int currentPage = 77; // 현재 보고있는 페이지
	// 파라미터 먼저 받고 계산은 나중에!
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int totalPage =(int)(Math.ceil((double)totalRecord/pageSize));
	// currentPage = 15면 firstPage=11, lastPage=20
	int firstPage=	currentPage-(currentPage-1)%blockSize;
	int lastPage=firstPage+(blockSize-1);
	
	if(lastPage>totalPage){
		lastPage=totalPage;
	}
	
%>
<%="totalRecord="+totalRecord+"<br>" %>
<%="pageSize="+pageSize+"<br>" %>
<%="blockSize="+blockSize+"<br>" %>
<%="currentPage="+currentPage+"<br>" %>
<%="totalPage="+totalPage+"<br>" %>
<%="firstPage="+firstPage+"<br>" %>
<%="lastPage="+lastPage+"<br>" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 16px;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}
a{
	text-decoration: none;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">


</script>
</head>
<body>

	<h2>페이징 처리</h2>
	<p>나 혼자 해보기!</p>

	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Points</th>
		</tr>
		
		<% for(int i=0; i<pageSize; i++){ %>
			<tr>
				<td>Jill</td>
				<td>Smith</td>
				<td>50</td>
			</tr>
		<%} %>
		
		<tr >
			<%-- <td> 하나로 묶고 페이지 번호만 출력 --%>
			<td colspan="3" align="center">
				<a href="#">◀</a>
			<% for(int j=firstPage; j<=lastPage ;j++){ %>
					<a href="/board/paging.jsp?currentPage=<%=j%>">[<%= j%>]</a>
			<%} %>
				<a href="#">▶</a>
			</td>
		</tr>
	</table>

</body>
</html>
