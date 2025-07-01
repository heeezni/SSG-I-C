package com.sinse.boardproject.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sinse.boardprojcet.pool.PoolManager;
import com.sinse.boardproject.exception.NoticeException;
import com.sinse.boardproject.model.Notice;

// CRUD
public class NoticeDAO {
	
	PoolManager poolManager=PoolManager.getInstance(); // 싱글턴으로 하나만 생성
	
	// 모든 레코드 가져오기
	public List selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Notice> list = new ArrayList<>();

		try {
			con=poolManager.getConnection(); //대여
			pstmt = con.prepareStatement("select * from notice order by notice_id desc");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_id(rs.getInt("notice_id"));
				notice.setTitle(rs.getString("title"));
				notice.setWriter(rs.getString("writer"));
				notice.setContent(rs.getString("content"));
				notice.setRegdate(rs.getString("regdate"));
				notice.setHit(rs.getInt("hit"));
				
				list.add(notice);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			poolManager.release(con, pstmt, rs);
		}

		return list;
	}

	// 한 건 가져오기
	public void select() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		con=poolManager.getConnection();
		StringBuffer sql=new StringBuffer();
		sql.append("select * from notice where notice_id=?");
		// 이제 프레임워크 사용하자~ (MyBatis)
	}

	// 한 건 넣기
	public void insert(Notice notice) throws NoticeException {

		Connection con = null; // 사용자마다 각각 connection 생성
		PreparedStatement pstmt = null;
		try {
			con=poolManager.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into notice(title,writer,content) values (?,?,?)");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getWriter());
			pstmt.setString(3, notice.getContent());

			int result = pstmt.executeUpdate(); // DML 수행

			if (result < 1) {
				throw new NoticeException("글 등록 실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			poolManager.release(con, pstmt);
		}
	}

	// 수정
	public void update() {

	}

	// 삭제
	public void delete() {

	}
}
