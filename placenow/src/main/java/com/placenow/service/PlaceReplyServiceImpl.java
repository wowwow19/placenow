package com.placenow.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.placenow.domain.PlaceReplyVO;
import com.placenow.mapper.PlaceMapper;
import com.placenow.mapper.PlaceReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
@Transactional
public class PlaceReplyServiceImpl implements PlaceReplyService {
	private PlaceMapper placeMapper;
	private PlaceReplyMapper placeReplyMapper;
	
	
	@Override
	@Transactional
	public Integer insert(PlaceReplyVO vo) {
		log.info("insert..." + vo);
		placeMapper.updateUpdateDate(vo.getPno());
		placeMapper.updateReplyNum(vo.getPno(), 1);
		return placeReplyMapper.insert(vo);
	}

	@Override
	public List<PlaceReplyVO> getList(Integer pno, Integer rno) {
		log.info("getList...{ pno: " + pno + ", rno: " + rno + " }");
		return placeReplyMapper.getList(pno, rno);
	}

	@Override
	public PlaceReplyVO get(Integer rno) {
		log.info("get..." + rno);
		return placeReplyMapper.get(rno);
	}

	@Override
	public Integer delete(Integer rno) {
		log.info("delete..." + rno);
		placeMapper.updateReplyNum(placeReplyMapper.get(rno).getPno(), -1);
		return placeReplyMapper.delete(rno);
	}

	@Override
	@Transactional
	public void like(Integer rno, String userId) {
		log.info("like..." + rno + userId);
		placeReplyMapper.like(rno, userId);
		placeReplyMapper.updateLikeNum(rno, 1);
	}

	@Override
	@Transactional
	public void unlike(Integer rno, String userId) {
		log.info("unlike..." + rno + userId);
		placeReplyMapper.unlike(rno, userId);
		placeReplyMapper.updateLikeNum(rno, -1);
	}

	@Override
	public List<Integer> getLikeList(Integer pno, String userId) {
		log.info("getLikeList..." + pno + userId);
		return placeReplyMapper.getLikeList(pno, userId);
	}

//	@Override
//	public boolean getRegDate(Integer pno, String userId) {
//		log.info("getRegDate..." + pno + userId);
//		return placeReplyMapper.getRegDate(pno, userId);
//	}
	
	
	
}
