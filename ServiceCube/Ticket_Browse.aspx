<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" EnableViewState="false"
    CodeFile="Ticket_Browse.aspx.cs" Inherits="Ticket_Browse" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    Browse Tickets
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    For searching and monitoring
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>

            <div class="box box-tbl">
                <div class="box-body">
                    <div class="form-inline">
                        <asp:TextBox ID="txtFilter" runat="server" CssClass="form-control" Width="200px" Watermark="Enter text to filter"></asp:TextBox>
                        <div class="form-group">
                            <label>Create Date</label>
                            <asp:TextBox ID="txtDateFrom" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                            <label>
                                to
                            </label>
                            <asp:TextBox ID="txtDateTo" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>
                                Status
                            </label>
                            <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" 
                                DataSourceID="SqlDataSourceStatus"
                                DataTextField="StatusName" DataValueField="StatusID" AutoPostBack="True"
                                CausesValidation="false" CssClass="multi">
                                <asp:ListItem Text="Open (Pending), On Process" Value="-2"></asp:ListItem>
                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                EnableCaching="false" CacheDuration="600" SelectCommand="SELECT StatusID, StatusName FROM [ServiceCube].[dbo].[Ticket_Status]"></asp:SqlDataSource>
                        </div>
                        <div class="form-group">
                            <label>
                                Type
                            </label>

                            <asp:DropDownList ID="ddlReqFrom" runat="server" AppendDataBoundItems="True"
                                DataTextField="ReqName" DataValueField="ReqID" AutoPostBack="True" CssClass="form-control"
                                CausesValidation="false" OnSelectedIndexChanged="ddlReqFrom_SelectedIndexChanged">
                                <asp:ListItem Text="All" Value="*"></asp:ListItem>
                                <asp:ListItem Text="Internal" Value="I"></asp:ListItem>
                                <asp:ListItem Text="Public" Value="P"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label>
                                Ticket Type
                            </label>
                            <asp:DropDownList ID="ddlTicketType" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceTicketType"
                                DataTextField="Name" DataValueField="ID" AutoPostBack="True" CssClass="multi">
                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTicketType" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                SelectCommand="s_Ticket_Type" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlReqFrom" PropertyName="SelectedValue" Name="Type" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" CausesValidation="false" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="box">
                        <div class="box-header with-border">
                            <span class="box-title">Requested From</span>
                        </div>
                        <div class="box-body">
                            <div class="form-inline">
                                <div class="form-group">

                                    <label>Branch</label>


                                    <asp:DropDownList ID="ddlReqBranch" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceReqBranch"
                                        DataTextField="BranchName" DataValueField="BranchID" AutoPostBack="True" OnSelectedIndexChanged="ddlSDBranch_SelectedIndexChanged"
                                        CssClass="multi">
                                        <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:SqlDataSource ID="SqlDataSourceReqBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT [BranchID], [BranchName] FROM [Branch] ORDER BY [BranchName]"></asp:SqlDataSource>

                                </div>
                                <div class="form-group">
                                    <label>
                                        Department</label>


                                    <asp:DropDownList ID="ddlReqDept" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceReqDept"
                                        DataTextField="Department" DataValueField="DeptID" Visible="true"
                                        AutoPostBack="True" CssClass="multi">
                                        <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceReqDept" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT [DeptID], [Department] FROM [ViewDept] WHERE ([Department] <> '' and ShowInHeadOffice = 1) ORDER BY [Department]"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <label>
                                        From Emp</label>

                                    <asp:TextBox ID="txtFromEmployee" runat="server" CssClass="empid-pick form-control" Width="60px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="box">
                        <div class="box-header with-border">
                            <span class="box-title">Assigned To</span>
                        </div>
                        <div class="box-body">
                            <div class="form-inline">
                                <div class="form-group">
                                    <label>Branch</label>


                                    <asp:DropDownList ID="ddlAssignBranch" runat="server" AppendDataBoundItems="True" DataTextField="BranchName" AutoPostBack="True" CausesValidation="false"
                                        DataValueField="BranchID" DataSourceID="SqlDataSourceBranch" OnSelectedIndexChanged="ddlAssignBranch_SelectedIndexChanged" CssClass="multi">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                        SelectCommand="s_AssignBranch_Emp" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="EmpID" Type="String" SessionField="EMPID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <label>
                                        Dept/Team</label>
                                    <asp:DropDownList ID="ddlAssignDept" runat="server" AppendDataBoundItems="true"
                                        DataSourceID="SqlDataSourceAssignDest" CssClass="multi"
                                        DataTextField="Department" DataValueField="DeptID" Visible="true"
                                        AutoPostBack="True">
                                        <asp:ListItem Text="ALL" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceAssignDest" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                        SelectCommandType="StoredProcedure"
                                        SelectCommand="s_AssignDept_BranchWise">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="EmpID" Type="String" SessionField="EMPID" />
                                            <asp:ControlParameter Name="BranchID" Type="Int32" ControlID="ddlAssignBranch" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>

                                <asp:Panel ID="PanelToEmp" runat="server" CssClass="form-group">
                                    <label>To Emp</label>
                                    <asp:TextBox ID="txtEmployee" runat="server" CssClass="empid-pick form-control" Width="60px"></asp:TextBox>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>


                </div>
            </div>

            <asp:GridView ID="gv1" runat="server" DataKeyNames="TicketID" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourceTicketBrowse" CssClass="Grid" BorderStyle="None" BackColor="White"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                PageSize="10" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="" SortExpression="isPublic">
                        <ItemTemplate>
                            <img src='Images/<%# Eval("isPublic").ToString() == "True" ? "globe.png" : "TBL3.png" %>' width="20" title='<%# Eval("Type") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request ID" SortExpression="TicketID">
                        <ItemTemplate>
                            <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' title="View Ticket" target="_blank">
                                <%# Eval("TicketID")%>
                            </a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Ticket Type" DataField="Name" SortExpression="Name" ItemStyle-Wrap="false">
                        <ItemStyle Wrap="true" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Subject" DataField="Subject" SortExpression="Subject"
                        ItemStyle-Wrap="true">
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Priority" DataField="PriorityName" SortExpression="PriorityName"
                        ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Status" SortExpression="StatusName">
                        <ItemTemplate>
                            <%# Eval("StatusName")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Create by" SortExpression="CreatedBy">
                        <ItemTemplate>
                            <span class="trustclick" type="emp" val='<%# Eval("CreatedBy") %>'><%# Eval("CreatedBy") %></span>
                            <%# Eval("Email")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Request On" SortExpression="CreatedDT">
                        <ItemTemplate>
                            <div title='<%# Eval("CreatedDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("CreatedDT"))%><br />
                                <time class="timeago" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle ForeColor="Gray" />
                    </asp:TemplateField>

                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#CCCC99" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>

            <br />
            <asp:Literal ID="lblStatus" runat="server" Text=""></asp:Literal>

            <asp:SqlDataSource ID="SqlDataSourceTicketBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="s_Ticket_Browse_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceTicketBrowse_Selected">
                <SelectParameters>

                    <asp:SessionParameter Name="EmpID" Type="String" SessionField="EMPID" />
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="255" />
                    <asp:ControlParameter ControlID="ddlStatus" Name="ReqStatus" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="ddlReqFrom" Name="Type" PropertyName="SelectedValue"
                        DefaultValue="*" Type="String" />
                    <asp:ControlParameter ControlID="ddlTicketType" Name="TicketType" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />

                    <asp:ControlParameter ControlID="ddlReqBranch" Name="ReqBranch" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlReqDept" Name="ReqDept" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlAssignBranch" Name="AssignBranch" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlAssignDept" Name="AssignDept" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:ControlParameter ControlID="txtEmployee" Name="AssignEmp" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="20" />
                    <asp:ControlParameter ControlID="txtFromEmployee" Name="ReqEmp" PropertyName="Text" Type="String"
                        DefaultValue="*" Size="20" />

                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" 
        AssociatedUpdatePanelID="UpdatePanel1"
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
