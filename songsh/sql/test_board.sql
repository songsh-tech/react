CREATE DATABASE board;
USE board;

CREATE TABLE user (
	email VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    tel_number VARCHAR(15) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    address_detail TEXT NULL,
    profile_image TEXT NULL,
    agreed_personal TINYINT NOT NULL
);

CREATE TABLE board (
    board_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT now(),
    favorite_count INT NOT NULL DEFAULT 0,
    comment_count INT NOT NULL DEFAULT 0,
    View_count INT NOT NULL DEFAULT 0,
    writer_email VARCHAR(50) NOT NULL,
    
    CONSTRAINT writer FOREIGN KEY (writer_email) REFERENCES user(email)
);

CREATE TABLE comment (
    comment_number INT PRIMARY KEY NOT NULL,
    contents TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT now(),
    user_email VARCHAR(50) NOT NULL,
    board_number INT NOT NULL,
    
	CONSTRAINT fk_writer FOREIGN KEY (user_email) REFERENCES user(email),
    CONSTRAINT fk_board_comment FOREIGN KEY (board_number) REFERENCES board(board_number)
);

CREATE TABLE favorite (
    user_email VARCHAR(50) NOT NULL,
    board_board_number INT NOT NULL,
    PRIMARY KEY (user_email, board_board_number),
    
    CONSTRAINT user_favorite FOREIGN KEY (user_email) REFERENCES user(email),
    CONSTRAINT board_favorite FOREIGN KEY (board_board_number) REFERENCES board(board_number)
);    
	
CREATE TABLE board_image (
	sequence INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    board_number INT NOT NULL,
    image_url TEXT NULL,
    
    CONSTRAINT board_image FOREIGN KEY (board_number) REFERENCES board(board_number)
);

CREATE TABLE search_log (
    sequence INT PRIMARY KEY NOT NULL,
    search_word TEXT NOT NULL,
    relation_word TEXT NULL,
    relation TINYINT NOT NULL
);

-- 1. 사용자로부터 이메일(email) : 'email@email.com', 패스워드(password) : 'P!ssw0rd', 닉네임(nickanme) : 'rose', 전화번호(tel_number) : '010-1234-5678', 주소(address) : '부산광역시 사하구', 주소상세(address_detail) : '낙동대로', 개인정보 수집 동의(agreed_personal): true 를 입력받아 user 테이블에 삽입하는 SQL을 작성하시오.
INSERT INTO user (email, password, nickname, tel_number, address, address_detail, agreed_personal) 
VALUES ('email@email.com', 'P!ssw0rd', 'rose', '010-1234-5678', '부산광역시 사하구', '낙동대로', TRUE);

-- 2. 사용자로부터 이메일(email) : 'email@email.com', 프로필 이미지(profile_image) : 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg' 를 입력받아 user 테이블의 해당 email을 가지는 레코드의 profile_image를 입력받은 profile_image로 변경하는 SQL을 작성하시오.
UPDATE user SET profile_image = 'https://cdn.onews.tv/news/photo/202103/62559_62563_456.jpg' WHERE email = 'email@email.com';

-- 3. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents): '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email): 'email2@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오. 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.
INSERT INTO board (title, contents, writer_email)
VALUES ('첫번째 게시물', '반갑습니다. 처음뵙겠습니다.', 'email2@email.com');
-- 실패한 이유는 FOREIGN KEY 때문에 writer_email 값인 'email2@email.com'이 user 테이블에 존재해야 하기 때문입니다.

-- 4. 사용자로부터 게시물 제목(title): 첫번째 게시물, 게시물 내용(contents): '반갑습니다. 처음뵙겠습니다.', 작성자 이메일(writer_email): 'email@email.com'을 입력받아 board 테이블에 삽입하는 SQL을 작성하시오. 만약 삽입에 실패한다면 실패하는 이유에 대하여 설명하시오.
INSERT INTO board (title, contents, writer_email)
VALUES ('첫번째 게시물', '반갑습니다.처음뵙겠습니다.',  'email@email.com');
-- 성공한 이유는 writer_email 값인 'email@email.com'이 1번 질문으로 user 테이블에 삽입되어 존재하기 때문입니다.

-- 5. 사용자로부터 게시물 번호(board_number): 1, 이미지 URL(image_url): 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg' 를 입력받아 board_image 테이블에 삽입하는 SQL을 작성하시오.
INSERT INTO board (board_number, title, contents, writer_email)
VALUES (1, '첫 번째 게시물', '내용입니다.', 'email@email.com');

INSERT INTO board_image (board_number, image_url)
VALUES (1, 'https://image.van-go.co.kr/place_main/2022/04/04/12217/035e1737735049018a2ed2964dda596c_750S.jpg');

-- 6. 사용자 email@email.com가 1번 게시물에 좋아요를 누르는 기능을 SQL로 작성하시오.
INSERT INTO favorite (user_email, board_board_number)
VALUES ('email@email.com', 1);

-- 7. 게시물번호(board_number), 게시물 제목(title), 게시물 내용(contents), 조회수(view_count), 댓글수(comment_count), 좋아요수(favorite_count), 게시물 작성일(write_datetime), 작성자 이메일(writer_email), 작성자 프로필 사진(writer_profile_image), 작성자 닉네임(writer_nickname)을 모두 조회하는 SQL을 작성하시오. (user 테이블과 board 테이블을 모두 이용하시오)
SELECT 
  B.board_number, 
  B.title, 
  B.contents, 
  B.view_count, 
  B.comment_count, 
  B.favorite_count,
  B.write_datetime,
  U.email AS writer_email, 
  U.profile_image AS writer_profile_image,
  U.nickname AS writer_nickname
FROM board B INNER JOIN user U 
ON B.writer_email = U.email;

-- 8. 7번 문제에서 작성한 SQL을 board_view라는 이름의 가상의 테이블로 생성하는 SQL을 작성하시오.
CREATE VIEW board_view AS
SELECT 
  B.board_number, 
  B.title, 
  B.contents, 
  B.view_count, 
  B.comment_count, 
  B.favorite_count,
  B.write_datetime,
  U.email AS writer_email, 
  U.profile_image AS writer_profile_image,
  U.nickname AS writer_nickname
FROM board B INNER JOIN user U 
ON B.writer_email = U.email;

-- 9. 사용자로 부터 '반갑'이라는 문자열을 입력받아 board_view 가상 테이블에서 제목(title) 또는 내용(contents)에 포함되어 있는 레코드를 조회하는 SQL을 작성하시오.
SELECT * FROM board_view WHERE title LIKE '%반갑%' OR contents LIKE '%반갑%';

-- 10. board 테이블에서 title 컬럼에 대한 조회 속도를 높이기 위한 기능을 board_title_idx 라는 이름으로 생성하는 SQL을 작성하시오.
CREATE INDEX board_title_idx ON board (title);

-- 11. board 테이블에서 작성자 별로 작성한 게시물의 수를 구하는 SQL을 작성하시오.
SELECT writer_email, COUNT(*) AS post_count FROM board
GROUP BY writer_email;





