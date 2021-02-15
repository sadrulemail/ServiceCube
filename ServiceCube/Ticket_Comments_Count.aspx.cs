using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ticket_Comments_Count : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        TrustControl1.getUserRoles();

        Title = "Ticket Comment Count";

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
        //hidAssignDept.Value = "";
        //foreach (ListItem LI in chkAssignDeptID.Items)
        //{
        //    LI.Selected = true;
        //    hidAssignDept.Value += LI.Value + ",";
        //}
    }

    protected void ddlReqFrom_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void grdvComment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    int CID = (int)(DataBinder.Eval(e.Row.DataItem, "CID"));
        //    StringBuilder sb = new StringBuilder();

        //    DataSetAttachmentTicket.s_Attachments_TicketRow[] oRows;
        //    oRows = (DataSetAttachmentTicket.s_Attachments_TicketRow[])
        //        DT.DefaultView.Table.Select("CID=" + CID.ToString());

        //    if (oRows.Length > 0)
        //    {
        //        sb.Append("<div class='filediv'><table class='noborder'>");
        //        for (int r = 0; r < oRows.Length; r++)
        //        {
        //            string[] ssss = getExtensionImage(
        //                    string.Format("{0}", oRows[r].Extension),
        //                    oRows[r].AID.ToString(),
        //                    oRows[r].FileId.ToLower()
        //                );

        //            sb.Append("<tr class='hoverTr'>");

        //            sb.Append("<td align='right' class='extlogotd' >");

        //            if (ssss[(int)FileDetails.LightBox].Length == 0)
        //            {
        //                sb.Append("<img title='AID:" + oRows[r].AID + "' src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='noborder' />");
        //            }
        //            else
        //            {
        //                sb.Append("<a target='_blank' class='" + ssss[(int)FileDetails.ACSS] + "' href='" + ssss[(int)FileDetails.LightBox] + "'>");
        //                sb.Append("<img title='AID:" + oRows[r].AID + "' loadimg=\"" + ssss[(int)FileDetails.LoadImg] + "\" src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='attachthumb' onerror=\"this.src='Images/Error.jpg'\" />");
        //                sb.Append("</a>");
        //            }

        //            sb.Append("</td>");

        //            sb.Append("<td class='extlogotd'>");
        //            sb.Append("<b>" + oRows[r].FileName + "</b><br /><span class='filesize'>" + TrustControl1.FileSize(oRows[r].FileSize) + "</span>&nbsp;&nbsp;&nbsp;<a target='_blank' href='Attachment.ashx?aid=" + oRows[r].AID + "&key=" + oRows[r].FileId.ToLower() + "'>Download</a>");

        //            if (ssss[(int)FileDetails.View].Length > 0)
        //                sb.Append("&nbsp;&nbsp;<a target='_blank' href='" + ssss[(int)FileDetails.View] + "' class='link'>View</a>");

        //            if (ssss[(int)FileDetails.Preview].Length > 0)
        //                sb.Append("<div style='margin:10px'><a target='_blank' href='Pdf.aspx?aid=" + oRows[r].AID.ToString() + "&key=" + oRows[r].FileId.ToLower() + "' title='Preview' class='link'><img src='Images/new_window.png' border='0'></a></div></td>");
        //            sb.Append("</tr>");
        //        }
        //        sb.Append("</table></div>");
        //        ((Literal)(e.Row.FindControl("litAttach"))).Text = sb.ToString();
        //    }
        //}
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
