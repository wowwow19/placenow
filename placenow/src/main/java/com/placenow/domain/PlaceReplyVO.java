package com.placenow.domain;


import lombok.Data;

@Data
public class PlaceReplyVO {
	private Integer rno;
	private Integer pno;
	private String userId;
	private String content;
	private String regDate;
	private Integer likeNum;
}
