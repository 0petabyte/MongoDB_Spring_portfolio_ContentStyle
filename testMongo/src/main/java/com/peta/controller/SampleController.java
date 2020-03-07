package com.peta.controller;

import javax.xml.ws.Response;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.peta.dto.BoardDTO;

@RestController
@RequestMapping("/sample")
public class SampleController {
	@RequestMapping("/hello")
	public String sayHello() {
		
		
		return "Hello World";
	}
	
	@RequestMapping("boardDTO")
	public BoardDTO board() {
		BoardDTO dto = new BoardDTO();
		dto.setTitle("test");
		dto.setContent("test2");
		return dto;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	

}
