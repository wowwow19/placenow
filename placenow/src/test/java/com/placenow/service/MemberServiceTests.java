package com.placenow.service;


import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;
import com.placenow.security.CustomUserDetailsService;
import com.placenow.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberServiceTests {
	@Autowired
	private MemberService service;

	@Test
	public void testRegister() {
		log.info("testRegister...");
		
		MemberVO memberVO = new MemberVO();
		AuthVO authVO = new AuthVO();
		TermsVO termsVO = new TermsVO();
		
		memberVO.setUserId("user18@placenow.co.kr");
		memberVO.setUserPw("pw18");
		memberVO.setUserName("일반사용자18");
		memberVO.setBirthYear("1972");
		memberVO.setGender("M");
		memberVO.setNewsletter("DISAGREE");
		
		authVO.setUserId(memberVO.getUserId());
		authVO.setAuth("ROLE_MEMBER");
		List<AuthVO> list = new ArrayList<AuthVO>();
		list.add(authVO);
		memberVO.setAuthList(list);
		
		termsVO.setUserId(memberVO.getUserId());
		termsVO.setUse("AGREE");
		termsVO.setPrivacy("AGREE");
		termsVO.setLocation("DISAGREE");
		
		service.register(memberVO, authVO, termsVO);
	}
}
