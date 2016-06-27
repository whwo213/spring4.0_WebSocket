package com.spring.mvc.user.vo;

/**
 * Created by young on 2016-06-19.
 */
public class UserVo {
    String IDX;
    String USERNAME;
    String PASSWORD;
    String EMAIL;
    String PHONE;
    String RANK;
    String ENABLE;


    public String getIDX() {
        return IDX;
    }

    public void setIDX(String IDX) {
        this.IDX = IDX;
    }

    public String getUSERNAME() {
        return USERNAME;
    }

    public void setUSERNAME(String USERNAME) {
        this.USERNAME = USERNAME;
    }

    public String getPASSWORD() {
        return PASSWORD;
    }

    public void setPASSWORD(String PASSWORD) {
        this.PASSWORD = PASSWORD;
    }

    public String getENABLE() {
        return ENABLE;
    }

    public void setENABLE(String ENABLE) {
        this.ENABLE = ENABLE;
    }


    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String EMAIL) {
        this.EMAIL = EMAIL;
    }

    public String getPHONE() {
        return PHONE;
    }

    public void setPHONE(String PHONE) {
        this.PHONE = PHONE;
    }

    public String getRANK() {
        return RANK;
    }

    public void setRANK(String RANK) {
        this.RANK = RANK;
    }


}
