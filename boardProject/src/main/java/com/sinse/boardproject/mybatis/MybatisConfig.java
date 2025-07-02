package com.sinse.boardproject.mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * Mybatis 프레임웍의 설정은 java클래스가 아닌 xml문서로 구성되어있음 but xml은 프로그래밍 언어가 아니므로, java를
 * 이용하여 xml을 해석해야 함 이 클래스는 xml을 읽어들여, 쿼리 수행에 필요한 객체를 얻기위한 설정 객체임
 * 
 * Mybatis는 사실 내부적으로 개발자 대신 JDBC를 제어하고 있음 하지만 mybatis를 사용하는 경우, 개발자는 더이상 jdbc를
 * 직접 제어하지 않음. 대신 쿼리를 수행해주는 mybatis가 제공하는 객체를 사용해야함 -> SqlSession 따라서 이 객체는 DB와의
 * CRUD를 담당하는 DAO가 취득하면 됨
 */
public class MybatisConfig { // 싱글톤으로 SqlSession 생성
	private static MybatisConfig instance;
	private SqlSessionFactory sqlSessionFactory;

	private MybatisConfig() {
		// Building SqlSessionFactory from XML
		// 패키지라 할 지라도 대상 자원이 java 클래스가 아니면, 일반 디렉토리 취급해야함
		String resource = "com/sinse/boardproject/mybatis/mybatis-config.xml";
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static MybatisConfig getInstance() {
		if (instance == null) {
			instance = new MybatisConfig();
		}
		return instance;
	}

	// SqlSession을 반환하는 메서드 정의
	// SqlSession은 쿼리문을 수행해주는 객체 (Connection, PreparedStatement, ResultSet 숨겨져 있음)
	public SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();

	}
}
