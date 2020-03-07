package com.peta.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.peta.dto.BoardDTO;
import com.peta.dto.PageMaker;
import com.peta.dto.SearchCriteria;
import com.peta.service.BoardService;
import com.peta.service.board.BoardListService;

//자동으로 생성되는 객체- class위에 선언한다.
//단, servlet-context.xml에 <context:component-scan base=package="">안에 선언이 되어 있어야 함
//@controller, @Service, @Repository, @Component, @RestController
@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Inject
	private BoardService service;
	
	@Inject
	private BoardListService boardservice;


	@RequestMapping(value="/listtest", method = RequestMethod.GET)
	public String list(@ModelAttribute ("cri") SearchCriteria cri, Model model) throws Exception{
		
		model.addAttribute("list",service.list());
		return "board/list.page";
	}
	
	@RequestMapping(value="/listCri", method = RequestMethod.GET)
	public String listAll(@ModelAttribute ("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute("list",service.listCriteria(cri));
		System.out.println(model);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		int test = service.listSearchCount(cri);
		pageMaker.setTotalCount(test);
		model.addAttribute("pageMaker",pageMaker);
		//System.out.println(cri.toString());
		return "board/list.page";
	}
	

	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String registerGET(@ModelAttribute ("cri") SearchCriteria cri,BoardDTO board,Model model)throws Exception {
		model.addAttribute("boardlist",boardservice.boardlist());
		return "board/register.page";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String registPost(BoardDTO board,Model model,RedirectAttributes attr) throws Exception{
		service.regist(board);
		String boardName = board.getBoard();
		attr.addFlashAttribute("msg","success");
		
		//model.addFlashAttribute("result","success");
		//return "/board/list.page";
		return "redirect:/board/list?board="+boardName;
	}

	@RequestMapping(value="/read",method = RequestMethod.GET)
	public String read(String id,@ModelAttribute("cri") SearchCriteria cri,Model model) throws Exception{
		System.out.println("board::::"+cri.getBoard());
		model.addAttribute("boardlist",boardservice.boardlist());
		model.addAttribute(service.read(id));
		return "board/read.page";
	}
	
	@RequestMapping(value="/modify",method = RequestMethod.GET)
	public String modifyGet(@ModelAttribute ("board") String testboard,@RequestParam("id") String id,@ModelAttribute("cri") SearchCriteria cri,Model model) throws Exception{
		model.addAttribute("boardlist",boardservice.boardlist());
		model.addAttribute(service.read(id));
		return "board/modify.page";
	}
	
	@RequestMapping(value="/remove",method = RequestMethod.POST)
	public String remove(@RequestParam("id") String id,SearchCriteria cri,RedirectAttributes rttr) throws Exception{
		service.remove(id);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addAttribute("board",cri.getBoard());
		rttr.addFlashAttribute("msg","SUCCESS");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/modify",method = RequestMethod.POST)
	public String modifyPost(BoardDTO board,@ModelAttribute("cri") SearchCriteria cri,Model model, RedirectAttributes rttr) throws Exception{
		service.modify(board);
		System.out.println(board.toString());
		String contentId=board.getId();
		model.addAttribute("boardlist",boardservice.boardlist());
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addFlashAttribute("msg","SUCCESS");
		return "redirect:/board/read?id="+contentId;
	}
	

}