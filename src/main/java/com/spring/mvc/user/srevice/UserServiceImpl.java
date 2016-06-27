package com.spring.mvc.user.srevice;

import com.spring.mvc.user.dao.UserDao;
import com.spring.mvc.user.vo.UserRoleVo;
import com.spring.mvc.user.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by young on 2016-06-19.
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    public UserDao userDao;
    public void setUserDao(UserDao userDao){this.userDao = userDao;}

    public int Register(UserVo userVo) {
        int emailCnt = this.userDao.uniqEmail(userVo.getEMAIL());
        int check = 0;
        if(emailCnt == 0){
            check = this.userDao.Register(userVo);
        }

        UserRoleVo userRoleVo = new UserRoleVo();
        if(check == 1){
            userRoleVo.setEMAIL(userVo.getEMAIL());
            userRoleVo.setROLE("ROLE_USER");
            check = this.userDao.roleRegister(userRoleVo);
        }
        return check;
    }



    public List<UserVo> userList() {
        return this.userDao.userList();
    }

    public int userListSuccess(int status, String idx) {
        return this.userDao.userListSuccess(status,idx);
    }

    public UserVo getUser(String idx) {
        return this.userDao.getUser(idx);
    }

    public int uniqEmail(String email) {
        return this.userDao.uniqEmail(email);
    }
}
