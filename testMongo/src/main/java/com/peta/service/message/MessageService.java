package com.peta.service.message;

import java.util.List;

import com.peta.dto.SearchCriteria;
import com.peta.dto.message.MessageDTO;

public interface MessageService {
	public void addMessage(MessageDTO dto) throws Exception;
	
	public MessageDTO readMessage(String uid,String id) throws Exception;
	
	public List<MessageDTO> readMessageList(SearchCriteria cri,String uid) throws Exception;
	
	public int readMessageCount(SearchCriteria cri,String uid) throws Exception;
}
