package com.acorn.team1.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.acorn.team1.domain.ScheduleVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class ScheduleDAOImpl implements ScheduleDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.acorn.mapper.ScheduleMapper";

	@Override
	public List<ScheduleVO> listAll(Integer year) throws Exception {
		log.info("ScheduleDAOImpl::listAll(year) invoked.");
		log.info("\t+ year: " + year);
		
		
		return session.selectList(namespace + ".listAll", year);
	} // listAll

	@Override
	public List<ScheduleVO> listCourse(Integer year, Integer courseCode) throws Exception {
		log.info("ScheduleDAOImpl::listCourse(year, courseCode) invoked.");
		log.info("\t+ year: " + year);
		log.info("\t+ courseCode: " + courseCode);
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("year", year);
		params.put("coursecode", courseCode);
		
		
		return session.selectList(namespace + ".listCourse", params);
	} // listCourse

} // end class
