package com.peta.service.main;

import java.util.List;

import org.springframework.stereotype.Service;

import com.peta.dto.BoardDTO;
import com.peta.dto.board.BoardListDTO;

@Service
public interface MainService {
	public List<BoardDTO> mainlist()throws Exception;
	
	public List<BoardListDTO> mainBoardList()throws Exception;
	
	public List<BoardDTO> picList()throws Exception;
}
