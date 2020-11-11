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
    String result = "";
    String state = "";
    DBConnection db = new DBConnection(user, pwd);
    ArrayList<String> values = new ArrayList<>();
    if (table.toUpperCase().equals("USERS")) {
        String id = request.getParameter("id");
        id = id.length() > 10 ? id.substring(0, 9) : id;
        values.add(DBConnection.strToStr(id));
        String name = request.getParameter("name");
        name = name.length() > 20 ? name.substring(0, 19) : name;
        values.add(DBConnection.strToStr(name));
        values.add(request.getParameter("age"));
        values.add(DBConnection.strToStr(request.getParameter("gender").toUpperCase()));
        values.add(DBConnection.strToDate(request.getParameter("join_date").toUpperCase()));
        String rating = request.getParameter("avg_rating");
        values.add(DBConnection.doubleToStr(rating));
    }
    if (table.toUpperCase().equals("LISTING")) {
        String id = request.getParameter("listing_id");
        id = id.length() > 10 ? id.substring(0, 9) : id;
        values.add(DBConnection.strToStr(id));
        String condition = request.getParameter("condition");
        condition = condition.length() > 20 ? condition.substring(0, 19) : condition;
        values.add(DBConnection.strToStr(condition));
        String status = request.getParameter("status");
        status = status.length() > 10 ? status.substring(0, 9) : status;
        values.add(DBConnection.strToStr(status));
        values.add(DBConnection.doubleToStr(request.getParameter("start_bid")));
        values.add(DBConnection.strToDate(request.getParameter("start_date").toUpperCase()));
        values.add(DBConnection.strToDate(request.getParameter("end_date").toUpperCase()));
    }
    if (table.toUpperCase().equals("BID")) {
        String amount = DBConnection.doubleToStr(request.getParameter("amount"));
        String listing_id = request.getParameter("listing_id");
        values.add(DBConnection.strToStr(listing_id));
        values.add(DBConnection.doubleToStr(amount));
        values.add(DBConnection.strToStr(request.getParameter("id")));
    }
    state = db.insertStatementBuilder(table.toUpperCase(), values);
    if (db.exec(state, db.getConnection()) != null) {
        result = "Success";
    } else {
        result = "Failed";

    }


%>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-2">
            <a>Statement:<br><code><%=state%>
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
</body>
</html>
