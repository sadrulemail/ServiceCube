r<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="ServiceCube.Test" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" />
    <!--[if lt IE 9]>
		<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
    <link href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="css/jquery.alerts.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <link href="css/StyleSheet.css" rel="stylesheet" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>

    <script src="js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <script src="script/jquery.watermark.min.js"></script>
    <script src="script/jquery.timeago.js"></script>
    <script src="script/jquery.alerts.js"></script>
    <script src="js/bootbox.js"></script>
    <script src="js/TrustBank.js"></script>

</head>
<body>
    <form runat="server" id="form1">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Button ID="Button1" runat="server" Text="Show from Server Event" OnClick="Button1_Click" />
                <asp:Button ID="cmdAlert" runat="server" Text="Client Message" OnClick="cmdAlert_Click" />
                <asp:HiddenField ID="hidModalShow" ClientIDMode="Static" Value="0" runat="server" EnableViewState="false" />
                <asp:HiddenField ID="hidModalName" ClientIDMode="Static" Value="myModal" runat="server" />
                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="Button3" runat="server" Text="Alert" OnClick="Button3_Click" />
                <asp:Button ID="Button4" runat="server" Text="Modal and Alert" OnClick="Button4_Click" />

                <div class="container">
                    <h2>Large Modal</h2>
                    <!-- Trigger the modal with a button -->
                    <button type="button" class="btn btn-info btn-lg" data-toggle="modal"
                        data-target="#myModal">
                        Open Large Modal</button>

                    <!-- Modal -->
                    <div class="modal " id="myModal" role="dialog">
                        <div class="modal-dialog modal-md" data-backdrop="static">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                                    <h4 class="modal-title">Modal Header</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        This is a large modal.
                                    </p>
                                    <asp:Button ID="Button2" runat="server" Text="Server Close" OnClick="Button2_Click" />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default bold" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    </form>
</body>
</html>
