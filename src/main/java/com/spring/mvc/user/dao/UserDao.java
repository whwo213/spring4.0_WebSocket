package com.spring.mvc.user.dao;

import com.spring.mvc.user.vo.UserRoleVo;
import com.spring.mvc.user.vo.UserVo;

import java.util.List;

/**
 * Created by young on 2016-06-19.
 */
public interface UserDao {
    public int Register(UserVo userVo);
    public int roleRegister(UserRoleVo userRoleVo);
    public List<UserVo> userList();
    public int userListSuccess(int status,String idx);
    public UserVo getUser(String idx);
    public int uniqEmail(String email);
}
