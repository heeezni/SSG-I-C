package com.sinse.memberapp2.repository;

import org.apache.ibatis.session.SqlSession;

import com.sinse.memberapp2.exception.MemberNotFoundException;
import com.sinse.memberapp2.model.Member;
import com.sinse.memberapp2.mybatis.MybatisConfig;

public class MemberDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	public Member login(Member member) throws MemberNotFoundException{ // 로그인 하면 회원정보가 반환되어야 하므로 Member자료형
		SqlSession sqlSession=config.getSqlSession();
		Member obj=sqlSession.selectOne("Member.login", member);
		if(obj==null) {
			throw new MemberNotFoundException("회원 정보가 일치하지 않습니다.");
		}
		
		sqlSession.close();
		
		return obj;
	}
}
