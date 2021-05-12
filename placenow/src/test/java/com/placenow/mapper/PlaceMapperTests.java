package com.placenow.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PlaceMapperTests {
	@Autowired
	private PlaceMapper mapper;
	
	@Test
	public void testExist() {
		log.info("testExist..." + mapper != null ? "true" : "false");
	}
	
	@Test
	public void testGetList() {
		log.info("testGetList...");
		mapper.getList().forEach(log::info);
	}
	
	@Test
	public void testGetListByCategory() {
		log.info("testGetListByCategory...");
		mapper.getListByCategory(new Criteria(null, null, 1, "월")).forEach(log::info);
	}
	
	@Test
	public void testGet() {
		log.info("testGet...");
		log.info(mapper.get(1));
	}
	
	@Test
	public void testGetTotalByRegion() {
		log.info("testGetTotalByRegion...");
		for(Integer i : mapper.getTotalByRegion()) {
			log.info(i);
		}
	}
	
	@Test
	public void testAdd() {
		log.info("testAdd...");
		PlaceVO vo = new PlaceVO();
		vo.setRegion(7);
		vo.setCategory(1);
		vo.setPname("해운대 해수욕장");
		vo.setAddress("부산광역시 해운대구 우동");
		mapper.add(vo);
	}
	
	@Test
	public void testAddFavList() {
		log.info("testAddFavList...");
		mapper.addFavList(48, "admin9@placenow.co.kr");
	}
	
	@Test
	public void testRemoveFavList() {
		log.info("testRemoveFavList...");
		mapper.removeFavList(48, "admin9@placenow.co.kr");
	}
	
	@Test
	public void testGetFavList() {
		log.info("testGetFavList...");
		mapper.getFavList("admin9@placenow.co.kr").forEach(log::info);
	}
	
	@Test
	public void testGetRecentReply() {
		log.info("testGetRecentReply");
		log.info(mapper.getRecentReply(123, "user17@placenow.co.kr") > 1 ? true : false);
	}
	
}
