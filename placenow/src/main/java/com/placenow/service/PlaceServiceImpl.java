package com.placenow.service;


import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceAttachVO;
import com.placenow.domain.PlaceVO;
import com.placenow.mapper.PlaceAttachMapper;
import com.placenow.mapper.PlaceMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.security.o3logon.a;

@Service
@Log4j
@AllArgsConstructor
public class PlaceServiceImpl implements PlaceService {
	private PlaceMapper placeMapper;
	private PlaceAttachMapper placeAttachMapper;
	
	@Override
	public List<PlaceVO> getList() {
		log.info("getList...");
		return placeMapper.getList();
	}

	@Override
	public List<PlaceVO> getListByCategory(Criteria cri) {
		log.info("getListByCategory...");
		List<PlaceVO> list = placeMapper.getListByCategory(cri);
		list.forEach(vo -> {
			vo.setAttachList(getAttachList(vo.getPno()));
		});
		return list;
	}

	@Override
	public PlaceVO get(Integer pno) {
		log.info("get...");
		PlaceVO vo = placeMapper.get(pno);
		vo.setAttachList(getAttachList(pno));
		return vo;
	}

	@Override
	public Integer[] getTotalByRegion() {
		log.info("getTotalByRegion...");
		return placeMapper.getTotalByRegion();
	}

	@Override
	@Transactional
	public void add(PlaceVO vo) {
		log.info("add...");
		placeMapper.addSelectKey(vo);
		vo.getAttachList().forEach(a -> {
			a.setPno(vo.getPno());
			placeAttachMapper.insert(a);
		});
	}

	@Override
	public List<PlaceAttachVO> getAttachList(Integer pno) {
		log.info("getAttachList :: pno..." + pno);
		return placeAttachMapper.findBy(pno);
	}

	@Override
	@Transactional
	public boolean update(PlaceVO vo) {
		log.info("modify :: PlaceVO..." + vo);
		placeAttachMapper.deleteAll(vo.getPno());
		vo.getAttachList().forEach(a -> {
			a.setPno(vo.getPno());
			placeAttachMapper.insert(a);
		});
		return placeMapper.update(vo) > 0;
	}

	@Override
	@Transactional
	public boolean delete(Integer pno) {
		placeAttachMapper.deleteAll(pno);
		return placeMapper.delete(pno) > 0;
	}

	@Override
	@Transactional
	public void addFavList(Integer pno, String userId) {
		log.info("addFavList..." + pno + userId);
		placeMapper.addFavList(pno, userId);
		placeMapper.updateFavNum(pno, 1);
	}
	
	@Override
	public List<PlaceVO> getFavList(String userId) {
		log.info("getFavList..." + userId);
		List<PlaceVO> list = placeMapper.getFavList(userId);
		list.forEach(vo -> {
			vo.setAttachList(getAttachList(vo.getPno()));
		});
		return list;
	}

	@Override
	@Transactional
	public void removeFavList(Integer pno, String userId) {
		log.info("removeFavList..." + pno + userId);
		placeMapper.removeFavList(pno, userId);
		placeMapper.updateFavNum(pno, -1);
	}

	@Override
	public Integer getRecentReply(Integer pno, String userId) {
		log.info("getRecentReply..." + pno + userId);
		return placeMapper.getRecentReply(pno, userId);
	}
	
}
