
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.sinse.memberapp2.mybatis.MybatisConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	MybatisConfig conf=MybatisConfig.getInstance();
	SqlSession sqlSession=conf.getSqlSession();
	
	out.print(sqlSession);
%>