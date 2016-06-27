<%@ page import="java.util.Calendar" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.User" %>
<%@ page import="com.spring.mvc.vacation.vo.VacationVo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.*" %>

<%--
  Created by IntelliJ IDEA.
  User: young
  Date: 2016-06-21
  Time: 오후 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object obj = auth.getPrincipal();
    User user = (User) obj;


%>
<c:set value="${vacationList}" var="vacationList"/>
<%
    List<VacationVo> vacationList = (List<VacationVo>) pageContext.getAttribute("vacationList");
%>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Calendar
            <small>Control panel</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Calendar</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-3">
                <!-- /. box -->
                <div class="box box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Create Event</h3>
                    </div>
                    <div class="box-body">
                        <%--<div class="btn-group" style="width: 100%; margin-bottom: 10px;">
                            <!--<button type="button" id="color-chooser-btn" class="btn btn-info btn-block dropdown-toggle" data-toggle="dropdown">Color <span class="caret"></span></button>-->
                            <ul class="fc-color-picker" id="color-chooser">
                                <li><a class="text-aqua" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-blue" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-light-blue" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-teal" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-yellow" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-orange" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-green" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-lime" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-red" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-purple" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-fuchsia" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-muted" href="#"><i class="fa fa-square"></i></a></li>
                                <li><a class="text-navy" href="#"><i class="fa fa-square"></i></a></li>
                            </ul>
                        </div>--%>
                        <!-- /btn-group -->
                        <label>일자선택</label>
                        <input id="datepicker" name="date" type="text" class="form-control" placeholder="날짜선택">
                        <label>사유</label>
                        <input id="memo" name="memo" type="text" class="form-control" placeholder="휴가에 대한 사유 입력">
                        <input type="hidden" name="userName" value="<%=getUserName(user.getUsername())%>" />
                        <input type="hidden" name="email" value="<%=user.getUsername()%>" />
                        <button id="add-new-event" type="button" class="form-control btn btn-primary btn-flat"
                                style="margin-top: 10px" onclick="$.sendTo(this)">Add
                        </button>
                        <!-- /btn-group -->
                        <!-- /input-group -->
                    </div>
                </div>
            </div>
            <!-- /.col -->
            <div class="col-md-9">
                <div class="box box-primary">
                    <div class="box-body no-padding">
                        <div class="box-body">
                            <!-- THE CALENDAR -->
                            <%
                                String y = request.getParameter("year");
                                String m = request.getParameter("month");

                                //현재 컴퓨터 시스템의 날짜 구하기
                                Calendar cal = Calendar.getInstance();
                                int year = cal.get(Calendar.YEAR);
                                int month = cal.get(Calendar.MONTH) + 1; //클라이언트에서 넘겨준 값이 없을때 표시하는 값

                                if (y != null)
                                    year = Integer.parseInt(y);
                                if (m != null)
                                    month = Integer.parseInt(m);

                                cal.set(year, month - 1, 1);
                                year = cal.get(Calendar.YEAR);
                                month = cal.get(Calendar.MONTH) + 1;

                                // 1일은 무슨 요일?
                                int w = cal.get(Calendar.DAY_OF_WEEK);

                                // 달의 마지막 날짜는?
                                int endDays = cal.getActualMaximum(Calendar.DATE);


                                SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyy-MM-dd");
                                Date date1 = null;
                                Date date2 = null;


                            %>

                            <div align="center" style="font-size: 30px">
                                <a href="/vacation/list?year=<%=year%>&month=<%=month-1%>">◀</a>
                                <%=year%>년 <%=month%>월
                                <a href="/vacation/list?year=<%=year%>&month=<%=month+1%>">▶</a>
                            </div>
                            <table class="table cals" width="100%" cellpadding="0" cellspacing="1" bgcolor="#cccccc">
                                <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup>
                                <tr height="25" bgcolor="#3c8dbc">
                                    <td width="30" align="center" style="color: white">일</td>
                                    <td width="30" align="center" style="color: white">월</td>
                                    <td width="30" align="center" style="color: white">화</td>
                                    <td width="30" align="center" style="color: white">수</td>
                                    <td width="30" align="center" style="color: white">목</td>
                                    <td width="30" align="center" style="color: white">금</td>
                                    <td width="30" align="center" style="color: white">토</td>
                                </tr>
                                <%--<%=vacationList%>--%>
                                <%
                                    int line = 0;
                                    //앞의 공백처리
                                    out.print("<tr bgcolor='#ffffff' height='25'>");
                                    for (int i = 1; i < w; i++) {
                                        out.print("<td> </td>");
                                        line += 1;
                                    }

                                    //1~마지막날까지 출력하기
                                    String fc;
                                    for (int i = 1; i <= endDays; i++) {
                                        fc = line == 0 ? "red" : (line == 6 ? "blue" : "black");%>
                                <td style="color:<%=fc%>; height: 100px;text-align: center;"
                                <%
                                    String month_s = month < 10 ? "0"+month : ""+month;
                                    String day_s = i < 10 ? "0"+i : ""+i;
                                %>
                                        id="<%=year%>-<%=month_s%>-<%=day_s%>"
                                >
                                    <span style="float: left;"><%=i%></span><br />
                                    <%


                                        for(VacationVo item : vacationList){
                                            date1 = simpleDateFormat.parse(item.getVACATION_DATE());
                                            date2 = simpleDateFormat.parse(year+"-"+month_s+"-"+day_s);
                                            String status = item.getTMP1().equals("N") ? "대기" : "승인";
                                            String color = item.getTMP1().equals("N") ? "style=\"color: red\"" : "style=\"color: green\"";
                                            if(date2.compareTo(date1) == 0){
                                                out.println("<p>"+item.getVACATION_USER_NAME()+"[<span "+color+">"+status+"</spsn>]</p>");
                                            }

                                        }
                                    %>
                                </td>
                                <%
                                        line += 1;
                                        if (line == 7 && i != endDays) {
                                            out.print("</tr><tr height='25' bgcolor='#ffffff'>");
                                            line = 0;
                                        }
                                    }

                                    //뒷부분 공백 처리
                                    while (line > 0 && line < 7) {
                                        out.print("<td> </td>");
                                        line++;
                                    }
                                    out.print("</tr>");
                                %>
                            </table>
                        </div>
                    </div>

                </div>
                <!-- /. box -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->



    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->



