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
    <nav class="navbar navbar-inverse">
        <div class="container">
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="main.jsp">Home</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">View Tables<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <%
                                DBConnection db=new DBConnection("","");
                                ArrayList<String> names=db.getTableNames();
                                for (int i=0;i<names.size();i++){
                                    StringBuffer sb=new StringBuffer();
                                    sb.append("<li><a href=\"viewtables.jsp?table=");
                                    sb.append(names.get(i));
                                    sb.append("\">");
                                    sb.append(names.get(i));
                                    sb.append("</a></li>");
                                    out.println(sb.toString());
                                }
                            %>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">New Record<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="newrecord.jsp?table=USERS">Users</a>
                            </li>
                            <li>
                                <a href="newrecord.jsp?table=BID">Bid</a>
                            </li>
                            <li>
                                <a href="newrecord.jsp?table=LISTING">Listing</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">Edit Record<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="editrecord.jsp?table=USERS">Users</a>
                            </li>
                            <li>
                                <a href="editrecord.jsp?table=BID">Bid</a>
                            </li>
                            <li>
                                <a href="editrecord.jsp?table=LISTING">Listing</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">Delete Record<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="deletetuple.jsp?table=USERS">Users</a>
                            </li>
                            <li>
                                <a href="deletetuple.jsp?table=BID">Bid</a>
                            </li>
                            <li>
                                <a href="deletetuple.jsp?table=LISTING">Listing</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">Search<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="search.jsp?type=USERS&lcond=ID&name=Customer&by=ID">Customer</a>
                            </li>
                            <li>
                                <a href="search.jsp?type=LISTING&lcond=LISTING_ID&name=Listing&by=listing_id">Listing - by ID</a>
                            </li>
                            <li>
                                <a href="search.jsp?type=LISTING&lcond=PNAME&name=Listing&by=name">Listing - by name</a>
                            </li>
                            <li>
                                <a href="search.jsp?type=LISTING&lcond=SELLERID&name=Listing&by=SellerID">Listing - by Seller</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
</div>

<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>