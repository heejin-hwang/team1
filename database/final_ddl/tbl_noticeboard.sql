create table tbl_noticeboard(
    id int auto_increment primary key COMMENT '게시판 번호',
    subject VARCHAR(150) not null COMMENT '제목', 
    categorize VARCHAR(15) not null COMMENT '종류',
    update_date timestamp null COMMENT '수정일시',
    upload_date timestamp default now() COMMENT '입력일시',
    context VARCHAR(3000) COMMENT '내용',
    start_date timestamp not null COMMENT '시작 날짜', 
    end_date timestamp not null COMMENT '끝 날짜',
    hits int default 0 COMMENT '조회 수', 
    course_code int not null COMMENT '강좌 코드', 
    admin_id VARCHAR(50) not null COMMENT '작성자',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);