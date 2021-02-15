<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true"
    CodeFile="NewTicket_Admin.aspx.cs" Inherits="NewTicket_Admin" EnableEventValidation="false"
    ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <style type="text/css">
        .style2 {
            font-size: x-large;
            font-weight: bold;
            color: silver;
        }

        .style3 {
            font-size: small;
        }

        .style5 {
            color: #666666;
        }

        .ROW2 {
            background-image: url( 'Images/bg7.gif' );
            background-position: top;
            background-repeat: repeat-x;
            background-color: White;
            cursor: default;
        }
        .box {            
            background: #fceabb; /* Old browsers */
            background: -moz-linear-gradient(top, #fceabb 0%, #fccd4d 50%, #fbdf93 100%); /* FF3.6-15 */
            background: -webkit-linear-gradient(top, #fceabb 0%,#fccd4d 50%,#fbdf93 100%); /* Chrome10-25,Safari5.1-6 */
            background: linear-gradient(to bottom, #fceabb 0%,#fccd4d 50%,#fbdf93 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fceabb', endColorstr='#fbdf93',GradientType=0 ); /* IE6-9 */
        }
    </style>
    
    <script type="text/javascript">
        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);

            if (ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'pdf') {
                $('[tblid=lblUploadStatus]').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('[tblid=lblUploadStatus]').html("Only <b>PDF</b> and <b>JPG</b> files can be uploaded.");
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
                $('[tblid=lblUploadStatus]').html('Only PDF and JPG files are allowed to upload.');
            }
            if (img != '') imgurl = '<img src="Images/' + img + '"/> ';
            $('#UploadBtn').show('Slow');
            $('[tblid=lblUploadStatus]').html(imgurl + '<b>' + filename + '</b><br>File uploaded successfully. Please click Attach.');
            $('#HidFileName').val(filename);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    Add Solved Ticket
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    Add new solved issue 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" ClientIDMode="Static" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />



            <div>

                <div class="box box-tbl" >
                    <div class="box-body">
                        <div class="form-inline">
                            <div class="form-group">
                                <label style="margin-right: 14px;">Ticket Type:</label>

                                <asp:SqlDataSource ID="SqlDataSourceRoot" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    SelectCommand="SELECT * FROM Ticket_Type WHERE Parent_ID=0 and Active = 1 and isPublic = 0 order by Name"></asp:SqlDataSource>
                                <asp:DropDownList ID="ddlRoot" runat="server" DataSourceID="SqlDataSourceRoot" ToolTip="Select" CssClass="form-control"
                                    DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true">
                                    <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                </asp:DropDownList>

                                <asp:DropDownList ID="ddlParent" runat="server" SelectedValue='<%# Eval("ID") %>' CssClass="form-control"
                                    ToolTip="Select">
                                </asp:DropDownList>
                                <asp:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="ddlParent"
                                    Category="District" PromptText="Select" ServicePath="WebService.asmx" LoadingText="Loading..."
                                    ServiceMethod="GetDropDownContents_Parent" ParentControlID="ddlRoot" />

                                <asp:DropDownList ID="ddlServiceType" runat="server" SelectedValue='<%# Eval("ID") %>' CssClass="form-control"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlServiceType_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:CascadingDropDown ID="CascadingDropDown2" runat="server" TargetControlID="ddlServiceType"
                                    Category="Thana" PromptText="Select Service" ServicePath="WebService.asmx" LoadingText="Loading..."
                                    ServiceMethod="GetDropDownContents_TicketType" ParentControlID="ddlParent" />
                                <asp:HiddenField ID="hidTicketType" runat="server" />

                            </div>
                        </div>
                    </div>
                </div>

                <%--  <div style="clear: left; margin-bottom: 5px">
                </div>--%>

                <div>
                    <asp:Panel ID="panelDeleteReq" runat="server" Visible="false" CssClass="box box-tbl">
                        <div class="form-inline">
                            <div class="form-group">
                                <label style="margin-right: 10px;">Branch Code:</label>


                                <asp:Label ID="lblBranchCode" runat="server" Text="Label"></asp:Label>

                            </div>
                        </div>
                        <div class="form-inline">
                            <div class="form-group">
                                <label style="margin-right: 37px;">Batch No:</label>


                                <asp:TextBox Width="100px" MaxLength="50" ID="txtBatchNo" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorBatchno" runat="server" ControlToValidate="txtBatchNo"
                                    ValidationGroup="grpCheck" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="form-inline">
                            <div style="margin-top: 7px;" class="form-group">
                                <label style="margin-right: 8px;">Authorized ID:</label>



                                <asp:TextBox Width="100px" CssClass="number form-control" MaxLength="10" ID="txtAuthorizedID"
                                    runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorAuthoID" runat="server" ControlToValidate="txtAuthorizedID"
                                    ValidationGroup="grpCheck" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-inline">
                            <div style="margin: 7px 0 0 100px;" class="form-group">
                                <asp:Button ID="btnCheck" runat="server" CssClass="btn" ValidationGroup="grpCheck" Text="Verify"
                                    OnClick="btnCheck_Click" />

                                <asp:Label ID="lblCheckStatus" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="panelCommaonTask" runat="server" Visible="false" style="background-color:#f3ffa5;padding:10px;border:1px solid silver;border-radius:4px;display:inline-block">
                        <div class="form-inline">
                            <div class="form-group">
                                <label style="margin-right:15px">Requester:</label>


                                <asp:TextBox ID="txtRequesterEmpID" MaxLength="6" runat="server" CssClass="form-control empid-pick"
                                    Style="width: 80px;" ClientIDMode="Static" placeholder="emp id"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqRequesterEmpID" runat="server" ControlToValidate="txtRequesterEmpID"
                                    ValidationGroup="grpCommonTicket" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                        
                        <div class="form-inline">
                            <div style="margin-top: 7px;" class="form-group">
                                <label style="margin-right: 32px;">Subject:</label>


                                <asp:TextBox ID="txtSubject" MaxLength="1000" TextMode="MultiLine" Rows="1" runat="server" CssClass="form-control"
                                    Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubject"
                                    ValidationGroup="grpCommonTicket" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="form-inline">
                            <div style="margin-top: 7px;" class="form-group">

                                <label>Issue Details:</label>


                                <asp:TextBox ID="txtCommentDtl" MaxLength="1000" TextMode="MultiLine" Rows="4" runat="server" CssClass="form-control"
                                    Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>

                            </div>
                        </div>
                        <div class="form-inline">
                            <div style="margin-top: 7px;" class="form-group">

                                <label style="margin-right: 35px;">Priority:</label>
                                <asp:SqlDataSource ID="SqlPririty" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    SelectCommand="SELECT * FROM V_ServicePriority"></asp:SqlDataSource>
                                <asp:DropDownList ID="ddlPriority" runat="server" DataSourceID="SqlPririty" ToolTip="Select" CssClass="form-control"
                                    DataTextField="PriorityName" DataValueField="PriorityID" OnDataBound="ddlPriority_DataBound">
                                    <%-- <asp:ListItem Value="2" Text="Normal"></asp:ListItem>--%>
                                </asp:DropDownList>
                                <asp:HiddenField ID="hidTicketNo" runat="server" />

                            </div>
                        </div>
                        <div class="form-inline">
                            <div style="margin-top: 7px;" class="form-group">

                                <label style="margin-right: 40px;">Status:</label>
                                
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" >
                                    <asp:ListItem Value="4" Text="Closed (Resolved)"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="On Process"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="Reject"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                       
                    
                          
                                <div style="margin: 7px 0 0 100px;" class="form-group">
                                    <asp:HiddenField ID="hidFileIds" runat="server" />

                                    <div class="pointer attachmentAdd">
                                        <asp:LinkButton runat="server" ID="cmdAddAttach" OnClick="cmdAddAttach_Click">
                                            <img src="Images/add-files.png" width="20" />Add Files</asp:LinkButton>
                                    </div>


                                    <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px" Font-Bold="False"
                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                        HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Image runat="server" CssClass="AttachmentThumb" ClientIDMode="Predictable" LoadImg='<%# getLinkImage(Eval("AID"),Eval("FileID"),Eval("Extension")) %>'
                                                ImageUrl="~/Images/Loading.gif" ID="Image1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                            <asp:HoverMenuExtender ID="Image1_HoverMenuExtender" runat="server" DynamicServicePath=""
                                                Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="Image1" CacheDynamicResults="True"
                                                OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                            </asp:HoverMenuExtender>
                                            <asp:Panel ID="AttachmentMenu" runat="server" BorderColor="Gray" BorderWidth="1px" ClientIDMode="Predictable"
                                                Width="120px" Style="padding: 5px; text-align: left;" CssClass="box">
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
                         
                     
                    </asp:Panel>

                    <asp:Panel runat="server" ID="ModalPanel1" Width="610px" CssClass="ModalPanel">
                        <div style="background-color: Green; border: 4px solid green">
                            <asp:Panel runat="server" ID="ModalTitle1" CssClass="MoveIcon"
                                HorizontalAlign="Center" Width="100%">
                                <table width="100%">
                                    <tr>
                                        <td align="left" style="color: white; font-size: 16pt; font-weight: bolder">
                                            <asp:Literal ID="Label12" runat="server" Text="Add New Attachment"></asp:Literal>
                                        </td>
                                        <td align="right">
                                            <a href="#" style="cursor: default">
                                                <asp:Image ID="ModalClose1" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="Panel3" runat="server" BackColor="#fefdc3" Height="200px">
                                <div style="padding: 20px 20px 20px 20px">
                                    <asp:AsyncFileUpload UploaderStyle="Traditional" ID="FileUpload1" runat="server"
                                        ThrobberID="myThrobber" Width="400"
                                        OnUploadedComplete="FileUpload1_UploadedComplete"
                                        OnClientUploadComplete="UploadComplete"
                                        OnClientUploadError="UploadError"
                                        OnUploadedFileError="FileUpload1_UploadedFileError"
                                        OnClientUploadStarted="AsyncFileUpload1_StartUpload" />

                                    <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" /><br />
                                    <asp:Label ID="lblUploadStatus" tblid="lblUploadStatus" runat="server" Text="" Style="font-size: small;">
                
                                    </asp:Label>
                                    <div style="display: none; padding-top: 20px" id="UploadBtn">
                                        <asp:Button ID="cmdUpload" runat="server" Height="33px"
                                            CssClass="btn"
                                            UseSubmitBehavior="true"
                                            CausesValidation="false" Text="Attach" Width="100px"
                                            OnClick="cmdUpload_Click" />
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </asp:Panel>

                    <span style="visibility: hidden">
                        <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                        <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
                    </span>
                    <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                        ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                        PopupDragHandleControlID="ModalTitle1" BackgroundCssClass="ModalPopupBG" RepositionMode="RepositionOnWindowResize">
                    </asp:ModalPopupExtender>




                    <asp:Panel ID="panelButton" runat="server" Visible="true">
                        <div class="form-inline">
                            <div style="margin-left: 100px;" class="form-group">

                                <asp:Button ID="btnSubmit" runat="server" Text="Submit Solved Ticket" OnClick="btnSubmit_Click" CssClass="btn"
                                    ValidationGroup="grpCommonTicket" Enabled="false" />
                                <asp:ConfirmButtonExtender TargetControlID="btnSubmit" ID="ConfirmButtonExtender_Submit" runat="server"
                                    ConfirmText="Do you want to Submit the information?"></asp:ConfirmButtonExtender>
                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" OnClick="btnReset_Click" />
                                <asp:ConfirmButtonExtender TargetControlID="btnReset" ID="conReset" runat="server"
                                    ConfirmText="All data will be lost. Do you want to Reset?"></asp:ConfirmButtonExtender>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <%--    </asp:Panel>--%>
            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="SELECT * FROM V_ServicePriority" SelectCommandType="Text"></asp:SqlDataSource>
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
