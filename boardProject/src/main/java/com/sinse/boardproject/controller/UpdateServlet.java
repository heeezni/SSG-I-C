package com.sinse.boardproject.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinse.boardproject.exception.NoticeException;
import com.sinse.boardproject.model.Notice;
import com.sinse.boardproject.repository.NoticeDAO;

/**
 * 클라이언트인 브라우저가 폼의 파라미터들을 Post로 요청하고 있음
 * 따라서 doXXX형 중 doPost로 처리하자
 * */
public class UpdateServlet extends HttpServlet{
	NoticeDAO noticeDAO=new NoticeDAO();
			
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		// 파라미터 받기
		String notice_id=request.getParameter("notice_id");
		String title=request.getParameter("title");
		String writer=request.getParameter("writer");
		String content=request.getParameter("content");
		
		Notice notice=new Notice();
		notice.setNotice_id(Integer.parseInt(notice_id));
		notice.setTitle(title);
		notice.setWriter(writer);
		notice.setContent(content);
		
		try {
			noticeDAO.update(notice); // 수정 수행
			out.print("<script>");
			out.print("alert('수정하시겠습니까?')");
			out.print("location.href='/notice/content.jsp'");
			out.print("</script>");
		} catch (NoticeException e) {
			e.printStackTrace();
			out.print("<script>");
			out.print("alert('"+e.getMessage()+"')");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
