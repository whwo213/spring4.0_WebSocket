package com.spring.mvc.user;

import com.spring.mvc.user.srevice.UserService;
import com.spring.mvc.user.vo.UserVo;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

/**
 * Created by young on 2016-06-21.
 */
@Controller
public class UserControll {
    Logger logger = LoggerFactory.getLogger(UserControll.class);

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/user/list" , method = RequestMethod.GET)
    public ModelAndView UserList(
            ModelAndView modelAndView
    ){
        List<UserVo> userList = userService.userList();
        modelAndView.addObject("userList",userList);
        modelAndView.setViewName("user/list");
        return modelAndView;
    }

    @RequestMapping(value = "/user/write",method = RequestMethod.GET)
    public ModelAndView UserWrite(
            ModelAndView modelAndView,
            UserVo userVo,
            @RequestParam(value = "idx",required = false) String idx
    ){

        if(idx == null){

        }else{
            userVo = userService.getUser(idx);
        }

        modelAndView.addObject("userVo",userVo);
        modelAndView.setViewName("user/write");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/user/list/status" , method = RequestMethod.GET)
    public String UserListSuccess(
            @RequestParam HashMap<String,String> param
            ){
        String idx = param.get("idx");
        int status = Integer.parseInt(param.get("status"));
        JSONObject obj = new JSONObject();


        if(userService.userListSuccess(status,idx) == 1){
            obj.put("msg","success");
        }else{
            obj.put("msg","error");
        }

        return obj.toJSONString();
    }
}
