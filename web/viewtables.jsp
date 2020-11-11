<%@ page import="bs.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Tables</title>
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
<%
    String user = (String) session.getAttribute("username");
    String pwd = (String) session.getAttribute("password");
    String table = (String) request.getParameter("table");
    DBConnection db = new DBConnection(user, pwd);
    ArrayList<String> col = db.getColumnsName(table.toUpperCase(), db.getConnection());
    ArrayList<String> content = db.viewTable(table.toUpperCase(), col, db.getConnection());
    int size = col.size();

%>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <table class="table table-striped">
                <thead>
                <tr>
                    <%
                        for (int i = 0; i < size; i++) {
                            out.println("<th>" + col.get(i) + "</th>");
                        }
                    %>
                </tr>
                </thead>
                <tbody>
                <tr>
                        <%
                int count=0;
                for (int i=0;i<content.size();i++){
                    count++;
                    out.println("<td>"+content.get(i)+"</td>");
                    if (count==size){
                        out.println("</tr>");
                        count=0;
                        if (i<content.size()-1)
                            out.println("<tr>");
                    }

                }
            %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <br>
            <br>
            <a href="main.jsp" class="btn btn-default btn-sm btn-success" role="button">Back to home page</a>
        </div>
    </div>
</div>

<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
