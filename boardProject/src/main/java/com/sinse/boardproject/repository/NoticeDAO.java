package com.sinse.boardproject.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.sinse.boardproject.exception.NoticeException;
import com.sinse.boardproject.model.Notice;
import com.sinse.boardproject.mybatis.MybatisConfig;

// CRUD
public class NoticeDAO {

	// PoolManager poolManager=PoolManager.getInstance(); // 싱글톤으로 하나만 생성
	MybatisConfig config = MybatisConfig.getInstance(); // 싱글톤으로 하나만 생성

	// 모든 레코드 가져오기
	public List selectAll() {
		SqlSession sqlSession = config.getSqlSession();
		List list = sqlSession.selectList("com.sinse.boardproject.model.Notice.selectAll"); // namespace.id (일 시킬 xml의 아이디)
		sqlSession.close();

		return list;
	}

	// 한 건 가져오기
	public Notice select(int notice_id) {
		SqlSession sqlSession = config.getSqlSession();
		Notice notice=sqlSession.selectOne("com.sinse.boardproject.model.Notice.select", notice_id); //누구에게 일 시킬지, 파라미터
		sqlSession.close();
		
		return notice;
	}

	// 한 건 넣기
	public void insert(Notice notice) throws NoticeException {
		SqlSession sqlSession = config.getSqlSession();
		int result=sqlSession.insert("com.sinse.boardproject.model.Notice.insert", notice);
		sqlSession.commit(); // DML 트랜젝션 확정
		sqlSession.close();
		
		if(result<1) {
			throw new NoticeException("등록 실패");
		}
	}

	// 수정
	public void update() {

	}

	// 삭제
	public void delete() {

	}
}
