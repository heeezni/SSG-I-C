<%--
  JSP 페이지 지시어(Directive)
  - contentType: 응답으로 생성될 콘텐츠의 유형과 문자 인코딩을 설정합니다. (UTF-8로 설정)
--%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%-- 
  Scriptlet 태그: JSP 내에서 자바 코드를 실행하는 데 사용됩니다.
  여기서는 페이징 처리에 필요한 변수들을 선언하고 계산합니다.
--%>
<%
	// ------------------------------------------------------------------------------------------
	// 페이징 처리 로직
	// ------------------------------------------------------------------------------------------

	// 1. 페이징 기본 변수 선언
	int totalRecord = 257;       // 전체 게시물 수 (데이터베이스에서 가져와야 할 값, 현재는 예시)
	int pageSize = 10;           // 한 페이지에 보여줄 게시물 수
	int blockSize = 10;          // 한 블록에 보여줄 페이지 번호 수
	int currentPage = 1;         // 현재 페이지 번호 (기본값 1)

	// 2. 현재 페이지 번호 설정
	// URL에 'currentPage' 파라미터가 있으면 해당 값으로 현재 페이지를 설정합니다.
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 3. 전체 페이지 수 계산
	// (전체 게시물 수 / 한 페이지당 게시물 수)를 올림하여 계산합니다.
	int totalPage = (int) (Math.ceil((double) totalRecord / pageSize));

	// 4. 현재 블록의 시작 페이지와 마지막 페이지 계산
	int firstPage = currentPage - (currentPage - 1) % blockSize; // 현재 블록의 시작 페이지 번호
	int lastPage = firstPage + (blockSize - 1);                // 현재 블록의 마지막 페이지 번호

	// 5. 마지막 페이지 번호 보정
	// 마지막 블록의 마지막 페이지 번호가 전체 페이지 수를 초과하지 않도록 조정합니다.
	if (lastPage > totalPage) {
		lastPage = totalPage;
	}
	// ------------------------------------------------------------------------------------------
%>

<%-- 
  Expression 태그: 변수나 표현식의 값을 문자열로 출력합니다.
  페이징 계산 결과를 확인하기 위한 디버깅용 출력입니다.
--%>
<%="totalRecord=" + totalRecord + "<br>"%>
<%="pageSize=" + pageSize + "<br>"%>
<%="blockSize=" + blockSize + "<br>"%>
<%="currentPage=" + currentPage + "<br>"%>
<%="totalPage=" + totalPage + "<br>"%>
<%="firstPage=" + firstPage + "<br>"%>
<%="lastPage=" + lastPage + "<br>"%>
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
		<%-- 
		  게시물 목록 출력 (예시 데이터)
		  - 실제로는 데이터베이스에서 조회한 데이터를 반복문으로 출력해야 합니다.
		  - 현재는 pageSize만큼 더미 데이터를 반복 출력합니다.
		--%>
		<% for(int i=0; i<pageSize; i++){%>
			  <tr>
				    <td>Jill</td>
				    <td>Smith</td>
				    <td>50</td>
			  </tr>
		<%}%>
		<tr>
			<td colspan="3" align="center">

				<%-- 이전 블록으로 이동 --%>
				<% if(firstPage-1 > 0){%>
					<a href="/board/list.jsp?currentPage=<%=firstPage-1%>">◀</a>
				<%}else{%>
					<a href="javascript:alert('이전 페이지가 없습니다.');">◀</a>
				<%}%>
			
				<%-- 페이지 번호 목록 --%>
				<% for(int j=firstPage; j<=lastPage; j++) {%>
					<a <% if(j==currentPage){%>class="pageNum"<%}%>
						href="/board/list.jsp?currentPage=<%=j%>">[<%=j%>]
					</a>
				<%} %>
			
				<%-- 다음 블록으로 이동 --%>
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
