package com.spring.mvc.vacation;

import com.spring.mvc.vacation.service.VacationService;
import com.spring.mvc.vacation.vo.VacationVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

/**
 * Created by young on 2016-06-24.
 */
@Controller
public class VacationControll {

    Logger logger = LoggerFactory.getLogger(VacationControll.class);

    @Autowired
    VacationService vacationService;

    @RequestMapping(value = "/vacation/list", method = RequestMethod.GET)
    public ModelAndView vacationList(
            ModelAndView modelAndView,
            @RequestParam HashMap<String,String> param
    ){

        String sDate = param.get("sDate");
        String eDate = param.get("eDate");
        String keyword = param.get("keyword");
        List<VacationVo> vacationList = vacationService.VacationList(sDate,eDate,keyword);


        modelAndView.addObject("vacationList",vacationList);
        modelAndView.setViewName("vacation/list");
        return modelAndView;
    }



    @RequestMapping(value = "/vacation/adminList", method = {RequestMethod.GET,RequestMethod.POST})
    public ModelAndView vacationAdminList(
            ModelAndView modelAndView,
            @RequestParam HashMap<String,String> param
    ){
        String sDate = param.get("sDate");
        String eDate = param.get("eDate");
        String keyword = param.get("keyword");
        List<VacationVo> vacationList = vacationService.VacationList(sDate,eDate,keyword);
        modelAndView.addObject("vacationList",vacationList);
        modelAndView.setViewName("vacation/adminList");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/vacation/adminListDelete",method = {RequestMethod.POST})
    public String vacationAdminListDelete(
            @RequestParam HashMap<String,String> param
    ){
        String idx = param.get("idx");
        String status = param.get("status");


        return "success";
    }

}
