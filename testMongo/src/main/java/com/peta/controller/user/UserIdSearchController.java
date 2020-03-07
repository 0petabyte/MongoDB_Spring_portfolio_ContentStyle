package com.peta.controller.user;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.peta.service.user.UserService;


@RestController
@RequestMapping("/user")
public class UserIdSearchController {

	@Inject
	private UserService service;
	
	@RequestMapping(value = "/joinId", method = RequestMethod.POST)
	public boolean searchId(String id)throws Exception{
		System.out.println(id);
		boolean idValue = service.joinId(id);
		return idValue;
	}
	
	@RequestMapping(value = "/joinUname", method = RequestMethod.POST)
	public boolean searchUname(String uname)throws Exception{
		System.out.println(uname);
		boolean idValue = service.joinUname(uname);
		return idValue;
	}
}
