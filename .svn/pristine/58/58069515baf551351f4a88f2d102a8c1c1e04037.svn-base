using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;
using Ghostscript.NET;
using System.Web;

public partial class Ticket : System.Web.UI.Page
{
    //string branch;
    //string CurrectStatus = "";
    //bool HideDetailViewFields = false;
    int MaxFileSizePerPageKB;
    string UploadPath;
    

    DataSetAttachmentTicket.s_Attachments_TicketDataTable DT;       

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        hidEmpID.Value = Session["EMPID"].ToString();
        Page.Title = "Ticket";
        MaxFileSizePerPageKB = int.Parse(TrustControl1.getValueOfKey("MaxFileSizePerPageKB"));
        UploadPath = Server.MapPath("Upload");

        if (!IsPostBack)
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

            txtTicketID.Text = string.Format("{0}", Request.QueryString["id"]); 
            txtTicketID.Focus();
            lblTicket.Text = string.Format("{0}", Request.QueryString["id"]);
            lblTicketTitle.Text = string.Format("Ticket # {0}", Request.QueryString["id"]);
            hidTicketID.Value = string.Format("{0}", Request.QueryString["id"]);
            ChangeSessionData(); 
            
            if (Session["BRANCHID"].ToString() == "1")
            {
                tab2.Visible = true;
            }

