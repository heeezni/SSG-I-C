package com.sinse.boardproject.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 삭제 요청을 처리하는 서블릿, 삭제 요청은 별도의 디자인을 요구하는 요청이 아니므로 jsp가 아닌 서블릿으로 처리
 * 
 * 삭제 후, 목록으로 링크걸면 됨
 */
public class DeleteServlet extends HttpServlet {
	// 삭제를 요청하는 클라이언트가 Get방식으로 요청을 하고 있으므로...
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
 
		String notice_id = request.getParameter("notice_id"); // 파라미터 받기
		System.out.println("넘겨받은 pk값은 "+notice_id);

	}

}
