package com.sinse.boardproject.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.sinse.boardproject.exception.NewsException;
import com.sinse.boardproject.model.News;
import com.sinse.boardproject.mybatis.MybatisConfig;

/**
 * DAO의 존재는 그대로 유지하되, DAO의 CRUD메서드 안에 
 * 상투적 JDBC코드 작성하지 말자!
Mybatis 프레임워크(SQL Mapper)과 Hibernate(ORM) 프레임워크를 이용하기 때문 
 */
public class NewsDAO {
	MybatisConfig config=MybatisConfig.getInstance(); //SqlFactory 보유하고 있음
	
	// 모든 레코드 가져오기
	public List selectAll() {
		SqlSession sqlSession=config.getSqlSession();
		List list=sqlSession.selectList("News.selectAll");
		sqlSession.close();
		return list;
	}
	
	// 한 건 가져오기
	public News select(int news_id) {
		return null;
	}
	
	// 한 건 넣기
	public void insert(News news) throws NewsException{
		SqlSession sqlSession=config.getSqlSession();
		int result=sqlSession.insert("News.insert",news);
		if(result<1) {
			throw new NewsException("등록 실패");
		}
		sqlSession.commit();
		sqlSession.close();
		
	}
	// 한 건 수정
	public void update(News news) {
		
	}
	// 한 건 삭제
	public void delete(int news_id) {
		
	}
}
