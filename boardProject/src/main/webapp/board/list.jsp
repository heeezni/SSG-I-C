<%@ page contentType="text/html; charset=UTF-8"%>
<%
	int totalRecord=257; // 총 레코드 수 (예시)
	int pageSize=10; // 한 페이지당 보여질 레코드 수
	//int totalPage=(totalRecord%pageSize==0)? totalRecord/pageSize : totalRecord/pageSize+1; // 총 페이지 수
	int blockSize=10; // 블럭당 보여질 페이지수
	int currentPage=1; //현재 유저가 보고있는 페이지
	if(request.getParameter("currentPage")!=null){ // 페이지 파라미터가 넘어올 때만
		currentPage=Integer.parseInt(request.getParameter("currentPage")); // 유저가 페이지 번호를 눌렀을 때의 정보 대체		
	}
	
	int totalPage=(int)(Math.ceil((double)totalRecord/pageSize)); // 무조건 올림
	//int firstPage=(int)Math.ceil((double)(totalPage/blockSize))*pageSize+1; // 전체 블럭단위 시작 페이지
	//int lastPage=(int)Math.ceil((double)(totalPage/blockSize))*pageSize+pageSize; //전체 블럭단위로 마지막 페이지
	int firstPage=currentPage-(currentPage-1)%blockSize; // 블럭당 시작 페이지
	int lastPage= firstPage+(blockSize-1); // 블럭당 마지막 페이지
	
	// 마지막 블럭에서 totalPage만 나올 수 있도록
	if(lastPage>totalPage) lastPage=totalPage;

	
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
		
		.pageNum{
			font-Size:17px;
			font-weight:bold;
			color:red;			
		}
		</style>
	</head>
	<body>
	
		<h2>페이징 처리 예제</h2>
		
		<table>
			  <tr>
				    <th>First Name</th>
				    <th>Last Name</th>
				    <th>Points</th>
			  </tr>
		<% for(int i=0; i<pageSize; i++){%>
			  <tr>
				    <td>Jill</td>
				    <td>Smith</td>
				    <td>50</td>
			  </tr>
		<%}%>
		<tr>
			<td colspan="3" align="center">
			<% if(firstPage-1 > 0){%>
				<a href="/board/list.jsp?currentPage=<%=firstPage-1%>">◀</a>
			<%}else{%>
				<a href="javascript:alert('이전 페이지가 없습니다.');">◀</a>
			<%}%>
			
			<% for(int j=firstPage; j<=lastPage; j++) {%>
				<a <% if(j==currentPage){%>class="pageNum"<%}%>
					href="/board/list.jsp?currentPage=<%=j%>">[<%=j%>]
				</a>
			<%} %>
			
			<% if(lastPage<totalPage){%>
				<a href="/board/list.jsp?currentPage=<%=firstPage+blockSize%>">▶</a>
			<%}else{%>
				<a href="javascript:alert('다음 페이지가 없습니다.');">▶</a>
			<%}%>
			
			</td>
		</tr>
		</table>
	
	</body>
</html>
