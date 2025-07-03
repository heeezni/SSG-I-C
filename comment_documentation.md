# 댓글 게시판 기능 명세서

## 1. 개요

이 문서는 뉴스 게시판의 각 게시물에 대한 댓글 기능을 설명합니다. 사용자는 뉴스 기사(News)에 댓글(Comment)을 작성하고 조회할 수 있습니다.

## 2. 핵심 기능

-   **댓글 작성:** 특정 뉴스 기사에 새로운 댓글을 등록합니다.
-   **댓글 조회:** 특정 뉴스 기사에 달린 모든 댓글 목록을 보여줍니다.

## 3. 시스템 구성 요소 (주요 파일)

댓글 기능은 아래의 파일들로 구성됩니다.

| 파일 경로                                                                                             | 설명                                                                                                                                                                                          |
| :---------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `boardProject/src/main/java/com/sinse/boardproject/model/Comment.java`                                | **데이터 모델(DTO):** 댓글의 데이터 구조를 정의하는 자바 클래스입니다. `comment_id`, `msg`, `user`, `msgdate` 필드와 함께 어떤 뉴스(`News`)에 속해있는지를 나타내는 `News` 객체를 포함합니다.         |
| `boardProject/src/main/java/com/sinse/boardproject/repository/CommentDAO.java`                        | **데이터 접근 객체(DAO):** 데이터베이스의 `comment` 테이블에 접근하여 CRUD(생성, 조회, 수정, 삭제) 작업을 수행하는 클래스입니다. Mybatis `SqlSession`을 사용하여 쿼리를 실행합니다.                 |
| `boardProject/src/main/java/com/sinse/boardproject/mybatis/CommentMapper.xml`                         | **Mybatis 매퍼:** 댓글 기능에 필요한 SQL 쿼리를 XML 형태로 정의한 파일입니다. `CommentDAO`에서 이 파일에 정의된 쿼리를 호출하여 사용합니다.                                                       |
| `boardProject/src/main/java/com/sinse/boardproject/comment/controller/WriteServlet.java`              | **컨트롤러(Servlet):** 사용자의 댓글 작성 요청(`HTTP POST`)을 받아 처리하는 서블릿입니다. 요청 파라미터를 읽어 `Comment` 객체를 생성하고 `CommentDAO`를 통해 데이터베이스에 저장합니다.             |
| `boardProject/src/main/java/com/sinse/boardproject/exception/CommentException.java`                   | **예외 처리:** 댓글 기능 수행 중 발생하는 예외를 처리하기 위한 사용자 정의 예외 클래스입니다.                                                                                                     |

## 4. 데이터베이스 모델

### `Comment` 테이블

| 컬럼명      | 데이터 타입 | 제약 조건      | 설명                                   |
| :---------- | :---------- | :------------- | :------------------------------------- |
| `comment_id`| `NUMBER`    | `PRIMARY KEY`  | 댓글의 고유 식별자 (자동 증가)         |
| `msg`       | `VARCHAR2`  | `NOT NULL`     | 댓글 내용                              |
| `user`      | `VARCHAR2`  | `NOT NULL`     | 작성자 이름                            |
| `msgdate`   | `DATE`      | `DEFAULT SYSDATE` | 작성 일시                              |
| `news_id`   | `NUMBER`    | `FOREIGN KEY` (references `News.news_id`) | 이 댓글이 속한 뉴스의 고유 식별자      |

## 5. 기능 상세 설명

### 5.1. 댓글 작성

1.  **사용자 입력:** 사용자는 뉴스 상세 페이지(`news/content.jsp`) 하단의 폼을 통해 댓글 내용(`msg`)과 작성자명(`user`)을 입력하고 '등록' 버튼을 클릭합니다.

2.  **요청 처리 (WriteServlet):**
    -   폼 데이터는 `HTTP POST` 방식으로 `WriteServlet`으로 전송됩니다.
    -   서블릿은 `request.getParameter()`를 사용하여 `msg`, `user`, 그리고 현재 보고 있는 `news_id`를 추출합니다.
    -   추출된 데이터를 사용하여 `Comment` 객체를 생성합니다.
    -   `CommentDAO`의 `insert()` 메소드를 호출하여 데이터베이스에 댓글을 저장합니다.

3.  **데이터베이스 저장 (CommentDAO & CommentMapper.xml):**
    -   `CommentDAO`는 Mybatis `SqlSession`을 얻어 `CommentMapper.xml`에 정의된 `insert` 쿼리를 실행합니다.
    -   `CommentMapper.xml`의 `insert` 쿼리는 전달받은 `Comment` 객체의 값을 사용하여 `comment` 테이블에 새로운 레코드를 추가합니다.

4.  **결과 반환:**
    -   등록이 성공하면, 사용자에게 '등록 성공' 알림 창을 띄우고 원래 보던 뉴스 상세 페이지로 다시 이동(`redirect`)시킵니다.
    -   등록 중 오류가 발생하면, `CommentException`이 발생하고 사용자에게 오류 메시지를 알린 후 이전 페이지로 돌아갑니다.

### 5.2. 댓글 목록 조회

1.  **요청:** 사용자가 뉴스 상세 페이지(`news/content.jsp`)에 접근하면 해당 뉴스에 달린 댓글 목록을 불러와야 합니다.

2.  **데이터 조회 (NewsMapper.xml & CommentDAO):
    -   뉴스 상세 정보를 가져오는 `NewsMapper.xml`의 `selectAll` 쿼리는 `<collection>` 태그를 사용하여 1:N 관계를 매핑합니다.
    -   `News` 객체를 조회할 때, `news_id`를 파라미터로 하여 `CommentMapper.xml`의 `selectByNewsId` 쿼리를 자동으로 실행합니다.
    -   `selectByNewsId` 쿼리는 특정 `news_id`에 해당하는 모든 댓글을 `comment` 테이블에서 조회합니다.

3.  **결과 매핑:**
    -   Mybatis는 `NewsMapper.xml`의 `CommentMap` 설정에 따라, 조회된 댓글 목록(`List<Comment>`)을 `News` 객체 안의 `commentList` 필드에 자동으로 채워 넣습니다.

4.  **화면 표시:**
    -   컨트롤러는 이렇게 완성된 `News` 객체(댓글 목록 포함)를 `news/content.jsp`로 전달합니다.
    -   JSP 페이지에서는 JSTL의 `<c:forEach>` 같은 태그를 사용하여 `news.commentList`를 순회하며 각 댓글의 내용(`msg`), 작성자(`user`), 작성일(`msgdate`)을 화면에 표시합니다.
