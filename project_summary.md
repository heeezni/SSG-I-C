# 프로젝트 요약

이 프로젝트는 JSP와 Servlet을 기반으로 한 간단한 웹 게시판 애플리케이션입니다. 데이터베이스 연동은 MyBatis 프레임워크를 사용하며, MySQL 데이터베이스를 대상으로 합니다.

## 주요 파일 및 역할

### 1. 설정 파일

*   **`pom.xml`**: Maven 프로젝트 설정 파일입니다. `javax.servlet-api`, `lombok`, `mysql-connector-j`, `mybatis` 등의 라이브러리 의존성을 관리합니다.
*   **`webapp/WEB-INF/web.xml`**: 웹 애플리케이션의 배포 서술자(Deployment Descriptor)입니다. 클라이언트의 요청 URL을 특정 서블릿(Controller)으로 매핑하는 역할을 합니다.
    *   `/notice/regist` -> `RegistServlet` (게시물 등록)
    *   `/notice/del` -> `DeleteServlet` (게시물 삭제)
    *   `/notice/update` -> `UpdateServlet` (게시물 수정)
*   **`mybatis/mybatis-config.xml`**: MyBatis 프레임워크의 메인 설정 파일입니다. 데이터베이스 연결 정보, 트랜잭션 관리자, 매퍼 파일의 경로 등을 설정합니다.
*   **`db/noticetable.sql`**: 게시판 테이블(`notice`)을 생성하기 위한 SQL 스크립트입니다.

### 2. Controller (Servlet)

*   **`controller/RegistServlet.java`**: 게시물 등록(`POST /notice/regist`) 요청을 처리합니다. 클라이언트가 보낸 제목, 작성자, 내용을 받아 `NoticeDAO`를 통해 데이터베이스에 저장합니다.
*   **`controller/DeleteServlet.java`**: 게시물 삭제 요청을 처리합니다.
*   **`controller/UpdateServlet.java`**: 게시물 수정 요청을 처리합니다.

### 3. Model (Data)

*   **`model/Notice.java`**: 게시물 정보를 담는 데이터 객체(DTO/VO)입니다. `notice_id`, `title`, `writer`, `content`, `regdate`, `hit` 필드를 가지며, Lombok의 `@Data` 어노테이션을 사용하여 getter/setter 등을 자동으로 생성합니다.

### 4. Repository (DAO & Mapper)

*   **`repository/NoticeDAO.java`**: 데이터베이스의 `notice` 테이블에 접근하여 CRUD(Create, Read, Update, Delete) 작업을 수행하는 클래스(DAO)입니다. MyBatis `SqlSession`을 사용하여 SQL 쿼리를 실행합니다.
*   **`mybatis/NoticeMapper.xml`**: `NoticeDAO`에서 실행할 SQL 쿼리를 정의하는 MyBatis 매퍼 파일입니다. 각 SQL 문은 `id`로 식별되며, `NoticeDAO`의 메서드와 매핑됩니다.

### 5. View (JSP)

*   **`webapp/notice/list.jsp`**: 게시물 목록을 보여주는 페이지입니다.
*   **`webapp/notice/write.jsp`**: 게시물 작성 폼을 제공하는 페이지입니다.
*   **`webapp/notice/content.jsp`**: 게시물 상세 내용을 보여주는 페이지입니다.
