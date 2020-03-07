package com.peta.dao.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.peta.dto.user.LoginDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;

public interface UserDAO {
	public UserDTO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next);
	
	public UserDTO checkUserWithSessionKey(String value);
	
	public List<UserUnameDTO>  searchid() throws Exception;
	
	public boolean joinId(String id) throws Exception;
	
	public boolean joinUname(String uname) throws Exception;
	
	public void joinUser(UserDTO user) throws Exception;
	
}
