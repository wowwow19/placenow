package com.placenow.service;

import java.util.List;

import com.placenow.domain.PlaceReplyVO;

public interface PlaceReplyService {
	Integer insert(PlaceReplyVO vo);
		
	List<PlaceReplyVO> getList(Integer pno, Integer rno);
	
	PlaceReplyVO get(Integer rno);
	
	Integer delete(Integer rno);
	
	void like(Integer rno, String userId);
	
	void unlike(Integer rno, String userId);
	
	List<Integer> getLikeList(Integer pno, String userId);
	
//	boolean getRegDate(Integer pno, String userId);
}
