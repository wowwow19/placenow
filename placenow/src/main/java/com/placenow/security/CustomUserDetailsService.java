package com.placenow.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.placenow.domain.MemberVO;
import com.placenow.mapper.MemberMapper;
import com.placenow.security.domain.CustomUser;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Service
@Data
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("Load User By UserName : " + username);
		
		MemberVO vo = memberMapper.read(username);
		log.warn("memberMapper vo : " + vo);
		
		return vo == null ? null : new CustomUser(vo);
	}		
}
