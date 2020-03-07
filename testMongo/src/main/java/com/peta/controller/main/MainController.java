package com.peta.controller.main;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.peta.dto.BoardDTO;
import com.peta.service.board.BoardListService;
import com.peta.service.main.MainService;

@Controller
public class MainController {
	
	@Inject
	private MainService service;
	
	@Inject
	private BoardListService boardservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String mainPage(Model model)throws Exception{
		model.addAttribute("boardList",service.mainBoardList());
		model.addAttribute("list",service.mainlist());
		model.addAttribute("boardlist",boardservice.boardlist());
		model.addAttribute("picList",service.picList());
		//service.mainlist();
		return "main/main.page";
	}
}
