package com.sinse.boardproject.news.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinse.boardproject.exception.NewsException;
import com.sinse.boardproject.model.News;
import com.sinse.boardproject.repository.NewsDAO;

/** 뉴스기사 등록 요청을 받는 서블릿 */
public class RegistServlet extends HttpServlet {
	NewsDAO newsDAO = new NewsDAO(); // 누구한테 일 시킬까?

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); // JSP의 페이지 지시 영역과 동일
		PrintWriter out = response.getWriter();

		// 글쓰기 파라미터 받기
		request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");

		// 글쓰기 수행
		News news = new News();
		news.setTitle(title);
		news.setWriter(writer);
		news.setContent(content);

		out.print("<script>");
		try {
			newsDAO.insert(news);
			out.print("location.href='/news/list.jsp';");
		} catch (NewsException e) {
			e.printStackTrace();
			out.print("alert('"+e.getMessage()+"');");
			out.print("history.back();");
		}
		out.print("</script>");
	}
}
