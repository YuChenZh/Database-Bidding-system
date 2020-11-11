<%@ page import="bs.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
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
    String lcond = request.getParameter("lcond");
    String rcond = request.getParameter("rcond");
    DBConnection db = new DBConnection(user, pwd);
    ArrayList<String> col=new ArrayList<>() ;
    ArrayList<String> content=new ArrayList<>();
    ArrayList<String> content2=new ArrayList<>();
    ArrayList<String> bid=db.getColumnsName("BID",db.getConnection());
    ArrayList<String> com=db.getColumnsName("COMMENTS",db.getConnection());
    ArrayList<String> content3=new ArrayList<>();
    db.updateOnUser(db.getConnection());
    if (table.equals("USERS")){
        col=db.getColumnsName("USERS",db.getConnection());
        content=db.viewTableWithCond("USERS",col,"ID", DBConnection.strToStr(rcond),db.getConnection());
        content2=db.viewTableWithCond("BID",bid,"ID",DBConnection.strToStr(rcond),db.getConnection());
        content3=db.viewTableWithCond("COMMENTS",com,"RATEE",DBConnection.strToStr(rcond),db.getConnection());

    }
    if (table.equals("LISTING")){
        col=db.getColumnsName("LISTING",db.getConnection());
        if (lcond.equals("LISTING_ID")){
            content=db.viewTableWithCond("LISTING",col,lcond,DBConnection.strToStr(rcond),db.getConnection());
            content2=db.viewTableWithCond("BID",bid, lcond,DBConnection.strToStr(rcond),db.getConnection());
        }
        if (lcond.equals("PNAME")){
            String query="SELECT * FROM LISTING WHERE LISTING_ID IN (SELECT LISTING_ID FROM PRODUCT,CONTAINS WHERE (CONTAINS.PID=PRODUCT.PID AND PNAME='"+rcond+"'))";
            String bq="SELECT * FROM BID WHERE LISTING_ID IN (SELECT LISTING_ID FROM PRODUCT,CONTAINS WHERE (CONTAINS.PID=PRODUCT.PID AND PNAME='"+rcond+"'))";
            content=db.viewTableWithQuery(table,col,query,db.getConnection());
            content2=db.viewTableWithQuery("BID",bid,bq,db.getConnection());
        }
        if (lcond.equals("SELLERID")){
            String query="SELECT * FROM LISTING WHERE LISTING_ID IN ( SELECT LISTING_ID FROM LISTS WHERE ID='"+rcond+"')";
            String bq="SELECT * FROM BID WHERE LISTING_ID IN ( SELECT LISTING_ID FROM LISTS WHERE ID='"+rcond+"')";
            content=db.viewTableWithQuery(table,col,query,db.getConnection());
            content2=db.viewTableWithQuery("BID",bid,bq,db.getConnection());
        }
    }
    int size=col.size();
%>
<div class="container">
    <div class="row">
    <div class="col-md-6 col-md-offset-3">
        <h3><%=table%></h3>
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
        <% if (size==0) out.println("<h1>Nothing</h1>");%>
    </div>
    </div>
    <div class="row">

        <div class="col-md-6 col-md-offset-3">
            <h3>BID</h3>
            <table class="table table-striped">
                <thead>
                <tr>
                    <%
                        for (int i = 0; i < bid.size(); i++) {
                            out.println("<th>" + bid.get(i) + "</th>");
                        }
                    %>
                </tr>
                </thead>
                <tbody>
                <tr>
                        <%
                count=0;
                for (int i=0;i<content2.size();i++){
                    count++;
                    out.println("<td>"+content2.get(i)+"</td>");
                    if (count==bid.size()){
                        out.println("</tr>");
                        count=0;
                        if (i<content2.size()-1)
                            out.println("<tr>");
                    }

                }
            %>
                </tbody>
            </table>
            <% if (size==0) out.println("<h1>Nothing</h1>");%>
        </div>
    </div>
    <% if (table.equals("USERS")) {%>
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h3><%=table.equals("USERS")?"COMMENTS":""%></h3>
            <table class="table table-striped">
                <thead>
                <tr>
                    <%
                        for (int i = 0; i < com.size(); i++) {
                            out.println("<th>" + com.get(i) + "</th>");
                        }
                    %>
                </tr>
                </thead>
                <tbody>
                <tr>
                        <%
                count=0;
                for (int i=0;i<content3.size();i++){
                    count++;
                    out.println("<td>"+content3.get(i)+"</td>");
                    if (count==com.size()){
                        out.println("</tr>");
                        count=0;
                        if (i<content3.size()-1)
                            out.println("<tr>");
                    }

                }
            %>
                </tbody>
            </table>
            <% if (size==0) out.println("<h1>Nothing</h1>");%>
        </div>
    </div>
    <%}%>
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
