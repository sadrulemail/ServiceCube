<%@ WebHandler Language="C#" Class="getDefaultService" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections.Generic;
using System.Text;

public class getDefaultService : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");

        int DeptID = 0;
        string EmpID = "0";
        try
        {
            DeptID = int.Parse(context.Request.QueryString["deptid"]);
            EmpID = context.Request.QueryString["empid"];
        }
        catch (Exception) { }


        //HttpCachePolicy cachePolicy = context.Response.Cache;
        //cachePolicy.SetCacheability(HttpCacheability.ServerAndPrivate);
        //cachePolicy.VaryByParams["deptid"] = true;
        //cachePolicy.VaryByParams["empid"] = true;
        //cachePolicy.SetOmitVaryStar(true);
        //cachePolicy.SetExpires(DateTime.Now + TimeSpan.FromMinutes(15));
        //cachePolicy.SetValidUntilExpires(true);

        StringBuilder sb = new StringBuilder();

        System.Data.DataTable dtTable;
        SqlConnection.ClearAllPools();
        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "";
            //Query = string.Format(string.Format("EXEC s_Team_Select"));
            Query = string.Format(string.Format("SELECT * FROM dbo.f_Default_Service(" + DeptID + ",'" + EmpID + "')"));

            if (DeptID == 0)
                Query = string.Format(string.Format("SELECT * FROM dbo.f_Default_Service(NULL,'"+EmpID+"')"));
   
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["ServiceCubeConnectionString"].ConnectionString;
            if (conn.State == ConnectionState.Closed) conn.Open();

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                ad.Fill(ds);

                dtTable = ds.Tables[0];
            }
            //string jString = "";
            //foreach (DataRow dtRow in dtTable.Rows)
            //{
            //    jString +="{ 'id' :" + dtRow["DeptID"].ToString()+", 'parent':"+dtRow["ParentDept"].ToString()+", 'text':"+dtRow["Department"].ToString()+", state:{ 'opened': true}},";
               
            //}

            //JObject json = JObject.Parse(jString);
            //string formatted = json.ToString();

            foreach (DataRow oRow in dtTable.Rows)
            {
                sb.Append("{");

                sb.Append("\"id\":" + oRow["id"].ToString());
                sb.Append(",\"text\":\"" + toJS(oRow["text"]) + "\"");
                sb.Append(",\"parent\":\"" + oRow["parent"].ToString() + "\"");
                sb.Append(",\"state\":{\"selected\":" + oRow["selected"].ToString().ToLower() + "}");

                sb.Append("},");
            }
        }

        context.Response.ContentType = "text/json";
        context.Response.Write("[" + sb.ToString().Substring(0, sb.ToString().Length - 1) + "]");
    }

    //public String ConvertDataTableTojSonString(DataTable dataTable)
    //{
    //    System.Web.Script.Serialization.JavaScriptSerializer serializer =
    //           new System.Web.Script.Serialization.JavaScriptSerializer();

    //    List<Dictionary<String, Object>> tableRows = new List<Dictionary<String, Object>>();

    //    Dictionary<String, Object> row;

    //    foreach (DataRow dr in dataTable.Rows)
    //    {
    //        row = new Dictionary<String, Object>();
    //        foreach (DataColumn col in dataTable.Columns)
    //        {
    //            row.Add(col.ColumnName, dr[col]);
    //        }
    //        tableRows.Add(row);
    //    }
    //    return serializer.Serialize(tableRows);
    //}

    protected string toJS(object value)
    {
        try
        {
            return HttpUtility.JavaScriptStringEncode(value.ToString().Replace("\n", ""));
        }
        catch (Exception)
        {
            return "";
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}