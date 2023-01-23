<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FitnessPulse_Web.Register" %>

<!DOCTYPE html>

<!--
 // WEBSITE: https://themefisher.com
 // TWITTER: https://twitter.com/themefisher
 // FACEBOOK: https://www.facebook.com/themefisher
 // GITHUB: https://github.com/themefisher/
-->

<html lang="en">
<head>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <title>FitnessPulse - Sign in</title>

        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css?family=Karla:400,700|Roboto" rel="stylesheet">
        <link href="template/plugins/material/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="template/plugins/simplebar/simplebar.css" rel="stylesheet" />

        <!-- PLUGINS CSS STYLE -->
        <link href="template/plugins/nprogress/nprogress.css" rel="stylesheet" />

        <!-- MONO CSS -->
        <link id="main-css-href" rel="stylesheet" href="template/css/style.css" />


        <!-- FAVICON -->
        <link href="template/images/favicon.png" rel="shortcut icon" />

        <!--
          HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries
        -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script src="template/plugins/nprogress/nprogress.js"></script>
    </head>

</head>
<body class="bg-light-gray" id="body">
    <div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh">
        <div class="d-flex flex-column justify-content-between">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-xl-5 col-md-10 ">
                    <div class="card card-default mb-0">
                        <div class="card-header pb-0">
                            <div class="app-brand w-100 d-flex justify-content-center border-bottom-0">
                                <a class="w-auto pl-0">
                                    <img src="template/images/logo.png" alt="Mono">
                                    <span class="brand-name text-dark">FitnessPulse</span>
                                </a>
                            </div>
                        </div>
                        <div class="card-body px-5 pb-5 pt-0">
                            <h4 class="text-dark text-center mb-5">Sign Up</h4>
                            <form runat="server">
                                <div class="row">

                                    <div class="row">
                                        <div class="form-group col-md-6 mb-4">
                                            <input type="text" class="form-control input-lg" id="Fname" runat="server" aria-describedby="nameHelp" placeholder="First Name">
                                        </div>

                                        <div class="form-group col-md-6 mb-4">
                                            <input type="text" class="form-control input-lg" id="Lname" runat="server" aria-describedby="nameHelp" placeholder="Last Name">
                                        </div>
                                    </div>

                                    <div class ="row">
                                        <div class="form-group col-md-8">
                                            <input type="email" class="form-control input-lg" id="email" runat="server" aria-describedby="emailHelp" placeholder="Email">
                                        </div>

                                        <div class="form_group col-md-4">  
                                            <asp:DropDownList ID="gender" runat="server" class="form-control" >  
                                            <asp:ListItem >Gender</asp:ListItem>  
                                            <asp:ListItem>Male</asp:ListItem>  
                                            <asp:ListItem>Female</asp:ListItem>  
                                            <asp:ListItem>Others</asp:ListItem>  
                                        </asp:DropDownList>  
                                        </div>  
                                    </div>

                                    
                                    <div class="form-group col-md-12">
                                        <input type="text" class="form-control input-lg" id="cnic" runat="server" aria-describedby="nameHelp" placeholder="CNIC">
                                    </div>

                                    <div class = "row">
                                        <div class="form-group col-md-6 ">
                                            <input type="password" class="form-control input-lg" id="password" runat="server" placeholder="Password">
                                        </div>
                                        <div class="form-group col-md-6 ">
                                            <input type="password" class="form-control input-lg" id="cpassword" runat="server" placeholder="Confirm Password">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="d-flex justify-content-between mb-3">

                                            <div class="custom-control custom-checkbox mr-3 mb-3">
                                                <input type="checkbox" class="custom-control-input" runat="server" id="customCheck2">
                                                <label class="custom-control-label" for="customCheck2">I agree to the terms and conditions.</label>
                                            </div>

                                        </div>

                                        <asp:Button runat="server" ID="btnRegst" Text="Register Account" CssClass="btn btn-primary btn-pill mb-4" 
                                    onClick="register"/>
                                        
                                <label class="text-danger" runat="server" id = "caution"></label>
                                        <p>
                                            Are you an admin?
                                            <a class="text-blue" href="Login.aspx">Sign in</a>
                                        </p>
                                    </div>
                                </div>
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
