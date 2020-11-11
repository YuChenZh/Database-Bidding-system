<%--
  Created by IntelliJ IDEA.
  User: AmemiyaYuko
  Date: 12/4/2016
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bs.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="refresh" content="5;url=main.jsp">
</head>
<body>
<%
    String dbname = new String((request.getParameter("dbusername")).getBytes("ISO-8859-1"), "UTF-8");
    String dbpwd = new String((request.getParameter("dbpwd")).getBytes("ISO-8859-1"), "UTF-8");
    session.setAttribute("username", dbname);
    session.setAttribute("password", dbpwd);
    DBConnection dbConnection = new DBConnection(dbname, dbpwd);
    boolean fail = false;
    dbConnection.updateOnUser(dbConnection.getConnection());
    String message;
    Connection c = dbConnection.getConnection();
    if (c != null) {
        response.setHeader("Refresh", "1;URL=main.jsp");
        message = "Login successfully";
    } else {
        response.setHeader("Refresh", "1;URL=index.jsp");
        message = "Login failed";
    }
    c.close();
%>
<h1><%= message%>
</h1>
</body>
</html>
