package com.peta.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.peta.controller.BoardController;
import com.peta.dto.PageMaker;
import com.peta.dto.SearchCriteria;
import com.peta.service.BoardService;
import com.peta.service.board.BoardListService;

@RequestMapping("/board/*")
@Controller
public class SearchBoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@Inject
	private BoardListService boardservice;
	
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		logger.info("list code");
		//System.out.println(cri.getSearchType());
		model.addAttribute("boardlist",boardservice.boardlist());
		model.addAttribute("list",service.listSearchCriteria(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		pageMaker.setTotalCount(service.listSearchCount(cri));
		//int count = service.listSearchCount(cri,board);
		//System.out.println(count);
		//model.addAttribute("board",board);
		model.addAttribute("pageMaker",pageMaker);
		
		return "board/listCri.page";
	}
}
