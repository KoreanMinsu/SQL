--테이블 author  생성
CREATE TABLE authors (
    author_id    NUMBER(10),
    author_name  VARCHAR2(100) NOT NULL,
    author_desc  VARCHAR2(100),
    PRIMARY KEY ( author_id )
);

--관련 시퀀스 생성
CREATE SEQUENCE seq_author_id INCREMENT BY 1 START WITH 1 NOCACHE;

--내용입력
INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '이문열',
    '경북 양양'
);

INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '박경리',
    '경상남도 통영'
);

INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '유시민',
    '17대 국회의원'
);

INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '기안84',
    '기안동에서 산 84년생'
);

INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '강풀',
    '온라인 만화가 1세대'
);

INSERT INTO authors VALUES (
    seq_author_id.NEXTVAL,
    '김영하',
    '알쓸신잡'
);

SELECT
    *
FROM
    authors;

--table books 생성
CREATE TABLE books (
    book_id    NUMBER(10),
    title      VARCHAR2(200) NOT NULL,
    pubs       VARCHAR2(100),
    pub_date   DATE,
    author_id  NUMBER(10),
    PRIMARY KEY ( book_id ),
    CONSTRAINT book_fk FOREIGN KEY ( author_id )
        REFERENCES authors ( author_id )
);

--관련 시퀀스생성
CREATE SEQUENCE seq_book_id INCREMENT BY 1 START WITH 1 NOCACHE;

--내용입력
INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '우리들의 일그러진 영웅',
    '다림',
    '1998-02-22',
    1
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '삼국지',
    '민음사',
    '2002-03-01',
    1
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '토지',
    '마로니에북스',
    '2012-08-15',
    2
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '유시민의 글쓰기 특강',
    '생각의 길',
    '2015-04-01',
    3
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '패션왕',
    '중앙북스(books)',
    '2012-02-22',
    4
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '순정만화',
    '재미주의',
    '2011-08-03',
    5
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '오직두사람',
    '문학동네',
    '2017-05-04',
    6
);

INSERT INTO books VALUES (
    seq_book_id.NEXTVAL,
    '26년',
    '재미주의',
    '2012-02-04',
    5
);

SELECT
    *
FROM
    books;
    
--조인하기
SELECT
    b.book_id,
    b.title,
    b.pubs,
    to_char(b.pub_date,'yyyy-mm-dd') "pub_date",
    b.author_id,
    au.author_name,
    au.author_desc
FROM
    books    b,
    authors  au
WHERE
    b.author_id = au.author_id;

--데이터 수정( 강풀정보 서울특별시//  author 테이블 기안84 데이터 삭제시도[삭제불가])
update authors
set author_desc = '서울특별시'
where author_id = 5;

delete from authors
where author_id = 4;


--삭제
DROP SEQUENCE seq_book_id;
DROP SEQUENCE seq_author_id;
DROP TABLE books;
DROP TABLE authors; 