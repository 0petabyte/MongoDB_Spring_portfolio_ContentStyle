package com.peta.dto.user;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "tb1_user")
public class UserUnameDTO {

	private String id;
	private String uid;
	private String uname;
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
	
	
}
