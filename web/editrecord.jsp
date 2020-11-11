<%@ page import="bs.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
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
    DBConnection db = new DBConnection(user, pwd);
    ArrayList<String> col = db.getColumnsName(table.toUpperCase(), db.getConnection());
    String primaryKey;

    int size = col.size();
%>
<div class="container">
    <h1> Please input SQL-friendly values</h1>
    <div class="col-md-4 col-md-offset-2">

        <a>e.g. 't000000001', 3.2, TO_DATE( '10-OCT-2016', 'DD-MON-YYYY' )</a>
        <br>
        <br>
        <form action="updateaction.jsp" class="form-group" method="post">
            <input type="hidden" name="table" value="<%=table%>">
            <div class="form-group">
                <label> Attribute</label>
                <select name="attr" id="attr">
                    <%
                        for (int i = 0; i < size; i++) {
                            out.print("<option value=\"");
                            out.print(col.get(i));
                            out.print("\">");
                            out.print(col.get(i));
                            out.println("</option>");
                        }
                    %>
                </select>
            </div>
            <br>

            <div class="form-group">
                <label for="content">Value</label>
                <input type="text" class="form-control" id="content" name="value">
            </div>
            <br>
            <div class="form-group">
                <label>Left Condition</label>
                <select name="lcond" >
                    <%
                        for (int i = 0; i < size; i++) {
                            out.print("<option value=\"");
                            out.print(col.get(i));
                            out.print("\">");
                            out.print(col.get(i));
                            out.println("</option>");
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="rcontent">Right Condition</label>
                <input type="text" class="form-control" id="rcontent" name="rcond">
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>

    </div>
</div>

<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
