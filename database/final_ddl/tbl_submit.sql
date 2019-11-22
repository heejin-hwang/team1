create table tbl_submit (
    id int auto_increment primary key COMMENT '과제 입력 ID',
    upload_date timestamp default now() COMMENT '과제 업로드 날짜',
    course_code int not null COMMENT '강좌 코드',
    assignment_id int not null COMMENT '과제 ID',
    groups_id int not null COMMENT '그룹 ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(assignment_id) references tbl_assignment(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(groups_id) references tbl_groups(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);