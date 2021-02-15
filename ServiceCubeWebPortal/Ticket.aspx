<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="ServiceCube.Ticket" %>

<%@ Register Src="~/UserControl.ascx" TagName="UserControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CpTitle" runat="Server">
    Your Issue Details

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
             else if (contentType == "image/jpeg" || contentType == "image/jpg") {
                 img = "ext/jpg.gif";
             }
             else {
                 $('#UploadBtn').hide();
                 $('#ctl00_CpBody_lblUploadStatus').html('Only PDF and JPG files are allowed to upload.');
             }
             if (img != '') imgurl = '<img src="Images/' + img + '" /> ';
             $('#UploadBtn').show('Slow');
             $('#ctl00_CpBody_lblUploadStatus').html(imgurl + '<b>' + filename + '</b><br>File uploaded successfully. Please click Attac.h');
             $('#ctl00_CpBody_HidFileName').val(filename);

         }
     </script>

    <asp:Literal ID="lblTicket" runat="server" Text=""></asp:Literal>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CpBody" runat="Server">
    <uc1:UserControl ID="UserControl1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <div class="content-back hidden-xs center-block" style="display: table">
                <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="table table-responsive table-bordered table-striped table-condensed contentGrid"
                    ForeColor="Black" GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="TicketID" EnableViewState="false"
                    DataSourceID="SqlDataSourceTicket" CellPadding="4" Width="100%" OnDataBound="DetailsView1_DataBound">
                    <Fields>
                        <asp:TemplateField HeaderText="Subject" ShowHeader="false">
                            <ItemTemplate>
                                <%# Eval("Subject")%>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" Font-Size="140%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type" ShowHeader="true">
                            <ItemTemplate>
                                <%# Eval("TicketTypeName")%></span>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ticket ID" ShowHeader="true">
                            <ItemTemplate>
                                <%# Eval("TicketID")%></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" ShowHeader="true">
                            <ItemTemplate>
                                <%# Eval("StatusName")%></span>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Priority" HeaderStyle-Wrap="false">
                            <ItemTemplate>
                                <%# Eval("PriorityName")%>
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Requested By" ShowHeader="true">
                            <ItemTemplate>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Requested on" ShowHeader="true">
                            <ItemTemplate>
                                <%-- <%# Eval("CreatedDT")%>--%>
                                <div title='<%# Eval("CreatedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                    <%# UserControl1.ToRecentDateTime(Eval("CreatedDT"))%>
                                    <time class="timeago time-small-gray" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="IP Address" ShowHeader="true">
                            <ItemTemplate>
                                <%# Eval("IP")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <EmptyDataTemplate>
                        No Data Found.
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" />

                </asp:DetailsView>
            </div>
            <div class="visible-xs center-block">
                <asp:DetailsView ID="DetailsView2" runat="server" BackColor="White" CssClass="table table-responsive table-bordered table-striped table-condensed"
                    ForeColor="Black" GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="TicketID"
                    DataSourceID="SqlDataSourceTicket" CellPadding="4" OnDataBound="DetailsView1_DataBound" EnableViewState="false">
                    <Fields>
                        <asp:TemplateField HeaderText="Subject" ShowHeader="false">
                            <ItemTemplate>
                                <%# Eval("Subject")%>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" Font-Size="140%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ticket Type" ShowHeader="false">
                            <ItemTemplate>
                                Type: <%# Eval("TicketTypeName")%></span>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ticket ID" ShowHeader="false">
                            <ItemTemplate>
                                Ticket ID: <%# Eval("TicketID")%></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" ShowHeader="false">
                            <ItemTemplate>
                                Status: <%# Eval("StatusName")%></span>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="true" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Priority" ShowHeader="false">
                            <ItemTemplate>
                                Priority: <%# Eval("PriorityName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Requested on" ShowHeader="false">
                            <ItemTemplate>
                                Requested on:
                                    <span title='<%# Eval("CreatedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                        <%# UserControl1.ToRecentDateTime(Eval("CreatedDT"))%>
                                        <div>
                                            <time class="timeago time-small-gray" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="IP Address" ShowHeader="false">
                            <ItemTemplate>
                                IP Address: <%# Eval("IP")%>                                
                                <div class="hidden"></dic><%# GetVisibleComment(Eval("isVisible")) %></div>
                            </ItemTemplate>
                        </asp:TemplateField>                        
                    </Fields>
                    <EmptyDataTemplate>
                        No Data Found.
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" />

                </asp:DetailsView>
            </div>
            <asp:Panel runat="server" ID="panelVisible">
                <div>
                    <asp:GridView ID="grdvComment" runat="server" DataKeyNames="CID" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceComments" CssClass="table table-striped table-bordered table-condensed table-hover" BorderStyle="None"
                        ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="false"
                        CellPadding="4" ForeColor="Black"
                        OnRowDataBound="grdvComment_RowDataBound">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <img src='Images/<%# Eval("icon")%>' height="24" width="24" border="0" title='<%# Eval("TypeName") %>' />
                                </ItemTemplate>
                                <ItemStyle Width="40px" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="hidden-xs" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comment">
                                <ItemTemplate>
                                    <div class='bold' title='<%# Eval("CID") %>'>
                                        <%# Eval("Comment").ToString().Replace("\n","<br />") %>
                                    </div>
                                    <div class="small">
                                        <asp:Literal ID="litAttach" runat="server" EnableViewState="false"></asp:Literal>
                                    </div>
                                    <div class="visible-xs">Posted by: <%# Eval("PostedBy") %></div>
                                    <div title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>' class="visible-xs">
                                        Posted on: <%# UserControl1.ToRecentDateTime( Eval("DT")) %><br />
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="" />
                                <HeaderStyle CssClass="hidden-xs" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Posted by">
                                <ItemTemplate>
                                    <%# Eval("PostedBy") %>
                                </ItemTemplate>
                                <ItemStyle CssClass="hidden-xs" />
                                <HeaderStyle CssClass="hidden-xs" Wrap="false" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Posted on" SortExpression="DT">
                                <ItemTemplate>
                                    <div title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                        <%# UserControl1.ToRecentDateTime( Eval("DT")) %><br />
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="hidden-xs" />
                                <HeaderStyle CssClass="hidden-xs" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle VerticalAlign="Top" />
                        <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                        <FooterStyle BackColor="#CCCC99" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                        SelectCommand="s_Comments_Select_Public" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                            <asp:SessionParameter Name="EmaiID" Type="String" SessionField="Username" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="row">

                    <div class="control" style="margin-bottom: 20px">
                        <asp:HiddenField ID="hidFileIds" runat="server" />


                        <asp:Panel ID="panelButton" runat="server" Visible="false">
                            <div class="row">
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-10">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Now" OnClick="btnSubmit_Click" />

                                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                                    <asp:ConfirmButtonExtender TargetControlID="btnReset" ID="conReset" runat="server"
                                        ConfirmText="All data will be lost. Do you want to Reset?"></asp:ConfirmButtonExtender>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <div class="row col-md-8 col-md-offset-2">
                    <asp:Panel runat="server" ID="PanelComment" CssClass="panel panel-success" Visible="false">
                        <div class="panel-heading">Post Reply</div>
                        <div class="panel-body">
                            <div class="row form-group has-feedback">

                                <asp:TextBox ID="txtCommentDtl" CssClass="form-control" MaxLength="1000" TextMode="MultiLine" Rows="4" runat="server"
                                    ClientIDMode="Static"></asp:TextBox>


                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPostReply" ControlToValidate="txtCommentDtl"
                                    ValidationGroup="grpticketStatus" SetFocusOnError="True" Font-Bold="true" Font-Size="150%" CssClass="form-control-feedback" runat="server" ForeColor="Red"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>

                            </div>


                            <div class="row">
                                <label class="col-sm-2 col-md-1 control-label text-right">
                                    Status:
                                </label>
                                <div class="col-sm-5 col-md-4">
                                    <asp:DropDownList ID="ddlStatusType" runat="server" AppendDataBoundItems="True" DataTextField="StatusName"
                                        DataValueField="StatusID" CssClass="form-control" DataSourceID="SqlDataSourceTicketStatus">
                                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-1 has-feedback">
                                    <asp:RequiredFieldValidator CssClass="form-control-feedback" ID="RequiredFieldValidator1" ControlToValidate="ddlStatusType"
                                        ValidationGroup="grpticketStatus" Font-Bold="true" Font-Size="150%" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <asp:SqlDataSource ID="SqlDataSourceTicketStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    SelectCommand="SELECT * FROM v_Public_TicketStatus" SelectCommandType="Text"></asp:SqlDataSource>
                            </div>

                            <div class="row">
                                <span class="pointer attachmentAdd">
                                    <asp:LinkButton runat="server" ID="cmdAddAttach" OnClick="cmdAddAttach_Click">
                            <img src="Images/add-files.png" width="20px" />Add Files</asp:LinkButton></span>

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
                            <div class="row">
                                <asp:Button ID="btnPostReply" runat="server" CssClass="btn col-sm-3 col-md-2" Text="Post Reply" ValidationGroup="grpticketStatus"
                                    OnClick="btnPostReply_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <%--  </asp:Panel>--%>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                    SelectCommand="s_Flora_Delete_Trn_Select" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                        <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceTicket" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                    SelectCommand="s_Ticket_Info_Select_Public" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceTicket_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                        <asp:SessionParameter SessionField="Username" Name="EmailID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
                <div style="height: 400px">
                </div>
            </asp:Panel>


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

                            <div style="display: none;" id="UploadBtn">
                                <br />
                                <asp:Button ID="cmdUpload" runat="server" Height="33px" UseSubmitBehavior="true"
                                    CausesValidation="false" Style="font-weight: 700" Text="Attach" Width="100px"
                                    OnClick="cmdUpload_Click" />
                            </div>

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

