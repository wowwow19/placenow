package com.placenow.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String birthYear;
	private String gender;
	private boolean enabled;
	private String newsletter;
	private String phone;
	
	private Date regDate;
	private List<AuthVO> authList;
}
