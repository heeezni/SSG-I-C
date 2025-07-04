package com.sinse.memberapp2.model;

import lombok.Data;

@Data
public class Emp {
	private int empno;
	private String ename;
	private String job;
	private int mgr;
	private String hiredate;
	private int sal;
	private int comm;
	private Dept dept; // 한 명의 사원 하나의 부서(정보)를 가지고 있다 (1:1)
}
