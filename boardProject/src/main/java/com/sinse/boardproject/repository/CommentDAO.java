package com.sinse.boardproject.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.sinse.boardproject.exception.CommentException;
import com.sinse.boardproject.model.Comment;
import com.sinse.boardproject.mybatis.MybatisConfig;

public class CommentDAO {
	MybatisConfig config=MybatisConfig.getInstance();
	
	// 모든 레코드 가져오기
	public List selectAll() {
		return null;
	}
	
	// 해당 뉴스 기사에 소속된 댓글만 가져오기
	public List selectByNewsId(int news_id) {
		SqlSession sqlSession=config.getSqlSession();
		List list=sqlSession.selectList("Comment.selectByNewsId", news_id);
		sqlSession.close();
		return list;
	}
	
	// 1건 가져오기
	public Comment select(int comment_id) {
		
		return null;
	}
	
	// 1건 넣기
	public void insert(Comment comment) {
		SqlSession sqlSession = config.getSqlSession();
		int result=sqlSession.insert("Comment.insert", comment);
		if(result<1) {
			throw new CommentException("등록 실패");
		}
		sqlSession.commit();
		sqlSession.close();
	}
	
	// 1건 수정
	public void update(Comment comment) {
		
	}
	
	// 1건 삭제
	public void delete(int comment_id) {
		
	}
}
