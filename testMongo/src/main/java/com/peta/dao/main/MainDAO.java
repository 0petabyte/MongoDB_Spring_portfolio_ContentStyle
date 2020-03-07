package com.peta.dao.main;

import java.util.List;

import com.peta.dto.BoardDTO;
import com.peta.dto.board.BoardListDTO;

public interface MainDAO {
	public List<BoardDTO> mainlist()throws Exception;
	
	public List<BoardListDTO> mainBoardList()throws Exception;
	
	public List<BoardDTO> piclist()throws Exception;
}
