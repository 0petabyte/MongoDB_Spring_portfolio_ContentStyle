package com.peta.dto;

import java.util.Arrays;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "board")
public class BoardDTO {
	
	@Id
	private String id;
	private String title;
	private String content;
	private String board;
	private String boardName;
	private Date dateTime;
	private String writer;
	private int viewcnt;
	private int replycnt;
	private String[] files;
	private String writerId;
	
	
	
	
	
	
	
	
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoard() {
		return board;
	}
	public void setBoard(String board) {
		this.board = board;
	}
	public String getWriterId() {
		return writerId;
	}
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDateTime() {
		return dateTime;
	}
	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
	@Override
	public String toString() {
		return "BoardDTO [id=" + id + ", title=" + title + ", content=" + content + ", dateTime=" + dateTime
				+ ", writer=" + writer + ", viewcnt=" + viewcnt + ", replycnt=" + replycnt + ", files="
				+ Arrays.toString(files) + "]";
	}


	
	

	
	

}
