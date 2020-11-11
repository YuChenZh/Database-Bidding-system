<%@ page import="bs.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bidding System</title>
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
<%
    String user = (String) session.getAttribute("username");
    String pwd = (String) session.getAttribute("password");
    String table = (String) request.getParameter("table");
    table = table.toUpperCase();
    String result;
    DBConnection db = new DBConnection(user, pwd);
    ArrayList<String> col = db.getColumnsName(table.toUpperCase(), db.getConnection());
    int size = col.size();
    String s=DBConnection.updateStatementBuilder(table,request.getParameter("attr"),request.getParameter("value"),request.getParameter("lcond"),request.getParameter("rcond"));
    Statement st=db.getConnection().createStatement();
    ResultSet rs=st.executeQuery(s);
    if (rs!=null)
        result="Success";
    else result="Failed";
    rs.close();
    st.close();
%>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-2">
            <a>Statement:<br><code><%=s%>
            </code><br>Executed</a><br>
            <h2><%=result%>
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="col-md-4 col-md-offset-2">
                <br>
                <br>
                <a href="main.jsp"
                   class="btn btn-default btn-sm <%=result.equals("Success")?"btn-success":"btn-danger"%>"
                   role="button">Back to home page</a>
            </div>
        </div>
    </div>
</div>
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
