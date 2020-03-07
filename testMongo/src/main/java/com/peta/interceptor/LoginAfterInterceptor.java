package com.peta.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginAfterInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginAfterInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession session = request.getSession();
		saveDest(request);
		if(session.getAttribute("login") !=null) {
			response.sendRedirect("/board/list");
			return false;
		}
		
		return true;
	}

	private void saveDest(HttpServletRequest req) {
		String referer = (String)req.getHeader("REFERER");
		String[] test = referer.split("9920");
		System.out.println(test[1]);
		req.getSession().setAttribute("beforUrl", test[1]);

	}

}
