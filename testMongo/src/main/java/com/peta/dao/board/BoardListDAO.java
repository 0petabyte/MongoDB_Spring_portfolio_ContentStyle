package com.peta.dao.board;

import java.util.List;

import com.peta.dto.board.BoardListDTO;

public interface BoardListDAO {

	public List<BoardListDTO> boardlist()throws Exception;
	
	public void boardCreate(BoardListDTO dto) throws Exception;
	
	public void boardRemove(String id)throws Exception;
	
	public void boardUpate(BoardListDTO dto) throws Exception;
}
