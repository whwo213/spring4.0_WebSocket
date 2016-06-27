<%@ page import="com.spring.mvc.user.vo.UserVo" %>
<%@ page import="com.spring.mvc.customClass.UtilString" %><%--
  Created by IntelliJ IDEA.
  User: young
  Date: 2016-06-21
  Time: 오후 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #example2 > thead > tr > th {
        text-align: center;
    }
</style>

<%
    UtilString utilString = new UtilString();
%>
<script type="text/javascript">
    $.formSuccess = function(e){
        var email = $(e).find('#email');
        var password = $(e).find('#password');
        var userName = $(e).find('#userName');
        var userTel = $(e).find('#userTel');
        var tel1 = $(e).find('#tel1');
        var tel2 = $(e).find('#tel2');
        var tel3 = $(e).find('#tel3');
        var rank = $(e).find('#rank option:selected');
        var status = $(e).find('#status option:selected');
        userTel.text(tel1.val()+'-'+tel2.val()+'-'+tel3.val());
        if(email.val() == ''){
            alert('이메일을 입력해주세요.');
            email.focus();
            return false;
        }

        if(password.val() == ''){
            alert('비밀번호을 입력해주세요.');
            password.focus();
            return false;
        }

        if(userName.val() == ''){
            alert('이름을 입력해주세요.');
            userName.focus();
            return false;
        }

        if(rank.val() == ''){
            alert('직급을 선택해주세요.');
            rank.focus();
            return false;
        }

        if(status.val() == ''){
            alert('승인상태을 입력해주세요.');
            status.focus();
            return false;
        }
        return true;

    }
</script>


<c:set var="userVo" value="${userVo}" />
<%
    UserVo userVo = (UserVo) pageContext.getAttribute("userVo");
%>


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            직원등록
            <small>Users paneal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Users</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <form action="/user/insert" method="post" onsubmit="return $.formSuccess(this)">
            <input type="hidden" name="userTel" id="userTel" value="<%=utilString.isNullStr(userVo.getPHONE())%>" />
            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" id="email" class="form-control" placeholder="이메일 입력" value="<%=utilString.isNullStr(userVo.getEMAIL())%>"/>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호 입력" value=""/>
            </div>
            <div class="form-group">
                <label>이름</label>
                <input type="text" name="userName" id="userName" class="form-control" placeholder="이름 입력" value="<%=utilString.isNullStr(userVo.getUSERNAME())%>"/>
            </div>
            <div class="form-group">
                <label>전화번호</label>
                <div class="form-inline">
                    <div class="form-group">
                        <select class="form-control" id="tel1" title="휴대전화 앞번호">
                            <option value="">선택하세요</option>
                            <option value="010" selected="selected">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
                            <option value="070">070</option>
                            <option value="0130">0130</option>
                            <option value="0303">0303</option>
                            <option value="0502">0502</option>
                            <option value="0504">0504</option>
                            <option value="0505">0505</option>
                            <option value="0506">0506</option>
                        </select>
                    </div>
                    -
                    <div class="form-group">
                        <input type="text" maxlength="4" id="tel2" class="form-control" placeholder="휴대전화 중간번호">
                    </div>
                    -
                    <div class="form-group">
                        <input type="text" maxlength="4" id="tel3" class="form-control" placeholder="휴대전화 뒷번호">
                    </div>
                </div>
            </div>
            <div class="form-group">

                <label>직급</label>
                <select class="form-control" name="rank">
                    <option value="">선택</option>
                    <option value="ceo" <%=utilString.isNullStr(userVo.getRANK()).equals("ceo") ? "selected=\"selected\"" : ""%> >CEO</option>
                    <option value="manager" <%=utilString.isNullStr(userVo.getRANK()).equals("manager") ? "selected=\"selected\"" : ""%>>매니저</option>
                    <option value="staff" <%=utilString.isNullStr(userVo.getRANK()).equals("staff") ? "selected=\"selected\"" : ""%>>사원</option>
                    <option value="alba" <%=utilString.isNullStr(userVo.getRANK()).equals("alba") ? "selected=\"selected\"" : ""%>>알바</option>
                </select>
            </div>
            <%
                String enable = utilString.isNullStr(userVo.getENABLE());
            %>
            <div class="form-group">
                <label>상태</label>
                <select class="form-control" name="status">
                    <option value="">선택</option>
                    <option value="1" <%=enable.equals("1") ? "selected=\"selected\"" : ""%>>승인</option>
                    <option value="0" <%=enable.equals("0") ? "selected=\"selected\"" : ""%>>대기</option>
                </select>
            </div>
            <div class="row" align="right">
                <div class="col-sm-12">
                    <a class="btn btn-danger" href="/user/list">취소</a>
                    <input type="submit" class="btn btn-success" value="등록"/>
                </div>
            </div>
        </form>
    </section>
    <!-- /.content -->
</div>
