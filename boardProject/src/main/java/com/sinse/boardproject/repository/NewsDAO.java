package com.sinse.boardproject.repository;

import java.util.List;

import com.sinse.boardproject.model.News;

/**
 * DAO의 존재는 그대로 유지하되, DAO의 CRUD메서드 안에 
 * 상투적 JDBC코드 작성하지 말자!
Mybatis 프레임워크(SQL Mapper)과 Hibernate(ORM) 프레임워크를 이용하기 때문 
 */
public class NewsDAO {
	
	// 모든 레코드 가져오기
	public List selectAll() {
		return null;
	}
	
	// 한 건 가져오기
	public News select(int news_id) {
		return null;
	}
	
	// 한 건 넣기
	public void insert(News news) {
		
	}
	// 한 건 수정
	public void update(News news) {
		
	}
	// 한 건 삭제
	public void delete(int news_id) {
		
	}
}
