package com.spring.mvc.user.srevice;

import com.spring.mvc.user.vo.UserVo;

import java.util.List;

/**
 * Created by young on 2016-06-19.
 */
public interface UserService {
    public int Register(UserVo userVo);
    public List<UserVo> userList();
    public int userListSuccess(int status,String idx);
    public UserVo getUser(String idx);
    public int uniqEmail(String email);
}
