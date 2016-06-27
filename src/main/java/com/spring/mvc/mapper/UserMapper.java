package com.spring.mvc.mapper;

import com.spring.mvc.user.vo.UserRoleVo;
import com.spring.mvc.user.vo.UserVo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * Created by young on 2016-06-19.
 */
public interface UserMapper {



    @Select(" SELECT COUNT(*) FROM USERS WHERE EMAIL = #{email} ")
    int uniqEmail(@Param(value = "email") String email);

    @Insert(" INSERT INTO USERS(IDX,USERNAME,PASSWORD,EMAIL,PHONE,RANK,ENABLE,REGDATE) VALUES(USER_SEQ.NEXTVAL,#{USERNAME},#{PASSWORD},#{EMAIL},#{PHONE},#{RANK},0,SYSDATE) ")
    int register(UserVo userVo);

    @Insert(" insert into user_roles(EMAIL,ROLE) VALUES(#{EMAIL},#{ROLE}) ")
    int roleRegister(UserRoleVo userRoleVo);

    @Select(" SELECT * FROM ( " +
            " SELECT ROWNUM AS RNUM, Z.* FROM ( " +
            " select * from users " +
            " ) Z WHERE ROWNUM <= 10 " +
            " ) WHERE RNUM >= 1 ")
    List<UserVo> userList();

    @Update(" UPDATE USERS SET ENABLE = #{status} WHERE IDX = #{idx} ") // LSIT 에서 상태값 수정
    int userListSuccess(@Param("status") int status,@Param("idx") String idx);

    @Select(" SELECT * FROM USERS WHERE IDX = #{idx} ")
    UserVo getUser(@Param("idx") String idx);



}



