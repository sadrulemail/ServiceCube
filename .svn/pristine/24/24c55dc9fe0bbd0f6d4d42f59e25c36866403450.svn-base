<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSingle.master" 
    AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login"
    ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphBody" Runat="Server">
    <div class="login-box">
        <div class="login-logo">
            
        </div>
        <div class="login-box-body">
            <p class="login-box-msg">Sign in to start your session</p>
            <div class="form-group has-feedback">
                <asp:TextBox ID="txtEmpID" runat="server" type="password" class="form-control" placeholder="login id"></asp:TextBox>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <asp:TextBox runat="server" ID="txtPassword" type="password" class="form-control" placeholder="password"></asp:TextBox>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox">
                            Remember my password
                        </label>
                    </div>
                </div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-success btn-block btn-flat">Sign In</button>
                </div>
            </div>
            <a href='<%= ConfigurationManager.AppSettings["HOME"] %>/Password.aspx'>I forgot my password</a>
        </div>
        <div class="login-logo">
            <a href='<%= ConfigurationManager.AppSettings["HOME"] %>' title="intraweb Home"><span class="fa fa-home"></span></a>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphFooter" Runat="Server">
    <!-- iCheck -->
    <script src='<%= ConfigurationManager.AppSettings["CDN"] %>/iCheck/icheck.min.js'></script>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });
        });
    </script>
</asp:Content>    
