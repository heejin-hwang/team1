create table tbl_attendance(
    id int auto_increment primary key COMMENT '출석ID',
    start_date_time timestamp default 0 COMMENT '시작 시간', 
    end_date_time timestamp default current_timestamp on update current_timestamp COMMENT '끝 시간',
    state varchar(50) default '결석' COMMENT '출결상태',
    start_checked varchar(50)  default '결석' COMMENT '출석체크확인',
    end_checked varchar(50)  default '결석'COMMENT '체크아웃확인',
    attendance_key VARCHAR(50) not null default "none" COMMENT '출석 세션 저장',
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