using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using AjaxControlToolkit;
using System.Collections.Specialized;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string[] GetSearchResult(
        string prefixText, 
        int count)
    {
        List<string> items = new List<string>(count);

        if (count == 0) count = 15;
        BuildItemsFromDatabase(prefixText, count, items);
        return items.ToArray();
    }
    

    private static void BuildItemsFromDatabase(
        string prefixText, 
        int count, 
        List<string> items)
    {
        string Query = "SELECT TOP " + count + " EMPID, EMP FROM ViewEMP WHERE EMPINFO LIKE '%" + prefixText + "%' AND ServiceStatus = '1' ORDER BY EMPNAME";
        SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString0"].ConnectionString);
        SqlCommand oCommand = new SqlCommand(Query, oConn);
        if (oConn.State == ConnectionState.Closed) oConn.Open();

        SqlDataReader oR = oCommand.ExecuteReader();
        //if (oR.HasRows)
        //    HeaderFooter = true;            
        //BuildHeader();    
        while (oR.Read())
        {
            var html = string.Format("<table width='300px'><tr><td valign='top'>{0}</td><td valign='top' align='right'><img width='60px' src='EmpImage.aspx?EMPID={1}&W=60' ></td></tr></table>", oR["EMP"], oR["EMPID"]);
            var item = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(oR["EMPID"].ToString(), html);
            //items.Add(item);
            items.Add(item);
            
        }
        oR.Close();
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetDropDownContents_Parent(
        string knownCategoryValues, 
        string category)
    {
        //knownCategoryValues = knownCategoryValues.Replace("undefined:", "").Replace(";", "");
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        int DIV_CODE;
        if (!kv.ContainsKey("undefined") ||
        !Int32.TryParse(kv["undefined"], out DIV_CODE))
        {
            return null;
        }

        string Query = "SELECT ID, Name FROM [dbo].[Ticket_Type] WHERE Active = 1 AND Parent_ID = '" + DIV_CODE + "' ORDER BY Name";
        SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString);
        SqlCommand oCommand = new SqlCommand(Query, oConn);
        if (oConn.State == ConnectionState.Closed) oConn.Open();

        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();

        SqlDataReader oR = oCommand.ExecuteReader();    
        while (oR.Read())
        {
            values.Add(new CascadingDropDownNameValue(oR["Name"].ToString(), oR["ID"].ToString()));
        }
        oR.Close();
        oConn.Close();


        return values.ToArray();
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetDropDownContents_TicketType(
        string knownCategoryValues,
        string category)
    {
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        int DIST_CODE;
        if (!kv.ContainsKey("District") ||
        !Int32.TryParse(kv["District"], out DIST_CODE))
        {
            return null;
        }

        string Query = "SELECT ID, Name FROM [dbo].[Ticket_Type] WHERE Active = 1 AND Parent_ID = '" + DIST_CODE + "' ORDER BY Name";
        SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString);
        SqlCommand oCommand = new SqlCommand(Query, oConn);
        if (oConn.State == ConnectionState.Closed) oConn.Open();

        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();

        SqlDataReader oR = oCommand.ExecuteReader();
        while (oR.Read())
        {
            values.Add(new CascadingDropDownNameValue(oR["Name"].ToString(), oR["ID"].ToString()));
        }
        oR.Close();
        oConn.Close();

        return values.ToArray();
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetDropDownContents_TicketType_Br(
        string knownCategoryValues,
        string category)
    {
        //knownCategoryValues = knownCategoryValues.Replace("undefined:", "").Replace(";", "");
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        int DIV_CODE;
        if (!kv.ContainsKey("undefined") ||
        !Int32.TryParse(kv["undefined"], out DIV_CODE))
        {
            return null;
        }

        string Query = "SELECT Name,ID FROM dbo.Ticket_Type WHERE ID NOT IN(1,2,6,9,1006,1007,1008) AND ACTIVE=1 AND ( '" + DIV_CODE + "' = '*'  OR ( '" + DIV_CODE + "' = 'P'  AND isPublic=1)  OR ( '" + DIV_CODE + "' = 'I' AND isPublic=0)) ORDER BY Name";
        SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString);
        SqlCommand oCommand = new SqlCommand(Query, oConn);
        if (oConn.State == ConnectionState.Closed) oConn.Open();

        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();

        SqlDataReader oR = oCommand.ExecuteReader();
        while (oR.Read())
        {
            values.Add(new CascadingDropDownNameValue(oR["Name"].ToString(), oR["ID"].ToString()));
        }
        oR.Close();
        oConn.Close();


        return values.ToArray();
    }
}

