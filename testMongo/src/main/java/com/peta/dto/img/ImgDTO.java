package com.peta.dto.img;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "imgBoard")
public class ImgDTO {
	private String id;
	private String title;
	private String content;
	private String fileName;
	private Date dateTime;
	private String writer;
	
	
	
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Date getDateTime() {
		return dateTime;
	}
	public void setDateTime(Date dateTime) {
		this.dateTime = dateTime;
	}
	@Override
	public String toString() {
		return "ImgDTO [id=" + id + ", title=" + title + ", content=" + content + ", fileName=" + fileName
				+ ", dateTime=" + dateTime + "]";
	}
	
	
	
	
}
