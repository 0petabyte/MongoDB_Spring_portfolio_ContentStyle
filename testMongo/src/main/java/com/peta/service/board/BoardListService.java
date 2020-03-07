package com.peta.service.board;

import java.util.List;

import org.springframework.stereotype.Service;

import com.peta.dto.board.BoardListDTO;


@Service
public interface BoardListService {
	
	public List<BoardListDTO> boardlist() throws Exception;
	
	public void boardcreate(BoardListDTO dto) throws Exception;
	
	public void boardRemove(String id) throws Exception;
	
	public void boardUpdate(BoardListDTO dto) throws Exception;
}