            if (txtTicketID.Text.Length > 0)
            {
                try
                {
                    Page.Title = string.Format("{0} - Ticket", txtTicketID.Text);
                }
                catch (Exception)
                {
                    Response.Write("Invalid Request.");
                    Response.End();
                    return;
                }
            }
            panelVisible.Visible = txtTicketID.Text.Trim().Length > 0;
            panelDetailViewVisible.Visible = txtTicketID.Text.Trim().Length > 0;

        }
    }

    public void ChangeSessionData()
    {
        if (!Directory.Exists(UploadPath))
        {
            Directory.CreateDirectory(UploadPath);
        }

        Random R = new Random(DateTime.Now.Millisecond +
                        DateTime.Now.Second * 1000 +
                        DateTime.Now.Minute * 60000 +
                        DateTime.Now.Hour * 3600000);

        HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());
        HidUploadTempFile.Value = Server.MapPath("Upload/" + HidPageID.Value);
    }
    protected void SqlDataSourceAddAcc_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            TrustControl1.ClientMsg(string.Format("{0}", "Deleted Successfully."));

        else
            TrustControl1.ClientMsg(string.Format("{0}", "Delete not Completed.Please try again."));

        //if (grdvAccountList.Rows.Count == 0)
        //    PanelLinkedAccount.Visible = false;
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
        string TicketNo = txtTicketID.Text.Trim();
        if (!TicketNo.Contains("."))
            TicketNo = DateTime.Now.Date.ToString("yyMMdd") + "." + TicketNo;

        Response.Redirect("Ticket.aspx?id=" + TicketNo, true);
    }

    protected void grdvComment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int CID = (int)(DataBinder.Eval(e.Row.DataItem, "CID"));
            StringBuilder sb = new StringBuilder();

            DataSetAttachmentTicket.s_Attachments_TicketRow[] oRows;
            oRows = (DataSetAttachmentTicket.s_Attachments_TicketRow[])
                DT.DefaultView.Table.Select("CID=" + CID.ToString());

            if (oRows.Length > 0)
            {
                sb.Append("<div class='filediv'><table class='noborder'>");
                for (int r = 0; r < oRows.Length; r++)
                {
                    string[] ssss = getExtensionImage(
                            string.Format("{0}", oRows[r].Extension),
                            oRows[r].AID.ToString(),
                            oRows[r].FileId.ToLower()
                        );

                    sb.Append("<tr class='hoverTr'>");

                    sb.Append("<td align='right' class='extlogotd' >");

                    if (ssss[(int)FileDetails.LightBox].Length == 0)
                    {                        
                        sb.Append("<img title='AID:" + oRows[r].AID + "' src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='noborder' />");
                    }
                    else
                    {
                        sb.Append("<a target='_blank' class='" + ssss[(int)FileDetails.ACSS] + " no-print' href='" + ssss[(int)FileDetails.LightBox] + "'>");
                        sb.Append("<img title='AID:" + oRows[r].AID + "' loadimg=\"" + ssss[(int)FileDetails.LoadImg] + "\" src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='attachthumb' onerror=\"this.src='Images/Error.jpg'\" />");
                        sb.Append("</a>");
                    }

                    sb.Append("</td>");
                    
                    sb.Append("<td class='extlogotd'>");
                    sb.Append("<b>" + oRows[r].FileName + "</b><br /><span class='filesize'>" + TrustControl1.FileSize(oRows[r].FileSize) + "</span>&nbsp;&nbsp;&nbsp;<a target='_blank' href='Attachment.ashx?aid=" + oRows[r].AID + "&key=" + oRows[r].FileId.ToLower() + "' class='no-print'>Download</a>");

                    if (ssss[(int)FileDetails.View].Length > 0)
                        sb.Append("&nbsp;&nbsp;<a target='_blank' href='" + ssss[(int)FileDetails.View] + "' class='link no-print'>View</a>");

                    if (ssss[(int)FileDetails.Preview].Length > 0)
                        sb.Append("<div style='margin:10px'><a target='_blank' href='Pdf.aspx?aid=" + oRows[r].AID.ToString() + "&key=" + oRows[r].FileId.ToLower() + "' title='Preview' class='link no-print'><img src='Images/new_window.png' border='0' /></a></div></td>");
                    sb.Append("</tr>");
                }
                sb.Append("</table></div>");
                ((Literal)(e.Row.FindControl("litAttach"))).Text = sb.ToString();
            }
        }           
    }

    enum FileDetails {
       Img,AID,Name,Size,FileKey,LoadImg,Width,CSS,ACSS,Preview,View,LightBox
    }

    //public string [] getExtensionImage(string Extension, string AID, string FileKey)
    //{
    //    string Pre = "Images/ext/";
    //    string[] RetVal = new string[12];
    //    RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
    //    RetVal[(int)FileDetails.Width] = "16px";
    //    RetVal[(int)FileDetails.CSS] = "noborder";
    //    RetVal[(int)FileDetails.LoadImg] = "";
    //    RetVal[(int)FileDetails.ACSS] = "";
    //    RetVal[(int)FileDetails.Preview] = "";
    //    RetVal[(int)FileDetails.View] = "";
    //    RetVal[(int)FileDetails.LightBox] = "";

    //    switch (Extension.ToUpper().Trim())
    //    {
    //        case "DOC":
    //        case "DOCX":
    //            RetVal[(int)FileDetails.Img] = Pre + "doc.gif";
    //            break;
    //        case "XLS":
    //        case "XLSX":
    //        case "XLSM":
    //        case "XLT":
    //        case "XLTX":
    //            RetVal[(int)FileDetails.Img] = Pre + "xls.gif";
    //            break;
    //        case "PPT":
    //        case "PPTX":
    //        case "PPTM":
    //        case "POTX":
    //        case "POTM":
    //        case "PPS":
    //        case "PPSX":
    //            RetVal[(int)FileDetails.Img] = Pre + "ppt.gif";
    //            break;
    //        case "ZIP":
    //        case "RAR":
    //        case "TAR":
    //        case "7ZIP":
    //            RetVal[(int)FileDetails.Img] = Pre + "zip.gif";
    //            break;
    //        case "TXT":
    //        case "INI":
    //        case "BAT":
    //            RetVal[(int)FileDetails.Img] = Pre + "txt.gif";
    //            RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
    //            break;
    //        case "PDF":
    //            //RetVal[0] = Pre + "pdf.gif";
    //            //RetVal[1] = "50px";
    //            //break;
    //            RetVal[(int)FileDetails.Img] = "Images/loading.gif";
    //            RetVal[(int)FileDetails.Width] = "80px";
    //            RetVal[(int)FileDetails.CSS] = "attachthumb";
    //            RetVal[(int)FileDetails.LoadImg] = string.Format("ShowImage.ashx?AID={0}&key={1}&W=160&P=1", AID, FileKey);
    //            RetVal[(int)FileDetails.ACSS] = "lightbox";
    //            RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?AID={0}&key={1}&view=yes", AID, FileKey);
    //            RetVal[(int)FileDetails.Preview] = string.Format("Pdf.aspx?AID={0}&KEY={1}", AID, FileKey);
    //            RetVal[(int)FileDetails.LightBox] = string.Format("ShowImage.ashx?AID={0}&key={1}&P=1&Z=1", AID, FileKey);
    //            break;
    //        case "JPG":
    //        case "JPEG":
    //        case "GIF":
    //        case "PNG":
    //        case "BMP":
    //            RetVal[(int)FileDetails.Img] = "Images/loading.gif";
    //            RetVal[(int)FileDetails.Width] = "80px";
    //            RetVal[(int)FileDetails.CSS] = "attachthumb";
    //            RetVal[(int)FileDetails.LoadImg] = string.Format("AttachShow.ashx?aid={0}&key={1}&W=160&H=200&R=1", AID, FileKey);
    //            RetVal[(int)FileDetails.ACSS] = "lightbox";                
    //            RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
    //            RetVal[(int)FileDetails.LightBox] = string.Format("AttachShow.ashx?aid={0}&key={1}&Z=0&R=1", AID, FileKey);
    //            break;
    //        default:
    //            RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
    //            break;
    //    }
    //    return RetVal;
    //}
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

    protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        DT = new DataSetAttachmentTicket.s_Attachments_TicketDataTable();
        DataSetAttachmentTicketTableAdapters.s_Attachments_TicketTableAdapter da 
            = new DataSetAttachmentTicketTableAdapters.s_Attachments_TicketTableAdapter();
        da.ClearBeforeFill = true;        
        da.Fill(DT, Request.QueryString["id"].ToString());        
        
    }
    protected void btnPostReply_Click(object sender, EventArgs e)
    {       
        string Msg = "";
        bool done = false;

        string MsgBody = "";
        string MsgSubject = "";
        string PublicMail = "";

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_PostReply_Comment_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = Request.QueryString["id"];
                cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentDtl.Text.Trim();
                cmd.Parameters.Add("@AssignedEmp", System.Data.SqlDbType.VarChar).Value = null;
                cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                cmd.Parameters.Add("@CommentType", System.Data.SqlDbType.Int).Value = 2;    //Post Reply
                cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value; 
                cmd.Parameters.Add("@TicketStatus", System.Data.SqlDbType.Int).Value = ddlStatusType.SelectedValue;
                cmd.Parameters.Add("@IsPrivateComment", System.Data.SqlDbType.Bit).Value = chkPrivate.Checked;

                SqlParameter SQL_MsgBody_Out = new SqlParameter("@MsgBody_Out", SqlDbType.VarChar, 255);
                SQL_MsgBody_Out.Direction = ParameterDirection.InputOutput;
                SQL_MsgBody_Out.Value = Msg;
                cmd.Parameters.Add(SQL_MsgBody_Out);
                SqlParameter SQL_MsgSubject_Out = new SqlParameter("@MsgSubject_Out", SqlDbType.VarChar, 255);
                SQL_MsgSubject_Out.Direction = ParameterDirection.InputOutput;
                SQL_MsgSubject_Out.Value = Msg;
                cmd.Parameters.Add(SQL_MsgSubject_Out);
                SqlParameter SQL_PublicMail = new SqlParameter("@PublicMail", SqlDbType.VarChar, 255);
                SQL_PublicMail.Direction = ParameterDirection.InputOutput;
                SQL_PublicMail.Value = Msg;
                cmd.Parameters.Add(SQL_PublicMail);


                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = done;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                done = (bool)SQL_Done.Value;

                MsgSubject = string.Format("{0}", SQL_MsgSubject_Out.Value);
                MsgBody = string.Format("{0}", SQL_MsgBody_Out.Value);
                PublicMail = string.Format("{0}", SQL_PublicMail.Value);
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (done)
        {
            
            if (PublicMail.Length > 1 && ddlStatusType.SelectedValue == "4" || ddlStatusType.SelectedValue == "5" || ddlStatusType.SelectedValue == "6")
            {
                //Send Email
                //string EmailType = Common.getValueOfKey("EmailType");
                //string ExchangeUrl = Common.getValueOfKey("ExchangeUrl");
                //string ExchangeUserName = Common.getValueOfKey("ExchangeUserName");
                //string ExchangeUserPassword = Common.getValueOfKey("ExchangeUserPassword");

                //try
                //{
                //    ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2013);
                //    service.Url = new Uri(ExchangeUrl);

                //    ServicePointManager.ServerCertificateValidationCallback =
                //        delegate(Object obj, X509Certificate certificate, X509Chain chain, SslPolicyErrors error)
                //        {
                //            return true;
                //        };
                //    service.UseDefaultCredentials = false;
                //    service.Credentials = new WebCredentials(ExchangeUserName, ExchangeUserPassword);

                //    EmailMessage message = new EmailMessage(service);
                //    message.Subject = MsgSubject;
                //    message.Body = new MessageBody(BodyType.HTML, string.Format("{0}", MsgBody).Replace("\n", "<br />"));


                //    message.ToRecipients.Add(PublicMail.Trim());

                //    message.Send();
                //    // lblStatus.Text = Msg;
                //}
                //catch (Exception ex)
                //{
                //    TrustControl1.ClientMsg("<b>Unable to send email.</b><br />" + ex.Message);
                //    return;
                //}
            }

            ClearCommentsControl(Msg);
            ClientMessageToReload();
            //TrustControl1.ClientMsg(Msg);
            //txtCommentDtl.Text = txtCommentInternal.Text = txtCommentTransfer.Text = txtCommentAssign.Text = "";
            //ddlStatusType.SelectedIndex = 0;


            //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);
        }
        else
        {

            TrustControl1.ClientMsg("Insert Failed.");
           // Response.Redirect("NewTicket.aspx", true);
        }      
    }

    private void ClientMessageToReload()
    {
        ChatHub.SendClientMsg(
                        Session["EMPID"].ToString(),
                        Request.QueryString["id"],
                        "Ticket Updated",
                        "1");
    }

    protected void btnSubmitInternal_Click(object sender, EventArgs e)
    {
        string Msg = "";
        bool done = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_PostInternalNote_Comment_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = Request.QueryString["id"];
                cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentInternal.Text.Trim();
                cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                cmd.Parameters.Add("@CommentType", System.Data.SqlDbType.Int).Value = 3;    //Internal Note
                cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value; 
               
                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = done;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                done = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (done)
        {
            ClearCommentsControl(Msg);
            ClientMessageToReload();
            //TrustControl1.ClientMsg(Msg);
            //txtCommentDtl.Text = txtCommentInternal.Text = txtCommentTransfer.Text = txtCommentAssign.Text = "";
            //ddlStatusType.SelectedIndex = 0;
            //grdvComment.DataBind();
            //DetailsView1.DataBind();

            //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);

        }
        else
        {

            TrustControl1.ClientMsg(Msg);
            // Response.Redirect("NewTicket.aspx", true);

        }
    }
    protected void btnTransfer_Click(object sender, EventArgs e)
    {
        if (hidAssignedTeamID.Value == "")
            TrustControl1.ClientMsg("Please Select Team");
        else
            SaveTransferTeamData();
    }

    private void SaveTransferTeamData()
    {
        string Msg = "";
        bool done = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_TransferTeam_Comment_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = Request.QueryString["id"];
                cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentTransfer.Text.Trim();
                cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                cmd.Parameters.Add("@CommentType", System.Data.SqlDbType.Int).Value = 4;    //Transfer Team
                cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value; 
                cmd.Parameters.Add("@AssignTeam", System.Data.SqlDbType.Int).Value = hidAssignedTeamID.Value; ;

                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = done;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                done = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (done)
        {
            //TrustControl1.ClientMsg(Msg);
            //txtCommentDtl.Text = txtCommentInternal.Text = txtCommentTransfer.Text = txtCommentAssign.Text = "";
            //ddlStatusType.SelectedIndex = 0;
            //grdvComment.DataBind();
            ClearCommentsControl(Msg);
            hidAssignedTeamID.Value = "";
            ClientMessageToReload();
            //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);
            // DetailsView1.DataBind();
        }
        else
        {
            TrustControl1.ClientMsg(Msg);
            // Response.Redirect("NewTicket.aspx", true);
        }
    }

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        string Msg = "";
        bool done = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_AssignEmp_Comment_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = Request.QueryString["id"];
                cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentAssign.Text.Trim();
                cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                cmd.Parameters.Add("@CommentType", System.Data.SqlDbType.Int).Value = 5;    //Assign to Emp
                cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value;
                cmd.Parameters.Add("@AssignEmp", System.Data.SqlDbType.VarChar).Value = txtEmployee.Text.Trim();

                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = done;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                done = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (done)
        {
            ClearCommentsControl(Msg);
            ClientMessageToReload();
            //TrustControl1.ClientMsg(Msg);
            //txtCommentDtl.Text = txtCommentInternal.Text = txtCommentTransfer.Text = txtCommentAssign.Text = "";
            //txtEmployee.Text = "";
            //ddlStatusType.SelectedIndex = 0;
            //grdvComment.DataBind();
            //DetailsView1.DataBind();

            //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);

        }
        else
        {

            TrustControl1.ClientMsg(Msg);
            // Response.Redirect("NewTicket.aspx", true);

        }
    }

    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        for (int r = 1; r < DetailsView1.Rows.Count; r++)
        {
            if (DetailsView1.Rows[r].Cells.Count == 2)
            {
                if (!DetailsView1.Rows[r].Cells[1].HasControls())
                {
                    //DetailsView1.Rows[r].Cells[0].Text += "|" + DetailsView1.Rows[r].Cells[1].Text + "|";
                    if (DetailsView1.Rows[r].Cells[1].Text.Trim().Replace("&nbsp;", "").Replace("(", "").Replace(")", "").Replace(" ", "") == string.Empty)
                        DetailsView1.Rows[r].Visible = false;
                }
                else
                {
                    try
                    {
                        string HeaderText = DetailsView1.Rows[r].Cells[0].Text;
                        string test = ((DataBoundLiteralControl)(DetailsView1.Rows[r].Cells[1].Controls[0])).Text.Trim().Replace("&nbsp;", "").Replace("\r\n", "").Replace(" ", "").Replace("()", "");
                        if (((DataBoundLiteralControl)(DetailsView1.Rows[r].Cells[1].Controls[0])).Text.Trim().Replace("&nbsp;", "").Replace("\r\n", "").Replace(" ", "").Replace("()", "") == string.Empty)
                            DetailsView1.Rows[r].Visible = false;
                    }
                    catch (Exception) { }
                    try
                    {
                        //if (((EMP)(DetailsView1.Rows[r].Cells[1].Controls[1])).Username == "")
                        //DetailsView1.Rows[r].Visible = false;
                        if (((HiddenField)(DetailsView1.Rows[r].Cells[1].Controls[0])).Value == "")
                            DetailsView1.Rows[r].Visible = false;
                    }
                    catch (Exception) { }
                    try
                    {
                        //if (((BEFTN)(DetailsView1.Rows[r].Cells[1].Controls[1])).Code == "")
                        //    DetailsView1.Rows[r].Visible = false;
                    }
                    catch (Exception) { }
                }
            }
        }

        string LastOpendBy = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "LastOpendBy"));
        string RequestedBy = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "CreatedBy"));
        if (RequestedBy == Session["EMPID"].ToString())
            chkPrivate.Visible = false;

        if (LastOpendBy.Length > 0 && LastOpendBy != Session["EMPID"].ToString())
        {
            PanelTicketStatus.Visible = true;
            lblTicketStatus.Text = string.Format("Please wait, this Ticket is being processed by: <span class='trustclick' type='emp' val='{0}'>{0}</span>",
                LastOpendBy);//, TrustControl1.getValueOfKey("HOME"));
        }
        else
        {
            PanelTicketStatus.Visible = false;
        }

        try
        {
            string CreatedBy = string.Format("{0}", DataBinder.Eval(DetailsView1.DataItem, "CreatedBy"));
            if (CreatedBy.Trim().Length > 0)
                if (TrustControl1.isRole("ADMIN") ||
                    (Session["BRANCHID"].ToString() == "1" && Session["DEPTID"].ToString() == "7"))
                {
                    (DetailsView1.FindControl("cmdEditTicket")).Visible = true;
                }
        }
        catch (Exception) { }

    }
    protected void btnSendtoBranch_Click(object sender, EventArgs e)
    {
        int CommentType = 7;    //Assign to Branch

        if (ddlBranch.SelectedValue == "1")
            CommentType = 4;    //Transfer Team

        if (ddlBranch.SelectedValue == "-3")
        {
            TrustControl1.ClientMsg("Please Select Branch");
            ddlBranch.Focus();
        }
        else
        {
            string Msg = "";
            bool done = false;

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_AssignBranch_Comment_Insert";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = Request.QueryString["id"];
                    cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentBranch.Text.Trim();
                    cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                    cmd.Parameters.Add("@CommentType", System.Data.SqlDbType.Int).Value = CommentType;
                    cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                    cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value;
                    cmd.Parameters.Add("@AssignBranch", System.Data.SqlDbType.Int).Value = ddlBranch.SelectedValue;
                    cmd.Parameters.Add("@AssignDept", System.Data.SqlDbType.Int).Value = ddlDept.SelectedValue;

                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    done = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);
                }
            }

            if (done)
            {
                ClearCommentsControl(Msg);
                ClientMessageToReload();
                //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);

            }
            else
            {
                TrustControl1.ClientMsg(Msg);
                // Response.Redirect("NewTicket.aspx", true);
            }
        }
    }

    private void ClearCommentsControl(string Msg)
    {
        TrustControl1.ClientMsg(Msg);
        txtCommentDtl.Text = txtCommentInternal.Text = txtCommentTransfer.Text = txtCommentAssign.Text =txtCommentBranch.Text= "";
        txtEmployee.Text = "";
        ddlStatusType.SelectedIndex = 0;
        ddlBranch.SelectedIndex = 0;
        grdvComment.DataBind();
        DetailsView1.DataBind();
        DataList1.DataBind();
        
    }
    protected void SqlDataSourceTicket_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            panelVisible.Visible = true;
        }
        else
            panelVisible.Visible = false;
    }

    public string getLinkImage(object AID, object FileKey, object Extension)
    {
        string RetVal = "";
        RetVal = "ShowImage.ashx?aid=" + AID.ToString() + "&key=" + FileKey.ToString() + "&w=60&p=1";
        return RetVal;
    }

    public string FileSize(object val)
    {
        float SizeVal = (float.Parse(val.ToString()));
        string size = "Unknown Size";
        if (SizeVal > 0)
        {
            if (SizeVal >= 1073741824)
                size = String.Format("{0:##.###}", (SizeVal / 1073741824)) + " GB";
            else if (SizeVal >= 1048576)
                size = String.Format("{0:##.##}", (SizeVal / 1048576)) + " MB";
            else if (SizeVal >= 1024)
                size = String.Format("{0:##}", (SizeVal / 1024)) + " KB";
            else
                size = String.Format("{0:##}", (SizeVal)) + " Bytes";
        }
        return size;
    }
    protected void cmdAddAttach_Click(object sender, EventArgs e)
    {
        lblUploadStatus.Text = "Select PDF or JPEG file to upload. (max " + MaxFileSizePerPageKB + " KB per page)";
        modalUpload.Show();
    }

    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //if (FileUpload1.FileBytes.Length > (300 * 1024))
        //{
        //    throw new Exception("Invalid File Size");
        //}
        FileUpload1.SaveAs(Path.Combine(UploadPath, HidPageID.Value));
        FileInfo FI = new FileInfo(Path.Combine(UploadPath, HidPageID.Value));
        FI.CreationTime = DateTime.Now;
    }
    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }

    protected void cmdUpload_Click(object sender, EventArgs e)
    {
        //lblUploadStatus.Text = lblUploadStatus.ClientID;
        //modalUpload.Show();
        //return;
        lblUploadStatus.Text = "";

        try
        {
            bool test = File.Exists(Path.Combine(UploadPath, HidPageID.Value));
        }
        catch (Exception ex)
        {
            lblUploadStatus.Text = ex.Message;
            modalUpload.Show();
        }

        {
            try
            {
                string FileName = HidFileName.Value.Trim();
                string Extension = FileName.Substring(FileName.Trim().Length - 4, 4).ToUpper().Replace(".", "");
                switch (Extension)
                {
                    case "JPG":
                    //case "JPEG":
                    //case "GIF":
                    //case "DOC":
                    //case "XSL":
                    //case "PPT":
                    case "PDF":
                        if (InsertData(ReadFile(Path.Combine(UploadPath, HidPageID.Value)), true, FileName, Extension))
                        {
                            //GridView1.DataBind();
                            TrustControl1.ClientMsg("<b>" + FileName + "</b> is successfully attached.");
                            DataList1.DataBind();
                        }
                        break;
                    default:
                        //lblUploadStatus.Text = "Only DOC, XLS, PPT, JPG, GIF and PDF files can be Attached.";                        
                        lblUploadStatus.Text = "Only PDF or JPEG files can be Attached.";
                        modalUpload.Show();
                        //ClientScript.RegisterClientScriptBlock(GetType(), "alertMsg", "<script>alert('File type error.');</script>"); break;
                        break;
                }
            }
            catch (Exception ex)
            {
                lblUploadStatus.Text = ex.Message;
                modalUpload.Show();
            }
            //FileUpload1.PostedFile.FileName
            //lblUploadStatus.Text = FileUpload1.PostedFile.FileName.ToString();
        }
        //else
        //{
        //    lblUploadStatus.Text = "No file found. Please select file to upload.";
        //    modalUpload.Show();
        //}
    }
    protected byte[] ReadFile(string filePath)
    {
        byte[] buffer;
        FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
        try
        {
            int length = (int)fileStream.Length;  // get file length
            buffer = new byte[length];            // create buffer
            int count;                            // actual number of bytes read
            int sum = 0;                          // total number of bytes read

            // read until Read method returns 0 (end of the stream has been reached)
            while ((count = fileStream.Read(buffer, sum, length - sum)) > 0)
                sum += count;  // sum is a buffer offset for next reading
        }
        finally
        {
            fileStream.Close();
        }
        return buffer;
    }
    private bool InsertData(byte[] content, bool IsInsertNew, string FileName, string Extension)
    {
        bool RetVal = true;

        if (Extension == "JPG")
        {
            if (content.Length > MaxFileSizePerPageKB * 1024)
            {
                TrustControl1.ClientMsg(string.Format("JPG file size must be less than {0} kb", MaxFileSizePerPageKB));
                modalUpload.Show();
                return false;
            }
        }
        else if (Extension == "PDF")
        {
            using (Stream str = new MemoryStream(content))
            {
                using (Ghostscript.NET.Rasterizer.GhostscriptRasterizer _rasterizer = new Ghostscript.NET.Rasterizer.GhostscriptRasterizer())
                {
                    _rasterizer.Open(str,
                            GhostscriptVersionInfo.GetLastInstalledVersion(GhostscriptLicense.GPL | GhostscriptLicense.AFPL, GhostscriptLicense.GPL),
                            true);
                    if (content.Length > MaxFileSizePerPageKB * 1024 * _rasterizer.PageCount)
                    {
                        TrustControl1.ClientMsg(string.Format("Each page of PDF file size must be less than {0} kb", MaxFileSizePerPageKB));
                        modalUpload.Show();
                        RetVal = false;
                    }
                }
            }
        }

        if (!RetVal) return RetVal;

        byte[] _content = Common.Compress(content);

        SqlConnection objConn = null;
        SqlCommand objCom = null;
        try
        {
            objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString);
            objCom = new SqlCommand("s_Attachments_Add", objConn);
            objCom.CommandType = CommandType.StoredProcedure;


            objCom.Parameters.Add("@InsertBy", SqlDbType.VarChar).Value = Session["EMPID"];
            objCom.Parameters.Add("@Attachment", SqlDbType.Image).Value = _content;
            objCom.Parameters.Add("@FileName", SqlDbType.VarChar).Value = FileName;
            objCom.Parameters.Add("@Extension", SqlDbType.VarChar).Value = Extension;
            objCom.Parameters.Add("@FileSize", SqlDbType.Int).Value = content.Length;
            objCom.Parameters.Add("@SessionID", SqlDbType.VarChar).Value = HidPageID.Value;


            objConn.Open();
            int i = objCom.ExecuteNonQuery();
            objConn.Close();

            File.Delete(Path.Combine(UploadPath, HidPageID.Value));
            DeleteAllUploadedFiles();

            return true;

            //lblUploadStatus.Text = "File Uploadted and Saved as: <a href=\"Attachment.aspx?a="+ i.ToString() +"\">" + i.ToString() + "." + Extension + "</a>";
        }
        catch (Exception ex)
        {
            TrustControl1.ClientMsg("Error: " + ex.Message);
        }
        //finally
        //{
        //    //objConn.Close();
        //}

        return false;
    }

    private void DeleteAllUploadedFiles()
    {
        string[] UploadFiles = Directory.GetFiles(UploadPath);
        foreach (string uf in UploadFiles)
        {
            FileInfo FI = new FileInfo(uf);
            if (FI.CreationTime.AddHours(6) < DateTime.Now)
                try
                {
                    FI.Delete();
                }
                catch (Exception) { }
        }
    }
    protected void cmdDeleteAttachment_Click(object sender, EventArgs e)
    {
        string AttachmentID = ((LinkButton)(sender)).CommandArgument;

        //if (UserControl1.isRole("USER", "ADMIN"))    //ADMIN or SUPERVISER
        {
            SqlConnection objConn = null;
            SqlCommand objCom = null;
            bool Done = false;
            string Msg = " ";


            try
            {
                //string Q = "DELETE FROM Attachments WHERE AID = " + AttachmentID + " AND DEPTID = " + Session["DEPTID"] + " AND BranchID = " + Session["BRANCHID"];
                objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString);
                string Client_IP_Address = string.Empty;
                try
                {
                    Client_IP_Address = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
                }
                catch (Exception)
                {
                    try
                    {
                        Client_IP_Address = HttpContext.Current.Request.UserHostAddress;
                    }
                    catch (Exception)
                    {
                        Client_IP_Address = Request.ServerVariables["LOCAL_ADDR"].ToString();
                    }
                }
                objCom = new SqlCommand("s_Attachments_Delete", objConn);
                objCom.CommandType = CommandType.StoredProcedure;
                objCom.Parameters.AddWithValue("@AID", AttachmentID);
                objCom.Parameters.AddWithValue("@DeletedBy", Session["EMPID"]);
                objCom.Parameters.AddWithValue("@DeletedFrom", Client_IP_Address);
                //objCom = new SqlCommand(Q, objConn);                

                SqlParameter S_Done = new SqlParameter("@Done", SqlDbType.Bit);
                S_Done.Value = Done;
                S_Done.Direction = ParameterDirection.InputOutput;
                objCom.Parameters.Add(S_Done);

                SqlParameter S_Msg = new SqlParameter("@Msg", SqlDbType.VarChar);
                S_Msg.Value = Msg;
                S_Msg.Direction = ParameterDirection.InputOutput;
                S_Msg.Size = 255;
                objCom.Parameters.Add(S_Msg);

                objConn.Open();
                int i = objCom.ExecuteNonQuery();

                Done = (bool)S_Done.Value;
                Msg = string.Format("{0}", S_Msg.Value);

                objConn.Close();
                if (Done)
                {
                    //GridView1.DataBind();
                    TrustControl1.ClientMsg(Msg);
                    DataList1.DataBind();
                }
                else
                {
                    TrustControl1.ClientMsg(Msg);
                }
            }
            catch (Exception ex)
            {
                TrustControl1.ClientMsg("Error: " + ex.Message);
            }
        }
    }


    protected void ddlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlDept.Items.Clear();
        ddlDept.Items.Add(new ListItem("Select Department", " "));
        if (ddlBranch.SelectedValue != "1")
        ddlDept.Items.Add(new ListItem("Any Department", "0"));
        ddlDept.DataBind();
    }

    protected void SqlDataSourceTicketMailWise_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblEmailTicketStatus.Text = string.Format("Total: <b>{0:N0}</b>", e.AffectedRows);
        PanelTicketMailWise.Visible = e.AffectedRows > 0;
        
    }



    protected void cmdPost_Click(object sender, EventArgs e)
    {
        DetailsView1.DataBind();
        GridViewTicketMailWise.DataBind();
        grdvComment.DataBind();
    }
}
