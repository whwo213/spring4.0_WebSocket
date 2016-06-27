<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.springframework.security.web.authentication.WebAuthenticationDetails" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
    body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #eee;
    }

    .form-403 {
        max-width: 800px;
        padding: 15px;
        margin: 0 auto;
    }
    .form-403 .form-403-heading,
    .form-403 .checkbox {
        margin-bottom: 10px;
    }
    .form-403 .checkbox {
        font-weight: normal;
    }
    .form-403 .form-control {
        position: relative;
        height: auto;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        padding: 10px;
        font-size: 16px;
    }
    .form-403 .form-control:focus {
        z-index: 2;
    }
    .form-403 input[type="email"] {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
    }
    .form-403 input[type="password"] {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
    }
</style>


<div class="container form-403" style="margin-top: 5%">
<h1>HTTP Status 403 - Access is denied</h1>
    <c:choose>
    <c:when test="${empty username}">
        <h2>You do not have permission to access this page!</h2>
    </c:when>
    <c:otherwise>
        <h2>Username : ${username} <br/>
            You do not have permission to access this page!</h2>
    </c:otherwise>
</c:choose>

</div>