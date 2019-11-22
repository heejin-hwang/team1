create table tbl_student(
    id VARCHAR(50) primary key COMMENT '학생ID(이메일)', 
    name VARCHAR(10) not null COMMENT '이름', 
    birthday VARCHAR(15) not null COMMENT '생일',  
    mobile_phone VARCHAR(15) not null COMMENT '핸드폰 번호', 
    temporarily_number VARCHAR(15) COMMENT '임시 연락처', 
    password VARCHAR(100) not null COMMENT '비밀번호', 
    address VARCHAR(50) not null COMMENT '기본주소',
    detail_address VARCHAR(200) COMMENT '상세 주소',
    job_id VARCHAR(10) not null default 4 COMMENT '로그인시 관리자와 구분하기 위함',
    session_limit timestamp COMMENT '로그인 만료 기간',
    session_key VARCHAR(50) not null default "none" COMMENT '로그인 세션 저장',
    pw_checked boolean not null default false COMMENT '처음 로그인 체크',
    state VARCHAR(10) COMMENT '수강중인지 아닌지 판단',
    course_code int not null COMMENT '강좌 코드', 
    groups_id int COMMENT '그룹 ID',
    foreign key(course_code) references tbl_course(code) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(groups_id) references tbl_groups(id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);