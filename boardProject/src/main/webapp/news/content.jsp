<%@page import="com.sinse.boardproject.model.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.sinse.boardproject.repository.CommentDAO"%>
<%@page import="com.sinse.boardproject.model.News"%>
<%@page import="com.sinse.boardproject.repository.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%! 
	NewsDAO newsDAO=new NewsDAO();
	CommentDAO commentDAO=new CommentDAO(); 
	// comment를 어디다 달아야할 지를 생각하기
%>	
	
<%
	// 내장 객체
	String news_id=request.getParameter("news_id");
	//out.print("넘겨받은 파라미터는 "+news_id);
	News news=newsDAO.select(Integer.parseInt(news_id));
	List<Comment> commentList = commentDAO.selectByNewsId(Integer.parseInt(news_id));
	
%>
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style>
/* body 요소의 기본 폰트 스타일을 설정합니다. */
body {
	font-family: Arial, Helvetica, sans-serif;
}

/* 모든 요소에 대해 box-sizing을 border-box로 설정하여 패딩과 테두리가 너비에 포함되도록 합니다. */
* {
	box-sizing: border-box;
}

/* 텍스트 입력 필드, 드롭다운, 텍스트 영역의 스타일을 설정합니다. */
input[type=text], select, textarea {
	width: 100%; /* 너비를 100%로 설정 */
	padding: 12px; /* 내부 여백 설정 */
	border: 1px solid #ccc; /* 테두리 스타일 설정 */
	border-radius: 4px; /* 테두리 둥글게 설정 */
	box-sizing: border-box; /* box-sizing 설정 */
	margin-top: 6px; /* 위쪽 마진 설정 */
	margin-bottom: 16px; /* 아래쪽 마진 설정 */
	resize: vertical; /* 세로 방향으로만 크기 조절 가능 */
}

/* 버튼 스타일을 설정합니다. */
input[type=button] {
	background-color: #04AA6D; /* 배경색 설정 */
	color: white; /* 글자색 설정 */
	padding: 12px 20px; /* 내부 여백 설정 */
	border: none; /* 테두리 없음 */
	border-radius: 4px; /* 테두리 둥글게 설정 */
	cursor: pointer; /* 마우스 오버 시 커서 변경 */
}

/* 버튼에 마우스 오버 시 배경색을 변경합니다. */
input[type=button]:hover {
	background-color: #45a049;
}

/* 컨테이너 클래스의 스타일을 설정합니다. */
.container {
	border-radius: 5px; /* 테두리 둥글게 설정 */
	background-color: #f2f2f2; /* 배경색 설정 */
	padding: 20px; /* 내부 여백 설정 */
}
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
</style>
<%-- 공통 링크 파일을 포함합니다. --%>
<%@ include file="/inc/head_link.jsp" %>
<script type="text/javascript">
	// jQuery를 사용하여 문서 로딩이 완료되면 실행될 함수를 정의합니다.
	$(()=>{
		// 서머노트(Summernote) 에디터를 #content 요소에 연동합니다.
		$("#content").summernote({
			height: 150 // 에디터의 높이 설정
		});
		$("#content").summernote('code', `<%=news.getContent()%>`);
		
		// 버튼 이벤트
		$("#bt_news_edit").click(()=>{
			
		});
		$("#bt_news_del").click(()=>{
			
		});
		$("#bt_news_list").click(()=>{
			location.href="/news/list.jsp";
		});
		
		$("#bt_news_regist").click(()=>{
			$("#comment_form").attr({
				method:"POST", // HTTP 프로토콜 통신에 사용되는 데이터 구성(Payload) body에 탑재됨
				action:"/comment/regist"
			});
			$("#comment_form").submit(); //전송
		});
	});
</script>

</head>
<body>

	<h3>댓글 게시판 - 글쓰기</h3>

	<div class="container">
		<form>
			<label for="fname">Title</label> <input type="text" id="fname" name="title" value="<%=news.getTitle()%>"> 
			<label for="lname">Writer</label> <input type="text" id="lname" name="writer" value="<%=news.getWriter()%>"> 			<label for="subject">Content</label>
			<textarea id="content" name="content" placeholder="내용입력" style="height: 200px"></textarea>
			<input type="button" value="수정" id="bt_news_edit">
			<input type="button" value="삭제" id="bt_news_del">
			<input type="button" value="목록" id="bt_news_list">
		</form>
		
		<form id="comment_form">
			
			<div id="comment_header">
					<input type="text" style="width:60%" name="msg">
					<input type="text" style="width:25%" name="user">
					<input type="hidden" name="news_id" value="<%= news.getNews_id()%>">
					<input type="button" value="등록" id="bt_news_regist">
			</div>		
		</form>
		<div id="comment_content">
			<table>
				<tr>
					<th>댓글 제목</th>
					<th>작성자</th>
					<th>등록일</th>		
				</tr>
				
				<%for(Comment comment:commentList){ %>
				<tr>
					<td><%=comment.getMsg() %></td>
					<td><%=comment.getUser() %></td>
					<td><%=comment.getMsgdate() %></td>		
				</tr>
				<%} %>
			</table>
		</div>		
	</div>
</body>
</html>