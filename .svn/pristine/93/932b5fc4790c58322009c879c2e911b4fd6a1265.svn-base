<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" CodeFile="Ticket_Comments_Count.aspx.cs" Inherits="Ticket_Comments_Count" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="Server">
    Ticket Comment Count
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphDescription" runat="Server">
    Ticket Summery
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td>                        
                        <div class="box">
                            <div class="box-body">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <label>Date:</label>
                                        <asp:TextBox ID="txtDateFrom" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                            Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>to</label>
                                        <asp:TextBox ID="txtDateTo" runat="server" Width="85px" CssClass="form-control Watermark Date"
                                            Watermark="dd/mm/yyyy" AutoPostBack="true"></asp:TextBox>
                                    </div>
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" Width="70px" CausesValidation="false" OnClick="btnSearch_Click" />
                                </div>
                            </div>
                        </div>                        
                    </td>
                    <td style="padding-left:10px">
                        <asp:LinkButton ID="cmdPreviousDay" runat="server" OnClick="cmdPreviousDay_Click" Text="" ClientIDMode="AutoID"
                            ToolTip="Previous Day" CssClass="button-round"><img src="Images/Previous.gif" width="32" height="32" border="0" alt="Prev" /></asp:LinkButton>
                        <asp:LinkButton ID="cmdNextDay" runat="server" OnClick="cmdNextDay_Click" ToolTip="Next Day" ClientIDMode="AutoID"
                            CssClass="button-round" Text=""><img src="Images/Next.gif" width="32" height="32" border="0" alt="Next" /></asp:LinkButton>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="grdvComment" runat="server" AutoGenerateColumns="False" ShowFooter="true"
                DataSourceID="SqlDataSourceComments" CssClass="Grid" BorderStyle="None" BackColor="White"
                ShowHeader="true" AllowPaging="false" AllowSorting="true" EnableViewState="true"
                BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                OnRowDataBound="grdvComment_RowDataBound" PagerSettings-PageButtonCount="30" HeaderStyle-HorizontalAlign="Center" 
                PagerSettings-Position="TopAndBottom" PagerSettings-Mode="NumericFirstLast" OnDataBound="grdvComment_DataBound">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href='../Profile.aspx?id=<%# Eval("Empid") %>' target="_blank">
                                <img src='<%# "EmpImage.aspx?EMPID=" + Eval("EMPID") %>&W=100&H=100&imgid=<%# Eval("ImageIdentifier") %>'
                                    height="35" width="35" border="0" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Emp Name" SortExpression="EmpName">
                        <ItemTemplate>
                            <div style="font-weight: bold"><%# Eval("EmpName") %></div>
                            <div style="color: Gray"><%# Eval("DesigName")%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" Wrap="false" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="New Post" SortExpression="New Post">
                        <ItemTemplate>
                            <%# Eval("New Post") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Post Reply" SortExpression="Post Reply">
                        <ItemTemplate>
                            <%# Eval("Post Reply") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Solved Ticket" SortExpression="Solved Ticket">
                        <ItemTemplate>
                            <%# Eval("Solved Ticket") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internal Note" SortExpression="Internal Note">
                        <ItemTemplate>
                            <%# Eval("Internal Note") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Transfer Team" SortExpression="Transfer Team">
                        <ItemTemplate>
                            <%# Eval("Transfer Team") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assign to Emp" SortExpression="Assign to Emp">
                        <ItemTemplate>
                            <%# Eval("Assign to Emp") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Assign to Branch/Dept" SortExpression="Assign to Branch">
                        <ItemTemplate>
                            <%# Eval("Assign to Branch") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="On Process" SortExpression="On Process">
                        <ItemTemplate>
                            <%# Eval("On Process") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Closed (Resolved)" SortExpression="Closed Resolved">
                        <ItemTemplate>
                            <%# Eval("Closed Resolved") %>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" Font-Size="X-Large" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Return to Requester" SortExpression="Return to Requester">
                        <ItemTemplate>
                            <%# Eval("Return to Requester") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Re-Open" SortExpression="Re-Open">
                        <ItemTemplate>
                            <%# Eval("Re-Open") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject" SortExpression="Reject">
                        <ItemTemplate>
                            <%# Eval("Reject") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total" SortExpression="Total">
                        <ItemTemplate>
                            <%# Eval("Total") %>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" Font-Size="X-Large" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    No Data Found.
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" HorizontalAlign="Center" Font-Size="Large" />
                <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                <FooterStyle BackColor="#dddddd" HorizontalAlign="Center" Font-Size="X-Large" Font-Bold="true" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                SelectCommand="s_Comment_Count" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" DefaultValue='01/01/1900'
                        PropertyName="Text" Type="DateTime" />

                    <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
                    <asp:SessionParameter Name="DeptID" SessionField="DEPTID" />
                </SelectParameters>
            </asp:SqlDataSource>


            <br />
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            
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

