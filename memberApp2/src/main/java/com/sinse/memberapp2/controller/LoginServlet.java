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
import lombok.extern.slf4j.*;


/**
 * Post로 전송되어오는 로그인 정보를 받아, 
 * 회원 테이블과 일치 여부에 따라
 * 로그인 성공 / 실패
 * */
@Slf4j
public class LoginServlet extends HttpServlet{
	
	//Logger logger=LoggerFactory.getLogger(getClass()); 
	MemberDAO memberDAO=new MemberDAO();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 받기 (한글처리 할 필요 x , id pwd니까)
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		
		log.info("qwe");
		
		for(int i=0; i<=10; i++) {
			log.trace("i는 "+i);
		}
		
		log.debug("넘겨받은 아이디 "+id);
		log.debug("넘겨받은 비번 "+pwd);
		
		Member member=new Member();
		member.setId(id);
		member.setPwd(pwd);		
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		out.print("<script>");
		Member obj=null;
		try {
			obj=memberDAO.login(member);
			
			// 로그인이 성공되면, 세션 객체에 담자!
			// jsp에서는 내장 객체로써, session이 지원되지만, 현재 이 코드는 서블릿이기때문에 개발자가 자료형으로 제어해야함
			HttpSession session= request.getSession(); // 현재 이 요청에 의해 할당된 세션 (tomcat이 만드므로 new 안됨)
			session.setAttribute("member", obj);
			
			out.print("alert('"+obj.getName()+" 님 반갑습니다.');");
			out.print("location.href='/index.jsp';");
			
			
		} catch (MemberNotFoundException e) {
			e.printStackTrace();
			out.print("alert('"+e.getMessage()+"');");
			out.print("history.back();");
		}
		out.print("</script>");
		
		
		
	/*	logger.trace("trace 레벨 출력");
		logger.debug("debug 레벨 출력");
		logger.info("info 레벨 출력");
		logger.warn("warn 레벨 출력");
		logger.error("error 레벨 출력");
		// fatal은 정말 치명적인 에러
	 */
	}
}
