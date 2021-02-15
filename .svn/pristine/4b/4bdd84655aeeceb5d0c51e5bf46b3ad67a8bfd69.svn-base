using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI;

public partial class Call_New : System.Web.UI.Page
{
    bool EditCallerClick = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();        

        if (!IsPostBack)
        {
            //GridView1.Visible = false;

            string Ph = string.Format("{0}", Request.QueryString["ph"]);
            if (Ph.Length > 0)
            {
                txtContractNo.Text = Ph;
                //txtDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                litTitle.Text = "Details of " + Ph;
                this.Title = Ph + " - Call Info";
                PanelCallerInfo.Visible = true;
                txtContractNo.Focus();
            }
            else
            {
                litTitle.Text = "Enter Phone Number";
                this.Title = "Call Info";
                txtContractNo.Focus();
            }
        }
        //else
        //    System.Threading.Thread.Sleep(1000);



        // Button1_Click.visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Call_New.aspx?ph=" + txtContractNo.Text.Trim(), true);
    }
    protected void SqlDataSourceKYC_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.CommandTimeout = 0;
    }

    protected void SqlDataSourceKYC_Selected1(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);
        //cmdDownload.Visible = e.AffectedRows > 0;
    }

    protected void cmdInsertNew_Click(object sender, EventArgs e)
    {
        ModalTitle.Text = "Add Caller Info";
        DetailsView3.ChangeMode(DetailsViewMode.Insert);
        DetailsView3.CellPadding = 2;
        modal.Show();
    }

    public bool cmdNewEnabled()
    {
        return true;
    }

    protected void cmdEdit_Click1(object sender, EventArgs e)
    {
        ModalTitle.Text = "Edit Item";
        DetailsView3.CellPadding = 1;
        modal.Show();
    }

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        //TrustControl1.ClientMsg(SqlDataSource1.UpdateParameters.Count.ToString());        
    }

    protected void DetailsView3_ModeChanged(object sender, EventArgs e)
    {
        //if (DetailsView3.CurrentMode == DetailsViewMode.ReadOnly)
        //{
        //    ModalTitle.Text = "Item View";
        //}
        //else if(DetailsView3.CurrentMode == DetailsViewMode.Edit)
        //{
        //    ModalTitle.Text = "Edit Item";
        //}
    }


    protected void DetailsView3_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        try
        {
            //string FileInfo = (e.NewValues["FileID"].ToString());
            //FileID = FileInfo.Substring(0, FileInfo.IndexOf(","));

            //if (!isFileInfo(FileInfo))
            //{
            //    e.Cancel = true;
            //    modal.Show();
            //    TrustControl1.ClientMsg("File ID Not Found.");
            //}
        }
        catch (Exception ex)
        {
            e.Cancel = true;
            modal.Show();
            TrustControl1.ClientMsg(ex.Message);
        }
    }


    protected void DetailsView3_DataBound(object sender, EventArgs e)
    {
        //DetailsView3.Rows[11].Cells[1].ColumnSpan = 2;
        //DetailsView3.Rows[11].Cells[0].Visible = false;

        if (DetailsView3.CurrentMode == DetailsViewMode.Edit)
        {
            string ServiceTypeID = string.Format("{0}", DataBinder.Eval(DetailsView3.DataItem, "ServiceTypeID"));
            string ServiceCategroyID = string.Format("{0}", DataBinder.Eval(DetailsView3.DataItem, "ServiceCategroyID"));

            //TrustControl1.ClientMsg(ServiceTypeID + " " + ServiceCategroyID);

            if (EditCallerClick)
            {
                foreach (ListItem LI in cboServiceType.Items)
                    if (LI.Value == ServiceTypeID)
                        LI.Selected = true;
                    else
                        LI.Selected = false;

                //cboServiceType_SelectedIndexChanged(sender, e);

                //cboServiceCategory.Items.Clear();
                //cboServiceCategory.Items.Add("");

                cboServiceCategory.DataBind();

                foreach (ListItem LI in cboServiceCategory.Items)
                    if (LI.Value == ServiceCategroyID)
                        LI.Selected = true;
                    else
                        LI.Selected = false;
            }
        }
    }

    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
        //TrustControl1.ClientMsg("Item ID: " + e.Command.Parameters["@RETURN_VALUE"].Value.ToString() + " Updated.");
    }


    protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
        TrustControl1.ClientMsg("Saved Successfully.");
        modal.Hide();
    }

    protected void SqlDataSource1_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        //e.Command.Parameters["@FileID"].Value = FileID;
    }

    

    protected void cmdShowAll_Click(object sender, EventArgs e)
    {
        //txtItemName.Text = string.Empty;
    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DetailsView3.ChangeMode(DetailsViewMode.ReadOnly);
        if (GridView1.SelectedIndex > -1)
            PanelCallDetails.Visible = true;
        else
            PanelCallDetails.Visible = false;

    }


    //News Modal Start......
    //##############################################################################################

    protected void cmdInsertNewService_Click(object sender, EventArgs e)
    {
        ModalTitle1.Text = "Add New Call Details";
        DetailsView1.ChangeMode(DetailsViewMode.Insert);
        DetailsView1.CellPadding = 2;
        ModalPopupExtender1.Show();
    }

    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
        grdvComment.DataBind();
        //TrustControl1.ClientMsg("Inserted Item ID: " + e.Command.Parameters["@RETURN_VALUE"].Value.ToString());
    }

    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //GridView2.DataBind();
        //TrustControl1.ClientMsg("Item ID: " + e.Command.Parameters["@RETURN_VALUE"].Value.ToString() + " Updated.");
    }

    protected void SqlDataSource2_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        //e.Command.Parameters["@FileID"].Value = FileID;
    }

    //protected void cboServiceType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    DetailsView3.Fields[1].Visible = true;
    //    DetailsView3.Fields[2].Visible = true;
    //    DetailsView3.Fields[3].Visible = true;

    //    modal.Show();
    //    string ServiceType = cboServiceType.SelectedItem.Value;
    //    if (ServiceType == "1")    //Card Support
    //    {
    //        ((TextBox)DetailsView3.FindControl("txtMobileAccNo")).Text = "";
    //        DetailsView3.Fields[3].Visible = false;
    //    }

    //    if (ServiceType == "4")    //Mobile Money
    //    {
    //        ((TextBox)DetailsView3.FindControl("txtCardNo")).Text = "";
    //        DetailsView3.Fields[2].Visible = false;
    //        ((TextBox)DetailsView3.FindControl("txtAccNo")).Text = "";
    //        DetailsView3.Fields[1].Visible = false;
    //    }
    //}

    protected void cboServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        cboServiceCategory.Items.Clear();
        cboServiceCategory.Items.Add("");

        DetailsView3.Fields[1].Visible = true;  //Acc No
        DetailsView3.Fields[2].Visible = true;  //Card No
        DetailsView3.Fields[3].Visible = true;  //Mobile No
        DetailsView3.Fields[4].Visible = true;  //Email

        modal.Show();
        string ServiceType = cboServiceType.SelectedItem.Value;

        bool AccNo_Visible = false;
        bool Card_No_Visible = false;
        bool Email_Visible = false;
        bool MobileAcc_Visible = false;

        try
        {
            AppSettingsReader oAppRead = new AppSettingsReader();
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            SqlConnection oConn = new SqlConnection(oConnString);
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlCommand oCommand = new SqlCommand("SELECT * from dbo.[Call_Service_Types] where [ServiceTypeID] = @ServiceType", oConn);
            oCommand.CommandType = CommandType.Text;
            oCommand.Parameters.Add("ServiceType", SqlDbType.Int).Value = ServiceType;

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();

            SqlDataReader oReader = oCommand.ExecuteReader();

            string Role = string.Empty;
            while (oReader.Read())
            {
                AccNo_Visible = (bool)oReader["AccNo_Visible"];
                Card_No_Visible = (bool)oReader["Card_No_Visible"];
                Email_Visible = (bool)oReader["Email_Visible"];
                MobileAcc_Visible = (bool)oReader["MobileAcc_Visible"];
            }
            oConn.Close();
        }
        catch (Exception) { }        

        if (!AccNo_Visible)
        {
            ((TextBox)DetailsView3.FindControl("txtAccNo")).Text = "";
            DetailsView3.Fields[1].Visible = false;
        }

        if (!Card_No_Visible)
        {
            ((TextBox)DetailsView3.FindControl("txtCardNo")).Text = "";
            DetailsView3.Fields[2].Visible = false;
        }

        if (!MobileAcc_Visible)
        {
            ((TextBox)DetailsView3.FindControl("txtMobileAccNo")).Text = "";
            DetailsView3.Fields[3].Visible = false;
        }

        if (!Email_Visible)
        {
            ((TextBox)DetailsView3.FindControl("txtEmail")).Text = "";
            DetailsView3.Fields[4].Visible = false;
        }
    }

    protected void grdvComment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
    }

    protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
       

    }





    protected void cboServiceCategory_DataBound(object sender, EventArgs e)
    {
        
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EDITCALL")
        {
            ModalTitle.Text = "Edit Caller Info";
            hidCallerID.Value = e.CommandArgument.ToString();
            DetailsView3.ChangeMode(DetailsViewMode.Edit);
            modal.Show();
            EditCallerClick = true;
        }
    }
}