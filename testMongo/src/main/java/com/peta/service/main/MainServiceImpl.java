package com.peta.service.main;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.peta.dao.main.MainDAO;
import com.peta.dto.BoardDTO;
import com.peta.dto.board.BoardListDTO;

@Service
public class MainServiceImpl implements MainService {

	@Inject
	private MainDAO dao;
	
	@Override
	public List<BoardDTO> mainlist() throws Exception {
		return dao.mainlist();
		
	}

	@Override
	public List<BoardListDTO> mainBoardList() throws Exception {
		
		return dao.mainBoardList();
	}

	@Override
	public List<BoardDTO> picList() throws Exception {
		return dao.piclist();
		
	}

	
}
