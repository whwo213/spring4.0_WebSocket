package com.spring.mvc.vacation.dao;

import com.spring.mvc.vacation.vo.VacationVo;

import java.util.List;

/**
 * Created by young on 2016-06-25.
 */
public interface VacationDao {
    public String uniqIdxSelect(String email);
    public int Register(VacationVo vacationVo);
    List<VacationVo> VacationList(String sDate,String eDate,String keyword);
    public int Update(String idx,String status);
}
