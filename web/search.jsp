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
<div class="container">
    <div class="col-md-4 col-md-offset-4">
        <form action="searchdatabase.jsp">
            <input type="hidden" name="table" value="<%=request.getParameter("type")%>">
            <input type="hidden" name="lcond" value="<%=request.getParameter("lcond")%>">
            <label for="f">Search <%=request.getParameter("name")%> by <%=request.getParameter("by")%></label>
            <input type="text" name="rcond" id="f">
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
