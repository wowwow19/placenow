package com.placenow.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.placenow.domain.PlaceReplyVO;

public interface PlaceReplyMapper {
	Integer insert(PlaceReplyVO vo);
	
	List<PlaceReplyVO> getList(@Param("pno") Integer pno, @Param("rno") Integer rno);
	
	PlaceReplyVO get(Integer rno);
	
	@Delete("DELETE FROM PLACE_REPLY WHERE RNO = #{rno}")
	Integer delete(Integer rno);
	
	void like(@Param("rno") Integer rno, @Param("userId") String userId);
	
	void unlike(@Param("rno") Integer rno, @Param("userId") String userId);
	
	@Update("UPDATE PLACE_REPLY SET LIKENUM = LIKENUM + #{amount} WHERE RNO = #{rno}")
	void updateLikeNum(@Param("rno") Integer rno, @Param("amount") Integer amount);
	
	List<Integer> getLikeList(@Param("pno") Integer pno, @Param("userId") String userId);
	
//	boolean getRegDate(@Param("pno") Integer pno, @Param("userId") String userId);
}
