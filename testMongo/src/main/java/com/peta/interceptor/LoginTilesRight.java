package com.peta.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.peta.dto.user.UserDTO;
import com.peta.service.user.UserService;

public class LoginTilesRight extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginAfterInterceptor.class);
	
	@Inject
	private UserService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception{
		HttpSession session= request.getSession();
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

		
		if(loginCookie !=null) {
			UserDTO userVO = service.checkLoginBefore(loginCookie.getValue());
			
			if(userVO != null) {
				session.setAttribute("login", userVO);
				return true;
			}
		}

		return true;
	}
	
	
}
