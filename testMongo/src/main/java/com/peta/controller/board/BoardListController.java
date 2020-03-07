package com.peta.controller.board;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.peta.dto.board.BoardListDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;
import com.peta.service.board.BoardListService;

@Controller
@RequestMapping("/admin/*")
public class BoardListController {
	
	@Inject
	private BoardListService service;
	

	
	@RequestMapping(value = "boardPage", method = RequestMethod.GET)
	public String boardpage(Model model,HttpSession session) throws Exception{
		try {
		UserDTO dto = (UserDTO) session.getAttribute("login");
		String userName = dto.getUname();
		System.out.println(userName);
		if (userName.equals("Admin")) {
			model.addAttribute("boardlist",service.boardlist());
			return "/board/createPage.page";
		}else{
			return "redirect:/board/list";
		}
		
		}catch (Exception e) {
			return "redirect:/board/list";
		}

		
	}
	
	@RequestMapping(value="boardcreate", method = RequestMethod.POST)
	public String boardCreate(BoardListDTO dto)throws Exception{
		service.boardcreate(dto);
		return "redirect:/admin/boardPage";
	}
	
	@RequestMapping(value="boardRemove", method = RequestMethod.GET)
	public String boardReamove(String id) throws Exception{
		service.boardRemove(id);
		return "redirect:/admin/boardPage";
	}
	
	
}
