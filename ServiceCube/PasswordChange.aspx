<%@ Page Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" CodeFile="PasswordChange.aspx.cs" Inherits="Default2" Title="Password Change" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    Password Change
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphDescription" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <div align="left" style="padding: 20px">
        <asp:Panel ID="Panel2" runat="server" Visible="true">
         <%--   <div class="box box-tbl">--%>
                <div style="padding: 20px 0 20px 175px;"  id="ErrorDiv" runat="server">
                    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Text="Error Message"></asp:Label>
                </div>
        <%--    </div>--%>
            <div class="form-inline">
                <label style="margin-right:60px;">Current Password</label>

                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txtPassword" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
            </div>
            <div class="form-inline" style="margin-top:10px;">
                <label style="margin-right:80px;">New Password</label>

                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" Width="150px"></asp:TextBox>
                <cc1:PasswordStrength ID="txtNewPassword_PasswordStrength" runat="server"
                    MinimumSymbolCharacters="1" MinimumUpperCaseCharacters="1"
                    PreferredPasswordLength="6" TargetControlID="txtNewPassword"
                    TextCssClass="Panel1" HelpHandlePosition="BelowRight"></cc1:PasswordStrength>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txtNewPassword" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
            </div>
            <div class="form-inline" style="margin-top:10px;">
                <label  style="margin-right:30px;">Re-type New Password</label>

                <asp:TextBox ID="txtRePassword" runat="server" CssClass="form-control" TextMode="Password" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ControlToValidate="txtRePassword" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
            </div>
            <div class="form-inline" style="margin:10px 0 0 174px;">
                <input type="button" value="Cancel" class="form-control" style="width: 80px" onclick="location = 'Default.aspx'" />

                <asp:Button ID="cmdChangePassword" runat="server" CssClass="form-control" OnClick="cmdChangePassword_Click"
                    Text="Change Password" Width="150px" />
            </div>
    </asp:Panel>
        <br />
    <asp:Panel ID="Panel1" runat="server" Visible="False">
        <table style="width: 400px;" class="ui-corner-all Panel1">
            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <b>Password Changed Successfully</b></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="centertext">
                    <asp:Button runat="server" ID="cmdLogingAgain" Style="width: 130px"
                        Text="OK" CausesValidation="false" OnClick="cmdLogingAgain_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
    </div>
</asp:Content>

