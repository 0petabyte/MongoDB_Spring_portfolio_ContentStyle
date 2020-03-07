package com.peta.controller.message;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.peta.dto.message.MessageDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;
import com.peta.service.message.MessageService;
import com.peta.service.user.UserService;

@RestController
@RequestMapping("/messages")
public class MessageController {

	@Inject
	private MessageService service;
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value="/", method = RequestMethod.POST)
	public ResponseEntity<String> addMessage(@RequestBody MessageDTO dto){
		ResponseEntity<String> entity = null;
		
		try {
			service.addMessage(dto);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	
	
//	@RequestMapping(value = "/read" , method = RequestMethod.GET)
//	public ResponseEntity<Map<String,Object>> ReadMessage(String uid,String id) throws Exception{
//		ResponseEntity<Map<String,Object>> entity = null;
//		try {
//			Map<String,Object> map = new HashMap<String, Object>();
//			MessageDTO message = service.readMessage(uid, id);
//			map.put("list",message);
//			entity=new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
//		}catch (Exception e) {
//			e.printStackTrace();
//			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}
	
	@RequestMapping(value = "/searchId" , method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> search() throws Exception{
		ResponseEntity<Map<String,Object>> entity = null;
		try {
			Map<String,Object> map = new HashMap<String, Object>();
			System.out.println("1");
			List<UserUnameDTO> ulist = userService.searchid();
			System.out.println(ulist);
			map.put("list",ulist);
			entity=new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//½ºÇÁ¸µ ÄÁÆ®·Ñ·¯ ºÎºÐ
	@RequestMapping(value = "/json", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String json(Locale locale, Model model) {    
	    String[] array = {"test2", "apple", "Áø¶ó¸é", "¶óººÀÌ", "ÆÏºù¼ö","³Ê±¸¸®","»ï¾ç¶ó¸é","¾È¼ºÅÁ¸é","ºÒ´ßººÀ½¸é","Â¥¿Õ","¶ó¸é»ç¸®"};
	    	
	        Gson gson = new Gson();

	    return gson.toJson(array);//["±èÄ¡ ººÀ½¹ä","½Å¶ó¸é","Áø¶ó¸é","¶óººÀÌ","ÆÏºù¼ö","³Ê±¸¸®","»ï¾ç¶ó¸é","¾È¼ºÅÁ¸é","ºÒ´ßººÀ½¸é","Â¥¿Õ","¶ó¸é»ç¸®"]
	}
}
