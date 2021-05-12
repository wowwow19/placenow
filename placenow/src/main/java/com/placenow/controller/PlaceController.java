package com.placenow.controller;

import java.io.File;
import java.security.Principal;
import java.util.List;

import javax.xml.soap.Detail;

import org.apache.ibatis.annotations.Delete;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.placenow.domain.Criteria;
import com.placenow.domain.PlaceAttachVO;
import com.placenow.domain.PlaceVO;
import com.placenow.service.PlaceService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Log4j
@RequestMapping("/place/*")
@AllArgsConstructor
public class PlaceController {
	private PlaceService service;
	
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
		log.info("list...");
		model.addAttribute("list", service.getListByCategory(cri));
		model.addAttribute("total", service.getTotalByRegion());
		model.addAttribute("cri", cri);
	}
	
	@GetMapping("more")
	public ResponseEntity<List<PlaceVO>> getListMore(Criteria cri) {
		log.info("getListMore...");
		return new ResponseEntity<>(service.getListByCategory(cri), HttpStatus.OK);
	}
	
	@GetMapping({"detail", "update"})
	public void detail(Criteria cri, Model model) {
		log.info("detail or update...");
		PlaceVO vo = service.get(cri.getPno());
		model.addAttribute("place", vo);
		model.addAttribute("cri", cri);
		model.addAttribute("attachList", vo.getAttachList());
//		model.addAttribute("replyList", service.);
	}
	
	@GetMapping("detail/{pno}")
	@ResponseBody
	public boolean detail(Principal principal, @PathVariable("pno") Integer pno) {
		log.info("detail check add recently...");
		return service.getRecentReply(pno, principal.getName()) > 0 ? true : false;
	}
	
	@PostMapping("update")
	@Secured("ROLE_ADMIN")
	public String modify(PlaceVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("update...");
		log.info(vo);
		vo.getAttachList().forEach(log::info);
		if(service.update(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:detail" + cri.getListLink();
	}
	
	@PostMapping("delete")
	@Secured("ROLE_ADMIN")
	public String delete(@RequestParam Integer pno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove...");
		
		List<PlaceAttachVO> list = service.getAttachList(pno);
		
		if(service.delete(pno)) {
			deleteFiles(list);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:list" + cri.getListLink2();
	}
	
	@GetMapping("add")
	@Secured("ROLE_ADMIN")
	public void add() {
		
	}
	
	@PostMapping("add")
	@Secured("ROLE_ADMIN")
	public String add(PlaceVO vo, RedirectAttributes rttr) {
		log.info("add...");
		service.add(vo);
		vo.getAttachList().forEach(log::info);
		rttr.addFlashAttribute("result", vo.getPno());
		
		return "redirect:list";
	}
	
	@GetMapping("{userId:.+}")
	@ResponseBody
	public List<PlaceVO> getFavList(@PathVariable("userId") String userId) {
		log.info("getFavList..." + userId);
		return service.getFavList(userId);
	}
	
	@PostMapping("{pno}/{userId:.+}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public void addFavList(@PathVariable("pno") Integer pno, @PathVariable("userId") String userId) {
		log.info("addFavList..." + pno + userId);
		service.addFavList(pno, userId);
	}
	
	@DeleteMapping("{pno}/{userId:.+}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public void removeFavList(@PathVariable("pno") Integer pno, @PathVariable("userId") String userId) {
		log.info("removeFavList..." + pno + userId);
		service.removeFavList(pno, userId);
	}
	
	@ResponseBody
	@GetMapping("getAttachList")
	public List<PlaceAttachVO> getAttachList(Integer pno) {
		log.info("getAttachList :: pno..." + pno);
		return service.getAttachList(pno);
	}
	
	private void deleteFiles(List<PlaceAttachVO> attachList) {
		log.info("deleteFiles :: attachList..." + attachList);
		
		attachList.forEach(attach -> {
			new File(UploadController.UPLOAD_PATH, attach.getDownloadPath()).delete();
			if(attach.isImage()) {
				new File(UploadController.UPLOAD_PATH, attach.getThumbnailPath()).delete();
			}
		});
	}
	
	@GetMapping("favorite")
	@PreAuthorize("isAuthenticated()")
	public void favorite(Principal principal, Model model) {
		log.info("favorite...");
		model.addAttribute("list", service.getFavList(principal.getName()));
	}

	
}
