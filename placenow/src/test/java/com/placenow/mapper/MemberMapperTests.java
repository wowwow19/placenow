package com.placenow.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testExist() {
		log.info("testExist...");
		log.info(mapper);
	}
	
	@Test
	public void testRead() {
		log.info("testRead...");
		log.info(mapper.read("admin9@placenow.co.kr"));
	}
}
