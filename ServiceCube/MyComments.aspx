﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" 
    CodeFile="MyComments.aspx.cs" Inherits="MyComments" EnableViewState="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    My Comments
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    Comments posted by me
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel runat="server" ID="panelAddItem">
                <div class="box">
                    <div class="box-body">
                        <div class="form-inline">
                            <asp:TextBox ID="txtFilter" CssClass="form-control" runat="server" Width="200px" Watermark="Enter text to filter"></asp:TextBox>
                            <div class="form-group">
                                <label>Comment Date</label>
                                <asp:TextBox ID="txtDateFrom" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                    Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>to</label>
                                <asp:TextBox ID="txtDateTo" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                    Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Status</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus" CssClass="multi"
                                    DataTextField="StatusName" DataValueField="StatusID" AutoPostBack="True"
                                    CausesValidation="false">
                                    <%--<asp:ListItem Text="Open (Pending), On Process" Value="-2"></asp:ListItem>--%>
                                    <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    EnableCaching="false" CacheDuration="600" SelectCommand="SELECT StatusID, StatusName FROM [ServiceCube].[dbo].[Ticket_Status]"></asp:SqlDataSource>
                            </div>
                            <div class="form-group">
                                <label>Type</label>
                                <asp:DropDownList ID="ddlReqFrom" runat="server" AppendDataBoundItems="True" CssClass=""
                                    DataTextField="ReqName" DataValueField="ReqID" AutoPostBack="True"
                                    CausesValidation="false" OnSelectedIndexChanged="ddlReqFrom_SelectedIndexChanged">
                                    <asp:ListItem Text="All" Value="*"></asp:ListItem>
                                    <asp:ListItem Text="Internal" Value="I"></asp:ListItem>
                                    <asp:ListItem Text="Public" Value="P"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label>Ticket Type</label>

                                <asp:DropDownList ID="ddlTicketType" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceTicketType" CssClass="multi"
                                    DataTextField="Name" DataValueField="ID" AutoPostBack="True">
                                    <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SqlDataSourceTicketType" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    SelectCommand="s_Ticket_Type" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlReqFrom" PropertyName="SelectedValue" Name="Type" />
                                    </SelectParameters>

                                </asp:SqlDataSource>
                            </div>

                            <div class="form-group">
                                <label>Comment Type</label>
                                <asp:DropDownList ID="ddlCommentType" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceCommentType" CssClass="multi"
                                    DataTextField="TypeName" DataValueField="CommentType" AutoPostBack="True"
                                    CausesValidation="false">
                                    <%--     <asp:ListItem Text="Open (Pending), On Process" Value="-2"></asp:ListItem>--%>
                                    <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceCommentType" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                    EnableCaching="false" CacheDuration="600" SelectCommand="SELECT CommentType, TypeName FROM [ServiceCube].[dbo].[Comment_Types]"></asp:SqlDataSource>
                            </div>
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" Width="70px" CausesValidation="false" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>

            </asp:Panel>
            <asp:GridView ID="grdvComment" runat="server" DataKeyNames="CID" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourceComments" CssClass="Grid" BorderStyle="None" BackColor="White"
                ShowHeader="true" AllowPaging="true" AllowSorting="true" Width="100%" 
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                OnRowDataBound="grdvComment_RowDataBound" PagerSettings-PageButtonCount="30"
                PagerSettings-Position="TopAndBottom" PagerSettings-Mode="NumericFirstLast">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="" SortExpression="isPublic">
                        <ItemTemplate>
                            <img src='Images/<%# Eval("isPublic").ToString() == "True" ? "Globe.png" : "TBL3.png" %>' width="20" title='<%# Eval("Type") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request ID" SortExpression="TicketID">
                        <ItemTemplate>
                            <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' title="View Ticket" target="_blank">
                                <%# Eval("TicketID")%></a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Ticket Type" DataField="Name" SortExpression="Name" ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Current Status" SortExpression="StatusName">
                        <ItemTemplate>
                            <%# Eval("StatusName")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Ticket Subject" DataField="Subject" SortExpression="Subject"></asp:BoundField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <img src='Images/<%# Eval("icon")%>' height="24" width="24" border="0" title='<%# Eval("TypeName") %>' />
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comment" SortExpression="Comment">
                        <ItemTemplate>
                            <div class='<%# (Eval("AssignStaff").ToString() == "" ? "hidden" : "")  %> assign-emp bold'>
                                Assigned to:
                                        <span class="trustclick" type="emp" val='<%# Eval("AssignStaff") %>'><%# Eval("AssignStaff") %></span>
                            </div>

                            <%# (Eval("AssignBranchName", "<div class='assignbranch bold'>Assigned to: {0}</div>"))%>
                            <%# (Eval("AssignDeptName", "<div class='assign-team bold'>Assigned to: {0}</div>"))%>
                            <div class='text-bold' title='CID:<%# Eval("CID") %>'>
                                <%# Eval("Comment").ToString().Replace("\n","<br />") %>
                            </div>
                            <asp:Literal ID="litAttach" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comment on" SortExpression="DT">
                        <ItemTemplate>
                            <div title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime( Eval("DT")) %><br />
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <div>
                                By:
                                        
                                        <span class="trustclick" type="emp" val='<%# Eval("EmpID") %>'><%# Eval("EmpID") %></span>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Wrap="false" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#CCCC99" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="s_Ticket_Comments" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
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
                    <asp:ControlParameter ControlID="ddlCommentType" Name="CommentType" PropertyName="SelectedValue"
                        DefaultValue="-1" Type="Int32" />
                    <asp:Parameter DefaultValue="-2" Name="CommentPostedDept"
                        Type="String" />
                    <asp:SessionParameter Name="ViewerEmpBranchID" SessionField="BRANCHID" />
                </SelectParameters>
            </asp:SqlDataSource>


            <br />
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            <%--    </asp:Panel>--%>
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
