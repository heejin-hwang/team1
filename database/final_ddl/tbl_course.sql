create table tbl_course(
    code int auto_increment primary key COMMENT '강좌코드',
    name VARCHAR(100) not null COMMENT '강좌 이름', 
    start_date timestamp not null COMMENT '강좌 시작 날짜', 
    end_date timestamp not null COMMENT '강좌 끝 날짜',
    state VARCHAR(15) not null COMMENT '강좌 상태', 
    personnel_class int not null COMMENT '강좌 인원', 
    admin_id VARCHAR(50) not null COMMENT '관리자ID', 
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);