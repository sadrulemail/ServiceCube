using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Call_Count : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        Title = "Call Info Count";

        if (!IsPostBack)
        {
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        grdvComment.DataBind();
    }
    protected void SqlDataSourceTicketBrowse_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void ddlAssignBranch_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void cmdPreviousDay_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime DT = DateTime.Parse(txtDateFrom.Text);
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
            grdvComment.DataBind();
        }
        catch (Exception) { }
    }

    protected void cmdNextDay_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime DT = DateTime.Parse(txtDateFrom.Text);
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
            grdvComment.DataBind();
        }
        catch (Exception) { }
    }

    protected void chkAssignDeptID_DataBound(object sender, EventArgs e)
    {
    }

    protected void ddlReqFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void grdvComment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }

    protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void grdvComment_DataBound(object sender, EventArgs e)
    {
        try
        {
            for (int c = 2; c < grdvComment.Columns.Count; c++)
            {
                int Total = 0;
                foreach (GridViewRow item in grdvComment.Rows)
                {
                    string text = (item.Cells[c].Controls[0] as DataBoundLiteralControl).Text;
                    Total += int.Parse(text);
                }

                grdvComment.FooterRow.Cells[c].Text = string.Format("{0}", Total);
            }
        }
        catch (Exception) { }
    }
}
