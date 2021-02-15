<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            font-weight: bold;
            color: silver;
        }
        .style3
        {
            font-size: small;
        }
        .style5
        {
            color: #666666;
        }
        .ROW2
        {
            background-image: url( 'Images/bg7.gif' );
            background-position: top;
            background-repeat: repeat-x;
            background-color: White;
            cursor: default;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    Home
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    Welcome
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:Panel ID="Panel1" runat="server" Style="text-align: left">
        <table>
            <tr>
                <td valign="top" style="padding: 10px 0px 30px 10px" colspan="2">
                    <table style="font-weight: bold;" cellpadding="10px">
                        <tr>
                            <td align="center" style="padding:15px" class='<%= ShowIfUser("USER") %>'>
                                <a href="NewTicket.aspx" class="Link" title="Submit New Ticket">
                                    <img src="Images/ticket-add.png" class="imagebutton" /><br />
                                     New Ticket</a>
                            </td>
                            <td align="center" style="padding:15px" class='<%= ShowIfUser("USER") %>'>
                                <a href="Ticket.aspx" class="Link" title="Go to Ticket">
                                    <img src="Images/ticket.png" class="imagebutton" /><br />
                                     Go to Ticket</a>
                            </td>
                            <td align="center" style="padding:15px" class='<%= ShowIfUser("USER") %>'>
                                <a href="Ticket_Inbox.aspx" class="Link" title="Ticket Inbox">
                                    <img src="Images/email_logo.jpg" class="imagebutton" /><br />
                                    Ticket Inbox</a>
                            </td>
                            <td align="center" style="padding:15px" class='<%= ShowIfUser("CALLCENTER") %>'>
                                <a href="Call_New.aspx" class="Link" title="New Call Info">
                                    <div class="imagebutton fa fa-phone  fa-5x" ></div><br />
                                    New Call Log</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="bottom">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">you logged in as</h3>
                        </div>
                        <div class="box-body">
                            <table>
                                <tr>
                                    <td>
                                        <b><span class="style3"><span class="style5">Branch:<br />
                                        </span>
                                            <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceBranch"
                                                BackColor="Yellow" Font-Bold="true" ForeColor="Navy" DataTextField="BranchName"
                                                CssClass="form-control"
                                                DataValueField="BranchID" Enabled="False" OnDataBound="cboBranch_DataBound">
                                                <asp:ListItem Value="0">All Branch</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where BranchID = @BranchID">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </span></b>
                                    </td>
                                    <td>
                                        <b><span class="style3"><span class="style5">Department:<br />
                                        </span>
                                            <asp:DropDownList ID="cboDept" runat="server" DataSourceID="SqlDataSourceDepartment"
                                                BackColor="Yellow" Font-Bold="true" ForeColor="Navy" DataTextField="Department"
                                                CssClass="form-control"
                                                DataValueField="DeptID" Enabled="False" OnDataBound="cboDept_DataBound">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                                SelectCommand="SELECT [DeptID], [Department] FROM [viewDept] WHERE DeptID = @DeptID">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="DeptID" SessionField="DEPTID" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </span></b>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
                <td rowspan="2" valign="bottom">
                    <asp:HyperLink runat="server" ID="ApplicationLogoBig" ImageUrl="" CssClass="applogobig" Style="margin: 100px;"></asp:HyperLink>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
