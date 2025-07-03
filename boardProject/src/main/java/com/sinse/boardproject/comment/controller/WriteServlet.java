package com.sinse.boardproject.comment.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sinse.boardproject.model.Comment;
import com.sinse.boardproject.model.News;
import com.sinse.boardproject.repository.CommentDAO;

public class WriteServlet extends HttpServlet {

	CommentDAO commentDAO = new CommentDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String msg = request.getParameter("msg");
		String user = request.getParameter("user");
		String news_id = request.getParameter("news_id"); // 내가 지금 보고 있는 뉴스기사

		// 댓글 내용 디버깅
		System.out.println(msg);
		System.out.println(user);
		System.out.println(news_id);

		Comment comment = new Comment();
		comment.setMsg(msg);
		comment.setUser(user);

		News news = new News(); // empty
		news.setNews_id(Integer.parseInt(news_id));
		comment.setNews(news);

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("<script>");
		try {
			commentDAO.insert(comment);
			out.print("alert('등록 성공');");
			out.print("location.href='/news/content.jsp?news_id=" + news_id + "';");
		} catch (Exception e) {
			e.printStackTrace();
			out.print("alert('" + e.getMessage() + "');");
			out.print("history.back();");
		}
		out.print("</script>");
	}
}
