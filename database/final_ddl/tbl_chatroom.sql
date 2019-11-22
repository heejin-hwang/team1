create table tbl_chatroom(
    code int auto_increment primary key COMMENT '채팅방ID',
    start_time timestamp default now() COMMENT '시작 일시', 
    end_time timestamp default now() COMMENT '끝 일시', 
    status VARCHAR(20) not null COMMENT '채팅 상태',
    course_code int not null COMMENT '강좌 코드',
    student_id VARCHAR(50) not null COMMENT '학생ID',
    admin_id VARCHAR(50) not null COMMENT '관리자ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(student_id) references tbl_student(id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(admin_id) references tbl_admin(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);