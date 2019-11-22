create table tbl_test(
    id int auto_increment primary key COMMENT '시험 ID',
    name VARCHAR(30) not null COMMENT '시험 이름', 
    date timestamp COMMENT '시험 날짜',  
    course_code int not null COMMENT '강좌 코드',
    admin_id VARCHAR(50) not null COMMENT '관리자 ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);