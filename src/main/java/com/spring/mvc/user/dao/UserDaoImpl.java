package com.spring.mvc.user.dao;

import com.spring.mvc.mapper.UserMapper;
import com.spring.mvc.user.vo.UserRoleVo;
import com.spring.mvc.user.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by young on 2016-06-19.
 */
@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    private UserMapper userMapper;


    public int Register(UserVo userVo) {
        return userMapper.register(userVo);
    }

    public int roleRegister(UserRoleVo userRoleVo) {
        return userMapper.roleRegister(userRoleVo);
    }

    public List<UserVo> userList() {
        return userMapper.userList();
    }

    public int userListSuccess(int status, String idx) {
        return userMapper.userListSuccess(status,idx);
    }

    public UserVo getUser(String idx) {
        return userMapper.getUser(idx);
    }

    public int uniqEmail(String email) {
        return userMapper.uniqEmail(email);
    }
}
