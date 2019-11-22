create table tbl_grade(
    id int auto_increment primary key COMMENT '성적 ID',
    score int not null COMMENT '성적',
    student_id VARCHAR(50) not null COMMENT '학생 ID',
    test_id int not null COMMENT '시험 ID',
    admin_id VARCHAR(50) not null COMMENT '관리자 ID',
    pass VARCHAR(100) not null default '0',
    foreign key(student_id) references tbl_student(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(test_id) references tbl_test(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);