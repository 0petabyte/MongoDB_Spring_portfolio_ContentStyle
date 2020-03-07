package com.peta.service.user;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.peta.dao.user.UserDAO;
import com.peta.dto.user.LoginDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	private UserDAO dao;

	@Override
	public UserDTO login(LoginDTO dto) throws Exception {
		
		return dao.login(dto);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) throws Exception {
		dao.keepLogin(uid, sessionId, next);
		
	}

	@Override
	public UserDTO checkLoginBefore(String value) {
		
		return dao.checkUserWithSessionKey(value);
	}
	
	@Override
	public List<UserUnameDTO> searchid() throws Exception{
		return dao.searchid();
	}

	@Override
	public boolean joinId(String id) throws Exception {
		
		return dao.joinId(id);
	}

	@Override
	public boolean joinUname(String uname) throws Exception {
		
		return dao.joinUname(uname);
	}

	@Override
	public void joinUser(UserDTO user) throws Exception {
		dao.joinUser(user);
		
	}

	
	
}
