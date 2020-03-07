package com.peta.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import com.mongodb.client.ClientSession;
import com.mongodb.client.MongoClient;
import com.peta.dao.BoardDAO;
import com.peta.dao.message.PointDAO;
import com.peta.dto.BoardDTO;
import com.peta.dto.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO dao;
	
	@Inject
	private PointDAO pointDAO;

	@Autowired
	private MongoClient mongoClient;
	
	@Override
	public List<BoardDTO> list() throws Exception{
		return dao.list();
	}
	
	@Override
	public void regist(BoardDTO board)throws Exception{
		
		try (ClientSession session = mongoClient.startSession()) {

			session.startTransaction();

			try {

				dao.create(session,board);
				pointDAO.updatePoint(session,board.getWriterId(), 30);
				session.commitTransaction();

			} catch (Exception e) {
				e.printStackTrace();
				session.abortTransaction();
			}
			session.close();

		}
		
		
		/*
		 * String[] files = board.getFiles();
		 * 
		 * if(files == null) {return;} for(String filesName : files) {
		 * System.out.println("dao In"); dao.addAttach(filesName); }
		 */
	}

	@Override
	public BoardDTO read(String id) throws Exception{
		dao.updateViewCnt(id);
		return dao.read(id);
	}
	
	@Override
	public void remove(String id)throws Exception{
		dao.remove(id);
	}
	
	@Override
	public void modify(BoardDTO board)throws Exception{
		dao.modify(board);
	}
	
	@Override
	public List<BoardDTO> listCriteria(com.peta.dto.Criteria cri) throws Exception{
		return dao.listCriteria(cri);
	}
	
	@Override
	public List<BoardDTO> listSearchCriteria(SearchCriteria cri) throws Exception{
		return dao.listSearch(cri);
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception{
		return dao.listSearchCount(cri);
	}

}