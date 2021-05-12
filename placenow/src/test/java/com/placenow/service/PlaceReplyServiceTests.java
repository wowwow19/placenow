package com.placenow.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceReplyVO;
import com.placenow.domain.PlaceVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PlaceReplyServiceTests {
	@Autowired
	private PlaceReplyService service;
	
	@Test
	public void testExist() {
		log.info("testExist..." + service != null ? "true" : "false");
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		log.info("testGetList...");
		service.getList(48, null).forEach(log::info);
	}
		
	@Test
	public void testInsert() {
		log.info("testInsert...");
		
		PlaceReplyVO vo = new PlaceReplyVO();
		vo.setPno(48);
		vo.setUserId("melona3");
		vo.setContent("테스트작성댓글");
		
		service.insert(vo);
	}
	
//	@Test
//	public void testGetRegDate() {
//		log.info("testGetRegDate");
//		log.info(service.getRegDate(47, "admin9@placenow.co.kr"));
//	}
}
