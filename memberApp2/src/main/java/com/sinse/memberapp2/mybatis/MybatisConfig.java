package com.sinse.memberapp2.mybatis;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * mybatis-config.xml을 읽어들여, 개발 시 쿼리문을 수행할 수 있는 객체인 SqlSession을
 * SqlSessionFactory로부터 얻게 해주는 유틸 클래스
 * mybatis는 내부적으로 JDBC를 사용함. 하지만 개발자가 상투적인 JDBC코드를 하나하나 작성하지 않게하기 위해
 * 코드들을 숨겨놓고 그 대신 SqlSession을 통해 쿼리 수행할 수 있게 해줌
 * */
public class MybatisConfig {
	// 싱글톤으로 생성
	private static MybatisConfig instance;
	private SqlSessionFactory sqlSessionFactory;
	
	private MybatisConfig() {
		// 공식 사이트 (Building SqlSessionFactory from XML)에서 가져오기
		String resource="com/sinse/memberapp2/mybatis/mybatis-config.xml";
		InputStream inputStream;
		try {
			inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	public static MybatisConfig getInstance() {
		
		if(instance==null) {
			instance=new MybatisConfig();
		}
		
		return instance;
	}
	
	// 쿼리 실행 객체인 SqlSession 반환	
	public SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}

}
