package com.sinse.memberapp2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sinse.memberapp2.exception.MemberNotFoundException;
import com.sinse.memberapp2.model.Member;
import com.sinse.memberapp2.repository.MemberDAO;
import lombok.extern.slf4j.Slf4j;

/**
 * Post로 전송되어오는 로그인 정보를 받아, 
 * 회원 테이블과 일치 여부에 따라
 * 로그인 성공 / 실패
 */
@Slf4j
public class LoginServlet extends HttpServlet {
	
	MemberDAO memberDAO = new MemberDAO();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 받기 (한글처리 할 필요 x , id pwd니까)
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");

		// 디버깅용 로그
		log.debug("넘겨받은 아이디: {}", id);
		log.debug("넘겨받은 비번: {}", pwd);

		// 상세 디버깅 (trace는 루프 디버깅 등에서 사용)
		for (int i = 0; i <= 10; i++) {
			log.trace("i는 {}", i);
		}
		
		Member member = new Member();
		member.setId(id);
		member.setPwd(pwd);		
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print("<script>");
		Member obj = null;
		try {
			obj = memberDAO.login(member);

			// 로그인 성공 시 info 레벨로 기록
			log.info("로그인 성공: {}", obj.getId());

			// 세션 처리 (서블릿에서는 직접 다룸)
			HttpSession session = request.getSession();
			session.setAttribute("member", obj);

			out.print("alert('" + obj.getName() + " 님 반갑습니다.');");
			out.print("location.href='/index.jsp';");

		} catch (MemberNotFoundException e) {
			log.error("로그인 실패: {}", e.getMessage(), e);
			out.print("alert('" + e.getMessage() + "');");
			out.print("history.back();");
		}
		out.print("</script>");
	}
}
