package com.spring.mvc.vacation.service;

import com.spring.mvc.vacation.dao.VacationDao;
import com.spring.mvc.vacation.vo.VacationVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by young on 2016-06-25.
 */
@Service
public class VacationServiceImpl implements VacationService {
    @Autowired
    private VacationDao vacationDao;

    public void setVacationDao(VacationDao vacationDao) {this.vacationDao = vacationDao;}


    public String uniqIdxSelect(String email) {
        return vacationDao.uniqIdxSelect(email);
    }

    public int Register(VacationVo vacationVo) {
        return vacationDao.Register(vacationVo);
    }

    public List<VacationVo> VacationList(String sDate,String eDate,String keyword) {
        return vacationDao.VacationList(sDate,eDate,keyword);
    }

    public int Update(String idx,String status) {
        return vacationDao.Update(idx,status);
    }
}
