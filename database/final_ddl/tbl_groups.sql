create table tbl_groups(
    id int auto_increment primary key COMMENT '그룹 ID', 
    name VARCHAR(30) not null COMMENT '그룹 이름',
    course_code int not null COMMENT '강좌 코드', 
    admin_id VARCHAR(50) not null COMMENT '작성자 ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);