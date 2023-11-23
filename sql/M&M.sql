
alter table movie add constraint movie_no primary key (movie_no);

commit;

select * from movie;
INSERT INTO movie (movie_title, movie_date, movie_jenre, movie_summary, movie_actor, movie_director, movie_link)
VALUES ('Movie 4', 20220101, 'Action', 'Summary 1', 'Actor 1', 'Director 1', 'Link 1');
--------------------------------------------------

create table member(
member_no number primary key,
member_email varchar2(100) not null,
member_nickname varchar2(50) not null,
member_pw varchar2(100) not null, 
member_mbti varchar2(10), 
member_reg date default sysdate,
member_status varchar2(20) default 'ACTIVE',
member_report_count number default 0 );
ALTER TABLE member ADD member_agreed number;
---------------------------------------
create sequence member_seq nocache;
ALTER TABLE member ADD member_image_path VARCHAR2(500) DEFAULT null;


commit;
------------------------------------
SELECT *
FROM member
ORDER BY member_no DESC;
commit;
select * from member;
--- 제약 조건 걸려있는거 삭제할때 씀 -------------
drop table member cascade constraints;
-------------------------------------------------
--drop table member;--
--drop sequence member_seq;--

commit;
----------------------------------------------
select * from member ORDER BY member_no DESC;



SELECT *
FROM member
WHERE member_nickname LIKE '%d%';

select count(*) from relation where member_no_follower=15 and member_no_following=7;


DELETE FROM member
WHERE member_no = 40;
--------------------------------------- 릴레이션 테이블
CREATE TABLE relation (
  relation_no NUMBER PRIMARY KEY,
  member_no_follower NUMBER NOT NULL,
  member_no_following NUMBER NOT NULL,
  follow_date date DEFAULT sysdate
);
-------------------------------------------
create sequence relation_seq nocache;
-----------------------------------------
select * from relation;



-- 어떤 리뷰에 누가 좋아요를 눌렀는지 알려줄 테이블
create table wholike(
    like_no number primary key,
    review_no number not null,
    member_no number not null,
    like_check number default 0 -- 좋아요 누르면 1로 변경
);
create sequence wholike_seq nocache;
----------------------------------------

select * from wholike;


-- 방명록 테이블
CREATE TABLE visit (
  visit_no NUMBER PRIMARY KEY,
  receiver NUMBER NOT NULL,
  sender NUMBER NOT NULL,
  content VARCHAR2(1000) NOT NULL,  
  visit_checked VARCHAR2(10) DEFAULT 'NO',
  recontent VARCHAR2(1000),
  is_comment NUMBER(1) DEFAULT 0,
visit_date DATE DEFAULT SYSDATE
);		
-----------------------------------					
create sequence visit_seq nocache;
				
select * from visit;			
					
					
					
                    
-- 리뷰 테이블 생성
create table review( 
    review_no number primary key,
    movie_no number not null,
    member_no number not null,
    review_content varchar2(4000) not null,
    review_star number default 0,
    review_mbti number,
    review_like number default 0,
    review_reg date default sysdate,
    review_readcount number default 0
);                    

-- 리뷰 시퀀스 생성
create sequence review_seq nocache;                    
-- 확인용 리뷰 인서트삽입
insert into review(review_no, movie_no, member_no, review_content, review_mbti)
values(review_seq.nextval, 17, 53, '재밌었다', 14);             
              commit;     
select * from review;  

-- 댓글 테이블 생성
create table reply(
    reply_no number primary key,    -- 댓글 고유번호
    review_no number not null,      -- 댓글 작성된 리뷰 고유번호
    member_no number not null,      -- 댓글 작성한 유저 고유번호
    reply_content varchar2(4000) not null,  -- 댓글 내용
    reply_reg date default sysdate,     -- 댓글 작성시간
    reply_group number default 0,       -- 댓글 그룹
    reply_step number default 0,        -- 댓글 순서
    reply_level number default 0        -- 댓글 답글 위치
);                    
                    
-----------------------------------------------------
-- 댓글 시퀀스 생성
create sequence reply_seq nocache;

drop table reply;
DROP SEQUENCE reply_seq;


