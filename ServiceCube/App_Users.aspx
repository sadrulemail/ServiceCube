<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true"
    CodeFile="App_Users.aspx.cs" Inherits="App_Users" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    App Users
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidAppCode" runat="server" />
            <asp:TabContainer runat="server" ID="TabContainer1" CssClass="NewsTab" ActiveTabIndex="0" OnDemand="true">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        User List
                    </HeaderTemplate>
                    <ContentTemplate>
                        <div class="box box-tbl">
                            <div class="form-inline">
                                <div class="form-group">
                                    <label>Branch:</label>

                                    <asp:DropDownList ID="dboBranch" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control"
                                        DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID">
                                        <asp:ListItem Value="-1" Text="All Branch"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranchOnly] ORDER BY [BranchName]"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <label>Department:</label>


                                    <asp:DropDownList ID="dboDept" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control"
                                        DataSourceID="SqlDataSourceDept" DataTextField="Department" DataValueField="DeptID">
                                        <asp:ListItem Value="-1" Text="All Department"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceDept" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT DeptID, Department FROM dbo.ViewDept order by Department"></asp:SqlDataSource>
                                </div>
                                <div class="form-group">
                                    <label>Status:</label>


                                    <asp:DropDownList ID="dboActive" runat="server" CssClass="form-control" AutoPostBack="True"> 
                                        <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                        <asp:ListItem Text="Not Active" Value="N"></asp:ListItem>
                                        <asp:ListItem Text="All" Value="*"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="3" PageSize="20"
                            DataSourceID="SqlDataSourceUsers" AllowPaging="True" AllowSorting="True" CssClass="Grid"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                            ForeColor="Black" GridLines="Vertical">
                            <RowStyle VerticalAlign="Top" BackColor="#F7F7DE" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:HyperLinkField HeaderText="Emp ID" SortExpression="EmpID" DataTextField="EmpID" Target="_blank"
                                    DataNavigateUrlFormatString="../Profile.aspx?id={0}" DataNavigateUrlFields="EmpID">
                                    <ItemStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" />
                                </asp:HyperLinkField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <a href='../Profile.aspx?id=<%# Eval("Empid") %>' target="_blank">
                                            <img src='<%# "EmpImage.aspx?EMPID=" + Eval("EMPID") %>&W=100&H=100&imgid=<%# Eval("ImageIdentifier") %>'
                                                height="35" width="35" border="0" /></a>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="User Information">
                                    <ItemTemplate>
                                        <div style="font-weight: bold"><%# Eval("EmpName") %></div>
                                        <div style="color: Gray"><%# Eval("DesigName")%></div>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Branch" SortExpression="BranchName">
                                    <ItemTemplate>
                                        <%# Eval("BranchName") %>
                                        <div style="color: Gray"><%# Eval("Department") %></div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Roles" SortExpression="Roles">
                                    <ItemTemplate>
                                        <%# Eval("Roles").ToString().Replace(",", "<br />") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Active" SortExpression="Active">
                                    <ItemTemplate>
                                        <%# (Eval("Status").ToString() == "True" ? "<img src='Images/tick.png' width='20px' height='20px' />" : "") %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="By" SortExpression="ByEmp">
                                    <ItemTemplate>
                                          <span class="trustclick" type="emp" val='<%# Eval("ByEmp") %>'>
                                               <%# Eval("ByEmp") %></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="On" SortExpression="LastInsert">
                                    <ItemTemplate>
                                        <div title='<%# Eval("LastInsert","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime( Eval("LastInsert")) %><br />
                                            <span class="time-small">
                                                <%# TrustControl1.ToRelativeDate(Eval("LastInsert")) %></span>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataRowStyle BackColor="Black" BorderStyle="None" ForeColor="White" />
                            <EmptyDataTemplate>
                                No Data Found.
                            </EmptyDataTemplate>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                            <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                            SelectCommand="usp_UserRole_Show" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceUsers_Selected">
                            <SelectParameters>
                                <asp:ControlParameter Name="AppID" ControlID="hidAppCode" PropertyName="Value" />
                                <asp:ControlParameter ControlID="dboBranch" PropertyName="SelectedValue" Name="BranchID" />
                                <asp:ControlParameter ControlID="dboDept" PropertyName="SelectedValue" Name="DeptID" />
                                <asp:ControlParameter ControlID="dboActive" PropertyName="SelectedValue" Name="Active"
                                    DefaultValue="*" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:Label ID="lblStatus" runat="server" Text="text" CssClass="SmallFont"></asp:Label>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        Summary
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td class="Button">Empty Branches:
                                </td>
                                <td style="width: 20px"></td>
                                <td class="Button">Branchwise Active Users:
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:GridView ID="GridViewEmptyBranches" runat="server" AutoGenerateColumns="False"
                                        BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                                        CellPadding="2" DataSourceID="SqlDataSourceEmptyBranches" GridLines="Vertical"
                                        Style="font-size: small;" AllowSorting="True" ForeColor="Black" CssClass="Grid">
                                        <RowStyle BackColor="#F7F7DE" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="BranchID" HeaderText="Branch ID" SortExpression="BranchID">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BranchName" HeaderText="Branch Name" SortExpression="BranchName">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                        </Columns>
                                        <EmptyDataRowStyle BackColor="Black" BorderStyle="None" ForeColor="White" />
                                        <EmptyDataTemplate>
                                            No Data Found.
                                        </EmptyDataTemplate>
                                        <FooterStyle BackColor="#CCCC99" />
                                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" CssClass="AlignCenter" />
                                    </asp:GridView>
                                    <br />
                                    <asp:Label ID="lblEmptyBranch" runat="server" Font-Size="Small"></asp:Label><br />

                                    <asp:SqlDataSource ID="SqlDataSourceEmptyBranches" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="App_Empty_Branch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceUsers1_Selected">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="AppID" ControlID="hidAppCode" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td></td>
                                <td valign="top">
                                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="2" DataSourceID="SqlDataSourceApp_Branchwise_Emp_Count"
                                        GridLines="Vertical" Style="font-size: small;" AllowSorting="True" ForeColor="Black"
                                        CssClass="Grid" OnRowCommand="GridView4_RowCommand">
                                        <RowStyle BackColor="#F7F7DE" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>
                                            <asp:BoundField DataField="BranchID" HeaderText="Branch ID" SortExpression="BranchID">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" CommandName="SelectBranch" CommandArgument='<%# Eval("BranchID") %>'
                                                        CausesValidation="false" Text='<%# Eval("BranchName") %>'> </asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Total" HeaderText="Active Users" SortExpression="Total">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <EmptyDataRowStyle BackColor="Black" BorderStyle="None" ForeColor="White" />
                                        <EmptyDataTemplate>
                                            No Data Found.
                                        </EmptyDataTemplate>
                                        <FooterStyle BackColor="#CCCC99" />
                                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" CssClass="AlignCenter" />
                                    </asp:GridView>
                                    <br />
                                    <asp:Label ID="lblApp_Branchwise_Emp_Count" runat="server" Font-Size="Small"></asp:Label><br />

                                    <asp:SqlDataSource ID="SqlDataSourceApp_Branchwise_Emp_Count" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="App_Branchwise_Emp_Count" SelectCommandType="StoredProcedure"
                                        OnSelected="SqlDataSourceApp_Branchwise_Emp_Count_Selected">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="AppID" ControlID="hidAppCode" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
