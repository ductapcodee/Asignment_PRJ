<%-- 
    Document   : login
    Created on : Oct 22, 2025, 11:43:23 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <form action="login" method="POST">
            Username:<input type="text" name="username" id="txtUsername"/> <br/>
            Password:<input type="password" name="password" id="txtPassword"/><br/>
            <input type="submit" id="btnLogin" value="Login"/>
        </form>
    </body>
</html>
