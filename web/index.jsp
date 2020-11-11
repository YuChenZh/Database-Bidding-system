<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bidding System</title>
    <script src="js/bootstrap.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="col-xs-6 col-md-offset-3">
        <br>
        <br>
        <h1> Bidding System</h1>
        <h3> A CS550 project</h3>
        <a>Qide Dong</a><br>
        <a>Yujing Chen</a>
        <br>
        <br>
        <br>
        <form action="login.jsp" method="post" class="form-horizontal">
            <div class="form-group">
                <label for="dbusername" class="col-md-2 control-label">Username</label>
                <div class="col-md-10">
                    <input type="text" name="dbusername" id="dbusername">
                </div>
            </div>
            <br/>
            <div class="form-group">
                <label for="dbpwd" class="col-md-2 control-label">Password</label>
                <div class="col-md-10">
                    <input type="text" name="dbpwd" id="dbpwd">
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <button type="submit" class="btn btn-default btn-primary">Login</button>
                </div>
            </div>

        </form>
    </div>

</div>
</body>
</html>