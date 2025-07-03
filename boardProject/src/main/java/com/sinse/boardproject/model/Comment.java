package com.sinse.boardproject.model;

import lombok.Data;

@Data
public class Comment {
	private int comment_id;
	private String msg;
	private String user;
	private String msgdate;
	
	// 한 개의 부모테이블만 봄
	private News news;
}
