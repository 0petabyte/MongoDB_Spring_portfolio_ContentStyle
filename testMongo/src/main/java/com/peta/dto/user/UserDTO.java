package com.peta.dto.user;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Document;

@Document (collection = "tb1_user")
public class UserDTO {
	private String id;
	private String uid;
	private String upw;
	private String uname;
	private int point;
	private Date sessionLimit;
	private String sessionkey;
	private String address;
	private String email;

	
	
	

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getSessionLimit() {
		return sessionLimit;
	}
	public void setSessionLimit(Date sessionLimit) {
		this.sessionLimit = sessionLimit;
	}
	public String getSessionkey() {
		return sessionkey;
	}
	public void setSessionkey(String sessionkey) {
		this.sessionkey = sessionkey;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public int getpoint() {
		return point;
	}
	public void setpoint(int upoint) {
		this.point = upoint;
	}
	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", uid=" + uid + ", upw=" + upw + ", uname=" + uname + ", point=" + point
				+ ", sessionLimit=" + sessionLimit + ", sessionkey=" + sessionkey + "]";
	}


	
	
}
