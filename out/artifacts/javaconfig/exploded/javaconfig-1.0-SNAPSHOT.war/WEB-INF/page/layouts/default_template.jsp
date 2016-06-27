<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.web.authentication.WebAuthenticationDetails" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="org.springframework.security.core.userdetails.User" %><%--
  Created by IntelliJ IDEA.
  User: apple6268
  Date: 16. 3. 22
  Time: 오후 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>

<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();



    Object ojb = auth.getPrincipal();




%>
<head>

    <tiles:insertAttribute name="header" />
</head>
<body>
<div class="container">
    <tiles:insertAttribute name="body" />


</div><!--/.container-->
<tiles:insertAttribute name="footer" />
</body>
</html>
