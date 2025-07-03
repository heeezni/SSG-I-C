package com.sinse.boardproject.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Data;

/**
 * 복잡한 페이징 처리 로직을 담당하는 유틸 클래스입니다.
 * 이 클래스는 게시물 목록 등을 페이지별로 나누어 표시하는 데 필요한
 * 다양한 계산을 수행합니다.
 */
@Data
public class Paging {
	private int totalRecord; // 전체 레코드(게시물)의 총 개수
	private int pageSize; // 한 페이지에 보여질 레코드(게시물)의 수
	private int totalPage; // 전체 페이지의 총 개수
	private int blockSize; // 한 블럭(그룹)에 보여질 페이지 번호의 수 (예: 1 2 3 4 5 6 7 8 9 10)
	private int currentPage=1; // 현재 사용자가 보고 있는 페이지 번호 (기본값은 1)
	private int firstPage; // 현재 블럭의 시작 페이지 번호
	private int lastPage; // 현재 블럭의 마지막 페이지 번호
	private int curPos; // 현재 페이지에서 List(컬렉션)의 시작 인덱스 (몇 번째 레코드부터 보여줄지)
	private int num; // 현재 페이지에서 게시물에 부여할 시작 번호 (역순 정렬 시 사용)
	
	
	/**
	 * 페이징 처리에 필요한 변수들을 초기화하고 계산하는 메서드입니다.
	 * @param list 페이징을 적용할 전체 데이터 목록 (예: List<News>)
	 * @param request 현재 HTTP 요청 정보를 담고 있는 HttpServletRequest 객체
	 */
	public void init(List list, HttpServletRequest request) {
		// 1. 전체 레코드 수 계산
		totalRecord=list.size();
		// 2. 페이지당 보여질 레코드 수 설정 (여기서는 10개로 고정)
		pageSize=10;
		// 3. 전체 페이지 수 계산 (올림 처리하여 소수점 이하를 버리지 않음)
		totalPage=(int)Math.ceil((double)totalRecord/pageSize);
		// 4. 블럭당 보여질 페이지 수 설정 (여기서는 10개로 고정)
		blockSize=10;
		
		// 5. 현재 페이지 번호 설정
		// 요청 파라미터에 currentPage가 있으면 해당 값으로 설정하고, 없으면 기본값 1을 유지합니다.
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 6. 현재 블럭의 시작 페이지 번호 계산
		// 예: currentPage가 1~10이면 firstPage는 1, 11~20이면 firstPage는 11
		firstPage=currentPage-(currentPage-1)%blockSize;
		// 7. 현재 블럭의 마지막 페이지 번호 계산
		lastPage=firstPage+(blockSize-1);
		// 8. 현재 페이지에서 List의 커서(index) 위치 계산
		// (currentPage - 1) * pageSize를 통해 해당 페이지의 첫 번째 레코드 인덱스를 구합니다.
		curPos=(currentPage-1)*pageSize;
		
		// 9. 현재 페이지의 시작 게시물 번호 계산 (역순으로 보여주기 위함)
		// 전체 레코드 수에서 현재 페이지의 시작 인덱스를 빼서 게시물 번호를 역순으로 매깁니다.
		num=totalRecord-curPos;
	}
}