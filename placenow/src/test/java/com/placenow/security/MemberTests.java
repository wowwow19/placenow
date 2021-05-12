package com.placenow.security;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;
import com.placenow.mapper.MemberMapper;
import com.placenow.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	@Autowired
	MemberMapper mapper;
		
	@Test
	public void testInsertMember() {
		MemberVO memberVO = new MemberVO();
		AuthVO authVO = new AuthVO();
		TermsVO termsVO = new TermsVO();
		
		memberVO.setUserId("user16@placenow.co.kr");
		memberVO.setUserPw("pw16");
		memberVO.setUserName("일반사용자16");
		memberVO.setBirthYear("1994");
		memberVO.setGender("M");
		memberVO.setNewsletter("AGREE");
		
		authVO.setUserId(memberVO.getUserId());
		authVO.setAuth("ROLE_MEMBER");
		List<AuthVO> list = new ArrayList<AuthVO>();
		list.add(authVO);
		memberVO.setAuthList(list);
		
		termsVO.setUserId(memberVO.getUserId());
		termsVO.setUse("AGREE");
		termsVO.setPrivacy("AGREE");
		termsVO.setLocation("AGREE");
		
		mapper.register(memberVO);
		mapper.grantMemberAuth(authVO);
		mapper.addTerms(termsVO);
	}
	
	@Test
	public void testInsertAuth() {
//		String sql = "INSERT INTO MEMBER_AUTH(USERID, AUTH) VALUES (?, ?)";
//		
//		for(int i = 0; i < 10; i++) {
//			Connection conn = null;
//			PreparedStatement pstmt = null;
//			
//			try {
//				conn = dataSource.getConnection();
//				pstmt = conn.prepareStatement(sql);
//				
//				if(i < 5) {
//					pstmt.setString(1, "user" + i + "@placenow.co.kr");
//					pstmt.setString(2, "ROLE_MEMBER");
//				} else {
//					pstmt.setString(1, "admin" + i + "@placenow.co.kr");
//					pstmt.setString(2, "ROLE_ADMIN");
//				}
//				
//				pstmt.executeUpdate();
//				pstmt.close();
//				conn.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
	}
}
