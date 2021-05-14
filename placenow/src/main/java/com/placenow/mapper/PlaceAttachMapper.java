package com.placenow.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import com.placenow.domain.PlaceAttachVO;

public interface PlaceAttachMapper {
	void insert(PlaceAttachVO vo);
	
	void delete(String uuid);
	
	List<PlaceAttachVO> findBy(Integer pno);
	
	@Delete("DELETE FROM PLACE_ATTACH WHERE PNO = #{pno}")
	void deleteAll(Integer pno);
	
	@Delete("DELETE FROM PLACE_ATTACH")
	void deleteAllComplete();
	
	@Select("SELECT * FROM PLACE_ATTACH WHERE UPLOADPATH = TO_CHAR(SYSDATE - 1, 'YYYY/MM/DD')")
	List<PlaceAttachVO> getOldFiles();
}
