package com.placenow.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;
import com.placenow.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {
	private BCryptPasswordEncoder encoder; 
	private MemberMapper mapper;
	
	@Override
	@Transactional
	public void register(MemberVO memberVO, AuthVO authVO, TermsVO termsVO) {
		log.info("register...");
		log.info("register MemberVO..." + memberVO);
		log.info("register AuthVO..." + authVO);
		log.info("register TermsVO..." + termsVO);
		
		memberVO.setUserPw(encoder.encode(memberVO.getUserPw()));
		
		mapper.register(memberVO);
		mapper.grantMemberAuth(authVO);
		mapper.addTerms(termsVO);
	}
	
}
