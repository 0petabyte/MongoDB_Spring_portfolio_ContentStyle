package com.peta.dao.message;

import java.util.HashMap;
import java.util.List;

import com.mongodb.client.ClientSession;
import com.peta.dto.SearchCriteria;
import com.peta.dto.message.MessageDTO;

public interface MessageDAO {

	public void create(ClientSession session,MessageDTO dto) throws Exception;
	
	public MessageDTO readMessage(String id) throws Exception;
	
	public HashMap<String, String> updateState(ClientSession session,String uid,String id) throws Exception;
	
	public List<MessageDTO> readMessageList(SearchCriteria cri,String uid) throws Exception;
	
	public int readMessageCount(SearchCriteria cri,String uid) throws Exception;
}
