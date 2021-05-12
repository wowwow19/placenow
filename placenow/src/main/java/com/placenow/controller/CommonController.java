package com.placenow.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mchange.net.MailSender;
import com.placenow.domain.AuthVO;
import com.placenow.domain.MemberVO;
import com.placenow.domain.TermsVO;
import com.placenow.security.CustomUserDetailsService;
import com.placenow.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {
	private CustomUserDetailsService customMemberService;
	private MemberService memberService;
	private JavaMailSender mailSender;
	
	@GetMapping("accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("accessError...auth :: " + auth);
		model.addAttribute("msg", "Access Denied (접근 거부)");
	}
	
	@GetMapping("customLogin")
	public void cuntomLogin(String error, String logout, Model model) {
		log.info("error :: " + error);
		log.info("logout :: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "아이디와 비밀번호를 확인해주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
	}
	
	@GetMapping("customLogout")
	public void logoutGet() {
		log.info("logoutGet...");
	}
	
	@PostMapping("customLogout")
	public void logoutPost(HttpServletRequest req) {
		log.warn("logoutPost...");
		log.warn(req.getHeader("referer"));
	}
	
	@GetMapping("register/terms")
	public void terms() {}
	
	@PostMapping("register/terms")
	public String terms(@ModelAttribute TermsVO vo, RedirectAttributes rttr) {
		log.info("register/terms...");
		log.info(vo);
		rttr.addFlashAttribute("terms", vo);
		return "redirect:/register";
	}
	
	@GetMapping("register")
	public void register(Model model) {
	}
	
	@PostMapping("register")
	public String register(@ModelAttribute TermsVO termsVO, @ModelAttribute MemberVO memberVO, RedirectAttributes rttr) {
		log.info("register...");
		log.info("register memberVO..." + memberVO);
		log.info("register termsVO..." + termsVO);
		
		List<AuthVO> authList = new ArrayList<AuthVO>();
		AuthVO authVO = new AuthVO();
		authVO.setUserId(memberVO.getUserId());
		authVO.setAuth("ROLE_MEMBER");
		authList.add(authVO);
		memberVO.setAuthList(authList);
		
		memberService.register(memberVO, authVO, termsVO);
		log.info("register success...");
		
		return "redirect:/";
	}
	
	@GetMapping("getUser/{userId:.+}")
	@ResponseBody
	public String getUser(@PathVariable("userId") String userId) {
		log.info("getUser...");
		return customMemberService.loadUserByUsername(userId) == null ? "" : customMemberService.loadUserByUsername(userId).getUsername() ;
	}
	
	@GetMapping("verify/{userId:.+}")
	@ResponseBody
	public String verifyUserId(@PathVariable("userId") String userId) {
		log.info("verifyUserId..." + userId);
		
		// 인증번호 생성
		Integer number = (int)(Math.random() * 899999) + 100001;
		log.info("verification number..." + number);
		
        // 전송 내용 설정
        String setFrom = "placenowverify@gmail.com";
        String toMail = userId;
        String title = "플레이스나우 회원가입 인증 이메일입니다.";
        String content = 
                "인증 번호는 " + number + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 입력해주세요.";
        
        // 이메일 전송
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
            log.info("sending email complete...");
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return number.toString();
	}
	
}
