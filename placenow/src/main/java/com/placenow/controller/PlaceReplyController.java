package com.placenow.controller;

import java.io.Console;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceReplyVO;
import com.placenow.service.PlaceReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/place/replies/*")
@Log4j
@AllArgsConstructor
public class PlaceReplyController {
	@Autowired
	private PlaceReplyService service;
		
	// 등록
	@PostMapping("add")
	public ResponseEntity<String> add(@RequestBody PlaceReplyVO vo) {
		log.info("add..." + vo);
		int insertCount = service.insert(vo);
		log.info("insertCount :: " + insertCount);
		return insertCount == 1 ? 
				new ResponseEntity<>(vo.getRno().toString(), HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 조회
	@GetMapping("{rno}")
	public ResponseEntity<PlaceReplyVO> get(@PathVariable("rno") Integer rno) {
		log.info("get..." + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// 작성일조회
//	@GetMapping("getRegDate/{pno}/{userId:.+}")
//	public boolean getRegDate(@PathVariable("pno") Integer pno, @PathVariable("userId") String userId) {
//		log.info("getRegDate..." + pno + userId);
//		return service.getRegDate(pno, userId);
//	}
	
	// 삭제
	@DeleteMapping("{rno}")
	// @PreAuthorize("principal.username == #replyer")
	public ResponseEntity<String> delete(@PathVariable("rno") Integer rno) {
		log.info("delete..." + rno);
		int deleteCount = service.delete(rno);
		log.info("deleteCount :: " + deleteCount);
		return deleteCount == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 페이지(더보기)
	@GetMapping({ "list/{pno}", "list/{pno}/{rno}" })
	public ResponseEntity<List<PlaceReplyVO>> getListMore(@PathVariable Optional<Integer> rno, @PathVariable Integer pno) {
		log.info("getListMore...");
		return new ResponseEntity<>(service.getList(pno, rno.isPresent() ? rno.get() : null), HttpStatus.OK);
	}
	
	@GetMapping("{pno}/{userId:.+}")
	@ResponseBody
	public List<Integer> getLikeList(@PathVariable("pno") Integer pno, @PathVariable("userId") String userId) {
		log.info("getLikeList..." + pno + userId);
		return service.getLikeList(pno, userId);
	}
	
	@PostMapping("{rno}/{userId:.+}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public void likeReply(@PathVariable("rno") Integer rno, @PathVariable("userId") String userId) {
		log.info("addFavList..." + rno + userId);
		service.like(rno, userId);
	}
	
	@DeleteMapping("{rno}/{userId:.+}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public void unlikeReply(@PathVariable("rno") Integer rno, @PathVariable("userId") String userId) {
		log.info("removeFavList..." + rno + userId);
		service.unlike(rno, userId);
	}

}
