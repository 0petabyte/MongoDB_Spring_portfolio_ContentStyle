package com.peta.controller.img;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.peta.dto.PageMaker;
import com.peta.dto.SearchCriteria;
import com.peta.dto.img.ImgDTO;
import com.peta.service.board.BoardListService;
import com.peta.service.img.ImgService;

@Controller
@RequestMapping(value="/img/*")
public class ImgBoardController {
	
	@Inject
	private ImgService service;
	
	@Inject
	private BoardListService boardservice;
	
	@RequestMapping(value="list" , method = RequestMethod.GET)
	public String listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute("list",service.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("boardlist",boardservice.boardlist());
		model.addAttribute("pageMaker",pageMaker);
		
		return "img/listCri.page";
	}
	
	
	@RequestMapping(value="register", method = RequestMethod.GET)
	public String registerGET(ImgDTO img,Model model)throws Exception{
		return "img/register.page";
	}
	
	@RequestMapping(value="register", method=RequestMethod.POST)
	public String registerPOST(ImgDTO img, Model model, RedirectAttributes attr) throws Exception{
		service.register(img);
		attr.addFlashAttribute("msg","success");
		return "redirect:/img/list";
	}
	
	@RequestMapping(value="read", method = RequestMethod.GET)
	public String read(@RequestParam("id") String id,@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(id));
		return "img/read.page";
	}
	
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modify(@RequestParam("id") String id, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(id));
		
		return "img/modify.page";
	}
	
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modify(ImgDTO img, @ModelAttribute("cri") SearchCriteria cri, Model model, RedirectAttributes rttr) throws Exception {
		service.modify(img);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addFlashAttribute("msg","SUCCESS");
		return "redirect:/img/list";
	}
	
	
	
	@RequestMapping(value="remove", method=RequestMethod.GET)
	public String remove(@RequestParam("id") String id, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		//System.out.println("remove");
		service.remove(id);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addFlashAttribute("msg","SUCCESS");
		
		return "redirect:/img/list";
	}
	
}
