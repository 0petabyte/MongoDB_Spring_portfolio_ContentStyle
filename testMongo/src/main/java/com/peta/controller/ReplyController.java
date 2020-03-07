package com.peta.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.peta.dto.Criteria;
import com.peta.dto.PageMaker;
import com.peta.dto.ReplyDTO;
import com.peta.service.BoardReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	@Inject
	private BoardReplyService service;
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyDTO dto){
		ResponseEntity<String> entity = null;
		try {
			service.create(dto);
			entity=new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> list(@PathVariable("rno") String rno,@PathVariable("page") Integer page){
		ResponseEntity<Map<String,Object>> entity = null;
		
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker=new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String,Object> map = new HashMap<String, Object>();
			List<ReplyDTO> list = service.list(rno,cri);
			
			map.put("list", list);
			int replyCount = service.count(rno);
			pageMaker.setTotalCount(replyCount);
			map.put("pageMaker",pageMaker);
			entity=new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}", method = {RequestMethod.PUT,RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("rno") String rno,@RequestBody ReplyDTO dto){
		ResponseEntity<String> entity = null;
		try {
			dto.setId(rno);
			service.update(dto);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("id") String id){
		ResponseEntity<String> entity = null;
		
		try {
			service.delete(id);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	

}
