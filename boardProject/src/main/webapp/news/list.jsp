<%@page import="com.sinse.boardproject.common.Paging"%>
<%@page import="com.sinse.boardproject.model.News"%>
<%@page import="java.util.List"%>
<%@page import="com.sinse.boardproject.repository.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--! 
	서블릿(JSP)의 멤버 영역으로, NewsDAO와 Paging 객체를 생성합니다.
	이 객체들은 해당 JSP 페이지의 모든 요청 처리에서 공유됩니다.
--%>
<%! 
	NewsDAO newsDAO=new NewsDAO(); 
	Paging paging = new Paging();
%>
<%-- =============================================================== --%>
<%-- JSP 스크립틀릿: 페이징 처리에 필요한 변수들을 계산하는 영역입니다. --%>
<%-- =============================================================== --%>
<%
	// 데이터베이스에서 모든 뉴스 목록을 가져옵니다.
	List<News> newsList=newsDAO.selectAll();
	// Paging 객체를 초기화하여 페이징 관련 계산을 수행합니다.
	// newsList: 페이징을 적용할 전체 데이터 목록
	// request: 현재 요청 정보를 담고 있는 HttpServletRequest 객체
	paging.init(newsList, request);
%>

<!DOCTYPE html>
<html>
<head>
<%-- 공통 CSS/JS 파일을 포함시키는 부분입니다. --%> 
<%@ include file="/inc/head.jsp" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<%-- =============================================================== --%>
<%-- CSS 스타일: 테이블 및 페이징 링크의 스타일을 정의합니다. --%>
<%-- =============================================================== --%>
<style>
table {
  border-collapse: collapse; /* 테이블 테두리 겹침 방지 */
  border-spacing: 0; /* 테이블 셀 간격 제거 */
  width: 100%; /* 테이블 너비를 100%로 설정 */
  border: 1px solid #ddd; /* 테이블 테두리 스타일 지정 */
}

th, td {
  text-align: left; /* 텍스트 왼쪽 정렬 */
  padding: 16px; /* 셀 내부 여백 설정 */
}

tr:nth-child(even) {
  background-color: #f2f2f2; /* 짝수 번째 행 배경색 지정 */
}
a {
	text-decoration: none; /* 링크 밑줄 제거 */
}
/* 현재 페이지 번호에 적용될 스타일입니다. */
.pageNum {
	font-size: 20px; /* 글자 크기 */
	color: red; /* 글자 색상 */
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	// jQuery를 사용하여 문서 로딩이 완료되면 실행될 함수를 정의합니다.
	$(()=>{
		// '글쓰기' 버튼 클릭 시 /news/write.jsp 페이지로 이동합니다.
		$('button').click(()=> {
			location.href="/news/write.jsp"
		});
	});

</script>
</head>
<body>

<h2>댓글 게시판 만들기</h2>
<p>게시판에 댓글을 달 수 있어요!</p>

<%-- =============================================================== --%>
<%-- 게시물 목록을 표시하는 테이블입니다. --%>
<%-- =============================================================== --%>
<table>
	  <tr>
		    <th>No.</th>
		    <th>기사 제목</th>
		    <th>작성자</th>
		    <th>작성일</th>
		    <th>조회수</th>
	  </tr>
	  
	  <%-- 한 페이지에 보여줄 게시물 수(pageSize)만큼 반복합니다. --%>
	  <%
	  	// 현재 페이지에서 시작할 게시물의 인덱스를 가져옵니다.
	  	int curPos=paging.getCurPos();
	  	// 현재 페이지에서 시작할 게시물의 번호를 가져옵니다.
	  	int num=paging.getNum();
	  %>
	  <%-- 한 페이지에 보여줄 게시물 수만큼 반복합니다. --%>
	  <%for(int i=1; i<=paging.getPageSize(); i++){ %>
	  <%-- 더 이상 표시할 게시물이 없으면 반복을 중단합니다. --%>
	  <%if(num<1) break; %>
	  <%-- 현재 인덱스에 해당하는 News 객체를 가져온 후, 인덱스를 1 증가시킵니다. --%>
	  <%News news=newsList.get(curPos++); %>
		  <tr>
			    <td><%=num-- %></td>
			    <td><a href="/news/content.jsp?news_id=<%=news.getNews_id()%>"><%=news.getTitle() %></a></td>
			    <td><%=news.getWriter() %></td>
			    <td><%=news.getRegdate() %></td>
			    <td><%=news.getHit() %></td>
		  </tr>
	  <%} %>
	  <tr>
	  	<td colspan="5">
	  		<%-- =============================================================== --%>
			<%-- 페이징 번호 및 이전/다음 링크를 표시합니다. --%>
			<%-- =============================================================== --%>
	  		<a href="#">◀</a>
	  		
	  		<%-- 현재 블록의 페이지 번호들을 반복하여 링크를 생성합니다. --%>
	  		<%for(int i=paging.getFirstPage(); i<=paging.getLastPage(); i++){ %>
	  		<%-- 총 페이지 수를 넘어서는 페이지 번호는 표시하지 않습니다. --%>
	  		<%if(i>paging.getTotalPage())break; %>
	  			<%-- 현재 페이지인 경우 'pageNum' 클래스를 적용하여 스타일을 다르게 표시합니다. --%>
	  			<a <%if(paging.getCurrentPage()==i){ %> class="pageNum" <%} %> 
	  				href="/news/list.jsp?currentPage=<%=i%>">[<%=i%>]</a>
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