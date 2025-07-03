package com.sinse.boardproject.exception;

public class CommentException extends RuntimeException {

	public CommentException(String msg) {
		super(msg); // 생성자는 물려받지 못하므로, 부모의 생성자르 호출
	}

	public CommentException(Throwable e) {
		super(e); // 생성자는 물려받지 못하므로, 부모의 생성자르 호출
	}

	public CommentException(String msg, Throwable e) {
		super(msg, e); // 생성자는 물려받지 못하므로, 부모의 생성자르 호출
	}
}
