package com.spring.mvc.vacation.service;

import com.spring.mvc.vacation.vo.VacationVo;

import java.util.List;

/**
 * Created by young on 2016-06-25.
 */
public interface VacationService {
    public String uniqIdxSelect(String email);
    public int Register(VacationVo vacationVo);
    List<VacationVo> VacationList(String sDate,String eDate,String keyword);
    public int Update(String idx,String status);
}
