package com.placenow.service;

import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;

public interface MemberService {
	void register(MemberVO memberVO, AuthVO authVO, TermsVO termsVO);
}
