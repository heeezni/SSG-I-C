package com.sinse.boardproject.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinse.boardproject.exception.NoticeException;
import com.sinse.boardproject.repository.NoticeDAO;

/**
 * 삭제 요청을 처리하는 서블릿, 삭제 요청은 별도의 디자인을 요구하는 요청이 아니므로 jsp가 아닌 서블릿으로 처리
 * 
 * 삭제 후, 목록으로 링크걸면 됨
 */
public class DeleteServlet extends HttpServlet {

	NoticeDAO noticeDAO=new NoticeDAO(); // 삭제 DB에 반영하려면 필요
	
	// 삭제를 요청하는 클라이언트가 Get방식으로 요청을 하고 있으므로...
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		String notice_id = request.getParameter("notice_id"); // 파라미터 받기
		System.out.println("넘겨받은 pk값은 "+notice_id);

		// 성공을 했는지, 실패를 했는지는 서버측은 알고 있으나, 클라이언트 측은 모르므로
		// 응답정보 객체가 보유한 출력 스트림에 원하는 문자열을 넣어두면, 
		// Tomcat이 응답정보를 구성하여 응답 수행 (요청 프로세스 종료)
		
		
		// 삭제
		try {
			noticeDAO.delete(Integer.parseInt(notice_id));
			out.print("<script>");
			out.print("alert('등록 성공');");			
			out.print("location.href='/notice/list.jsp';");			
			out.print("</script>");
		} catch (NoticeException e) {
			e.printStackTrace();
			out.print("<script>");
			out.print("alert('"+e.getMessage()+"');");			
			out.print("history.back();"); // 브라우저 아이콘 중 뒤로가기누르는 효과		
			out.print("</script>");
			
		}	
	}
}
