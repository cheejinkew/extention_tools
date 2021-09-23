<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>TELEMETRY TOOLS LOGIN </title>


    <!--STYLESHEET-->
    <!--=================================================-->

    <!--Open Sans Font [ OPTIONAL ]-->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>


    <!--Bootstrap Stylesheet [ REQUIRED ]-->
    <link href="css/bootstrap.min.css" rel="stylesheet">


    <!--Nifty Stylesheet [ REQUIRED ]-->
    <link href="css/nifty.min.css?r=<%= DateTime.Now %>" rel="stylesheet">


    <!--Nifty Premium Icon [ DEMONSTRATION ]-->
    <link href="css/demo/nifty-demo-icons.min.css" rel="stylesheet">


    <!--=================================================-->



    <!--Pace - Page Load Progress Par [OPTIONAL]-->
    <link href="plugins/pace/pace.min.css" rel="stylesheet">
    <script src="plugins/pace/pace.min.js"></script>


        
    <!--Demo [ DEMONSTRATION ]-->
    <link href="css/demo/nifty-demo.min.css" rel="stylesheet">

    
    <!--=================================================

    REQUIRED
    You must include this in your project.


    RECOMMENDED
    This category must be included but you may modify which plugins or components which should be included in your project.


    OPTIONAL
    Optional plugins. You may choose whether to include it in your project or not.


    DEMONSTRATION
    This is to be removed, used for demonstration purposes only. This category must not be included in your project.


    SAMPLE
    Some script samples which explain how to initialize plugins or components. This category should not be included in your project.


    Detailed information and more samples can be found in the document.

    =================================================-->
        
</head>

<!--TIPS-->
<!--You may remove all ID or Class names which contain "demo-", they are only used for demonstration. -->

<body>
    <div id="container" class="cls-container" style ="background-image:url(img/save-water.jpg);background-repeat:no-repeat;background-size:auto;">
        
		<!-- BACKGROUND IMAGE -->
		<!--===================================================-->
		<div id="bg-overlay"></div>
		
		
		<!-- LOGIN FORM -->
		<!--===================================================-->
		<div class="cls-content" >
		    <div class="cls-content-sm panel" style="background-color:White;">
		        <div class="panel-body">
		            <div class="mar-ver pad-btm">
		                <h1 class="h3">TELEMETRY TOOLS</h1>
		                <p>Sign In to your account</p>
		            </div>
		            <form action="Dashboard.aspx">
		                <div class="form-group">
                          <input type="text" id="txtUserName" class="form-control" name="name" placeholder="username or email">
		                    
		                </div>
		                <div class="form-group">
		                    <input type="password" id="txtpwd" class="form-control" name="pwd" placeholder="password">
		                </div>
		                <div class="checkbox pad-btm text-left">
		                    <input id="demo-form-checkbox" class="magic-checkbox" type="checkbox">
		                    <label for="demo-form-checkbox">Remember me</label>
		                </div>
                        <input type="button" id="btnLogin" class="btn btn-primary btn-lg btn-block" value="Sign In" /> 
		            </form>
		        </div>
		
		        <div class="pad-all">
		            <a href="pages-password-reminder.html" class="btn-link mar-rgt">Forgot password ?</a> 
		        </div>
		    </div>
		</div>
		<!--===================================================-->
		 
    </div>
    <!--===================================================-->
    <!-- END OF CONTAINER -->


        
    <!--JAVASCRIPT-->
    <!--=================================================-->

    <!--jQuery [ REQUIRED ]-->
    <script src="js/jquery.min.js"></script>


    <!--BootstrapJS [ RECOMMENDED ]-->
    <script src="js/bootstrap.min.js"></script>


    <!--NiftyJS [ RECOMMENDED ]-->
    <script src="js/nifty.min.js"></script>
     
    <!--=================================================-->
    
    <!--Background Image [ DEMONSTRATION ]-->
    <script src="js/demo/bg-images.js"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              $("#txtUserName").val($.cookie('UserName'));
              $("#txtpwd").val($.cookie('Password'));
          });

          $("#btnLogin").click(function () {
              var Username = $("#txtUserName").val();
              var Password = $("#txtpwd").val();

              if (Username.trim() == "" || Password.trim() == "") {
                  alert("Please enter user name and password");
                  return false;
              }
              var _remember = "1";

              $.ajax({
                  type: "POST",
                  url: "login.aspx/CheckLogin",
                  contentType: "application/json; charset=utf-8",
                  data: '{uname: \"' + Username + '\",pwd: \"' + Password + '\"}',
                  dataType: "json",
                  success: function (response) {
                      var jsonObject = (response.d);
                      if (jsonObject == "Y") {
                          window.location.href = "index.aspx";
                      }
                      else {
                          alert("Either user name or password In-correct");
                      }
                  }
              });


          });
    </script>
</body>
</html>


