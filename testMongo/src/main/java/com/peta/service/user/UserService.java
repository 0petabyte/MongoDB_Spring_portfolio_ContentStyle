package com.peta.service.user;

import java.util.Date;
import java.util.List;

import com.peta.dto.user.LoginDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;

public interface UserService {
	public UserDTO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next) throws Exception;
	
	public UserDTO checkLoginBefore(String value);

	public List<UserUnameDTO> searchid() throws Exception;
	
	public boolean joinId(String id) throws Exception;
	
	public boolean joinUname(String uname) throws Exception;
	
	public void joinUser(UserDTO user) throws Exception;
}
