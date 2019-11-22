create table tbl_fileupload (
    id int primary key COMMENT '첨부파일 번호',
    name_key VARCHAR(200) COMMENT '첨부파일 암호화명',
    name VARCHAR(100) COMMENT '첨부파일명',
    path VARCHAR(200) COMMENT '첨부파일 경로',
    size VARCHAR(50) COMMENT '첨부파일 크기',
    update_date timestamp COMMENT '수정일시',
    upload_date timestamp default now() COMMENT '입력일시',
    admin_id VARCHAR(50) null COMMENT '작성자',
    notice_id int COMMENT '게시판 번호',
    fileboard_id int COMMENT '파일 공유 게시판 번호',
    submit_id int COMMENT '과제 업로드 게시판 번호',
    group_id int null COMMENT '그룹 페이지 파일 업로드',
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(notice_id) references tbl_noticeboard(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(fileboard_id) references tbl_fileboard(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(submit_id) references tbl_submit(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(group_id) references tbl_groups(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);