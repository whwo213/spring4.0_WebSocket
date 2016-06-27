<%@ page import="java.util.List" %>
<%@ page import="com.spring.mvc.vacation.vo.VacationVo" %>
<%@ page import="org.springframework.util.StringUtils" %><%--
  Created by IntelliJ IDEA.
  User: young
  Date: 2016-06-25
  Time: 오후 2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:set value="${vacationList}" var="vacationList"/>
<%
    String sDate = StringUtils.isEmpty(request.getParameter("sDate")) ? "" : request.getParameter("sDate");
    String eDate = StringUtils.isEmpty(request.getParameter("eDate")) ? "" : request.getParameter("eDate");
    String keyword = StringUtils.isEmpty(request.getParameter("keyword")) ? "" : request.getParameter("keyword");
%>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            휴가관리
            <small>Vacation paneal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Users</li>
        </ol>
    </section>
    <section class="content">
        <div class="col-xs-12">
            <div class="box-body">
                <div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
                    <div class="row">
                        <div class="col-sm-12">
                            <form action="/vacation/adminList" method="post">
                                <input id="datepicker1" name="sDate" type="text" value="<%=sDate%>" class="form-control" placeholder="시작일 선택">
                                <input id="datepicker2" name="eDate" type="text" value="<%=eDate%>" class="form-control" placeholder="종료일 선택">
                                <input name="keyword" type="text" value="<%=keyword%>" class="form-control" placeholder="이름 검색">
                                <input type="submit" class="btn btn-default" value="검색" style="width: 10%">
                            </form>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-sm-12">
                            <%List<VacationVo> vacationList = (List<VacationVo>) pageContext.getAttribute("vacationList");%>
                            <table class="table table-bordered table-striped dataTable" role="grid"
                                   aria-describedby="example2_info">
                                <colgroup>
                                    <col width="10%"/>
                                    <col width="10%"/>
                                    <col width="20%"/>
                                    <col width="50%"/>
                                    <col width="10%"/>
                                </colgroup>
                                <tr>
                                    <th>번호</th>
                                    <th>이름</th>
                                    <th>휴가신청일</th>
                                    <th>휴가사유</th>
                                    <th>상태</th>
                                </tr>
                                <%if(vacationList.size() == 0){%>
                                <tr>
                                    <td colspan="5" align="center">데이터가 없습니다.</td>
                                </tr>
                                <%}%>
                                <%
                                    for(VacationVo item : vacationList){%>
                                <tr>
                                    <td>a</td>
                                    <td><%=item.getVACATION_USER_NAME()%></td>
                                    <td><%=item.getVACATION_DATE()%></td>
                                    <td><%=item.getVACATION_MEMO()%></td>
                                    <%
                                        String status = StringUtils.isEmpty(item.getTMP1()) ? "" :item.getTMP1();
                                    %>
                                    <td>
                                        <select onchange="$.status(this)" id="<%=item.getIDX()%>">
                                            <option value="">선택</option>
                                            <option value="N" <%=status.equals("N") ? "selected=\"selected\"" : ""%>>대기</option>
                                            <option value="Y" <%=status.equals("Y") ? "selected=\"selected\"" : ""%>>승인</option>
                                        </select>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </section>
</div>
</body>
<script type="text/javascript">
    jQuery(function(){
        $('#datepicker1').datepicker({
            autoclose:true,
        })
        $('#datepicker2').datepicker({
            autoclose:true,
        })
    })
    $.status = function(e){
        var idx = $(e).attr('id');
        var val = $(e).find('option:selected').val();
        $.ajax({
            url:'/vacation/adminListDelete',
            type:'post',
            dataType:'html',
            data:{'idx':idx,'status':val},
            success:function(data){
                alert('success');
            },error:function(error){
                alert('error');
            }
        })
    }

</script>
</html>
