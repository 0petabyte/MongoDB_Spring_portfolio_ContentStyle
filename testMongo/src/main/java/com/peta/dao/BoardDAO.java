package com.peta.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.mongodb.client.ClientSession;
import com.peta.dto.BoardDTO;
import com.peta.dto.SearchCriteria;
import com.peta.dto.upload.UploadDTO;


public interface BoardDAO {
	

	
	// 게시판 리스트
	 public List<BoardDTO> list() throws Exception ;
	 
	 public void create(ClientSession session, BoardDTO board) throws Exception;
	 
	 public BoardDTO read(String id) throws Exception;
	 
	 public void remove(String id)throws Exception;
	 
	 public void modify(BoardDTO board) throws Exception;
	 
	 public List<BoardDTO> listCriteria(com.peta.dto.Criteria cri) throws Exception;
	 
	 public List<BoardDTO> listSearch(SearchCriteria cri) throws Exception;
	 
	 public int listSearchCount(SearchCriteria cri) throws Exception;
	 
	 public void updateReplyCnt(ClientSession session,String rno, int amount) throws Exception;
	 
	 public String getRno(String id) throws Exception;
	 
	 public void updateViewCnt(String id) throws Exception;
	 
	 public void deleteAttach(String id) throws Exception;
	 
	/* public void addAttach(String fullName) throws Exception; */
	 

	 
	 
	 
}