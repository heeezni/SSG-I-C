package com.sinse.memberapp2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sinse.memberapp2.exception.MemberNotFoundException;
import com.sinse.memberapp2.model.Member;
import com.sinse.memberapp2.repository.MemberDAO;
/**
 * Post로 전송되어오는 로그인 정보를 받아, 
 * 회원 테이블과 일치 여부에 따라
 * 로그인 성공 / 실패
 * */
public class LoginServlet extends HttpServlet{
	Logger logger=LoggerFactory.getLogger(getClass()); 
	MemberDAO memberDAO=new MemberDAO();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 받기 (한글처리 할 필요 x , id pwd니까)
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		
		for(int i=0; i<=10; i++) {
			logger.trace("i는 "+i);
		}
		
		logger.debug("넘겨받은 아이디 "+id);
		logger.debug("넘겨받은 비번 "+pwd);
		
		Member member=new Member();
		member.setId(id);
		member.setPwd(pwd);		
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out=response.getWriter();
		
		out.print("<script>");
		Member obj=null;
		try {
			obj=memberDAO.login(member);
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
