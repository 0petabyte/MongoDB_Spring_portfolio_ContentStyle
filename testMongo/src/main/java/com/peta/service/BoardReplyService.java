package com.peta.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.peta.dto.Criteria;
import com.peta.dto.ReplyDTO;


@Service
public interface BoardReplyService {

	public List<ReplyDTO> list(String rno,Criteria cri) throws Exception;
	
	public void create(ReplyDTO dto) throws Exception;
	
	public void update(ReplyDTO dto) throws Exception;
	
	public void delete(String id) throws Exception;
	
	public int count(String rno) throws Exception;
}
