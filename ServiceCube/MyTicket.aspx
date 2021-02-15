﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" 
    CodeFile="MyTicket.aspx.cs" Inherits="MyTicket" EnableViewState="false" %>

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
    </style>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
   My Tickets
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
    My submitted ticket list
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <div class="box box-tbl">
                <div class="box-body">
                    <div class="form-inline">
                        <asp:TextBox ID="txtFilter" runat="server" Width="250px" CssClass="form-control" Watermark="Enter text to filter"></asp:TextBox>
                        <div class="form-group">

                            <label>Create Date</label>
                            <asp:TextBox ID="txtDateFrom" runat="server" Width="85px" CssClass="Watermark Date form-control"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>to</label>

                            <asp:TextBox ID="txtDateTo" runat="server" Width="85px" CssClass="Watermark Date form-control"
                                Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Ticket Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceStatus" CssClass="multi"
                                DataTextField="StatusName" DataValueField="StatusID" AutoPostBack="True"
                                CausesValidation="false">

                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                EnableCaching="true" CacheDuration="600" SelectCommand="SELECT StatusID, StatusName FROM [ServiceCube].[dbo].[Ticket_Status]"></asp:SqlDataSource>
                        </div>
                       
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" Width="70px" CausesValidation="false" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <div>
                <asp:GridView ID="grdvTicketList" runat="server" DataKeyNames="TicketID" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSourceTicketBrowse" CssClass="Grid" BorderStyle="None" BackColor="White"
                    BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                    AllowPaging="True" AllowSorting="true" PagerSettings-Position="TopAndBottom"
                    PageSize="10" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>


                        <asp:TemplateField HeaderText="Request ID" SortExpression="TicketID">
                            <ItemTemplate>
                                <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' title="View Ticket" target="_blank">
                                    <%# Eval("TicketID")%></a>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Font-Bold="true" Wrap="false" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Ticket Type" DataField="Name" SortExpression="Name" 
                                ItemStyle-Wrap="true">
                            <ItemStyle Wrap="true" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Subject" DataField="Subject" SortExpression="Subject"
                            ItemStyle-Wrap="true">
                            <ItemStyle Wrap="true" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Priority" DataField="PriorityName" SortExpression="PriorityName"
                            ItemStyle-Wrap="false">
                            <ItemStyle Wrap="false" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Status" SortExpression="StatusName">
                            <ItemTemplate>
                                <%# Eval("StatusName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Create by" SortExpression="CreatedBy">
                            <ItemTemplate>

                                <span class="trustclick" type="emp" val='<%# Eval("CreatedBy") %>'>
                                    <%# Eval("CreatedBy") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Request On" SortExpression="ReqDT">
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
            </div>
            <div style="padding-top:10px">
                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceTicketBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="s_MyCreatedTicket" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceTicketBrowse_Selected">
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
                    <asp:SessionParameter Name="BranchID" Type="String" SessionField="BRANCHID" />
                    <asp:SessionParameter Name="DeptID" Type="String" SessionField="DEPTID" />

                </SelectParameters>
            </asp:SqlDataSource>
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