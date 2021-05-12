package com.placenow.service;

import java.util.List;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceAttachVO;
import com.placenow.domain.PlaceVO;

public interface PlaceService {
	List<PlaceVO> getList();

	List<PlaceVO> getListByCategory(Criteria cri);
	
	PlaceVO get(Integer pno);
	
	Integer[] getTotalByRegion();
	
	void add(PlaceVO vo);
	
	List<PlaceAttachVO> getAttachList(Integer pno);
	
	boolean update(PlaceVO vo);
	
	boolean delete(Integer pno);
	
	void addFavList(Integer pno, String userId);
	
	void removeFavList(Integer pno, String userId);
	
	List<PlaceVO> getFavList(String userId);
	
	Integer getRecentReply(Integer pno, String userId);
}
