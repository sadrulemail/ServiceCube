using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using Ghostscript.NET;
using System.IO;

public partial class NewTicket_Admin : System.Web.UI.Page
{
    static string verifiedLogo = "<img src='Images/verified.png' width='16' height='16' border='0' title='Verified' />";
    int MaxFileSizePerPageKB;
    protected void Page_Load(object sender, EventArgs e)
    {
        MaxFileSizePerPageKB = int.Parse(TrustControl1.getValueOfKey("MaxFileSizePerPageKB"));
        TrustControl1.getUserRoles();

        if (!IsPostBack)
        {
            this.Title = "Add Solved Ticket";
            if (!Directory.Exists(Server.MapPath("Upload")))
            {
                Directory.CreateDirectory(Server.MapPath("Upload"));
            }

            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());
            HidUploadTempFile.Value = Server.MapPath("Upload/" + HidPageID.Value);
        }

        if (panelCommaonTask.Visible)

            if (IsPostBack)
            {
                //panelButton.Visible = ddlServiceType.SelectedIndex > 0;
                //TrustControl1.ClientMsg(ddlServiceType.Items.Count.ToString());
            }
            else
            {
                //GetTicketNo();
                HideAllPanels();
            }

    }

    private void GetTicketNo()
    {
        string Ticket_No = "";
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_get_TicketNo";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlParameter Sql_TicketNo = new SqlParameter("@TicketNo", SqlDbType.VarChar, 255);
                    Sql_TicketNo.Direction = ParameterDirection.InputOutput;
                    Sql_TicketNo.Value = Ticket_No;
                    cmd.Parameters.Add(Sql_TicketNo);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();


                    Ticket_No = string.Format("{0}", Sql_TicketNo.Value);
                }

            }
        }

        catch (Exception ex)
        {
            TrustControl1.ClientMsg(ex.Message);
        }
        hidTicketNo.Value = Ticket_No;
    }

    private void HideAllPanels()
    {
        panelButton.Visible = false;
        panelDeleteReq.Visible = false;
    }

    protected void cboBranch_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
            try
            {

            }
            catch (Exception) { }
    }
    protected void cboDept_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
            try
            {

            }
            catch (Exception) { }
    }

    protected void ddlServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Disable All Combos of Ticket Types
        ddlServiceType.Enabled = false;
        ddlParent.Enabled = false;
        ddlRoot.Enabled = false;

        //TrustControl1.ClientMsg(TicketType);
        hidTicketType.Value = ddlServiceType.SelectedItem.Value;


        switch (hidTicketType.Value)
        {
            case "1":
                //Card Query
                panelCommaonTask.Visible = true;
                btnSubmit.Enabled = true;
                txtRequesterEmpID.Focus();
                break;
            case "2":
                panelCommaonTask.Visible = true;
                btnSubmit.Enabled = true;
                txtRequesterEmpID.Focus();
                break;
            case "3":
                //Flora Delete Request
                txtBatchNo.Focus();
                panelDeleteReq.Visible = true;
                lblBranchCode.Text = string.Format("0000{0}", Session["BRANCHID"]);
                lblBranchCode.Text = lblBranchCode.Text.Substring(lblBranchCode.Text.Length - 4);
                break;
            default:
                panelCommaonTask.Visible = true;
                btnSubmit.Enabled = true;
                txtRequesterEmpID.Focus();
                break;
        }

        //Visible Common Controls
        panelButton.Visible = true;
    }
    protected void btnCheck_Click(object sender, EventArgs e)
    {
        //ClientMsg(DetailsView1.SelectedValue.ToString());
        string Msg = "";
        bool isVerified = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Flora_Delete_Trn_Check";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@pass_user_id", System.Data.SqlDbType.VarChar).Value = txtAuthorizedID.Text.Trim();
                cmd.Parameters.Add("@trn_branch_code", System.Data.SqlDbType.VarChar).Value = lblBranchCode.Text.Trim();
                cmd.Parameters.Add("@batchno", System.Data.SqlDbType.VarChar).Value = txtBatchNo.Text.Trim();

                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = isVerified;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                isVerified = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (!isVerified)
        {
            //txtOTP.Text = "";
            TrustControl1.ClientMsg(Msg);
            lblCheckStatus.Text = string.Format("{0}", Msg);
            lblCheckStatus.CssClass = "error";


            btnSubmit.Enabled = true;
            panelCommaonTask.Visible = true;

            //ddlPriority.SelectedIndex = 1;
        }
        else
        {
            //OTP Verified
            //PanelOtp.Visible = false;
            //ShowNextPanel();
            TrustControl1.ClientMsg(Msg);
            InactiveBatchNo();
            lblCheckStatus.Text = verifiedLogo + " " + Msg;
            lblCheckStatus.CssClass = "";


            btnSubmit.Enabled = true;
            panelCommaonTask.Visible = true;
            txtSubject.Focus();
        }
    }

    private void InactiveBatchNo()
    {
        txtAuthorizedID.Enabled = false;
        txtBatchNo.Enabled = false;
        btnCheck.Enabled = false;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        GetTicketNo();

        switch (hidTicketType.Value)
        {
            case "1":
                //Card Query
                break;
            case "2":
                break;
            case "3":
                if (SaveFloraDeleteTransaction()) SaveCommonfieldData();
                break;
            default:
                SaveCommonfieldData();
                txtSubject.Text = txtCommentDtl.Text = "";
                break;
        }
    }


    protected void btnReset_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewTicket_Admin.aspx", true);
    }


    #region   Common Transaction insert
    private Boolean SaveCommonfieldData()
    {
        string Msg = "";
        bool isVerified = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Tickets_Insert_Admin";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = hidTicketNo.Value;
                cmd.Parameters.Add("@TicketTypeID", System.Data.SqlDbType.Int).Value = hidTicketType.Value;
                cmd.Parameters.Add("@Subject", System.Data.SqlDbType.VarChar).Value = txtSubject.Text.Trim();
                cmd.Parameters.Add("@Comments", System.Data.SqlDbType.VarChar).Value = txtCommentDtl.Text.Trim();
                cmd.Parameters.Add("@Priority", System.Data.SqlDbType.Int).Value = ddlPriority.SelectedValue.Trim();

                cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = TrustControl1.getIPAddress();
                cmd.Parameters.Add("@Status", System.Data.SqlDbType.Int).Value = ddlStatus.SelectedItem.Value;
                cmd.Parameters.Add("@FileIDs", System.Data.SqlDbType.VarChar).Value = hidFileIds.Value;
                cmd.Parameters.Add("@CreatedBy", System.Data.SqlDbType.VarChar).Value = txtRequesterEmpID.Text.Trim();
                cmd.Parameters.Add("@AddedBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"];
                string ax = hidFileIds.Value;
                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = isVerified;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                isVerified = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }

        if (!isVerified)
        {
            TrustControl1.ClientMsg(Msg);

        }
        else
        {

            TrustControl1.ClientMsg(Msg);
            //  Response.Redirect("NewTicket_Admin.aspx", true);

        }
        return isVerified;
    }

    #endregion

    #region Flora Delete Transaction Request
    private Boolean SaveFloraDeleteTransaction()
    {
        string Msg = "";
        bool isDone = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Flora_Delete_Trn_Request_Insert";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@TicketID", System.Data.SqlDbType.VarChar).Value = hidTicketNo.Value;
                cmd.Parameters.Add("@BranchCode", System.Data.SqlDbType.VarChar).Value = lblBranchCode.Text.Trim();
                cmd.Parameters.Add("@AuthorizedID", System.Data.SqlDbType.Int).Value = txtAuthorizedID.Text.Trim();
                cmd.Parameters.Add("@Req_Status", System.Data.SqlDbType.Bit).Value = true;
                // hidFileIds.Value;
                SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                SQL_Msg.Direction = ParameterDirection.InputOutput;
                SQL_Msg.Value = Msg;
                cmd.Parameters.Add(SQL_Msg);

                SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                SQL_Done.Direction = ParameterDirection.InputOutput;
                SQL_Done.Value = isDone;
                cmd.Parameters.Add(SQL_Done);

                cmd.Connection = conn;
                conn.Open();

                cmd.ExecuteNonQuery();

                isDone = (bool)SQL_Done.Value;
                Msg = string.Format("{0}", SQL_Msg.Value);
            }
        }
        return isDone;
    }
    #endregion

    protected void ddlPriority_DataBound(object sender, EventArgs e)
    {
        ddlPriority.SelectedIndex = 1;
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

    // for adding file
    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //if (FileUpload1.FileBytes.Length > (300 * 1024))
        //{
        //    throw new Exception("Invalid File Size");
        //}
        FileUpload1.SaveAs(HidUploadTempFile.Value);
        FileInfo FI = new FileInfo(HidUploadTempFile.Value);
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
            bool test = File.Exists(HidUploadTempFile.Value);
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
                        if (InsertData(ReadFile(HidUploadTempFile.Value), true, FileName, Extension))
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

            File.Delete(HidUploadTempFile.Value);

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

    protected void cmdAddAttach_Click(object sender, EventArgs e)
    {
        //ModalTitle.Text = "Add New File";
        //DetailsView3.ChangeMode(DetailsViewMode.Insert);
        //DetailsView3.CellPadding = 2;

        lblUploadStatus.Text = "Select PDF or JPEG file to upload. (max " + MaxFileSizePerPageKB + " KB per page)";
        modalUpload.Show();
    }

    public string getLinkImage(object AID, object FileKey, object Extension)
    {
        string RetVal = "";
        RetVal = "AttachShow.ashx?aid=" + AID.ToString() + "&key=" + FileKey.ToString() + "&w=60&p=1";
        return RetVal;
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

}