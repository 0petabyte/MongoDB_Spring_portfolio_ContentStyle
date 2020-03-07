package com.peta.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import com.peta.dao.BoardDAO;
import com.peta.dto.BoardDTO;
import com.peta.dto.SearchCriteria;

@Service
public interface BoardService {
	
	public List<BoardDTO> list() throws Exception;
	
	public void regist(BoardDTO board)throws Exception;
	
	public BoardDTO read(String id)throws Exception;
	
	public void remove(String id)throws Exception;
	
	public void modify(BoardDTO board)throws Exception;
	
	public List<BoardDTO> listCriteria(com.peta.dto.Criteria cri) throws Exception;
	
	public List<BoardDTO> listSearchCriteria(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
}
