package com.peta.dao;

import java.util.List;

import com.mongodb.client.ClientSession;
import com.peta.dto.Criteria;
import com.peta.dto.ReplyDTO;

public interface BoardReplyDAO {
	
	public List<ReplyDTO> list(String rno,com.peta.dto.Criteria cri) throws Exception;
	
	public void create(ClientSession session,ReplyDTO dto) throws Exception;
	
	public void update(ReplyDTO dto) throws Exception;
	
	public void delete(ClientSession session,String id) throws Exception;
	
	public int count(String rno) throws Exception;
}
