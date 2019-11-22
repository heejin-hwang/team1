create table tbl_assignment (
    id int auto_increment primary key COMMENT '과제 ID',
    name VARCHAR(100) not null COMMENT '과제 이름', 
    description VARCHAR(500) not null COMMENT '과제 설명', 
    start_date timestamp default now() COMMENT '시작 날짜',
    end_date timestamp not null COMMENT '끝 날짜',
    course_code int not null COMMENT '강좌 코드',
    admin_id VARCHAR(50) not null COMMENT '관리자 ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
); 