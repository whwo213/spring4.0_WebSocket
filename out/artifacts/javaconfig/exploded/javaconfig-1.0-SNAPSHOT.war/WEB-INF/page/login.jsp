
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
    <h1>Flat Login Form</h1><span>Pen <i class='fa fa-paint-brush'></i> + <i class='fa fa-code'></i> by <a href='http://andytran.me'>Andy Tran</a></span>
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
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="remember-me"> 비밀번호 기억
                </label>
            </div>
        </form>
    </div>
    <div class="form" style="display: none">
        <h2>Create an account</h2>
        <form action="/insert" method="post">
            <input type="text" placeholder="userName" name="userName"/>
            <input type="password" placeholder="Password" name="passowrd"/>
            <input type="email" placeholder="Email Address" name="email"/>
            <input type="tel" placeholder="Phone Number" name="phone"/>
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
</script>