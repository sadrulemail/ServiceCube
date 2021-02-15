<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DefaultServiceTicket.aspx.cs" Inherits="DefaultServiceTicket" EnableEventValidation="false"
    ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="script/jquery.autosize-min.js" type="text/javascript"></script>
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
    <script type="text/javascript">
        function onClientUploadComplete(sender, e) {
            var id = e.get_fileId();
            var fileSize = getReadableFileSizeString(e.get_fileSize());
            var fileName = e.get_fileName();

            $('#attachmentFileList').show().append("<li highlight='yes' style='background:yellow'><div id='attach-del' class='attach-del-btn' title='Remove'></div><input id='chkfilelist' type='checkbox' value='" + id + "' checked ><img src='Images/sortable.png' class='MoveIcon' width='16' height='14' /><a href='Attachment.ashx?key=" + id + "&aid=-1' target='_blank' class='link' >" + fileName + "</a> (" + fileSize + ")</li>");
            RefreshAttachments();
            $('#attachmentFileList li[highlight=yes]').animate({ backgroundColor: "#FFF" }, 3000);
            $('#attachmentFileList li[highlight=yes]').removeAttr('highlight');


            $('.attach-del-btn').click(function () {
                $(this).parent().hide('slow', function () {
                    $(this).remove();
                    RefreshAttachments();
                });
            });
        }  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    My Default Service Ticket
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div class="row">
                <link href="jstree/themes/default/style.css" rel="stylesheet" type="text/css" />
                <ul id="my-team-assign">
                </ul>
                <asp:HiddenField ID="hidAssignedTeamID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hidEmpID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hidDeptID" runat="server" ClientIDMode="Static" />
            </div>
            <div class="row">
                <asp:Button ID="btnDefaultService" runat="server" Text="Save My Default Service Ticket" 
                    onclick="btnDefaultService_Click" />
            </div>
            <asp:SqlDataSource ID="SqlDataSourceTicketBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="s_Ticket_Browse_Select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
