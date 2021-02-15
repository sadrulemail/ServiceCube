<%@ Page Title="" Language="C#" MasterPageFile="~/MasterLTE.master" AutoEventWireup="true" 
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    Page Title
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphDescription" Runat="Server">
    Optional description
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
    <div class="col-sm-6">
        <div class="box">
            <div class="box-header">
            <h3 class="box-title">Box Title</h3>
                </div>
            <div class="box-body"><p>This is a box body.</p>      
                <table class="table table-responsive">
                    <tr>
                        <td>
                            Father's Name</td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="enter your name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Mother's Name</td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="enter your name"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                        
            </div>
            <div class="box-footer">
                <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="btn btn-success" />
                <asp:Button ID="Button2" runat="server" Text="Click Me" CssClass="btn btn-success" />
            </div>
        </div>
    </div>
</asp:Content>