<script type="text/javascript" src="/resources/socket/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="/resources/socket/stomp.js"></script>
<script type="text/javascript">


    $(document).ready(function() {

        $('#datepicker').datepicker({
            autoclose:true,
        })

        var messageList = $("#messages");

        var getMessageString = function(data) {
//            var date = new Date(message.date);
            $('.cals tbody tr:not(:eq(0)) td').each(function(index){
                if(data.date == $(this).attr('id')){
                    $(this).append('<p>'+data.userName+' [<span style="color: red">대기</span>]</p>')
                }
            })
        };

        var socket = new SockJS('/send');
        var stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
            // subscribe to the /topic/entries endpoint which feeds newly added messages
            stompClient.subscribe('/topic/entries', function(data) {
                // when a message is received add it to the end of the list
                var body = data.body;
                var message = JSON.parse(body);
//                messageList.append(getMessageString(message));
                getMessageString(message)
            });
        });

/*        $("#send").on("click", function() {
            // send the message

            stompClient.send("/app/send", {}, JSON.stringify({'message':$("#message").val()}));
            $("#message").val("");
        });*/

        $.sendTo = function(e){
            var date = $(e).parent().find('input[name=date]').val();
            var memo = $(e).parent().find('input[name=memo]').val();
            var userName = $(e).parent().find('input[name=userName]').val();
            var email = $(e).parent().find('input[name=email]').val();
            stompClient.send("/app/send", {}, JSON.stringify({'date':date,'memo':memo,'userName':userName,'email':email}));
        }

    });

</script>


<%!

    public String getUserName(String email) throws ClassNotFoundException {

        DataSource ds = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuffer query = new StringBuffer();

        String url = "jdbc:oracle:thin:@//bananablue.iptime.org:1521/orcl";        // 사용하려는 데이터베이스명을 포함한 URL 기술
        String id = "c##apple6268";                                                    // 사용자 계정
        String pw = "rave6268";                                                // 사용자 계정의 패스워드

        Class.forName("oracle.jdbc.driver.OracleDriver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.

        String msg = "";
        try{
            conn= DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
            query.append(" SELECT * FROM USERS WHERE EMAIL = ? ");
            pstmt = conn.prepareStatement(query.toString());
            pstmt.setString(1,email);
            rs = pstmt.executeQuery();
            while (rs.next()){
                msg = rs.getString("USERNAME");
            }


        }catch (Exception e){
            msg = e.toString();
        }finally {
            if(conn != null){try{conn.close();}catch (SQLException sql){msg = sql.toString();}}
            if(pstmt != null){try{pstmt.close();}catch (SQLException sql){msg = sql.toString();}}
            if(rs != null){try{rs.close();}catch (SQLException sql){msg = sql.toString();}}
        }
        return msg;
    }


%>