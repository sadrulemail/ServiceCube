<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" CodeFile="Call_Comments.aspx.cs" Inherits="Call_Comments" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    Call Comment/Follow up Search
    <style type="text/css">
        .high {
            font-weight: bolder;
            color: white;
            border-radius: 4px;
            padding: 3px 7px;
            background: red;
            box-shadow: -1px -1px 1px rgba(0,0,0,.2);
        }

        .low {
            font-weight: bolder;
            color: white;
            border-radius: 4px;
            padding: 3px 7px;
            background: green;
            box-shadow: -1px -1px 1px rgba(0,0,0,.2);
        }

        .notset {
            font-weight: bolder;
            color: white;
            border-radius: 4px;
            padding: 3px 7px;
            background: Gray;
            box-shadow: -1px -1px 1px rgba(0,0,0,.2);
        }

        .showall {
            font-weight: bolder;
            color: black;
            border-radius: 4px;
            padding: 3px 7px;
            background: yellow;
            box-shadow: -1px -1px 1px rgba(0,0,0,.2);
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphTitle" runat="Server">
    Call Comments/Follow up Search
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="box box-tbl">
                <div class="form-inline">
                    <div class="form-group">
                        <asp:TextBox ID="txtFilter" runat="server" CssClass="form-control" placeholder="enter text to filter" Width="200px"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtContractNo" CssClass="form-control" runat="server" placeholder="contact no" Width="120px" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtEmpID" CssClass="form-control empid-pick" runat="server" placeholder="emp id" Width="60px" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Date:</label>
                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date form-control" Width="80px" AutoPostBack="true"></asp:TextBox>
                        <label>to:</label>
                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date form-control" Width="80px"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Status:</label>
                        <asp:DropDownList runat="server" ID="cboStatusName"
                            AppendDataBoundItems="true" CssClass="form-control"
                            AutoPostBack="true"
                            DataSourceID="SqlDataSourceStatusName"
                            DataTextField="StatusName" DataValueField="StatusID">
                            <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Status_Types" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <div class="form-group">
                        <label>Top:</label>
                        <asp:DropDownList runat="server" ID="cboTop"
                            CssClass="form-control"
                            AutoPostBack="true">
                            <asp:ListItem Text="500" Value="500"></asp:ListItem>
                            <asp:ListItem Text="1 k" Value="1000"></asp:ListItem>
                            <asp:ListItem Text="5 k" Value="5000"></asp:ListItem>
                            <asp:ListItem Text="10 k" Value="10000"></asp:ListItem>
                            <asp:ListItem Text="50 k" Value="50000"></asp:ListItem>
                            <asp:ListItem Text="1 lac" Value="100000"></asp:ListItem>
                            <asp:ListItem Text="10 lac" Value="1000000"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="cmdOK" CssClass="btn" runat="server" OnClick="Button1_Click" Text="Show" CausesValidation="false"
                            Width="80px" />
                    </div>
                </div>
            </div>
            <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="Small"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#6B696B" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" PageSize="10" Style="font-size: small" CssClass="Grid" PagerSettings-Position="TopAndBottom" DataKeyNames="CallerID">
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField HeaderText="Customer" SortExpression="Comments">
                        <ItemTemplate>
                           
                            <div title='<%# Eval("CallCommentsID") %>'><%# Eval("Comments") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="StatusName" HeaderText="Comment Status" SortExpression="StatusName" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bold" />
                    

                    <asp:TemplateField HeaderText="Insert DT" SortExpression="InsertDT">
                        <ItemTemplate>
                            <div title='<%# Eval("InsertDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("InsertDT"))%><div>
                                    <time class="timeago time-small-gray" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                            </div>
                            By:
                               <span class="trustclick" type="emp" val='<%# Eval("InsertBY") %>'>
                                   <%# Eval("InsertBY") %></span>
                        </ItemTemplate>
                        <ItemStyle Wrap="false" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Customer Info" SortExpression="CustomerName">
                        <ItemTemplate>
                            <div class="bold"><a href='Call_New.aspx?ph=<%# Eval("ContractNo") %>' target="_blank" title="Details"><%# Eval("ContractNo") %></a></div>
                            <%# Eval("CustomerName","<div class='bold'>{0}</div>") %>
                        </ItemTemplate>
                    </asp:TemplateField>


                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <EmptyDataRowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
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

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
        SelectCommand="s_Call_Comments" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:ServiceCubeConnectionString.ProviderName %>"
        OnSelecting="SqlDataSource1_Selecting" OnSelected="SqlDataSource1_Selected1">
        <%--onselected="SqlDataSourceKYC_Selected">--%>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtContractNo" Name="ContractNo" PropertyName="Text"
                Type="String" DefaultValue="*" />
            <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text"
                Type="String" DefaultValue="*" />
            <asp:ControlParameter ControlID="cboStatusName" Name="StatusID" PropertyName="SelectedValue"
                Type="Int16" DefaultValue="-1" />

            <asp:ControlParameter ControlID="txtDateFrom" DbType="Date" Name="DateFrom" PropertyName="Text"
                DefaultValue="01/01/1900" />
            <asp:ControlParameter ControlID="txtDateTo" DbType="Date" Name="DateTo" PropertyName="Text"
                DefaultValue="01/01/1900" />
            <asp:ControlParameter ControlID="cboTop" Name="Top" PropertyName="SelectedValue"
                Type="Int16" DefaultValue="500" />
            <asp:ControlParameter ControlID="txtEmpID" Name="EMPID" Type="String" DefaultValue="*" />
            <%--<asp:SessionParameter SessionField="BRANCHID" Name="BranchID" Type="Int32" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
