using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;


public partial class MyComments : System.Web.UI.Page
{
    static string verifiedLogo = "<img src='Images/verified.png' width='16' height='16' border='0' title='Verified' />";
    DataSetAttachmentTicket.s_Attachments_TicketDataTable DT;
    protected void Page_Load(object sender, EventArgs e)
    {

        TrustControl1.getUserRoles();
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
        Title = "My Comments";

        if (IsPostBack)
        {
            //hidAssignDept.Value = "";
            //foreach (ListItem LI in chkAssignDeptID.Items)
            //    if (LI.Selected)
            //        hidAssignDept.Value += LI.Value + ",";
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewTicket.aspx", true);
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
        grdvComment.DataBind();
    }
    protected void SqlDataSourceTicketBrowse_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void ddlAssignBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ddlAssignDept.Items.Clear();
        //ddlAssignDept.Items.Add(new ListItem("ALL", "-1"));
        ////if (ddlAssignBranch.SelectedValue != "1")
        ////    ddlAssignDept.Items.Add(new ListItem("Any Department", "0"));
        //ddlAssignDept.DataBind();
        //gv1.DataBind();
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
        ddlTicketType.Items.Clear();
        ddlTicketType.Items.Add(new ListItem("All", "-1"));
        ddlTicketType.DataBind();
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

    enum FileDetails
    {
        Img, AID, Name, Size, FileKey, LoadImg, Width, CSS, ACSS, Preview, View, LightBox
    }
    protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //DT = new DataSetAttachmentTicket.s_Attachments_TicketDataTable();
        //DataSetAttachmentTicketTableAdapters.s_Attachments_TicketTableAdapter da
        //    = new DataSetAttachmentTicketTableAdapters.s_Attachments_TicketTableAdapter();
        //da.ClearBeforeFill = true;
        //da.Fill(DT, Request.QueryString["id"].ToString());

        lblStatus.Text = string.Format("Total: <b>{0:N0}</b>", e.AffectedRows);

    }
    public string[] getExtensionImage(string Extension, string AID, string FileKey)
    {
        string Pre = "Images/ext/";
        string[] RetVal = new string[12];
        RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
        RetVal[(int)FileDetails.Width] = "16px";
        RetVal[(int)FileDetails.CSS] = "noborder";
        RetVal[(int)FileDetails.LoadImg] = "";
        RetVal[(int)FileDetails.ACSS] = "";
        RetVal[(int)FileDetails.Preview] = "";
        RetVal[(int)FileDetails.View] = "";
        RetVal[(int)FileDetails.LightBox] = "";

        switch (Extension.ToUpper().Trim())
        {
            case "DOC":
            case "DOCX":
                RetVal[(int)FileDetails.Img] = Pre + "doc.gif";
                break;
            case "XLS":
            case "XLSX":
            case "XLSM":
            case "XLT":
            case "XLTX":
                RetVal[(int)FileDetails.Img] = Pre + "xls.gif";
                break;
            case "PPT":
            case "PPTX":
            case "PPTM":
            case "POTX":
            case "POTM":
            case "PPS":
            case "PPSX":
                RetVal[(int)FileDetails.Img] = Pre + "ppt.gif";
                break;
            case "ZIP":
            case "RAR":
            case "TAR":
            case "7ZIP":
                RetVal[(int)FileDetails.Img] = Pre + "zip.gif";
                break;
            case "TXT":
            case "INI":
            case "BAT":
                RetVal[(int)FileDetails.Img] = Pre + "txt.gif";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                break;
            case "PDF":
                //RetVal[0] = Pre + "pdf.gif";
                //RetVal[1] = "50px";
                //break;
                RetVal[(int)FileDetails.Img] = "Images/loading.gif";
                RetVal[(int)FileDetails.Width] = "80px";
                RetVal[(int)FileDetails.CSS] = "AttachmentThumb";
                RetVal[(int)FileDetails.LoadImg] = string.Format("ShowImage.ashx?aid={0}&key={1}&W=160&P=1", AID, FileKey);
                RetVal[(int)FileDetails.ACSS] = "lightbox";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                RetVal[(int)FileDetails.Preview] = string.Format("Pdf.aspx?aid={0}&key={1}", AID, FileKey);
                RetVal[(int)FileDetails.LightBox] = string.Format("ShowImage.ashx?aid={0}&key={1}&P=1&Z=1", AID, FileKey);
                break;
            case "JPG":
            case "JPEG":
            case "GIF":
            case "PNG":
            case "BMP":
                RetVal[(int)FileDetails.Img] = "Images/loading.gif";
                RetVal[(int)FileDetails.Width] = "80px";
                RetVal[(int)FileDetails.CSS] = "AttachmentThumb";
                RetVal[(int)FileDetails.LoadImg] = string.Format("ShowImage.ashx?aid={0}&key={1}&W=160&H=200&R=1", AID, FileKey);
                RetVal[(int)FileDetails.ACSS] = "lightbox";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                RetVal[(int)FileDetails.LightBox] = string.Format("ShowImage.ashx?aid={0}&key={1}&Z=0&R=1", AID, FileKey);
                break;
            default:
                RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
                break;
        }
        return RetVal;
    }
}
