<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ServiceCube.Home" %>

<%@ Register Src="UserControl.ascx" TagName="UserControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CpTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpBody" runat="server">
    <uc1:UserControl ID="UserControl1" runat="server" />
    <div class="row">
        <div class="col-sm-3">
            <img src="images/service-cube.png" class="img-responsive center-block" />
        </div>
        <div class="col-sm-9">
            <p>Welcome to <%= ConfigurationManager.AppSettings["AppName"] %>. This System will allow you to submit your queries and issues to the Trust Bank Helpdesk to ensure quick resolution.</p>
            <p class="bold"><%= ConfigurationManager.AppSettings["AppName"] %> will help you to-</p>
            <ul>
                <li>Track your issues and solutions under the “Submitted     Issues” Tab.</li>
                <li>Receive status and alerts to your inbox directly.</li>
                <li>Use Frequently Asked Questions (FAQ’s Tab) to solve common issues. (on development)</li>
                <li>To receive the latest Updates and News from the <%= ConfigurationManager.AppSettings["AppName"] %> Team.</li>
            </ul>
            <p>Please ensure you rate our service through the Star Rating system that will be sent in your mailbox on resolution of your query and issue. This will help us in improving our service.</p>
            <p>Thank you for being with <%= ConfigurationManager.AppSettings["AppName"] %> Team.</p>
        </div>
    </div>
</asp:Content>
