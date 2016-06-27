package com.spring.mvc.customClass;

/**
 * Created by young on 2016-06-24.
 */
public class UtilString {
    public String isNullStr(String str){
        str = str != null ? str : "";
        str = !str.equals("") ? str : "";
        return str;
    }
}
