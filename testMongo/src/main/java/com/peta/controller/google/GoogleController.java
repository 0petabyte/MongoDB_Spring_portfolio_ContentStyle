package com.peta.controller.google;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GoogleController {
    @ResponseBody
    @RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST)
    public int VerifyRecaptcha(HttpServletRequest request) {
        
        String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println(gRecaptchaResponse);
        //0 = 성공, 1 = 실패, -1 = 오류
        try {
            if(com.peta.google.VerifyRecaptcha.verify(gRecaptchaResponse))
                return 0;
            else return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }


}
