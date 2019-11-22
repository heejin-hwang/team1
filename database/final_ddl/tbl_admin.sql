create table tbl_admin (
    id VARCHAR(50) primary key COMMENT '관리자ID',
    name VARCHAR(10) NOT null COMMENT '이름',
    birthday VARCHAR(15) not null COMMENT '생일',
    mobile_phone VARCHAR(15) not null COMMENT '핸드폰', 
    temporarily_number VARCHAR(15) COMMENT '임시연락처',
    address VARCHAR(50) not null COMMENT '기본 주소',
    detail_address VARCHAR(200) COMMENT '상세 주소',
    password VARCHAR(100) not null COMMENT '비밀번호',
    category VARCHAR(15) not null COMMENT '타입',
    job_id VARCHAR(10) not null COMMENT '로그인시 학생과 구분하기 위함',
    session_limit timestamp COMMENT '로그인 만료 기간',
    session_key VARCHAR(50) not null default "none" COMMENT '로그인 세션 저장',
    pw_checked boolean not null default true COMMENT '처음 로그인 체크'
);