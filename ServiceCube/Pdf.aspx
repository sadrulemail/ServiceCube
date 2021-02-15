<%@ Page Language="C#" AutoEventWireup="true" Inherits="PdfViewer" ValidateRequest="false"
    EnableSessionState="False" CodeFile="Pdf.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="jquery/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Pdf.css" rel="stylesheet" type="text/css" />
    <script src="script/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="script/TrustPdf.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            background: #EEEEEE;
        }
        
        .PdfBorderStyle
        {
            border-color: #CCCCCC;
            border-style: solid;
        }
        
        a
        {
            text-decoration: none;
        }
    </style>
    <title></title>
</head>
<body style="font-family: Arial; font-size: small">
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="TrustScriptManager" runat="server" 
            CompositeScript-ScriptMode="Release" AsyncPostBackTimeout="360000">
        </asp:ScriptManager>
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <asp:HiddenField ID="hidTotalPage" runat="server" />
                <asp:HiddenField ID="hidCurrentPage" runat="server" />
                <asp:Panel ID="Panel1" runat="server" Height="100%" ScrollBars="Vertical" CssClass="LeftPanel"
                    HorizontalAlign="Center" Width="180px">
                    <div style="height: 10px">
                    </div>
                </asp:Panel>
                <asp:AlwaysVisibleControlExtender ID="Panel1_AlwaysVisibleControlExtender" runat="server"
                    Enabled="True" TargetControlID="Panel1" VerticalOffset="0">
                </asp:AlwaysVisibleControlExtender>
                <div style="padding-left: 210px">
                    <table>
                        <tr>
                            <td align="left">
                                <table>
                                    <tr>
                                       <%-- <td width="230px">
                                            <asp:TextBox ID="ZoomFactor" runat="server" AutoPostBack="True" OnTextChanged="ZoomFactor_TextChanged"
                                                Style="height: 22px" Visible="true" Width="60px">100</asp:TextBox>
                                            <asp:SliderExtender ID="SliderExtender1" runat="server" Enabled="True" Length="200"
                                                Maximum="200" Minimum="50" Steps="10" TargetControlID="ZoomFactor" />
                                        </td>--%>
                                        <td width="100px">
                                            <asp:LinkButton ID="Previous1" runat="server" CausesValidation="False" CssClass="button1"
                                                OnClick="Previous1_Click" ToolTip="Previous Page"><img src="Images/Previous.gif" width="32" height="32" border="0" /></asp:LinkButton>
                                            <asp:LinkButton ID="Next1" runat="server" CausesValidation="False" CssClass="button1"
                                                OnClick="Next1_Click" ToolTip="Next Page"><img src="Images/Next.gif" width="32" height="32" border="0" /></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPageXofY" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td style="padding-left: 40px" valign="top">
                                            <asp:HyperLink ID="cmdDownloadImage" runat="server" ToolTip="Download">
                                                <table class="table-white">
                                                    <tr>
                                                        <td>
                                                            <img src="Images/download.gif" width="40" height="40" border="0" />
                                                        </td>
                                                        <td style="padding-left: 5px">
                                                            <asp:Label ID="DownloadLink" runat="server" Font-Size="11pt" Font-Underline="false"
                                                                Font-Bold="true" Text=""></asp:Label><br />
                                                            <asp:Label ID="lblSize" runat="server" Text="1.2 MB" Font-Size="9pt" ForeColor="Gray"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:Image ID="imgMain" runat="server" CssClass="PdfBorderStyle AttachmentThumbBig"
                                    ImageUrl="~/Images/processing.gif" BorderWidth="1px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td width="100px">
                                            <asp:LinkButton ID="Previous2" runat="server" CausesValidation="False" CssClass="button1"
                                                OnClick="Previous1_Click" ToolTip="Previous Page"><img src="Images/Previous.gif" width="32" height="32" border="0" /></asp:LinkButton>
                                            <asp:LinkButton ID="Next2" runat="server" CausesValidation="False" CssClass="button1"
                                                OnClick="Next1_Click" ToolTip="Next Page"><img src="Images/Next.gif" width="32" height="32" border="0" /></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPageXofY2" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" AssociatedUpdatePanelID="UpdatePanel1"
            DisplayAfter="10">
            <ProgressTemplate>
                <div class="TransparentGrayBackground">
                </div>
                <asp:Image ID="Image1" runat="server" alt="" ImageUrl="~/Images/processing.gif" CssClass="LoadingImage"
                    Width="214" Height="138" />
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:AlwaysVisibleControlExtender ID="UpdateProgress1_AlwaysVisibleControlExtender"
            runat="server" Enabled="True" HorizontalSide="Center" TargetControlID="Image1"
            UseAnimation="false" VerticalSide="Middle">
        </asp:AlwaysVisibleControlExtender>
    </div>
    </form>
</body>
</html>
