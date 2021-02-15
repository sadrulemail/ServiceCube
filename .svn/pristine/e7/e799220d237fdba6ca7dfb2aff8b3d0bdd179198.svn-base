using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Call_Comments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!IsPostBack)
        {
            GridView1.Visible = true;
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.AddMonths(-6));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
        }

        this.Title = "Call Comments/Follow up Search";

        // Button1_Click.visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
        GridView1.Visible = true;
        // Button1.visible = true;

    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.CommandTimeout = 0;
    }


    protected void SqlDataSource1_Selected1(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);
        //cmdDownload.Visible = e.AffectedRows > 0;
    }

    protected void cboServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //cboServiceCategory.Items.Clear();
        ListItem LI = new ListItem("All", "-1");
        //cboServiceCategory.Items.Add(LI);
    }
}