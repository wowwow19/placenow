package com.placenow.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.placenow.domain.PlaceReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PlaceReplyMapperTests {
	@Autowired
	private PlaceReplyMapper mapper;
	
	@Test
	public void testExist() {
		log.info("testExist..." + mapper != null ? "true" : "false");
	}
	
	@Test
	public void testGetList() {
		log.info("testGetList...");
		mapper.getList(48, null).forEach(log::info);
	}
	
	@Test
	public void testInsert() {
		log.info("testInsert...");
		
		PlaceReplyVO vo = new PlaceReplyVO();
		vo.setPno(48);
		vo.setUserId("melona3");
		vo.setContent("테스트작성댓글");
		
		log.info(mapper.insert(vo));
	}
	
	@Test
	public void testLike() {
		log.info("testLike...");
		
		mapper.like(44, "user0@placenow.co.kr");
		mapper.updateLikeNum(44, 1);
	}
	
	@Test
	public void testUnlike() {
		log.info("testLike...");
		
		mapper.unlike(44, "user0@placenow.co.kr");
		mapper.updateLikeNum(44, -1);
	}
	
//	@Test
//	public void testGetRegDate() {
//		log.info("testGetRegDate...");
//		log.info(mapper.getRegDate(47, "user0@placenow.co.kr"));
//	}
}
