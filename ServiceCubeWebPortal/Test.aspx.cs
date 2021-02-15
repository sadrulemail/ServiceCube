using System;
using System.Web.UI;

namespace ServiceCube
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            hidModalShow.Value = "1";
            ModalShow("myModal");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //System.Threading.Thread.Sleep(2000);
            hidModalShow.Value = "0";

            //ClientMsg("Test"); 
            ModalHide("myModal");
        }

        public void ModalShow(string ClientID)
        {
            ScriptManager.RegisterClientScriptBlock(
                this.Page, this.Page.GetType(),
                "modal",
                "$('#" + ClientID + "').modal({ backdrop: 'static', keyboard: false, show: true });"
                , true);
        }
        public void ModalHide(string ClientID)
        {
            ScriptManager.RegisterClientScriptBlock(
                this.Page, this.Page.GetType(),
                "modal",
                "$('#" + ClientID + "').modal('hide');$('.modal-backdrop').remove();"
                , true);
        }       

        public void ClientMsg(string MsgTxt, Control focusControl)
        {
            string script1 = "";
            if (focusControl != null)
                script1 = "$('#" + focusControl.ClientID + "').focus();";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", "bootbox.alert('" + MsgTxt + "', function(){setTimeout(function(){" + script1 + "},100)});", true);
        }

        public void ClientMsg(string MsgTxt)
        {
            ClientMsg(MsgTxt, null);
        }

        public void ClientAlert(string MsgTxt)
        {
            ClientAlert(MsgTxt, null);
        }

        public void ClientAlert(string MsgTxt, Control focusControl)
        {
            string script1 = "";
            if (focusControl != null)
                script1 = "$('#" + focusControl.ClientID + "').focus();";
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", "jAlert('" + MsgTxt + "','Trust Bank', function(r){" + script1 + "});", true);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            ClientAlert("Test");
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            ModalShow("myModal");
            ClientAlert("Test");
        }

        protected void cmdAlert_Click(object sender, EventArgs e)
        {
            ClientMsg("This is an Alert.<br><b>This is bold text.</b>", TextBox2);
        }
    }
}