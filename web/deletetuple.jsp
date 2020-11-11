<%@ page import="bs.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
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
    DBConnection db = new DBConnection(user, pwd);
    table = table.toUpperCase();
    boolean executed = false;
    if (request.getParameter("pk") != null) {
        try {
            db.delete(request.getParameter("pk"), request.getParameter("spk")==null?"":request.getParameter("spk"), table, db.getConnection());

        } catch (SQLException e) {
            e.printStackTrace();
        }
        executed = true;
    }
%>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <%=executed?"<a class=\"alert-success\"><h3>Deleted</h3></a>":""%>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h3><%=table%>
            </h3>
            <form action="deletetuple.jsp" class="form-group" method="get">
                <input type="hidden" name="table" value="<%=table%>">
                <div class="form-group">
                    <label for="pk">First Primary Key (For USERS, it's ID;For LISTING, it's listing_id; For BID, it's
                        listing_id)</label>
                    <input type="text" name="pk" id="pk">
                </div>
                <div class="form-group">
                    <label for="spk">Second Primary Key (Only for BID, here to input amount)</label>
                    <input type="number" step="any" name="spk" id="spk" min="0">
                </div>
                <button type="submit" class="btn btn-primary">Delete</button>
            </form>
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