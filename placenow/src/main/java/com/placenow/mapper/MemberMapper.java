package com.placenow.mapper;

import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;

public interface MemberMapper {
	MemberVO read(String userId);
	
	void register(MemberVO vo);
	
	void grantMemberAuth(AuthVO vo);
	
	void addTerms(TermsVO vo);
}
