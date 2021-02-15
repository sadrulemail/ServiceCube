<%@ WebHandler Language="C#" Class="SearchBox" %>

using System;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.SessionState;

public class SearchBox : IHttpHandler, IReadOnlySessionState
{
    [WebMethod(EnableSession = true)]
    public void ProcessRequest(HttpContext context)
    {
        string prefixText = context.Request.QueryString["term"];

        //System.Threading.Thread.Sleep(2000);
        using (SqlConnection conn = new SqlConnection())
        {
            SqlConnection.ClearAllPools();
            string Query = string.Format("EXEC s_Emp_SearchBox_AssignEmp '{0}', '{1}', '{2}', '{3}'",
                prefixText, 
                context.Session["EMPID"],
                context.Session["DEPTID"],
                context.Session["BRANCHID"]);
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = Query;
                cmd.Connection = conn;
                StringBuilder sb = new StringBuilder();
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    //while (sdr.Read())
                    //{
                    //    sb.Append(
                    //        string.Format("{0},{1},{2},{3}"
                    //        , sdr["RESULT"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                    //        , sdr["Img"]
                    //        , sdr["ID"]
                    //        , sdr["URL"])
                    //        ).Append(Environment.NewLine);
                    //}
                    while (sdr.Read())
                    {
                        sb.Append("{").Append(
                            string.Format("\"name\":\"{0}\",\"img\":\"{1}\",\"id\":\"{2}\",\"profile\":\"{3}\",\"result\":\"{4}\""
                            , sdr["name"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                            , sdr["Img"]
                            , sdr["ID"]
                            , sdr["URL"]
                            , sdr["result"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                            )
                            ).Append("},");
                    }
                }
                conn.Close();
                try
                {
                    context.Response.Write("[" + sb.ToString().Substring(0, sb.Length - 1) + "]");
                }
                catch (Exception) { context.Response.Write("[]"); }
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}