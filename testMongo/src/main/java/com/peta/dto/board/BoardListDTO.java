package com.peta.dto.board;

import org.springframework.data.mongodb.core.mapping.Document;


@Document(collection = "boardList")
public class BoardListDTO {
	private String id;
	private String boardName;
	private String boardUrl;
	private int boardOrder;
	
	
	
	public int getBoardOrder() {
		return boardOrder;
	}
	public void setBoardOrder(int boardOrder) {
		this.boardOrder = boardOrder;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoardUrl() {
		return boardUrl;
	}
	public void setBoardUrl(String boardUrl) {
		this.boardUrl = boardUrl;
	}
	
	

}
