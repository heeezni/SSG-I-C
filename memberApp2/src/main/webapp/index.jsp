<%@page import="com.sinse.memberapp2.model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 이 서블릿에 요청을 시도할 때, 웹 컨테이너에서는 무조건 세션 객체를 생성 + 세션 ID 할당
	// 이 세션 아이디는 톰캣이 보내는 응답정보에 쿠키형태로 존재하게 됨
	// 세션과 세션 아이디는 매 요청마다 만들어지는 것이 아님
	// 1. 클라이언트가 요청 시 톰캣이 발급한 쿠키가 존재하지 않을 때는 새로 만듦
	// 요청 후 일정시간동안 아무런 재요청이 없을 떄는 더이상 사용하지 않는 것으로 판단하여 새롭게 세션 할당
	
	/*String id=session.getId();
	out.print("지금 이 요청에 의해 할당된 세션 ID는 "+id);*/
	
	// 만일 이 페이지의 요청자가 로그인에 성공한 사람이라면, 세션에 member라는 이름으로
	// Member객체가 담겨있을 것임
	Member member=(Member)session.getAttribute("member");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공 페이지</title>
</head>
<body>
	<%= member.getName() %>님 안녕하세요!
</body>
</html>