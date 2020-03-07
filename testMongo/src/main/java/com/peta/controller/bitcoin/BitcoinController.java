package com.peta.controller.bitcoin;

import javax.inject.Inject;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mongodb.client.MongoClient;
import com.peta.config.BitcoinCollection;
import com.peta.service.bitcoin.BitcoinService;
import com.peta.service.board.BoardListService;

@Controller
@RequestMapping("/coin/*")
public class BitcoinController {
	

	@Inject
	private BitcoinService service;
	
	@Inject
	private BoardListService boardservice;
	
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public String list(Model model,String coin,String sort) throws Exception{
		model.addAttribute("AllList",service.listAll(sort));
		model.addAttribute("nowPage",coin);
		model.addAttribute("list",service.list(coin));
		model.addAttribute("boardlist",boardservice.boardlist());
		
		return "/bitcoin/list.coin";
	}
	
	@RequestMapping(value="/listAll", method = RequestMethod.GET)
	public String listAll(Model model,@ModelAttribute("coin") String coin,String sort) throws Exception{
		model.addAttribute("nowPage",coin);
		model.addAttribute("AllList",service.listAll(sort));
		model.addAttribute("boardlist",boardservice.boardlist());
		
		return "/bitcoin/listAll.coin";
	}
}
