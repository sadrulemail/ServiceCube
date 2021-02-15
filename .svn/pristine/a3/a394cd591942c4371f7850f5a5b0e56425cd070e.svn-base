using Ghostscript.NET;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ServiceCube
{
    public partial class NewService : System.Web.UI.Page
    {
        int MaxFileSizePerPageKB;
        string UploadPath;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            MaxFileSizePerPageKB = int.Parse(UserControl1.getValueOfKey("MaxFileSizePerPageKB"));
            UploadPath = Server.MapPath("Upload");

            if(!IsPostBack)
            {
                string Type = string.Format("{0}", Request.QueryString["type"]); ;
                
                if (Type != "Complain" && Type != "Request")
                {
                    Response.Redirect("Home.aspx", true);
                    return;
                }

                litTitle.Text = Type;
                this.Title = "New "+ litTitle.Text + " - " + UserControl1.getValueOfKey("AppName");

                Page.Form.Attributes.Add("enctype", "multipart/form-data");

                if (!Directory.Exists(UploadPath))
                {
                    Directory.CreateDirectory(UploadPath);
                }

                Random R = new Random(DateTime.Now.Millisecond +
                                DateTime.Now.Second * 1000 +
                                DateTime.Now.Minute * 60000 +
                                DateTime.Now.Hour * 3600000);

                HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());  
                
            }

            //Title = Session["LOGINLOGID"].ToString();
        }

        protected void ddlParent_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlParent.Enabled = false;
            ddlRoot.Enabled = false;

            hidTicketType.Value = ddlRoot.SelectedItem.Value;

            panelButton.Visible = true;
            panelCommaonTask.Visible = true;
            txtSubject.Focus();
        }

        protected void ddlPriority_DataBound(object sender, EventArgs e)
        {
            ddlPriority.SelectedIndex = 1;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //GetTicketNo();
            SaveCommonfieldData();                    
        }

        private Boolean SaveCommonfieldData()
        {
            string Msg = "";
            bool isVerified = false;
            string MsgBody = "";
            string MsgSubject = "";
            string PublicMail = "";


            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_Tickets_Insert_Public";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@TicketTypeID", System.Data.SqlDbType.Int).Value = hidTicketType.Value;
                    cmd.Parameters.Add("@Subject", System.Data.SqlDbType.NVarChar).Value = txtSubject.Text.Trim();
                    cmd.Parameters.Add("@Comments", System.Data.SqlDbType.NVarChar).Value = txtCommentDtl.Text.Trim();
                    cmd.Parameters.Add("@Priority", System.Data.SqlDbType.Int).Value = ddlPriority.SelectedValue.Trim();
                    cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value;
                    cmd.Parameters.Add("@LoginLogID", SqlDbType.BigInt).Value = Session["LOGINLOGID"].ToString();

                    cmd.Parameters.Add("@IP", System.Data.SqlDbType.VarChar).Value = UserControl1.getIPAddress();
                    //  cmd.Parameters.Add("@Status", System.Data.SqlDbType.Int).Value = 1;
                    //cmd.Parameters.Add("@FileIDs", System.Data.SqlDbType.VarChar).Value = hidFileIds.Value;
                    // cmd.Parameters.Add("@CreatedBy", System.Data.SqlDbType.VarChar).Value = "metun@yahoo.com";

                   //cmd.Parameters.Add("@PublicID", System.Data.SqlDbType.Int).Value = Session["emailID"];
                   //  string ss = Session["USERNAME"].ToString();

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

                    cmd.Parameters.Add("@EmailID", System.Data.SqlDbType.VarChar).Value = Session["USERNAME"].ToString().Trim();
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
                    MsgSubject = string.Format("{0}", SQL_MsgSubject_Out.Value);
                    MsgBody = string.Format("{0}", SQL_MsgBody_Out.Value);
                    PublicMail = string.Format("{0}", SQL_PublicMail.Value);
                }
            }

            if (!isVerified)
            {
                UserControl1.ClientAlert(Msg);
            }
            else
            {

                lblStatus.Text = (Msg);
                Panel1.Visible = false;
                Panel2.Visible = true;

                ////Send Email
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
                //    UserControl1.ClientMsg("<b>Unable to send email.</b><br />" + ex.Message);
                 
                //}

            }
            return isVerified;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("New.aspx", true);
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
                UserControl1.ClientAlert(ex.Message);
            }
            hidTicketNo.Value = Ticket_No;
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
                UserControl1.ModalShow("ModalPanel");
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
                                UserControl1.ModalHide("ModalPanel");
                                UserControl1.ClientAlert("<b>" + FileName + "</b> is successfully attached.");
                                DataList1.DataBind();
                                
                            }
                            break;
                        default:
                            //lblUploadStatus.Text = "Only DOC, XLS, PPT, JPG, GIF and PDF files can be Attached.";                        
                            lblUploadStatus.Text = "Only PDF or JPEG files can be Attached.";
                            UserControl1.ModalShow("ModalPanel");
                            //ClientScript.RegisterClientScriptBlock(GetType(), "alertMsg", "<script>alert('File type error.');</script>"); break;
                            break;
                    }
                }
                catch (Exception ex)
                {
                    lblUploadStatus.Text = ex.Message;
                    UserControl1.ModalShow("ModalPanel");
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
                    UserControl1.ClientAlert(string.Format("JPG file size must be less than {0} kb", MaxFileSizePerPageKB));
                    UserControl1.ModalShow("ModalPanel");
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
                            lblUploadStatus.Text = (string.Format("Each page of PDF file size must be less than {0} kb", MaxFileSizePerPageKB));
                            UserControl1.ModalShow ("ModalPanel");
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


                objCom.Parameters.Add("@PublicID", SqlDbType.VarChar).Value = Session["USERID"].ToString();
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
                UserControl1.ClientAlert("Error: " + ex.Message);
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

        protected void cmdAddAttach_Click(object sender, EventArgs e)
        {
            //ModalTitle.Text = "Add New File";
            //DetailsView3.ChangeMode(DetailsViewMode.Insert);
            //DetailsView3.CellPadding = 2;

            lblUploadStatus.Text = "Select PDF or JPEG file to upload. (max " + MaxFileSizePerPageKB + " KB per page)";
            UserControl1.ModalShow("ModalPanel");
        }

        public string getLinkImage(object AID, object FileKey, object Extension)
        {
            string RetVal = "";
            RetVal = "ShowImage.ashx?aid=" + AID.ToString() + "&key=" + FileKey.ToString() + "&w=60&p=1";
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
                 
                    objCom.Parameters.AddWithValue("@PublicID", Session["USERID"]);
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
                        UserControl1.ClientAlert(Msg);
                        DataList1.DataBind();
                    }
                    else
                    {
                        UserControl1.ClientAlert(Msg);
                    }
                }
                catch (Exception ex)
                {
                    UserControl1.ClientAlert("Error: " + ex.Message);
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

        protected void cmdTestClose_Click(object sender, EventArgs e)
        {
            UserControl1.ModalHide("ModalPanel");
        }
    }
}