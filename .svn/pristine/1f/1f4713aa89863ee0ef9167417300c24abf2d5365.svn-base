<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeBehind="New.aspx.cs" Inherits="ServiceCube.NewService" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="UserControl.ascx" TagName="UserControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CpTitle" runat="server">
    Submit New <asp:Literal ID="litTitle" runat="server"></asp:Literal>
    <script type="text/javascript">
        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);

            if (ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'pdf') {
                $('#ctl00_CpBody_lblUploadStatus').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('#ctl00_CpBody_lblUploadStatus').html("Only <b>PDF</b> and <b>JPG</b> files can be uploaded.");
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "",
                    htmlMessage: ""
                }
                return false;
            }
        }

        function UploadError() {
            $('#UploadBtn').hide();
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var img = '';
            var imgurl = '';
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            //alert(text);
            if (contentType == "application/pdf") {
                img = "ext/pdf.gif";
            }
            else if (contentType == "image/jpeg") {
                img = "ext/jpg.gif";
            }
            else {
                $('#UploadBtn').hide();
                $('#ctl00_CpBody_lblUploadStatus').html('Only PDF and JPG files are allowed to upload.');
            }
            if (img != '') imgurl = '<img src="Images/' + img + '"/> ';
            $('#UploadBtn').show('Slow');
            $('#ctl00_CpBody_lblUploadStatus').html(imgurl + '<b>' + filename + '</b><br>File uploaded successfully. Please click Attach.');
            $('#ctl00_CpBody_HidFileName').val(filename);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpBody" runat="server">
    <uc1:UserControl ID="UserControl1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div cssclass="row">
                <div class="col-md-2 hidden-xs">
                    <img src="images/Service-cube.png" class="img-responsive center-block" />
                </div>
                <asp:Panel runat="server" ID="Panel1" CssClass="col-md-10 col-lg-9">
                    <div class="panel panel-success">

                        <div class="panel-body">
                            <div class="row">
                                <label class="col-sm-2 control-label text-right">
                                     Type:</label>
                                <div class="col-sm-10 has-feedback">
                                    <asp:SqlDataSource ID="SqlDataSourceRoot" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                        SelectCommand="s_Ticket_Types_Public" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="ParentID" QueryStringField="id" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:DropDownList ID="ddlRoot" runat="server" DataSourceID="SqlDataSourceRoot" ToolTip="Select"
                                        DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlParent_SelectedIndexChanged">
                                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <asp:Panel ID="panelCommaonTask" runat="server" Visible="false">
                                <div class="row">
                                    <label class="col-sm-2 control-label text-right">
                                        Subject:</label>
                                    <div class="col-sm-10 has-feedback">
                                        <asp:TextBox ID="txtSubject" MaxLength="1000" TextMode="MultiLine" Rows="1" runat="server"
                                            ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubject"
                                            CssClass="form-control-feedback" ErrorMessage="*" Style="margin: 5px" ForeColor="Red" Font-Size="25px" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label text-right">
                                        Issue Details:
                                    </label>
                                    <div class="col-sm-10 has-feedback">
                                        <asp:TextBox ID="txtCommentDtl" MaxLength="1000" TextMode="MultiLine" Rows="6" runat="server"
                                            ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCommentDtl"
                                            CssClass="form-control-feedback" ErrorMessage="*" Style="margin: 5px" ForeColor="Red" Font-Size="25px" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label text-right">
                                        Priority:
                                    </label>
                                    <div class="col-sm-1">
                                        <asp:SqlDataSource ID="SqlPririty" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                            SelectCommand="SELECT * FROM V_ServicePriority"></asp:SqlDataSource>
                                        <asp:DropDownList ID="ddlPriority" runat="server" DataSourceID="SqlPririty" ToolTip="Select"
                                            DataTextField="PriorityName" DataValueField="PriorityID" OnDataBound="ddlPriority_DataBound">
                                            <%-- <asp:ListItem Value="2" Text="Normal"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hidTicketNo" runat="server" />
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-sm-2 control-label text-right">
                                        Attachment:
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="pointer attachmentAdd">
                                            <asp:LinkButton runat="server" ID="cmdAddAttach" OnClick="cmdAddAttach_Click">
                                            <img src="Images/add-files.png" width="20" />Add Files</asp:LinkButton>
                                        </div>
                                        <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                            RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px" Font-Bold="False"
                                            Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                            HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:Image runat="server" CssClass="AttachmentThumb" LoadImg='<%# getLinkImage(Eval("AID"),Eval("FileID"),Eval("Extension")) %>'
                                                    ImageUrl="~/Images/Loading.gif" ID="Image1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                                <asp:HoverMenuExtender ID="Image1_HoverMenuExtender" runat="server" DynamicServicePath=""
                                                    Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="Image1" CacheDynamicResults="True"
                                                    OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                                </asp:HoverMenuExtender>
                                                <asp:Panel ID="AttachmentMenu" runat="server" BorderColor="Gray" BorderWidth="1px"
                                                    Width="120px" Style="padding: 5px; text-align: left;" CssClass="ui-corner-all Shadow Panel1">
                                                    <div>
                                                        <asp:HyperLink ID="HyperLink3" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View in PDF Viewer"
                                                            NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&view=yes" %>'
                                                            Style="color: blue" Target="_blank"><b>View File</b></asp:HyperLink><br />
                                                    </div>
                                                    <div style="margin-top: 5px" class='<%# (Eval("Extension").ToString().ToLower() =="pdf" ? "" : "hidden") %>'>
                                                        <asp:HyperLink ID="HyperLink2" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View as HTML"
                                                            NavigateUrl='<%# "pdf.aspx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
                                                            Style="color: blue" Target="_blank"><b>View as HTML</b></asp:HyperLink><br />
                                                    </div>
                                                    <div style="margin-top: 5px">
                                                        <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server" NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
                                                            Font-Size="10pt" Style="color: blue" ToolTip='<%# Eval("FileName") %>'><b>Download</b></asp:HyperLink>
                                                    </div>
                                                    <div style="font-size: 7pt">
                                                        <%# "<b>" + FileSize(Eval("FileSize")) + "</b><br /><span style=\"color:Gray\"><b>Upload On:</b><br>" + Common.ToRecentDateTime(Eval("InsertDT")) + "<br>" + "<time class='timeago' datetime='" + Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") + "'></time>" + "</span>"%>
                                                    </div>
                                                    <asp:LinkButton ID="cmdDeleteAttachment" CssClass="link" CommandName="DELETE" Font-Bold="true"
                                                        CommandArgument='<%# Eval("AID") %>' runat="server" CausesValidation="False"
                                                        Text="Delete" OnClick="cmdDeleteAttachment_Click" Enabled="true"
                                                        Visible="true" Style="color: #CC0000"></asp:LinkButton>
                                                    <asp:ConfirmButtonExtender ID="cmdDeleteAttachment_ConfirmButtonExtender" runat="server"
                                                        ConfirmText="Are you sure you want to Delete?" Enabled="True" TargetControlID="cmdDeleteAttachment"></asp:ConfirmButtonExtender>
                                                </asp:Panel>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:SqlDataSource ID="SqlDataSourceAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                            SelectCommand="SELECT * FROM v_Attachments_Browse WHERE (SessionID = @SessionID)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="HidPageID" Name="SessionID" PropertyName="Value" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:Panel ID="panelButton" runat="server" Visible="false">
                                <div class="row">
                                    <div class="col-sm-2">
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-block" Text="Submit Now" OnClick="btnSubmit_Click" />
                                        <asp:ConfirmButtonExtender runat="server" ID="conSubmit" ConfirmText="Do you want to Submit?" TargetControlID="btnSubmit" />
                                    </div>
                                    <%--<div class="col-md-2">
                                        <asp:Button ID="btnReset" runat="server" CssClass="btn btn-block" Text="Reset" OnClick="btnReset_Click" />
                                        <asp:ConfirmButtonExtender TargetControlID="btnReset" ID="conReset" runat="server"
                                            ConfirmText="All data will be lost. Do you want to Reset?"></asp:ConfirmButtonExtender>
                                    </div>--%>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="Panel2" CssClass="alert alert-success Center col-md-9" Visible="false">
                    <asp:Literal ID="lblStatus" runat="server"></asp:Literal>
                </asp:Panel>
            </div>

            <asp:Panel runat="server" ID="ModalPanel" ClientIDMode="Static" CssClass="modal" role="dialog" TabIndex="-1">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                            <h4 class="modal-title">Add New Attachment</h4>
                        </div>
                        <div class="modal-body">

                            <asp:AsyncFileUpload UploaderStyle="Traditional" ID="FileUpload1" runat="server"
                                ThrobberID="myThrobber" Width="100%"
                                OnUploadedComplete="FileUpload1_UploadedComplete"
                                OnClientUploadComplete="UploadComplete"
                                OnClientUploadError="UploadError"
                                OnUploadedFileError="FileUpload1_UploadedFileError"
                                OnClientUploadStarted="AsyncFileUpload1_StartUpload" />
                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" /><br />
                            <asp:Label ID="lblUploadStatus" runat="server" Text="" Style="font-size: small;">
                
                            </asp:Label>

                            <div style="display: none;" id="UploadBtn"><br />
                                <asp:Button ID="cmdUpload" runat="server" Height="33px" UseSubmitBehavior="true"
                                    CausesValidation="false" Style="font-weight: 700" Text="Attach" Width="100px"
                                    OnClick="cmdUpload_Click" />
                            </div>
                            <asp:Button Visible="false" ID="cmdTestClose" runat="server" Text="Close" CausesValidation="false"  OnClick="cmdTestClose_Click" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default bold" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>

            </asp:Panel>
            <asp:HiddenField ID="hidTicketType" runat="server" />
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" runat="server" Value="" />

            <span style="visibility: hidden">
                <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
            </span>
            <%-- <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                PopupDragHandleControlID="ModalTitleBar1" BackgroundCssClass="ModalPopupBG" RepositionMode="RepositionOnWindowResize">
            </asp:ModalPopupExtender>   --%>
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
        UseAnimation="false" VerticalSide="Middle"></asp:AlwaysVisibleControlExtender>
</asp:Content>
