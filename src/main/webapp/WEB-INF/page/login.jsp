
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html >
<head>
    <meta charset="UTF-8">
    <title>Flat Login Form 3.0</title>


    <link rel="stylesheet" href="/resources/login/css/reset.css">

    <link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

    <link rel="stylesheet" href="/resources/login/css/style.css">




</head>

<body>


<!-- Form Mixin-->
<!-- Input Mixin-->
<!-- Button Mixin-->
<!-- Pen Title-->
<div class="pen-title">
    <h1>BananaBlue</h1><span>Desain <i class='fa fa-paint-brush'></i> + <i class='fa fa-code'></i> by <a href='http://andytran.me'>junga</a></span>
</div>
<!-- Form Module-->
<div class="module form-module">
    <div class="toggle"><i class="fa fa-times fa-pencil" style="margin-top: 10px"></i></div>
    <div class="form" >
        <h2>Login to your account</h2>
        <form action="<c:url value='/j_spring_security_check' />" method="post">
            <input type="text" placeholder="Username" name="username"/>
            <input type="password" placeholder="password" name="password"/>
            <button>Login</button>
            <div style="margin-top: 10px">
                    <input type="checkbox" value="remember-me" style="display: table-row-group; width: inherit"> 비밀번호 기억
            </div>
            ${msg}
            ${error}
        </form>
    </div>
    <div class="form" style="display: none">
        <h2>Create an account</h2>
        <form action="/insert" method="post" onsubmit="return $.formInsert(this);">
            <input type="text" placeholder="회원 이름" name="username"/>
            <input type="password" placeholder="비밀번호" name="password"/>
            <input type="email" placeholder="이메일 주소" name="email"/>
            <input type="tel" placeholder="휴대폰 번호" name="phone"/>
            <button>Register</button>
        </form>
    </div>
    <div class="cta"><a href="http://andytran.me">Forgot your password?</a></div>
</div>

<script src='/resources/jquery/jquery-1.12.2.min.js'></script>

</body>
</html>


<script type="text/javascript">
    jQuery(function(){
        $(document).on('click','.toggle',function(){

            $('.form').slideToggle( "slow" );
        })
    })

    $.formInsert = function(e){
        var username = $(e).find('input[name=username]')
        var password = $(e).find('input[name=password]')
        var email = $(e).find('input[name=email]')
        var phone = $(e).find('input[name=phone]')
        if(username.val() == ''){
            alert('회원이름을 입력해주세요.');
            username.focus();
            return false;
        }
        if(password.val() == ''){
            alert('패스워드를 입력해주세요.');
            password.focus();
            return false;
        }
        if(email.val() == ''){
            alert('이메일을 입력해주세요.');
            email.focus();
            return false;
        }
        if(phone.val() == ''){
            alert('휴대전화번호을 입력해주세요.');
            phone.focus();
            return false;
        }

        return true;
    }
</script>