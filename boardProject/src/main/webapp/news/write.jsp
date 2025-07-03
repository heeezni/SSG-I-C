<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</style>
<%-- 공통 링크 파일을 포함합니다. --%>
<%@ include file="/inc/head_link.jsp" %>
<script type="text/javascript">
	// jQuery를 사용하여 문서 로딩이 완료되면 실행될 함수를 정의합니다.
	$(()=>{
		// 서머노트(Summernote) 에디터를 #content 요소에 연동합니다.
		$("#content").summernote({
			placeholder: '내용 입력', // 입력 필드에 표시될 플레이스홀더 텍스트
			height: 150 // 에디터의 높이 설정
		});
		
		// 'Submit' 버튼(input[type='button'])에 클릭 이벤트를 연결합니다.
		$("input[type='button']").click(()=>{
			// 폼의 action 속성을 "/news/regist"로, method 속성을 "POST"로 설정합니다.
			// POST 방식은 데이터를 HTTP Body에 담아 전송하므로, GET 방식(URL에 데이터 노출)보다 안전하고 데이터 길이 제한이 없습니다.
			$('form').attr({
				action:"/news/regist",
				method: "POST", 
			});
			
			$('form').submit(); // 폼을 전송합니다.
			
		});
	});
</script>

</head>
<body>

	<h3>댓글 게시판 - 글쓰기</h3>

	<div class="container">
		<form>
			<label for="fname">Title</label> <input type="text" id="fname" name="title" placeholder="제목 입력"> 
			<label for="lname">Writer</label> <input type="text" id="lname" name="writer" placeholder="작성자 입력"> 			<label for="subject">Content</label>
			<textarea id="content" name="content" placeholder="내용입력" style="height: 200px"></textarea>
			<input type="button" value="Submit">
		</form>
	</div>

</body>

</html>