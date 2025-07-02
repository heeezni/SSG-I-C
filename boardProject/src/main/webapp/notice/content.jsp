<%@page import="com.sinse.boardproject.model.Notice"%>
<%@page import="com.sinse.boardproject.repository.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%! NoticeDAO noticeDAO=new NoticeDAO(); %>
<%
	// 요청 객체로부터 파라미터 뽑아내기
	// 이 스크립틀릿 영역은 이 jsp가 서블릿으로 변경되어질 때, service() 메서드 영역이므로
	// 이미 service()메서드의 매개변수인 요청객체 & 응답객체 넘겨받은 상태
	// service(HttpServletRequest request, HttpServletResponse response)
	String notice_id=request.getParameter("notice_id");
	
	//String sql ="select * from notice where notice_id="+notice_id;
	//out.print(sql);
	
	Notice notice=noticeDAO.select(Integer.parseInt(notice_id));
	
%>
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}

input[type=button] {
	background-color: #04AA6D;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=button]:hover {
	background-color: #45a049;
}

.container {
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>
<script type="text/javascript">
	$(()=>{
		// 서머노트 연동
		$("#content").summernote({
			placeholder: '내용 입력',
			height: 150
		});
		$("#content").summernote('code',"<%=notice.getContent()%>");

		// 버튼에 이벤트 연결 (서머노트 버튼도 포함되어있음 주의)
		// 3번째 - 수정
		$($("input[type='button']")[3]).click(()=>{
			if(confirm("수정하시겠어요?")){
				// 서버로 입력폼의 내용을 모두 가져가야 함 -> post방식 사용
				$("form").attr({
					method:"POST",
					action:"/notice/update"
				});
				$("form").submit();
			}
		});
		// 4번째 - 삭제
		$($("input[type='button']")[4]).click(()=>{
			if(confirm("삭제하시겠어요?")){
				// Get 방식 요청 (링크)
				location.href="/notice/del?notice_id=<%=notice_id%>"
			}
		});
		
		// 5번째 -목록
		$($("input[type='button']")[5]).click(()=>{
			location.href="/notice/list.jsp";
		});
		
	});
</script>

</head>
<body>

	<h3>게시판 - 상세보기</h3>

	<div class="container">
		<form>
			<input type="hidden" name="notice_id" value="<%=notice.getNotice_id()%>"> 
			<!-- ▲ "hidden" = 컴포넌트의 역할은 하지만 시각적으로 보이지 않음 
					노출되지 않은 상태로 데이터를 전송할 때 사용
			-->
			
			<label for="title">Title</label> <input type="text" name="title" value="<%=notice.getTitle()%>" placeholder="제목 입력"> 
			<label for="writer">Writer</label> <input type="text" name="writer" value="<%=notice.getWriter()%>" placeholder="작성자 입력"> 
			<label for="content">Content</label>
			<textarea id="content" name="content" placeholder="내용입력" style="height: 200px"></textarea>
			<input type="button" value="수정">
			<input type="button" value="삭제">
			<input type="button" value="목록">
		</form>
	</div>

</body>

</html>
