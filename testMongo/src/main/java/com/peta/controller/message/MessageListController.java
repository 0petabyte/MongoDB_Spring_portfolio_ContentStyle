package com.peta.controller.message;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.peta.dto.PageMaker;
import com.peta.dto.SearchCriteria;
import com.peta.dto.message.MessageDTO;
import com.peta.service.BoardService;
import com.peta.service.message.MessageService;

@Controller
@RequestMapping("/messagelist")
public class MessageListController {
	
	@Inject
	private MessageService service;
	
	@Inject
	private BoardService boardService;

	@RequestMapping(value="", method=RequestMethod.GET)
	public String messagelist(@ModelAttribute ("cri") SearchCriteria cri, String uid, Model model) throws Exception{
		
		int test = service.readMessageCount(cri, uid);
		model.addAttribute("messagelist",service.readMessageList(cri,uid));
		model.addAttribute("messageSize", test);
		model.addAttribute("sendId",uid);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(test);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("type",cri.getSearchType());
		return "/message/messageList";
	}
	
	@RequestMapping(value="send", method=RequestMethod.GET)
	public String sendGet() throws Exception{

		return "/message/messageSendForm";
	}
	
	@RequestMapping(value = "read" , method = RequestMethod.GET)
	public String readGet(String uid, String id,Model model)throws Exception{
		
		MessageDTO message = service.readMessage(uid, id);
		model.addAttribute("list",message);
		return "/message/messageReadForm";
	}
}
