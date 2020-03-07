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

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Inject
	private UserService service;

	private void saveDest(HttpServletRequest req) {
		System.out.println("dest 진입");
		String uri = req.getRequestURI();
		
		String query = req.getQueryString();
		System.out.println("쿼리:"+query);
		if(query ==null || query.equals("null")) {
			query ="";
		}else {
			query = "?" + query;
		}
		System.out.println(query);
		if(req.getMethod().equals("GET")) {
			logger.info("dest : " + (uri + query));
			req.getSession().setAttribute("dest", uri + query);
		}
	}
	//로그인이 필요한 페이지 들 이동경로
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception{
		System.out.println("3번");
		HttpSession session= request.getSession();
		System.out.println("prehandle ........1");
		Object test = session.getAttribute("login");
		System.out.println("Object :" +test);
		if(session.getAttribute("login") == null) {
			logger.info("current user is not logined");
			
			saveDest(request);
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				System.out.println("null아님 :" + loginCookie);
				UserDTO userVO = service.checkLoginBefore(loginCookie.getValue());
				
				logger.info("USERVO : "+userVO);
				
				if(userVO != null) {
					session.setAttribute("login", userVO);
					return true;
				}
			}
			
			response.sendRedirect("/user/login");
			return false;
		}
		return true;
	}
	

}
