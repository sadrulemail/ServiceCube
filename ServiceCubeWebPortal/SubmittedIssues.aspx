<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeBehind="SubmittedIssues.aspx.cs" Inherits="ServiceCube.SubmittedIssues" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="UserControl.ascx" TagName="UserControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CpTitle" runat="server">
    Submitted Issues
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CpBody" runat="server">
    <uc1:UserControl ID="UserControl1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" EnableViewState="false"
                DataSourceID="SqlDataSource1" GridLines="None" PageSize="30"
                CssClass="table table-responsive table-condensed table-bordered table-hover table-striped search-result-grid"
                AllowPaging="True" AllowSorting="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="TopAndBottom">

                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="bold"><%# Eval("Name")%></div>
                            <div><%# Eval("Subject")%></div>

                            <div title='<%# Eval("CreatedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                Submitted on: <%# UserControl1.ToRecentDateTime(Eval("CreatedDT"))%>
                                <div class="">
                                    <time class="timeago time-small-gray" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                            </div>
                            <div>Priority: <%# Eval("PriorityName")%></div>
                            <div class="bold">Status: <%# Eval("StatusName")%></div>
                            <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' target="_blank" class="bold btn btn-block btn-default">View Details</a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" CssClass="visible-xs" />
                        <HeaderStyle CssClass="hidden" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Type & Subject" SortExpression="Name">
                        <ItemTemplate>
                            <div class="bold"><%# Eval("Name")%></div>
                            <div><%# Eval("Subject")%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" CssClass="visible-sm" />
                        <HeaderStyle CssClass="visible-sm" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Issue Type" SortExpression="Name">
                        <ItemTemplate>
                            <div class="bold"><%# Eval("Name")%></div>

                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" CssClass="nowrap bold hidden-sm hidden-xs" />
                        <HeaderStyle CssClass="hidden-sm hidden-xs" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                        <ItemTemplate>
                            <div class="visible-xs bold"><%# Eval("Name")%></div>
                            <div><%# Eval("Subject")%></div>
                        </ItemTemplate>

                        <ItemStyle HorizontalAlign="Left" CssClass="hidden-sm hidden-xs" />
                        <HeaderStyle CssClass="hidden-sm hidden-xs" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Submitted on" SortExpression="CreatedDT">
                        <ItemTemplate>
                            <div title='<%# Eval("CreatedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# UserControl1.ToRecentDateTime(Eval("CreatedDT"))%>
                                <div class="">
                                    <time class="timeago time-small-gray" datetime='<%# Eval("CreatedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="nowrap hidden-xs" />
                        <HeaderStyle CssClass="hidden-xs" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Priority" SortExpression="PriorityName">
                        <ItemTemplate>
                            <%# Eval("PriorityName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" CssClass="hidden-xs" />
                        <HeaderStyle CssClass="hidden-xs " />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status" SortExpression="StatusName">
                        <ItemTemplate>
                            <%# Eval("StatusName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" CssClass="bold hidden-xs" />
                        <HeaderStyle CssClass="hidden-xs" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <a href='Ticket.aspx?id=<%# Eval("TicketID") %>' target="_blank" class="bold btn btn-default">View Details</a>

                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Width="120px" CssClass="hidden-xs" />
                        <HeaderStyle CssClass="hidden-xs" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Center" CssClass="PagerStyle2" />
                <RowStyle />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <div class="row">
                <asp:Literal ID="lblStatus" runat="server"></asp:Literal>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Ticket_Browse_Public" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:SessionParameter Name="Email" SessionField="USERNAME" Type="String" />
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
