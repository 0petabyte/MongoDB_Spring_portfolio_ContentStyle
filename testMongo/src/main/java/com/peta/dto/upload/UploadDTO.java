package com.peta.dto.upload;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

@Document (collection = "tb1_attach")
public class UploadDTO {
	private String fullname;
	private String bno;
	private Date regdate;
	
	
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getBno() {
		return bno;
	}
	public void setBno(String bno) {
		this.bno = bno;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
