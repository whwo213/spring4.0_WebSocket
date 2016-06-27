package com.spring.mvc.mapper;

import com.spring.mvc.vacation.vo.VacationVo;
import org.apache.ibatis.annotations.*;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * Created by young on 2016-06-25.
 */
public interface VacationMapper {



    @Select(" Select IDX from USERS WHERE EMAIL = #{email} ")
    String uniqIdxSelect(@Param(value = "email") String email);

    @Insert(" INSERT INTO VACATION(IDX,VACATION_USER_NAME,VACATION_DATE,VACATION_MEMO,PARENT_IDX) VALUES(VACATION_SEQ.NEXTVAL,#{VACATION_USER_NAME},#{VACATION_DATE},#{VACATION_MEMO},#{PARENT_IDX}) ")
    int register(VacationVo vacationVo);


    @SelectProvider(type = VacationList.class, method = "getVacationList")
    List<VacationVo> VacationList(@Param(value = "sDate") String sDate
            ,@Param(value = "eDate") String eDate
            ,@Param(value = "keyword") String keyword);

    public class VacationList{
        public String getVacationList(Map<String,Object> map){
            final String sDate = (String) map.get("sDate");
            final String eDate = (String) map.get("eDate");
            final String keyword = (String) map.get("keyword");
            StringBuffer query = new StringBuffer();
            query.append(" SELECT * FROM VACATION ");
            query.append(" WHERE 1=1 ");
            if(!StringUtils.isEmpty(sDate)){
                query.append(" AND TO_CHAR(VACATION_DATE,'yyyy-MM-dd') >= #{sDate} ");
            }

            if(!StringUtils.isEmpty(eDate)){
                query.append(" AND TO_CHAR(VACATION_DATE,'yyyy-MM-dd') <= #{eDate} ");
            }

            if(!StringUtils.isEmpty(keyword)){
                query.append(" AND VACATION_USER_NAME like '%'||#{keyword}||'%' ");
            }
            query.append(" ORDER BY IDX DESC ");

            return query.toString();
        }
    }

    @Update(" UPDATE VACATION SET TMP1 = #{status} WHERE IDX = #{idx} ")
    int Update(@Param(value = "idx") String idx,@Param(value = "status") String status);

}
