﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

public partial class Ticket_Browse_Br : System.Web.UI.Page
{
    static string verifiedLogo = "<img src='Images/verified.png' width='16' height='16' border='0' title='Verified' />";

    protected void Page_Load(object sender, EventArgs e)
    {
      
        TrustControl1.getUserRoles();
        Title = "Ticket Browse";
        //if (panelCommaonTask.Visible)

        //if (IsPostBack && !AjaxFileUpload1.IsInFileUploadPostBack)
        //{
        //    //panelButton.Visible = ddlServiceType.SelectedIndex > 0;
        //    //TrustControl1.ClientMsg(ddlServiceType.Items.Count.ToString());
        //}
        //else
        //{
        //    //GetTicketNo();
        //    HideAllPanels();        
        //}

    }

    
   
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewTicket.aspx", true);
    }

    protected void ddlSDBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReqBranch.SelectedItem.Value == "1")
        {
            lblDept.Visible = true;
            ddlReqDept.Visible = true;
          
        }
        else
        {
            lblDept.Visible = false;
            ddlReqDept.Visible = false;
            ddlReqDept.SelectedIndex = 0;
         
        }
    }
   

    


    protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        //string path = Server.MapPath("Upload/") + Session.SessionID + "_" + e.FileName;
        //AjaxFileUpload1.SaveAs(path);

        try
        {
            //FileInfo FI = new FileInfo(path);
            //string FileName = FI.Name.Substring(FI.Name.IndexOf("_") + 1);
            //int ID = int.Parse(hidID.Value);
            TrustControl1.InsertData(e.GetContents(), true, 1, e.FileName, e.ContentType, e.FileSize, e.FileId);
            //File.Delete(path);            
        }
        catch (Exception) { }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gv1.DataBind();
    }
    protected void ddlReqFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlTicketType.Items.Clear();
        ddlTicketType.Items.Add(new ListItem("All", "-1"));
        ddlTicketType.DataBind();
    }
}