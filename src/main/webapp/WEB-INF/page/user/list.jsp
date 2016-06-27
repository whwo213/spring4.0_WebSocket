<%@ page import="java.util.List" %>
<%@ page import="com.spring.mvc.user.vo.UserVo" %><%--
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


<c:set value="${userList}" var="userList"/>
<%
    List<UserVo> userList = (List<UserVo>) pageContext.getAttribute("userList");
%>

<%!
    public Integer toInt(String x) {
        int a = 0;
        try {
            a = Integer.parseInt(x);
        } catch (Exception e) {
        }
        return a;
    }
%>
<%
    int pageno = toInt(request.getParameter("pageno"));
    if (pageno < 1) {//현재 페이지
        pageno = 1;
    }
    int total_record = userList.size();           //총 레코드 수
    int page_per_record_cnt = 10;  //페이지 당 레코드 수
    int group_per_page_cnt = 5;     //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
//					  									  [6],[7],[8],[9],[10]

    int record_end_no = pageno * page_per_record_cnt;
    int record_start_no = record_end_no - (page_per_record_cnt - 1);
    if (record_end_no > total_record) {
        record_end_no = total_record;
    }


    int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt > 0 ? 1 : 0);
    if (pageno > total_page) {
        pageno = total_page;
    }


// 	현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
    int group_no = pageno / group_per_page_cnt + (pageno % group_per_page_cnt > 0 ? 1 : 0);
//		현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)
//	ex) 	14		=	13(몫)		=	 (66 / 5)		1	(1(나머지) =66 % 5)

    int page_eno = group_no * group_per_page_cnt;
//		현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호
//	ex) 	70		=	14	*	5
    int page_sno = page_eno - (group_per_page_cnt - 1);
// 		현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
//	ex) 	66	=	70 - 	4 (5 -1)

    if (page_eno > total_page) {
//	   현재 그룹 끝 번호가 전체페이지 수 보다 클 경우
        page_eno = total_page;
//	   현재 그룹 끝 번호와 = 전체페이지 수를 같게
    }

    int prev_pageno = page_sno - group_per_page_cnt;  // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
//		이전 페이지 번호	= 현재 그룹 시작 번호 - 페이지당 보여줄 번호수
//	ex)		46		=	51 - 5
    int next_pageno = page_sno + group_per_page_cnt;    // <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
//		다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
//	ex)		56		=	51 - 5
    if (prev_pageno < 1) {
//		이전 페이지 번호가 1보다 작을 경우
        prev_pageno = 1;
//		이전 페이지를 1로
    }
    if (next_pageno > total_page) {
//		다음 페이지보다 전체페이지 수보가 클경우
        next_pageno = total_page / group_per_page_cnt * group_per_page_cnt + 1;
//		next_pageno=total_page
//		다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1
//	ex)			   = 	76 / 5 * 5 + 1	????????
    }

    // [1][2][3].[10]
    // [11][12]
%>


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            직원정보
            <small>Users paneal</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Users</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">

        <div class="col-xs-12">
            <div class="box-body">
                <div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
                    <div class="row">
                        <div class="col-sm-6"></div>
                        <div class="col-sm-6"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <table class="table table-bordered table-striped dataTable" role="grid"
                                   aria-describedby="example2_info">
                                <colgroup>
                                    <col width="5%"/>
                                    <col width="30%"/>
                                    <col width="20%"/>
                                    <col width="30%"/>
                                    <col width="5%"/>
                                    <col width="5%"/>
                                    <col width="5%"/>
                                </colgroup>
                                <thead>
                                <tr role="row">
                                    <th class="sorting_desc" tabindex="0" aria-controls="example2" rowspan="1"
                                        colspan="1"
                                        aria-label="Rendering engine: activate to sort column ascending"
                                        aria-sort="descending">번호
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="Browser: activate to sort column ascending">아이디
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="Platform(s): activate to sort column ascending">이름
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="Engine version: activate to sort column ascending">휴대폰번호
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="CSS grade: activate to sort column ascending">상태
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="CSS grade: activate to sort column ascending">수정
                                    </th>
                                    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1"
                                        aria-label="CSS grade: activate to sort column ascending">삭제
                                    </th>
                                </tr>
                                </thead>
                                <tbody>

                                <%for (UserVo item : userList) {%>
                                <tr role="row" class="odd">
                                    <td class="sorting_1">1</td>
                                    <td><%=item.getEMAIL()%>
                                    </td>
                                    <td><%=item.getUSERNAME()%>
                                    </td>
                                    <td><%=item.getPHONE()%>
                                    </td>
                                    <td style="text-align: center">
                                        <select class="form-control" onchange="$.success(this)" id="<%=item.getIDX()%>">
                                            <option value="">선택</option>
                                            <option value="0" <%=item.getENABLE().equals("0") ? "selected=\"selected\"" : ""%>>대기</option>
                                            <option value="1" <%=item.getENABLE().equals("1") ? "selected=\"selected\"" : ""%>>승인</option>
                                        </select>
                                    </td>
                                    <td style="text-align: center;color: #00a7d0"><a href="/user/write?idx=<%=item.getIDX()%>"><span class="glyphicon glyphicon-ok-circle"></span></a></td>
                                    <td style="text-align: center;color: red"><span class="glyphicon glyphicon-remove-circle" id="<%=item.getIDX()%>" onclick="$.delete(this)"></span></td>
                                </tr>
                                <%}%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12">
                            <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                <ul class="pagination">
                                    <li class="paginate_button previous <%--disabled--%>" id="example2_previous"><a href="/user/list?pageno=<%=prev_pageno%>"
                                                                                                            aria-controls="example2"
                                                                                                            data-dt-idx="0"
                                                                                                            tabindex="0"
                                                                                                            class="glyphicon glyphicon-chevron-left
"></a>
                                    </li>
                                    <%for(int i =page_sno;i<=page_eno;i++){%>
                                    <li class="paginate_button <%=pageno == i ? "active" : ""%>"><a href="/user/list?pageno=<%=pageno%>" aria-controls="example2"
                                                                          data-dt-idx="<%=i%>"
                                                                          tabindex="0"><%=i%></a></li>
                                    <%}%>

                                    <li class="paginate_button next" id="example2_next"><a href="/user/list?pageno=<%=next_pageno%>"
                                                                                           aria-controls="example2"
                                                                                           data-dt-idx="7"
                                                                                           tabindex="0" class="glyphicon glyphicon-chevron-right
"></a></li>
                                </ul>

                            </div>
                        </div>
                    </div>

                    <div class="row" align="right">
                        <div class="col-sm-12">
                            <button class="btn btn-success" onclick="window.location.href='/user/write'">등록</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>


<script type="text/javascript">

    $.success = function(e){
        var idx = $(e).attr('id');
        var status = $(e).find(':selected').val();
        $.ajax({
            url:'/user/list/status',
            type:'get',
            dataType:'json',
            data:{'idx':idx,'status':status},
            success:function(data){
                console.log()
                if(data.msg == 'success'){
                    alert('정상적으로 수정 되었습니다.');
                }

            },error:function(error){
                alert('timeout');
            }
        })
    }

    $.delete = function(e){
        var idx = $(e).attr('id')

        var result = confirm('해당 데이터를 정말 삭제하시겠습니까?');

        if(result) {
            alert(idx);
        } else {
            //no
        }
    }
</script>