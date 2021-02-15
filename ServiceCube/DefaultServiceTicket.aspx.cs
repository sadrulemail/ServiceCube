using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

public partial class DefaultServiceTicket : System.Web.UI.Page
{
    static string verifiedLogo = "<img src='Images/verified.png' width='16' height='16' border='0' title='Verified' />";

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
        hidEmpID.Value = Session["EMPID"].ToString();
        hidDeptID.Value = Session["DEPTID"].ToString();

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
    protected void btnDefaultService_Click(object sender, EventArgs e)
    {
        if (hidAssignedTeamID.Value.Length > 0)
        {

            string Msg = "";
            bool isVerified = false;

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_MyDefaultServiceTicket";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EmpID", System.Data.SqlDbType.VarChar).Value = Session["EMPID"];
                    cmd.Parameters.Add("@DeptIDs", System.Data.SqlDbType.VarChar).Value = hidAssignedTeamID.Value;


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

            TrustControl1.ClientMsg(Msg);
        }
        else
            TrustControl1.ClientMsg("My Default Ticket has not been Saved. Please Select atleast one Ticket Service.");
    }

    
}
