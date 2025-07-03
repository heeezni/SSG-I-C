<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int totalRecord=26;
	int pageSize=10; // 페이지당 보여질 레코드 수
	int blockSize=10; // 블럭당 보여질 페이지 수
	
	int totalPage=(int)Math.ceil((double)totalRecord/pageSize); // 총 페이지 수
	
	int currentPage=1; // 현재보고있는 페이지
	if(request.getParameter("currentPage")!=null){ // currentPage가 안날라오면 null (null일 땐 명시한 currentPage=1로 갈 수 있게)
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int firstPage= currentPage-(currentPage-1)%blockSize;
	int lastPage= firstPage+(blockSize-1);
	
	int num=totalRecord-((currentPage-1)*pageSize); // 페이지당 시작번호 (currentPage가 증가할 수록 totalRecord감소)
	

%>
<%="totalRecord : "+totalRecord+"<br>" %>
<%="totalPage : "+totalPage+"<br>" %>
<%="currentPage : "+currentPage+"<br>" %>
<%="firstPage : "+firstPage+"<br>" %>
<%="lastPage : "+lastPage+"<br>" %>
<%="num : "+num+"<br>" %>

<!DOCTYPE html>
<html>
<head>
<%-- 공통부분 jsp로 빼고 include로 붙이기--%> 
<%@ include file="/inc/head.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
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
a {
	text-decoration: none;
}
.pageNum {
	font-size: 20px;
	color: red;
}
</style>
</head>
<body>

<h2>댓글 게시판 만들기</h2>
<p>게시판에 댓글을 달 수 있어요!</p>

<table>
	  <tr>
		    <th>No.</th>
		    <th>기사 제목</th>
		    <th>작성자</th>
		    <th>작성일</th>
		    <th>조회수</th>
	  </tr>
	  <%for(int i=1; i<=pageSize; i++){ %>
	  <%if(num<1) break; // data가 0이하이면 멈추기 %>
		  <tr>
			    <td><%=num-- %></td>
			    <td>Smith</td>
			    <td>50</td>
			    <td>50</td>
			    <td>50</td>
		  </tr>
	  <%} %>
	  <tr>
	  	<td colspan="5">
	  		<a href="#">◀</a>
	  		
	  	<%for(int i=firstPage; i<=lastPage; i++){ %>
	  	<%if(i>totalPage)break; // 총 페이지 수를 넘어서면 멈추기 %>
	  		<a <%if(currentPage==i){ %> class="pageNum" <%} %> 
	  			href="/news/news.jsp?currentPage=<%=i%>">[<%=i%>]</a>
	  	<%} %>	  	
	  	
	  		<a href="#">▶</a>
	  	</td>
	  </tr>
	  <tr>
	  	<td colspan="5">
	  		<button>글쓰기</button>
	  	</td>
	  </tr>
</table>

</body>
</html>