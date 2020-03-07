package com.peta.controller.board;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.peta.dto.ReplyDTO;
import com.peta.dto.board.BoardListDTO;
import com.peta.service.BoardReplyService;
import com.peta.service.board.BoardListService;

@RestController
@RequestMapping("/admin")
public class BoardRestController {
	
	
	@Inject
	private BoardListService service;

	@RequestMapping(value="modify", method = {RequestMethod.PUT,RequestMethod.PATCH})
	public ResponseEntity<String> update(String id,@RequestBody BoardListDTO dto){
		ResponseEntity<String> entity = null;
		try {
			//dto.setId(rno);
			service.boardUpdate(dto);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
