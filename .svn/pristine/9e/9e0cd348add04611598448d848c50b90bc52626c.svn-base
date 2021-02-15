<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true"
    Inherits="Call_New" CodeFile="Call_New.aspx.cs" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    Customer Information Search
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

        .accno {
            margin-bottom: 7px;
        }
    </style>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="Server">--%>
<asp:Content ID="Content3" ContentPlaceHolderID="cphTitle" runat="Server">
    <asp:Literal ID="litTitle" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphDescription" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphBody" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="box box-tbl">
                <div class="form-inline">
                    <div class="form-group">

                        <label>Contract Number:</label>

                        <label>+</label>

                        <asp:TextBox Style="font-size: 110%; font-weight: bold" ID="txtContractNo" runat="server" CssClass="form-control" placeholder="contract no" Width="200px" MaxLength="100" onfocus="select()"></asp:TextBox>
                        <asp:FilteredTextBoxExtender runat="server" ID="filter1"
                            TargetControlID="txtContractNo" FilterType="Custom"
                            ValidChars="0123456789"></asp:FilteredTextBoxExtender>


                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" CssClass="btn" Text="Show" CausesValidation="false" />

                    </div>
                </div>
            </div>



            <%-- Modal Start....--%>
            <asp:Panel runat="server" ID="PanelCallerInfo" CssClass="group" Visible="false">

                <div style="margin-top: 10px;" class="group-body">
                    <asp:Button ID="cmdInsertNew0" runat="server" CausesValidation="False" OnClick="cmdInsertNew_Click" CssClass="btn" Text="Add New" Visible="True" />

                    <span style="visibility: hidden">
                        <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                        <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
                    </span>
                    <asp:ModalPopupExtender ID="modal" runat="server" BackgroundCssClass="ModalPopupBG" CancelControlID="ModalClose" Enabled="True" PopupControlID="ModalPanel"
                        PopupDragHandleControlID="ModalTitleBar" RepositionMode="RepositionOnWindowResize" TargetControlID="cmdShow">
                    </asp:ModalPopupExtender>
                    <asp:Panel ID="ModalPanel" runat="server" CssClass="ModalPanel1">
                        <div style="background: white">
                            <asp:Panel ID="ModalTitleBar" runat="server" CssClass="MoveIcon" BackColor="Green">
                                <div style="color: White; font-size: 14pt; font-weight: bolder; padding: 5px; margin: 0">

                                    <asp:Literal ID="ModalTitle" runat="server" Text="Add New Item"></asp:Literal>

                                    <div style="float: right; cursor: pointer">
                                        <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />

                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:HiddenField ID="hidCallerID" runat="server" />
                            <div class="Panel1 form-inline" style="display: inline-block; margin: 5px 5px 0 5px" >
                                Service:
                                <asp:DropDownList runat="server" EnableViewState="true" AutoPostBack="true" CssClass="form-control" ID="cboServiceType" AppendDataBoundItems="true" DataSourceID="SqlDataSourceServiceTypes" 
                                    DataTextField="ServiceTypeName" DataValueField="ServiceTypeID" OnSelectedIndexChanged="cboServiceType_SelectedIndexChanged">
                                    <asp:ListItem Text="" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboServiceType" runat="server" ControlToValidate="cboServiceType"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceServiceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Service_Types" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                    </SelectParameters>
                                </asp:SqlDataSource>


                                Category:
                                <asp:DropDownList runat="server"
                                    EnableViewState="true"
                                    AutoPostBack="False" CssClass="form-control"
                                    ID="cboServiceCategory"
                                    AppendDataBoundItems="false"
                                    DataSourceID="SqlDataSourceServiceCategory"
                                    DataTextField="ServiceCategoryName"
                                    DataValueField="ServiceCategroyID" OnDataBound="cboServiceCategory_DataBound">
                                    <asp:ListItem Text="" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboServiceCategory" runat="server" ControlToValidate="cboServiceCategory"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceServiceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Service_Category" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="cboServiceType" PropertyName="SelectedValue" Name="ServiceTypeID" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                            </div>



                            <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="False"
                                BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="1px"
                                CellPadding="0" CellSpacing="0" CssClass="Grid table-stripe-odd"
                                DataKeyNames="CallerID" DataSourceID="SqlDataSource1" DefaultMode="Insert"
                                GridLines="None" OnDataBound="DetailsView3_DataBound"
                                OnItemUpdating="DetailsView3_ItemUpdating"
                                OnModeChanged="DetailsView3_ModeChanged"
                                Width="100%" EnableViewState="true">
                                <FooterStyle ForeColor="Black" />
                                <RowStyle ForeColor="Black" />
                                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                                <Fields>
                                    <asp:BoundField DataField="CallerID" HeaderText="Caller ID" InsertVisible="False" ReadOnly="True" SortExpression="CallerID" Visible="false" />

                                    <asp:TemplateField HeaderText="A/C No" SortExpression="AccNo">
                                        <ItemTemplate>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("AccNo") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control" Text='<%# Bind("AccNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control" placeholder="A/C No" Text='<%# Bind("AccNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Card No" SortExpression="CardNo">
                                        <ItemTemplate>
                                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("CardNo") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" Text='<%# Bind("CardNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Card No" Text='<%# Bind("CardNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Mobile Acc No" SortExpression="MobileAccNo">
                                        <ItemTemplate>
                                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("MobileAccNo") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMobileAccNo" runat="server" CssClass="form-control" Text='<%# Bind("MobileAccNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtMobileAccNo" runat="server" CssClass="form-control" placeholder="Mobile A/C No" Text='<%# Bind("MobileAccNo") %>' MaxLength="30" Width="150px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                        <ItemTemplate>
                                            <asp:Label ID="Label12" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Invalid Email" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" Text='<%# Bind("Email") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Invalid Email" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName">
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("CustomerName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" Text='<%# Bind("CustomerName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" placeholder="Customer Name" Text='<%# Bind("CustomerName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Father Name" SortExpression="FatherName">
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("FatherName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control" Text='<%# Bind("FatherName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control" placeholder="Father Name" Text='<%# Bind("FatherName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Mother Name" SortExpression="MotherName">
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("MotherName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMotherName" runat="server" CssClass="form-control" Text='<%# Bind("MotherName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtMotherName" runat="server" CssClass="form-control" placeholder="Mother Name" Text='<%# Bind("MotherName") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDOB" runat="server" CssClass="Date form-control" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>' Width="85px"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatortxtItemDate" runat="server" ControlToValidate="txtDOB" Display="Dynamic" ErrorMessage="*" Font-Bold="true" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtDOB" runat="server" CssClass="Date form-control" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>' Width="85px"></asp:TextBox>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatortxtItemDate" runat="server" ControlToValidate="txtDOB" Display="Dynamic" ErrorMessage="*" Font-Bold="true" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("DOB", "{0:dd/MM/yyyy}") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                        <ItemTemplate>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Text='<%# Bind("Address") %>' Rows="2" TextMode="MultiLine" MaxLength="255" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Text='<%# Bind("Address") %>' Rows="2" TextMode="MultiLine" MaxLength="255" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Service Description" SortExpression="ServiceDesc">
                                        <ItemTemplate>
                                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("ServiceDesc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtServiceDesc" runat="server" CssClass="form-control" Text='<%# Bind("ServiceDesc") %>' Rows="2" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtServiceDesc" runat="server" CssClass="form-control" Text='<%# Bind("ServiceDesc") %>' Rows="2" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Customer Feedback" SortExpression="CustomerFeedback">
                                        <ItemTemplate>
                                            <asp:Label ID="Label12" runat="server" Text='<%# Bind("CustomerFeedback") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCustomerFeedback" runat="server" CssClass="form-control" Text='<%# Bind("CustomerFeedback") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtCustomerFeedback" runat="server" CssClass="form-control" placeholder="Customer Feedback" Text='<%# Bind("CustomerFeedback") %>' MaxLength="255" Width="300px"></asp:TextBox>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Customer Satisfaction">
                                        <EditItemTemplate>
                                            <asp:RadioButtonList runat="server" ID="cboClientStatusName" AppendDataBoundItems="True"
                                                DataSourceID="SqlDataSourceClientStatusName"
                                                DataTextField="ClientStatusName" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                DataValueField="ClientStatusID" CssClass="btn-group" 
                                                SelectedValue='<%# Bind("ClientStatusID") %>'>
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboClientStatusName" runat="server" ControlToValidate="cboClientStatusName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceClientStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Client_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:RadioButtonList runat="server" ID="cboClientStatusName" AppendDataBoundItems="True"
                                                DataSourceID="SqlDataSourceClientStatusName"
                                                DataTextField="ClientStatusName" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                DataValueField="ClientStatusID" CssClass="btn-group" 
                                                SelectedValue='<%# Bind("ClientStatusID") %>'>
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboClientStatusName" runat="server" ControlToValidate="cboClientStatusName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceClientStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Client_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("ClientStatusName") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status">
                                        <EditItemTemplate>
                                            <asp:DropDownList runat="server" ID="cboStatusName" CssClass="form-control" AppendDataBoundItems="true" SelectedValue='<%# Bind("StatusID") %>' DataSourceID="SqlDataSourceStatusName" DataTextField="StatusName" DataValueField="StatusID">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboStatusName" runat="server" ControlToValidate="cboStatusName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:DropDownList runat="server" ID="cboStatusName" CssClass="form-control" AppendDataBoundItems="true" SelectedValue='<%# Bind("StatusID") %>' DataSourceID="SqlDataSourceStatusName" DataTextField="StatusName" DataValueField="StatusID">
                                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboStatusName" runat="server" ControlToValidate="cboStatusName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("StatusName") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit" Enabled="<%# cmdNewEnabled() %>" OnClick="cmdEdit_Click1" Text="Edit" Width="80px" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button ID="cmdUpdate" runat="server" CssClass="btn"  CausesValidation="True" CommandName="Update" OnClick="cmdUpdate_Click" Text="Update" Width="80px" />
                                            <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure you want to Update?" Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                            <asp:Button ID="Button2" runat="server" CssClass="btn"  CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="80px" />
                                        </EditItemTemplate>
                                        <HeaderTemplate>
                                            <asp:Panel ID="Panel2" runat="server">
                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                </asp:DropDownList>
                                            </asp:Panel>
                                        </HeaderTemplate>
                                        <InsertItemTemplate>
                                            <asp:Button ID="cmdInsert" CssClass="btn" runat="server" CausesValidation="True" CommandName="Insert" Text="Save" Width="80px" />
                                            <asp:ConfirmButtonExtender ID="cmdInsert_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure you want to Save Item?" Enabled="True" TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                            <asp:Button ID="Button2" runat="server" CssClass="btn" CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="80px" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                </Fields>
                                <HeaderStyle />
                                <InsertRowStyle BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" />
                                <EditRowStyle />
                            </asp:DetailsView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                InsertCommand="s_CallService_Add_Edit" InsertCommandType="StoredProcedure"
                                OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated"
                                OnUpdating="SqlDataSource1_Updating"
                                SelectCommand="SELECT * FROM [Caller_Info] WHERE ([CallerID] = @CallerID)"
                                UpdateCommand="s_CallService_Add_Edit" UpdateCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidCallerID" Name="CallerID" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Direction="InputOutput" Name="CallerID" Type="Int32" />
                                    <asp:QueryStringParameter Name="ContractNo" QueryStringField="ph" Type="String" />
                                    <asp:Parameter Name="CustomerName" Type="String" />
                                    <asp:Parameter Name="FatherName" Type="String" />
                                    <asp:Parameter Name="MotherName" Type="String" />
                                    <asp:Parameter Name="Address" Type="String" />
                                    <asp:Parameter Name="DOB" Type="DateTime" />
                                    <asp:SessionParameter Name="ModifiedBy" SessionField="EMPID" Type="String" />

                                    <asp:Parameter Name="AccNo" Type="String" DefaultValue="" />
                                    <asp:ControlParameter ControlID="cboServiceType" PropertyName="SelectedValue" Name="ServiceTypeID" Type="Int16" />
                                    <asp:Parameter Name="CardNo" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="ServiceDesc" Type="String" Size="-1" />
                                    <asp:Parameter Name="ClientStatusID" Type="Int16" />
                                    <asp:Parameter Name="MobileAccNo" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="StatusID" Type="Int16" />
                                    <asp:Parameter Name="CustomerFeedback" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:ControlParameter ControlID="cboServiceCategory" PropertyName="SelectedValue" Name="ServiceCategroyID" Type="Int16" />



                                    <%--<asp:Parameter DefaultValue="true" Name="Remark" Type="String" />
                            <asp:Parameter Name="TypeID" Type="Int16" />
                            <asp:QueryStringParameter Name="ItemTypeID" Type="Int32" QueryStringField="type" />--%>
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Direction="InputOutput" Name="CallerID" Type="Int32" />
                                    <asp:QueryStringParameter Name="ContractNo" QueryStringField="ph" Type="String" />
                                    <asp:Parameter Name="CustomerName" Type="String" />
                                    <asp:Parameter Name="FatherName" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="MotherName" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="Address" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="DOB" Type="DateTime" />
                                    <asp:SessionParameter Name="ModifiedBy" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="AccNo" Type="String" DefaultValue="" />
                                    <asp:ControlParameter ControlID="cboServiceType" PropertyName="SelectedValue" Name="ServiceTypeID" Type="Int16" />
                                    <asp:Parameter Name="CardNo" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="ServiceDesc" Type="String" Size="-1" />
                                    <asp:Parameter Name="ClientStatusID" Type="Int16" />
                                    <asp:Parameter Name="MobileAccNo" Type="String" DefaultValue="" />
                                    <asp:Parameter Name="StatusID" Type="Int16" />
                                    <asp:Parameter Name="CustomerFeedback" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:ControlParameter ControlID="cboServiceCategory" PropertyName="SelectedValue" Name="ServiceCategroyID" Type="Int16" />
                                    <%--<asp:Parameter DefaultValue="true" Name="Remark" Type="String" />
                            <asp:Parameter Name="TypeID" Type="Int16" />
                            <asp:QueryStringParameter Name="ItemTypeID" Type="Int32" QueryStringField="type" />--%>
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </div>
                    </asp:Panel>


                    <%--Modal end....--%>


                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#6B696B" BorderStyle="Solid" BorderWidth="1px"
                        CellPadding="4" CssClass="Grid" DataKeyNames="CallerID" DataSourceID="SqlDataSourceKYC" ForeColor="Black" GridLines="Vertical"
                        PagerSettings-Position="TopAndBottom" PageSize="20" Style="font-size: small" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand">
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <Columns>



                            <asp:TemplateField HeaderText="#" ShowHeader="true" SortExpression="CallerID">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnkSelectCallerID" CommandName="Select" CausesValidation="false" Font-Bold="true" Font-Size="Medium">
                                <%# Eval("CallerID") %>

                                    </asp:LinkButton><br /><br />
                                    <asp:LinkButton runat="server" ID="lnkEdit" CommandArgument='<%# Eval("CallerID") %>' CommandName="EDITCALL" CausesValidation="false" >Edit</asp:LinkButton>

                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Customer Info" SortExpression="CustomerName">

                                <ItemTemplate>
                                    <%# Eval("CustomerName","<div class='bold'>{0}</div>") %>
                                    <%# Eval("FatherName","<div>Father: {0}</div>") %>
                                    <%# Eval("MotherName","<div>Mother: {0}</div>") %>
                                    <%# Eval("Address","<div>Address: {0}</div>") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="DOB" SortExpression="DOB">

                                <ItemTemplate>
                                    <%# Eval("DOB", "{0:dd/MM/yyyy}") %>
                                    <div class="time-small"><%# TrustControl1.getAge(Eval("DOB")) %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:BoundField DataField="ServiceTypeName" HeaderText="Type" SortExpression="ServiceTypeName" ItemStyle-Font-Bold="true" />--%>


                            <asp:TemplateField HeaderText="Type/Category" SortExpression="ServiceTypeName">
                                <ItemTemplate>
                                    <%# Eval("ServiceTypeName","<div class='accno'>Type:<br/>{0}</div>") %>
                                    <%# Eval("ServiceCategoryName","<div class='accno'>Category:<br/>{0}</div>") %>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Acc/Card/TBMM/Email" SortExpression="AccNo">
                                <ItemTemplate>
                                    <%# Eval("AccNo","<div class='accno'>CBS A/C:<br/>{0}</div>") %>
                                    <%# Eval("CardNo","<div class='accno'>Card Number:<br/>{0}</div>") %>
                                    <%# Eval("MobileAccNo","<div class='accno'>TBMM A/C:<br/>{0}</div>") %>
                                    <%# Eval("Email","<div class='accno'>Email:<br/>{0}</div>") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="ServiceDesc" HeaderText="Description" SortExpression="ServiceDesc" />

                            <asp:BoundField DataField="CustomerFeedback" HeaderText="Customer Feedback" SortExpression="CustomerFeedback" />
                            <asp:BoundField DataField="ClientStatusName" HeaderText="Rating" SortExpression="ClientStatusName" ItemStyle-HorizontalAlign="Center" />

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
                            </asp:TemplateField>

                            

                            <%--<asp:TemplateField HeaderText="Update DT" SortExpression="UpdateDT">
                                <ItemTemplate>
                                    <div title='<%# Eval("UpdateDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("UpdateDT"))%><div>
                                            <time class="timeago time-small-gray" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </div>
                                    By:
                                     
                                <span class="trustclick" url='<%= ConfigurationManager.AppSettings["HOME"] %>/EmpInfo/Emp.ashx?type=1&id=<%# Eval("UpdateBY") %>'>
                                            <%# Eval("UpdateBY") %></span>                                 
                                </ItemTemplate>
                            </asp:TemplateField>--%>


                            <asp:BoundField DataField="StatusName" HeaderText="Status" SortExpression="StatusName" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" CssClass="PagerStyle" ForeColor="Black" HorizontalAlign="Left" />
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                        <EmptyDataRowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle CssClass="GridSelect" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
                </div>
            </asp:Panel>

            <%-- <asp:Button ID="btnDownload" runat="server" Text="Download as xlsx" Style="width: 130px;"
                OnClick="btnDownload_Click" />--%><%--<asp:Button ID="cmdDownload" Visible="false" runat="server" Text="Download as xlsx"
                OnClick="cmdDownload_Click" />--%>







            <%--##########################################################################################################--%>










            <asp:Panel runat="server" ID="PanelCallDetails" CssClass="group" Visible="false">
                <h5>Comments/Follow ups
                </h5>
                <div class="group-body">
                    <%--New Modal Start...--%>
                    <%--<asp:Button ID="Button3" runat="server" CausesValidation="False" OnClick="cmdInsertNewService_Click" Text="Add New" Visible="True" />--%>

                    <span style="visibility: hidden">
                        <asp:Button ID="Button4" runat="server" CausesValidation="False" />
                        <asp:Button ID="Button5" runat="server" CausesValidation="False" />
                    </span>
                    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                        BackgroundCssClass="ModalPopupBG"
                        CancelControlID="Image2"
                        Enabled="True"
                        PopupControlID="ModalPanel1"
                        PopupDragHandleControlID="ModalTitleBar1"
                        RepositionMode="RepositionOnWindowResize"
                        TargetControlID="Button4">
                    </asp:ModalPopupExtender>

                    <asp:Panel ID="ModalPanel1" runat="server" CssClass="ModalPanel1">
                        <div style="background: green">
                            <asp:Panel ID="ModalTitleBar1" runat="server" CssClass="MoveIcon" HorizontalAlign="Center">
                                <table width="100%">
                                    <tr>
                                        <td align="left" style="color: White; font-size: 14pt; font-weight: bolder">
                                            <asp:Label ID="ModalTitle1" runat="server" Text="Add New Item"></asp:Label>
                                        </td>
                                        <td align="right"><a href="#" style="cursor: default">
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                        </a></td>
                                    </tr>
                                </table>
                            </asp:Panel>

                            <%--   OnItemUpdating="DetailsView1_ItemUpdating" 
                OnModeChanged="DetailsView1_ModeChanged" --%>

                            <asp:HiddenField ID="hidCallCommentsID" runat="server" />
                            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
                                BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="1px"
                                CellPadding="4" CellSpacing="0" CssClass="Grid table-stripe-odd"
                                DataKeyNames="CallTypeID" DataSourceID="SqlDataSource2" DefaultMode="Insert"
                                GridLines="None" OnDataBound="DetailsView3_DataBound"
                                Width="565px">
                                <FooterStyle ForeColor="Black" />
                                <RowStyle ForeColor="Black" />
                                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                                <Fields>
                                    <asp:BoundField DataField="CallCommentsID" HeaderText="CallCommentsID" InsertVisible="False" ReadOnly="True" SortExpression="CallCommentsID" Visible="false" />



                                    <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                                        <ItemTemplate>
                                            <asp:Label ID="Label13" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtComments" runat="server" Text='<%# Bind("Comments") %>' Rows="3" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtComment" runat="server" ControlToValidate="txtComments" Display="Dynamic" ErrorMessage="*" ValidationGroup="CallDetails" Font-Bold="true" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtComments" runat="server" Text='<%# Bind("Comments") %>' Rows="3" TextMode="MultiLine" Width="300px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtComment" runat="server" ControlToValidate="txtComments" Display="Dynamic" ErrorMessage="*" ValidationGroup="CallDetails" Font-Bold="true" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Status">
                                        <EditItemTemplate>
                                            <asp:DropDownList runat="server" CssClass="form-control" ID="cboCommentsStatusName" AppendDataBoundItems="true" SelectedValue='<%# Bind("StatusID") %>' DataSourceID="SqlDataSourceStatusName" DataTextField="StatusName" DataValueField="StatusID">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboCommentsStatusName" runat="server" ControlToValidate="cboCommentsStatusName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:DropDownList runat="server" ID="cboCommentsStatusName" AppendDataBoundItems="true" SelectedValue='<%# Bind("StatusID") %>' DataSourceID="SqlDataSourceStatusName" DataTextField="StatusName" DataValueField="StatusID">
                                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcboCommentsStatusName" runat="server" ControlToValidate="cboCommentsStatusName" ValidationGroup="CallDetails"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" Font-Bold="true" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSourceStatusName" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>" SelectCommand="s_Call_Status_Types" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <%# Eval("StatusName") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>



                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit" Enabled="<%# cmdNewEnabled() %>" OnClick="cmdEdit_Click1" Text="Edit" Width="80px" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button ID="cmdUpdate" ValidationGroup="CallDetails" runat="server" CausesValidation="True" CommandName="Update" OnClick="cmdUpdate_Click" Text="Update" Width="80px" />
                                            <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure you want to Update?" Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="80px" />
                                        </EditItemTemplate>
                                        <HeaderTemplate>
                                            <asp:Panel ID="Panel2" runat="server">
                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                </asp:DropDownList>
                                            </asp:Panel>
                                        </HeaderTemplate>
                                        <InsertItemTemplate>
                                            <asp:Button ID="cmdInsertCallDetails" runat="server"
                                                ValidationGroup="CallDetails"
                                                CausesValidation="True"
                                                CommandName="Insert"
                                                Text="Insert" Width="80px" />
                                            <asp:ConfirmButtonExtender ID="cmdInsert_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure you want to Insert Item?" Enabled="True" TargetControlID="cmdInsertCallDetails"></asp:ConfirmButtonExtender>
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Width="80px" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                </Fields>
                                <HeaderStyle />
                                <InsertRowStyle BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" />
                                <EditRowStyle />
                            </asp:DetailsView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                                ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
                                InsertCommand="s_Call_Comments_Insert_Update" InsertCommandType="StoredProcedure"
                                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated"
                                OnUpdating="SqlDataSource2_Updating"
                                SelectCommand="SELECT * FROM [Call_Type_Value] WHERE ([CallerID] = 21)"
                                UpdateCommand="s_Call_Comments_Insert_Update" UpdateCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidCallerID" Name="CallerID" PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Direction="InputOutput" Name="CallTypeID" Type="Int32" />
                                    <asp:Parameter Name="ServiceDesc" Type="String" />
                                    <asp:SessionParameter Name="ModifiedBy" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="ServiceTypeID" Type="Int16" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Direction="InputOutput" Name="CallCommentsID" Type="Int32" />
                                    <asp:ControlParameter ControlID="GridView1" Name="CallerID" PropertyName="SelectedValue" Type="Int64" />
                                    <asp:Parameter Name="Comments" Type="String" Size="-1" />
                                    <asp:SessionParameter Name="ModifiedBy" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="StatusID" Type="Int16" />
                                </InsertParameters>
                            </asp:SqlDataSource>



                        </div>
                    </asp:Panel>

                    <%--New Modal End...--%>


                    <div>

                        <asp:GridView ID="grdvComment" runat="server" DataKeyNames="CallCommentsID" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSourceComments" CssClass="Grid" BorderStyle="None" BackColor="White"
                            ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="true"
                            BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                            OnRowDataBound="grdvComment_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <div title='<%# Eval("CallCommentsID") %>'><%# Eval("SL") %></div>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comment">
                                    <ItemTemplate>
                                        <%# Eval("Comments").ToString().Replace("\n","<br />") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <%# Eval("StatusName") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Posted on" SortExpression="InsertDT">
                                    <ItemTemplate>
                                        <div title='<%# Eval("InsertDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime( Eval("InsertDT")) %><br />
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                        <div>
                                            By:
                                            <span class="trustclick" type="emp" val='<%# Eval("InsertBy") %>'>
                                               <%# Eval("InsertBy") %></span>
                                        </div>
                                    </ItemTemplate>
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
                            SelectCommand="s_Call_Comments_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="CallerID" PropertyName="SelectedValue" Type="Int64" />
                                <asp:SessionParameter SessionField="EMPID" Name="EmpID" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>


                    <asp:Button ID="Button3" runat="server" CausesValidation="False" OnClick="cmdInsertNewService_Click" Text="Add New" Visible="True" />







                </div>
            </asp:Panel>

        </ContentTemplate>
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="cmdDownload" />--%>
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
    <br />

    <asp:SqlDataSource ID="SqlDataSourceKYC" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
        SelectCommand="s_Call_Basic_Info" SelectCommandType="StoredProcedure"
        OnSelecting="SqlDataSourceKYC_Selecting" OnSelected="SqlDataSourceKYC_Selected1">
        <%--onselected="SqlDataSourceKYC_Selected">--%>
        <SelectParameters>
            <asp:QueryStringParameter Name="ContractNo" QueryStringField="ph" Type="String" DefaultValue="*" />
            <asp:SessionParameter SessionField="EMPID" Name="EMPID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <%--<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ServiceCubeConnectionString %>"
        SelectCommand="s_Call_Details" SelectCommandType="StoredProcedure"
        OnSelecting="SqlDataSourceKYC_Selecting" OnSelected="SqlDataSourceKYC_Selected1">

        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="CallerID" PropertyName="SelectedValue" Type="Int64" />
            <asp:SessionParameter SessionField="EMPID" Name="EmpID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
</asp:Content>
