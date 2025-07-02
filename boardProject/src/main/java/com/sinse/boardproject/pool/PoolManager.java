package com.sinse.boardproject.pool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class PoolManager {
	private String driver = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/spring4";
	private String user = "spring4";
	private String pwd = "1234";

	/* 비록 생성자는 막았지만, 내가 지원해주는 메서드로 인스턴스를 가져가라! */
	private static PoolManager instance;

	// Connection들을 모아서 관리할 벡터 (순서가 있는 List 계열)
	Vector<Connection> connectionPool = new Vector<>();

	private PoolManager() {

	}

	public static PoolManager getInstance() { // 싱글톤으로 인스턴스 얻어오기
		if (instance == null) {
			instance = new PoolManager();
		}
		return instance;
	}

	// 커넥션 담아두기 : 접속자 없어도 미리 담아두기
	public void createConnection() {
		for (int i = 0; i < 20; i++) {
			try {
				Class.forName(driver);
				Connection con=DriverManager.getConnection(url, user, pwd);
				// 벡터에 모아 놓기. 즉, 풀을 만든다!
				connectionPool.add(con); 
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 빌려주기
	public synchronized Connection getConnection() {
		// 빌려줄 것이 없으면 또 만들면 됨!
		if(connectionPool.isEmpty()) { // connection 객체가 소진되었다면...
			createConnection();
		}
		return connectionPool.remove(0); // 반환과 동시에, 기존 벡터 요소 하나 제거! (0번째 꺼내면서 그 공간도 제거)
	}
	
	// 반납하기
	public void release(Connection con) {
		if(con!=null) {
			connectionPool.add(con); // 다시 벡터에 추가
		}
	}
	public void release(Connection con, PreparedStatement pstmt) {
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con!=null) {
			connectionPool.add(con); // 다시 벡터에 추가
		}
	}
	public void release(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con!=null) {
			connectionPool.add(con); // 다시 벡터에 추가
		}
	}
}
