package com.peta.controller.user;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import com.peta.dto.user.LoginDTO;
import com.peta.dto.user.UserDTO;
import com.peta.service.board.BoardListService;
import com.peta.service.user.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Inject
	private UserService service;
	
	@Inject
	private BoardListService boardservice;
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginGET(@ModelAttribute("dto") LoginDTO dto,HttpSession session) {
		

		return "/user/login.page";

	}
	
	@RequestMapping(value = "/loginCheck", method = RequestMethod.GET)
	public String loginCheck() {
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model)throws Exception{
		UserDTO vo = service.login(dto);
		System.out.println("VO : " + vo);
		if(vo == null) {
			return;
		}
			
		model.addAttribute("userVO",vo);
		
		if(dto.isUseCookie()) {
			int amount = 60 * 60 * 24 * 7;
			Date sessionLimit = new Date(System.currentTimeMillis()+(1000*amount));
			
			service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
			
		}

		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception{
		Object obj = session.getAttribute("login");
		
		if(obj != null) {
			UserDTO vo = (UserDTO) obj;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getUid(), session.getId(), new Date());
				
			}
		}
		
		return "user/logout";
	}
	
	@RequestMapping(value="/join",method = RequestMethod.GET)
	public String joingPage(Model model)throws Exception{
		model.addAttribute("boardlist",boardservice.boardlist());
		return "user/joinForm.base";
	}
	
	@RequestMapping(value="/joininsert",method = RequestMethod.GET)
	public String joing2Page(Model model)throws Exception{
		model.addAttribute("boardlist",boardservice.boardlist());
		return "user/joinInsertForm.base";
	}
	
	@RequestMapping(value = "/joininsert", method = RequestMethod.POST)
	public String joinPagePost(Model model,UserDTO user)throws Exception{
		System.out.println("�����");
		service.joinUser(user);
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = "/loginConnect", method = RequestMethod.GET)
	public void loginConnect()throws Exception{
		
	}
}
