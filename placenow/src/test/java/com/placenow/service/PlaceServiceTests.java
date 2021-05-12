package com.placenow.service;

import static org.junit.Assert.assertNotNull;

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
public class PlaceServiceTests {
	@Autowired
	private PlaceService service;
	
	@Test
	public void testExist() {
		log.info("testExist..." + service != null ? "true" : "false");
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		log.info("testGetList...");
		service.getList().forEach(log::info);
	}
	
	@Test
	public void testGetListByCategory() {
		log.info("testGetListByCategory...");
		service.getListByCategory(new Criteria(null, null, null, "경")).forEach(log::info);
	}
	
	@Test
	public void testGet() {
		log.info("testGet...");
		log.info(service.get(21));
	}
	
	@Test
	public void testGetTotalByRegion() {
		log.info("testGetTotalByRegion...");
		for(Integer i : service.getTotalByRegion()) {
			log.info(i);
		}
	}
	
	@Test
	public void testGetRecentReply() {
		log.info("testGetRecentReply...");
		log.info(service.getRecentReply(123, "user17@placenow.co.kr"));
	}
	
	@Test
	public void testAdd() {
		log.info("testAdd...");
		
		PlaceVO vo = new PlaceVO();
		
		vo.setRegion(6);
		vo.setCategory(1);
		vo.setPname("이월드");
		vo.setAddress("대구광역시 달서구 두류공원로 200");
		
		service.add(vo);
	}
	
	@Test
	public void testAddFavList() {
		log.info("testAddFavList...");
		service.addFavList(48, "admin9@placenow.co.kr");
	}
	
	@Test
	public void testRemoveFavList() {
		log.info("testRemoveFavList...");
		service.removeFavList(47, "admin9@placenow.co.kr");
	}
}