-- 찜 관련 테이블 생성
create table want(
want_no number primary key, movie_no number not null, member_no number not null);
-- 찜 시퀀스 생성
create sequence want_seq nocache;

select * from want;





-- 장르 테이블 생성
create table genre(
genre_no number primary key, movie_genre_no varchar2(4000) not null, movie_genre_name varchar2(50) not null );

--drop table genre;
--장르 시퀀스 생성
create sequence genre_seq nocache;
-- 시퀀스 지우기
--DROP SEQUENCE genre_seq;

-- 장르 테이블 시퀀스 만들고 넣기
insert into genre values(genre_seq.nextval,1,'범죄');
insert into genre values(genre_seq.nextval,2,'가족');
insert into genre values(genre_seq.nextval,3,'전쟁');
insert into genre values(genre_seq.nextval,4,'공연');
insert into genre values(genre_seq.nextval,5,'서부극');
insert into genre values(genre_seq.nextval,6,'드라마');
insert into genre values(genre_seq.nextval,7,'멜로/로멘스');
insert into genre values(genre_seq.nextval,8,'액션');
insert into genre values(genre_seq.nextval,9,'코미디');
insert into genre values(genre_seq.nextval,10,'스릴러');
insert into genre values(genre_seq.nextval,11,'공포');
insert into genre values(genre_seq.nextval,12,'애니메이션');
insert into genre values(genre_seq.nextval,13,'어드벤쳐');
insert into genre values(genre_seq.nextval,14,'SF');
insert into genre values(genre_seq.nextval,15,'판타지');
insert into genre values(genre_seq.nextval,16,'미스터리');
insert into genre values(genre_seq.nextval,17,'다큐멘터리');
insert into genre values(genre_seq.nextval,18,'사극');
insert into genre values(genre_seq.nextval,19,'뮤지컬');
commit;

select * from genre;


-- MBTI table 생성
create table mbti(
    mbti_no number primary key,
    mbti_name varchar2(10) not null,
    movie_genre varchar2(100) 
);
-- MBTI 시퀀스 생성
create sequence mbti_seq nocache;

-- 테이블, 시퀀스 지우기
--DROP SEQUENCE mbti_seq;
--drop table mbti;

-- MBTI 에 해당하는 장르 번호 입력
insert into mbti values(member_seq.nextval, 'istj', '1,2,3,4,5,18,6,16,10'); 
insert into mbti values(member_seq.nextval, 'isfj', '1,2,3,4,5,18,6,16,10'); 
insert into mbti values(member_seq.nextval, 'infj', '1,2,3,4,5,18,6,16,10'); 
insert into mbti values(member_seq.nextval, 'intj', '1,2,3,4,5,18,6,16,10'); 

insert into mbti values(member_seq.nextval, 'istp', '1,2,3,4,5,8,9,10,12,14,15'); 
insert into mbti values(member_seq.nextval, 'isfp', '1,2,3,4,5,8,9,10,12,14,15'); 
insert into mbti values(member_seq.nextval, 'infp', '1,2,3,4,5,8,9,10,12,14,15'); 
insert into mbti values(member_seq.nextval, 'intp', '1,2,3,4,5,8,9,10,12,14,15'); 

insert into mbti values(member_seq.nextval, 'estp', '1,2,3,4,5,8,9,13,14,19'); 
insert into mbti values(member_seq.nextval, 'esfp', '1,2,3,4,5,8,9,13,14,19');
insert into mbti values(member_seq.nextval, 'enfp', '1,2,3,4,5,8,9,13,14,19');
insert into mbti values(member_seq.nextval, 'entp', '1,2,3,4,5,8,9,13,14,19'); 

insert into mbti values(member_seq.nextval, 'estj', '7,9,10,11,12,17,18'); 
insert into mbti values(member_seq.nextval, 'esfj', '7,9,10,11,12,17,18'); 
insert into mbti values(member_seq.nextval, 'enfj', '7,9,10,11,12,17,18'); 
insert into mbti values(member_seq.nextval, 'entj', '7,9,10,11,12,17,18'); 

insert into mbti values(member_seq.nextval, 'no', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19');
commit;
select * from mbti;



