package com.spring.mvc;
import com.spring.mvc.user.srevice.UserService;
import com.spring.mvc.user.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

/**
 * Created by apple6268 on 16. 1. 28.
 */
@Controller
public class Controll {

    Logger logger = LoggerFactory.getLogger(Controll.class);

    @Autowired
    private UserService userService;

    @RequestMapping(value = { "/"}, method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView defaultPage(
            UserVo userVo
    ) {
        ModelAndView model = new ModelAndView();

        model.setViewName("redirect:index");
        return model;
    }

    @RequestMapping(value = "/insert",method = RequestMethod.POST)
    public ModelAndView userInsert(
            @RequestParam HashMap<String,String> param,
            ModelAndView modelAndView,
            UserVo userVo
    ){

        userVo.setUSERNAME(param.get("username"));
        userVo.setPASSWORD(param.get("password"));
        userVo.setEMAIL(param.get("email"));
        userVo.setPHONE(param.get("phone"));
        userVo.setRANK("");
        int success = userService.Register(userVo);

        String msg = "";
        if(success > 0){
            msg = "가입신청되었습니다. 관리자가 승인처리후 로그인이 가능합니다.";
            modelAndView.setViewName("redirect:/login");
        }else{
            msg = "이메일이 존재합니다.";
            modelAndView.setViewName("login");
        }
        modelAndView.addObject("msg",msg);

        return modelAndView;
    }



    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "회원 계정 또는 암호가 잘못되었습니다.");
        }

        if (logout != null) {
            model.addObject("msg", "성공적으로 로그아웃 되었습니다.");
        }
        model.setViewName("login");

        return model;

    }

    //for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public ModelAndView accesssDenied() {

        ModelAndView model = new ModelAndView();

        //check if user is login
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        model.addObject("principal",auth.getPrincipal());
        WebAuthenticationDetails details = (WebAuthenticationDetails) auth.getDetails();

        /*if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            model.addObject("username", userDetail.getUsername());

        }*/
        if(!details.equals("")){
            model.setViewName("index");
        }else{
            model.setViewName("403");
        }


        return model;

    }



    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView Index() {

        ModelAndView model = new ModelAndView();
        model.setViewName("index");

        return model;

    }

}
