package com.placenow.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceVO;

public interface PlaceMapper {
	
	List<PlaceVO> getList();
	List<PlaceVO> getListByCategory(Criteria cri);
	
	PlaceVO get(Integer pno);
	
	Integer[] getTotalByRegion();
	
	void add(PlaceVO vo);
	void addSelectKey(PlaceVO vo);
	
	Integer update(PlaceVO vo);
	
	@Delete("DELETE FROM PLACE WHERE PNO = #{pno}")
	Integer delete(Integer pno);
	
	@Update("UPDATE PLACE SET REPLYNUM = REPLYNUM + #{amount} WHERE PNO = #{pno}")
	void updateReplyNum(@Param("pno") Integer pno, @Param("amount") Integer amount);
	
	@Update("UPDATE PLACE SET UPDATEDATE = SYSDATE WHERE PNO = #{pno}")
	void updateUpdateDate(@Param("pno") Integer pno);
	
	void addFavList(@Param("pno") Integer pno, @Param("userId") String userId);
	
	void removeFavList(@Param("pno") Integer pno, @Param("userId") String userId);
	
	@Update("UPDATE PLACE SET FAVNUM = FAVNUM + #{amount} WHERE PNO = #{pno}")
	void updateFavNum(@Param("pno") Integer pno, @Param("amount") Integer amount);
	
	List<PlaceVO> getFavList(String userId);
	
	Integer getRecentReply(@Param("pno") Integer pno, @Param("userId") String userId);
}
