package com.peta.service.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.peta.dao.board.BoardListDAO;
import com.peta.dto.board.BoardListDTO;

@Service
public class BoardListServiceImpl implements BoardListService{

	@Inject
	private BoardListDAO dao;
	
	@Override
	public List<BoardListDTO> boardlist() throws Exception {
		return dao.boardlist();
	}

	@Override
	public void boardcreate(BoardListDTO dto) throws Exception {
		dao.boardCreate(dto);
	}

	@Override
	public void boardRemove(String id) throws Exception {
		dao.boardRemove(id);
	}

	@Override
	public void boardUpdate(BoardListDTO dto) throws Exception {
		dao.boardUpate(dto);
		
	}
	
	

}
