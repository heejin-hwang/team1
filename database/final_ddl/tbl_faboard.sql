create table tbl_faboard(
    id int not null auto_increment COMMENT '마이페이지 게시판 번호',
    title VARCHAR(200) NOT NULL,
    content VARCHAR(200) NOT NULL,
    writer VARCHAR(50) NOT NULL,
    regdate TIMESTAMP NOT NULL DEFAULT now(),
    viewcnt INT DEFAULT 0,
    PRIMARY KEY (id)
);