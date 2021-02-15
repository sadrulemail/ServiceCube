﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true"
    Inherits="Ticket" CodeFile="Ticket.aspx.cs" ValidateRequest="false" EnableViewState="true" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
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
    Ticket Request Show #<asp:Literal ID="lblTicket" runat="server" Text=""></asp:Literal>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    For searching 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Button ID="cmdPost" runat="server" Text="Button" CssClass="hide" OnClick="cmdPost_Click" />
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="hidChatHub" runat="server" Value="1" />
            <asp:HiddenField ID="hidEmpID" runat="server" Value="" />
            <asp:HiddenField ID="hidTicketID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" ClientIDMode="Static" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />
            <asp:Label ID="lblTicketTitle" runat="server" CssClass="print-only bold" Font-Size="120%"></asp:Label>
            <div style="float: left" class="hidden-print">
                <div class="box">
                    <div class="box-body">
                        <div class="form-inline" style="display:inline-block">
                           
                                <label>Ticket ID</label>
                                <asp:TextBox ID="txtTicketID" runat="server" CssClass="Center form-control" Width="200px" MaxLength="20"
                                    Font-Size="Large" onfocus="this.select()"></asp:TextBox>
                                <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender1" TargetControlID="txtTicketID"
                                    ValidChars="1234567890."></asp:FilteredTextBoxExtender>
                            </div>
                            <asp:Button ID="btnSearch" runat="server" Text="Show" Width="80px" Height="30px" CssClass="btn "
                                CommandName="Select" OnClick="btnSearch_Click" />

                       
                    </div>
                </div>
            </div>

            <asp:Panel ID="PanelTicketStatus" runat="server" Style="float: left; padding-left: 50px;">
                <div class="alert alert-warning text-bold">
                    <asp:Label ID="lblTicketStatus" runat="server"
                        Text=""></asp:Label>
                </div>
            </asp:Panel>

            <div style="clear: left;"></div>

            <asp:Panel runat="server" ID="panelDetailViewVisible">
                <table>
                    <tr>
                        <td valign="top">
                            <asp:SqlDataSource ID="SqlDataSourceTicket" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                SelectCommand="s_Ticket_Info_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceTicket_Selected"
                                UpdateCommand="s_Ticket_Info_Update" UpdateCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                                    <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="TicketID" Size="50" Type="String" />
                                    <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                                    <asp:Parameter Name="TicketTypeID" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="Grid Grid-stripe"
                                ForeColor="Black" GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="TicketID" EnableViewState="false"
                                DataSourceID="SqlDataSourceTicket" CellPadding="4" Width="450px" OnDataBound="DetailsView1_DataBound">
                                <Fields>
                                    <asp:TemplateField HeaderText="Subject" ShowHeader="false">
                                        <ItemTemplate>
                                            <div style="float: right; margin-right: 6px">
                                                <img src='Images/<%# Eval("CreatedBy").ToString() == "" ? "globe.png" : "TBL3.png" %>' width="30" />
                                            </div>
                                            <div><%# Eval("Subject")%></div>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" Font-Size="140%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ticket Type" ShowHeader="false">
                                        <ItemTemplate>
                                            <div style="float: right; margin-right: 6px" class="no-print">
                                                <asp:LinkButton ID="cmdEditTicket" Text="Edit" runat="server" CommandName="Edit" Visible="false" />
                                            </div>
                                            <span title="Ticket Type"><%# Eval("TicketTypeName")%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            Type: 
                                            <asp:DropDownList ID="ddlTicketType" runat="server" DataSourceID="SqlDataSourceTicketType"
                                                DataTextField="Name" DataValueField="ID"
                                                SelectedValue='<%# Bind("TicketTypeID") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceTicketType" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                                SelectCommand="s_Ticket_Type" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:Parameter Name="Type" DefaultValue="I" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                            <asp:LinkButton ID="cmdUpdateTicket" Text="Update" runat="server" CommandName="Update" />
                                            <asp:ConfirmButtonExtender runat="server" ID="conUpdateTicket" ConfirmText="Do you want to Udpate?" TargetControlID="cmdUpdateTicket" />
                                            <asp:LinkButton ID="cmdCancelTicket" Text="Cancel" runat="server" CommandName="Cancel" CausesValidation="false" />

                                        </EditItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" ShowHeader="true">
                                        <ItemTemplate>
                                            <span><%# Eval("StatusName")%></span>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Priority" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <%# Eval("PriorityName")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requested By" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("FullName")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Email" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("Email")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mobile Number" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("Mobile")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requested By" ShowHeader="true">
                                        <ItemTemplate>
                                            <span class="trustclick" type="emp" val='<%# Eval("CreatedBy") %>'><%# Eval("CreatedBy") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Requested on" ShowHeader="true">
                                        <ItemTemplate>
                                            <div title='<%# Eval("CreatedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>' class="hidden-print">
                                                <%# TrustControl1.ToRecentDateTime(Eval("CreatedDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </div>
                                            <div class="print-only">
                                                <%# Eval("CreatedDT","{0:dd/MM/yyyy h:mm:ss tt}") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Added By" ShowHeader="true">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hidAddedBy" runat="server" Value='<%# Eval("AddedBy") %>' />
                                            <span class="trustclick" type="emp" val='<%# Eval("AddedBy") %>'><%# Eval("AddedBy") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assigned Emp" ShowHeader="true">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hidAssignedEmp" runat="server" Value='<%# Eval("AssignedEmp") %>' />
                                            <span class="trustclick" type="emp" val='<%# Eval("AssignedEmp") %>'><%# Eval("AssignedEmp") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assign Branch" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("BranchName")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assign Dept" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("Department")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Last Response" ShowHeader="true">
                                        <ItemTemplate>
                                            <div title='<%# Eval("LastResponseDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>' class="hidden-print">
                                                <%# TrustControl1.ToRecentDateTime(Eval("LastResponseDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("LastResponseDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </div>
                                            <div class="print-only">
                                                <%# Eval("LastResponseDT","{0:dd/MM/yyyy h:mm:ss tt}") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="IP Address" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("IP")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                                <EditRowStyle />
                                <EmptyDataTemplate>
                                    No Data Found.
                                </EmptyDataTemplate>
                                <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" />
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle VerticalAlign="Top" />
                            </asp:DetailsView>

                        </td>
                        <td valign="top" style="padding: 0 0 0 50px">
                            <asp:Panel runat="server" ID="PanelTicketMailWise" Style="max-height: 300px; overflow: auto; overflow-x: hidden">
                                <div class="text-bold">Other Tickets from this Email:</div>
                                <asp:GridView ID="GridViewTicketMailWise" runat="server" CssClass="Grid" DataSourceID="SqlDataSourceTicketMailWise"
                                    AllowSorting="True" BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" EnableViewState="false"
                                    AutoGenerateColumns="False" BorderWidth="1px" CellPadding="3" ForeColor="Black">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>

                                        <asp:TemplateField HeaderText="Ticket ID" SortExpression="TicketID">
                                            <ItemTemplate>
                                                <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' target="_blank"><%# Eval("TicketID") %></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                                            <ItemTemplate>
                                                <%# Eval("Subject") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="On" SortExpression="CreatedDT">
                                            <ItemTemplate>
                                                <div title='<%# Eval("CreatedDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>' class="hidden-print">
                                                    <%# TrustControl1.ToRecentDateTime(Eval("CreatedDT"))%><br />
                                                    <time class="timeago" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                </div>
                                                <div class="print-only">
                                                     <%# Eval("CreatedDT","{0:dd/MM/yyyy h:mm:ss tt}") %>                                                  
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle ForeColor="Gray" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status" SortExpression="StatusName">
                                            <ItemTemplate>
                                                <%# Eval("StatusName") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" />
                                    <HeaderStyle Wrap="False" BackColor="#6B696B" Font-Bold="False" ForeColor="White"
                                        HorizontalAlign="Center" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceTicketMailWise" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    SelectCommand="s_TicketsMailWise" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceTicketMailWise_Selected">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="TicketID" QueryStringField="id" Type="String" />

                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblEmailTicketStatus" runat="server"></asp:Label>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Panel runat="server" ID="panelVisible">

                <div style="max-width: 800px">
                    <asp:GridView ID="grdvComment" runat="server" DataKeyNames="CID" AutoGenerateColumns="False"
                        DataSourceID="SqlDataSourceComments" CssClass="Grid" BorderStyle="None" BackColor="White"
                        ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="false"
                        BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                        OnRowDataBound="grdvComment_RowDataBound">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <img src='Images/<%# Eval("icon")%>' height="24" width="24" border="0" title='<%# Eval("TypeName") %>' />
                                </ItemTemplate>
                                <ItemStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comment">
                                <ItemTemplate>
                                    <div class='<%# (Eval("AssignStaff").ToString() == "" ? "hidden" : "")  %> assign-emp bold'>
                                        Assigned to:
                                        <span class="trustclick no-print" type="emp" val='<%# Eval("AssignStaff") %>'><%# Eval("AssignStaff") %></span>
                                        <span class="print-only"><%# Eval("AssignStaff") %></span>
                                    </div>

                                    <%# (Eval("AssignBranchName", "<div class='assignbranch bold'>Assigned to: {0}</div>"))%>
                                    <%# (Eval("AssignDeptName", "<div class='assign-team bold'>Assigned to: {0}</div>"))%>
                                    <div class='autohyperlink'>
                                        <%# Eval("Comment").ToString().Replace("\n","<br />") %>
                                    </div>
                                    <asp:Literal ID="litAttach" runat="server"></asp:Literal>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Posted on" SortExpression="DT">
                                <ItemTemplate>
                                    <div title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>' class="no-print">
                                        <%# TrustControl1.ToRecentDateTime( Eval("DT")) %><br />
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </div>
                                    <div class="print-only">
                                        <%# Eval("DT","{0:dd/MM/yyyy h:mm:ss tt}") %>                                                  
                                    </div>
                                    <div>
                                        By:                                        
                                        <span class="trustclick no-print" type="emp" val='<%# Eval("EmpID") %>'><%# Eval("EmpID") %></span>
                                        <span class="print-only"><%# Eval("EmpID") %></span>
                                        <%# Eval("EmpID").ToString() == "" ? "<img src='Images/web.gif' title='Public' />" : "" %>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                        <FooterStyle BackColor="#CCCC99" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                        SelectCommand="s_Comments_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                            <asp:SessionParameter Name="ViewerEmpID" Type="String" SessionField="EMPID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>

                <div class="hidden-print" style="display: table; margin: 15px 0; min-width: 200px">
                    <h5>Attachments</h5>
                    <div class="">
                        <div class="pointer attachmentAdd bold">
                            <asp:LinkButton runat="server" ID="cmdAddAttach" CausesValidation="false" OnClick="cmdAddAttach_Click">
                            <img src="Images/add-files.png" width="20px" />Add Files</asp:LinkButton>
                        </div>

                        <div style="padding: 5px">
                            <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px" Font-Bold="False"
                                Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Image runat="server" CssClass="AttachmentThumb" ClientIDMode="Predictable"
                                        LoadImg='<%# getLinkImage(Eval("AID"), Eval("FileID"), Eval("Extension")) %>'
                                        ImageUrl="~/Images/Loading.gif" ID="ImageThumb1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                    <asp:Panel ID="AttachmentMenu" ClientIDMode="Predictable" runat="server" BorderColor="Gray" BorderWidth="1px"
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
                                            <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server"
                                                NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
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
                                            ConfirmText="Are you sure you want to Delete?" Enabled="True"
                                            TargetControlID="cmdDeleteAttachment"></asp:ConfirmButtonExtender>
                                    </asp:Panel>
                                    <asp:HoverMenuExtender ID="ImageThumb1_HoverMenuExtender" runat="server"
                                        Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="ImageThumb1"
                                        OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                    </asp:HoverMenuExtender>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:SqlDataSource ID="SqlDataSourceAttachments" runat="server"
                                ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                SelectCommand="SELECT * FROM v_Attachments_Browse WHERE (SessionID = @SessionID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HidPageID" Name="SessionID" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>

                <asp:TabContainer runat="server" ID="tabContainer" CssClass="hidden-print" 
                    OnDemand="true"  UseVerticalStripPlacement="false"
                    ActiveTabIndex="0" Width="700px" CssTheme="XP" >
                    <asp:TabPanel runat="server" ID="tab1" >
                        <HeaderTemplate>
                            Reply to Requester
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">

                                    <asp:TextBox ID="txtCommentDtl" MaxLength="1000" TextMode="MultiLine" Rows="4" runat="server"
                                        Style="width: 550px;" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPostReply" ControlToValidate="txtCommentDtl"
                                        ValidationGroup="grpticketStatus" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>

                                </div>
                                <div style="margin-top: 7px;" class="form-group">
                                    Ticket Status: &nbsp;&nbsp;
                <asp:DropDownList ID="ddlStatusType" runat="server" AppendDataBoundItems="True" DataTextField="StatusName"
                    DataValueField="StatusID" DataSourceID="SqlDataSourceTicketStatus" CssClass="form-control">
                    <asp:ListItem Value="" Text="Select"></asp:ListItem>
                </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlStatusType"
                                        ValidationGroup="grpticketStatus" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSourceTicketStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                        SelectCommand="s_TicketStatusBranchWise" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="id" Name="TicketID" />
                                            <asp:SessionParameter Name="ViewerEmpID" Type="String" SessionField="EMPID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group" style="margin-left: 20px; margin-top: 20px;">
                                    <asp:CheckBox ID="chkPrivate" runat="server" Text="Make it private" ToolTip="Private comments will be visible by me and requester only." />

                                </div>
                            </div>
                            <div style="margin-top: 7px;" class="form-group">
                                <asp:Button ID="btnPostReply" runat="server" Text="Post Reply" ValidationGroup="grpticketStatus"
                                    OnClick="btnPostReply_Click" CssClass="btn btn-default" />
                                <asp:ConfirmButtonExtender ID="cmdDeleteAttachment_ConfirmButtonExtender" runat="server"
                                    ConfirmText="Do you want to Post the information?" Enabled="True"
                                    TargetControlID="btnPostReply"></asp:ConfirmButtonExtender>
                            </div>

                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel runat="server" ID="tab2" Visible="false">
                        <HeaderTemplate>
                            Internal Note/Comment
                        </HeaderTemplate>
                        <ContentTemplate>
                            <p>
                                This option is only available at Head Office. And this comment will be visible only from my department. 
                            
                            </p>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="txtCommentInternal" MaxLength="1000" TextMode="MultiLine" Rows="4" CssClass="form-control"
                                        runat="server" Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorInternalNote" ControlToValidate="txtCommentInternal"
                                        ValidationGroup="grpInternalNote" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <div style="margin-top: 7px;" class="form-group">
                                    <asp:Button ID="btnSubmitInternal" runat="server" CssClass="btn" Text="Post Internal Note" ValidationGroup="grpInternalNote"
                                        OnClick="btnSubmitInternal_Click" />
                                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender_SubmitInternal" runat="server"
                                        ConfirmText="Do you want to Post the information?" Enabled="True"
                                        TargetControlID="btnSubmitInternal"></asp:ConfirmButtonExtender>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel runat="server" ID="tab3" Visible="false">
                        <HeaderTemplate>
                            Assign Dept/Team
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">

                                    <link href="jstree/themes/default/style.css" rel="stylesheet" type="text/css" />
                                    <ul id="team-assign">
                                    </ul>
                                    <asp:HiddenField ID="hidAssignedTeamID" runat="server" ClientIDMode="Static" />
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="txtCommentTransfer" MaxLength="1000" TextMode="MultiLine" Rows="4"
                                        runat="server" Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTransferTeam" ControlToValidate="txtCommentTransfer"
                                        ValidationGroup="grpTransferTeam" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="btnTransfer" runat="server" ValidationGroup="grpTransferTeam" Text="Transfer Team"
                                        OnClick="btnTransfer_Click" />
                                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender_Transfer" runat="server"
                                        ConfirmText="Do you want to Post the information?" Enabled="True"
                                        TargetControlID="btnTransfer"></asp:ConfirmButtonExtender>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel runat="server" ID="tab5" Visible="true">
                        <HeaderTemplate>
                            Assign to Branch/Dept
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlBranch" runat="server" AppendDataBoundItems="True" DataTextField="BranchName" CssClass="multi"
                                        DataValueField="BranchID" DataSourceID="SqlDataSourceBranch" AutoPostBack="True" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged">
                                        <asp:ListItem Text="Select Branch" Value="-3"></asp:ListItem>
                                        <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="ddlBranch"
                                        ValidationGroup="grpCommentBranch" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT BranchID, BranchName FROM [ViewBranchOnly] order by BranchName"></asp:SqlDataSource>


                                    <asp:DropDownList ID="ddlDept" runat="server" AppendDataBoundItems="True" DataTextField="Department" CssClass="multi"
                                        DataValueField="DeptID" DataSourceID="SqlDataSourceDept">
                                        <asp:ListItem Text="Select Department"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="ddlDept"
                                        ValidationGroup="grpCommentBranch" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>

                                    <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                        SelectCommand="s_Emp_Dept_All" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlBranch" Name="BranchID" Type="Int32" PropertyName="SelectedValue" />
                                        </SelectParameters>

                                    </asp:SqlDataSource>
                                    <span id="cmdViewEmp" class="link" style="cursor: pointer">View Employees</span>
                                </div>
                            </div>
                            <div class="form-inline">
                                <div style="margin: 7px 0 0 0;" class="form-group">
                                    <asp:TextBox ID="txtCommentBranch" MaxLength="1000" TextMode="MultiLine" Rows="4" CssClass="form-control"
                                        runat="server" Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtCommentBranch"
                                        ValidationGroup="grpCommentBranch" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>

                            </div>
                            <div style="margin: 7px 0 0 0;" class="form-group">
                                <asp:Button ID="btnSendtoBranch" runat="server" CssClass="btn" Text="Assign to Branch/Dept" ValidationGroup="grpCommentBranch" OnClick="btnSendtoBranch_Click" />
                                <asp:ConfirmButtonExtender ID="ConfirmButtonExtender_SendtoBranch" runat="server"
                                    ConfirmText="Do you want to Post the information?"
                                    TargetControlID="btnSendtoBranch" BehaviorID="_content_ConfirmButtonExtender_SendtoBranch"></asp:ConfirmButtonExtender>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel runat="server" ID="tab4" Visible="true">
                        <HeaderTemplate>
                            Assign to Emp
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="txtEmployee" runat="server" CssClass="empid-pick form-control" Width="80px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmp" ControlToValidate="txtEmployee"
                                        ValidationGroup="grpCommentAssign" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <div style="clear: left"></div>
                                <div style="margin-top: 7px;" class="form-group">
                                    <asp:TextBox ID="txtCommentAssign" MaxLength="1000" TextMode="MultiLine" Rows="4" CssClass="form-control"
                                        runat="server" Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAssignEmp" ControlToValidate="txtCommentAssign"
                                        ValidationGroup="grpCommentAssign" SetFocusOnError="True" runat="server" ForeColor="Red"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <div style="clear: left"></div>
                                <div style="margin-top: 7px;" class="form-group">
                                    <asp:Button ID="btnAssign" runat="server" CssClass="btn" Text="Assign to Emp" ValidationGroup="grpCommentAssign"
                                        OnClick="btnAssign_Click" />
                                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender_AssignEmp" runat="server"
                                        ConfirmText="Do you want to Post the information?" Enabled="True"
                                        TargetControlID="btnAssign"></asp:ConfirmButtonExtender>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>

                </asp:TabContainer>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                    SelectCommand="s_Flora_Delete_Trn_Select" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtTicketID" Name="TicketID" PropertyName="Text" />
                        <asp:SessionParameter SessionField="EMPID" Name="EMPID" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
            </asp:Panel>
            <span style="visibility: hidden">
                <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
            </span>

            <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                PopupDragHandleControlID="ModalTitle1" BackgroundCssClass="ModalPopupBG"
                RepositionMode="RepositionOnWindowResizeAndScroll">
            </asp:ModalPopupExtender>

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
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cmdAddAttach" />
            <asp:AsyncPostBackTrigger ControlID="cmdPost" />
        </Triggers>
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
