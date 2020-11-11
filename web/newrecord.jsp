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
    int size = col.size();
%>
<% if (table.equals("USERS")) {%>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-2">
            <form action="insertaction.jsp" class="form-inline" method="post">
                <input type="hidden" name="table" value="USERS">
                <div class="form-group">
                    <label for="id">ID</label>
                    <input type="text" class="form-control" id="id" placeholder="10 digits" name="id">
                </div>
                <br>
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" placeholder="Less than 20 chars" name="name">
                </div>
                <br>
                <div class="form-group">
                    <label for="age">Age</label>
                    <input type="number" class="form-control" id="age" min="1" max="150" placeholder="<150" name="age">
                </div>
                <br>
                <div class="form-group">
                    <label>Gender</label><br>
                    <input type="radio" class="form-control" name="gender" value="F"> Female<br>
                    <input type="radio" class="form-control" name="gender" value="M"> Male<br>
                </div>
                <br>
                <div class="form-group">
                    <label for="joindate">Join Date</label>
                    <input type="date" class="form-control" id="joindate" name="join_date">
                </div>
                <br>
                <div class="form-group">
                    <label for="avg_rating">Average Rating</label>
                    <input type="number" step="any" class="form-control" id="avg_rating" placeholder="eg. 3.02, 4.32"
                           min="0" max="5" name="avg_rating">
                </div>
                <br>
                <button type="submit" class="btn btn-primary">Insert</button>
            </form>
        </div>
    </div>
</div>
<% } %>

<% if (table.equals("LISTING")) {
%>

<div class="container">
    <div class="col-md-6 col-md-offset-4">
        <form action="insertaction.jsp" class="form-inline" method="post">
            <input type="hidden" name="table" value="LISTING">
            <div class="form-group">
                <label for="lid">Listing ID</label>
                <input type="text" class="form-control" id="lid" placeholder="10 digits" name="listing_id">
            </div>
            <br>
            <div class="form-group">
                <label for="cond">Condition</label>
                <input type="text" class="form-control" id="cond" placeholder="< 20 chars" name="condition">
            </div>
            <br>
            <div class="form-group">
                <label for="status">Status</label>
                <input type="text" class="form-control" id="status" placeholder="< 20 chars" name="status">
            </div>
            <br>
            <div class="form-group">
                <label for="sb">Start bid</label>
                <input type="number" step="any" class="form-control" id="sb" min="0" name="start_bid">
            </div>
            <br>
            <div class="form-group">
                <label for="st">Start Time</label>
                <input type="date" class="form-control" id="st" name="start_date">
            </div>
            <br>
            <div class="form-group">
                <label for="et">End Time</label>
                <input type="date" class="form-control" id="et" name="end_date">
            </div>
            <br>
            <button type="submit" class="btn btn-primary">Insert</button>
        </form>
            <%}%>


            <% if (table.equals("BID")) {%>
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-2">
                    <form action="insertaction.jsp" class="form-inline" method="post">
                        <input type="hidden" name="table" value="BID">
                        <div class="form-group">
                            <label for="liid">Listing ID</label>
                            <input type="text" class="form-control" id="liid" placeholder="10 digits" name="listing_id">
                        </div>
                        <br>
                        <div class="form-group">
                            <label for="am">Amount</label>
                            <input type="number" step="any" class="form-control" id="am" min="1" name="amount">
                        </div>
                        <br>
                        <div class="form-group">
                            <label for="bi">Buyer ID</label>
                            <input type="text" class="form-control" id="bi" placeholder="10 digits" name="id">
                        </div>
                        <br>
                        <button type="submit" class="btn btn-primary">Insert</button>
                    </form>
                </div>
            </div>
        </div>
            <% } %>


        <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/bootstrap.js"></script>
</body>
</html>
