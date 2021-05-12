package com.placenow.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@WebAppConfiguration
@Log4j
public class PlaceControllerTests {
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Before
	public void setup() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info("testList...");
		log.info(mvc.perform(MockMvcRequestBuilders.get("/place/list"))
				.andReturn());
	}
	
	@Test
	public void testListByCategory() throws Exception {
		log.info("testListByCategory...");
		log.info(mvc.perform(MockMvcRequestBuilders.get("/place/list/1"))
				.andReturn());
	}
	
	@Test
	public void testGet() throws Exception {
		log.info("testGet...");
		log.info(mvc.perform(MockMvcRequestBuilders.get("/place/21"))
				.andReturn());
	}

}
