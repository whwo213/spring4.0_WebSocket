package com.spring.mvc.vacation.dao;

import com.spring.mvc.mapper.VacationMapper;
import com.spring.mvc.vacation.vo.VacationVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by young on 2016-06-25.
 */
@Repository
public class VacationDaoImpl implements VacationDao  {

    @Autowired
    private VacationMapper vacationMapper;

    public String uniqIdxSelect(String email) {
        return vacationMapper.uniqIdxSelect(email);
    }

    public int Register(VacationVo vacationVo) {
        return vacationMapper.register(vacationVo);
    }

    public List<VacationVo> VacationList(String sDate,String eDate,String keyword) {
        return vacationMapper.VacationList(sDate,eDate,keyword);
    }

    public int Update(String idx,String status) {
        return vacationMapper.Update(idx,status);
    }
}
