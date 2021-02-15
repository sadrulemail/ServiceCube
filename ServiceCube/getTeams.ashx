<%@ WebHandler Language="C#" Class="getTeams" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections.Generic;

public class getTeams : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");

        int DeptID = 0;
        try
        {
            DeptID = int.Parse(context.Request.QueryString["deptid"]);
        }
        catch (Exception) { }


        HttpCachePolicy cachePolicy = context.Response.Cache;
        cachePolicy.SetCacheability(HttpCacheability.ServerAndPrivate);
        cachePolicy.VaryByParams["deptid"] = true;        
        cachePolicy.SetOmitVaryStar(true);
        cachePolicy.SetExpires(DateTime.Now + TimeSpan.FromMinutes(15));
        cachePolicy.SetValidUntilExpires(true);

        String jSonString;

        System.Data.DataTable dtTable;
        SqlConnection.ClearAllPools();
        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "";
            //Query = string.Format(string.Format("EXEC s_Team_Select"));
            Query = string.Format(string.Format("SELECT * FROM dbo.f_Team_Child(" + DeptID + ")"));

            if (DeptID == 0)
                Query = string.Format(string.Format("SELECT * FROM dbo.f_Team_Child(NULL)"));
   
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

            jSonString = ConvertDataTableTojSonString(dtTable);            
        }

        context.Response.ContentType = "text/json";
        context.Response.Write(jSonString);
    }

    public String ConvertDataTableTojSonString(DataTable dataTable)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer =
               new System.Web.Script.Serialization.JavaScriptSerializer();

        List<Dictionary<String, Object>> tableRows = new List<Dictionary<String, Object>>();

        Dictionary<String, Object> row;

        foreach (DataRow dr in dataTable.Rows)
        {
            row = new Dictionary<String, Object>();
            foreach (DataColumn col in dataTable.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            tableRows.Add(row);
        }
        return serializer.Serialize(tableRows);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}