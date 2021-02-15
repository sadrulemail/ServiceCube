using System;
using System.Collections;
using System.Web;

public partial class MasterLTE : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string getMenuActive(object node)
    {
        try
        {
            string PageUrl = HttpContext.Current.Request.Url.Segments[HttpContext.Current.Request.Url.Segments.Length - 1].Replace("/", "");
            

            SiteMapNode n = (SiteMapNode)node;
            string SiteMapUrl = n.Url;
            SiteMapUrl = (SiteMapUrl.Split('?'))[0].Replace("/", "");            

            if (SiteMapUrl.ToLower() == PageUrl.ToLower()) return "active";

            foreach(SiteMapNode cn in n.ChildNodes)
            {                
                SiteMapUrl = "/" + (cn.Url.Split('?'))[0];
                SiteMapUrl = SiteMapUrl.Substring(SiteMapUrl.LastIndexOf("/"));
                SiteMapUrl = SiteMapUrl.Replace("/", "");
                //Literal1.Text += SiteMapUrl + "<br>";
                if (SiteMapUrl.ToLower() == PageUrl.ToLower()) return "active";
            }
            
             
            
            //Literal1.Text += SiteMapUrl + "|" + PageUrl;
            
            //if (SiteMapUrl.ToLower() == PageUrl.ToLower())
            //{
            //    Literal1.Text += "|active<br />"; 
            //    return "active";
            //}
            //Literal1.Text += "<br />";
        }
        catch (Exception) { }
        return "";
    }
    public string getNodeValue(object node, string key)
    {
        try
        {
            return ((SiteMapNode)node)[key].ToString();
        }
        catch (Exception) { }
        return "";
    }

    public string getMenuClass(object node)
    {
        string ClassName = "";
        SiteMapNode n = (SiteMapNode)node;
        object roles = n.Roles;
        string branch = "*";
        try
        {
            branch = n["branch"].ToString();
            //Literal1.Text += " > " + branch;
        }
        catch (Exception) { }

        //Literal1.Text += "<br>" + Session["ROLES"].ToString() + " > ";
        string[] Roles = Session["ROLES"].ToString().Split(',');
        string BranchID = Session["BRANCHID"].ToString();
        ArrayList AL = (ArrayList)roles;        
        foreach (string s in AL)
        {
            //Literal1.Text += s + " | ";
            foreach (string Role in Roles)
                if (
                        (s == Role || s == "*")
                        &&
                        (
                            branch == "*"
                            || branch == BranchID
                            || (branch == "-1" && BranchID != "1")
                        )
                     )
                {
                    ClassName = "";
                    string PageName = HttpContext.Current.Request.Url.Segments[HttpContext.Current.Request.Url.Segments.Length - 1].Replace("/", "");
                    //return PageName;
                    string SiteMapUrl = n.Url;
                    SiteMapUrl = (SiteMapUrl.Split('?'))[0];
                    SiteMapUrl = (SiteMapUrl.Split('/'))[(SiteMapUrl.Split('/')).Length - 1];
                    //return SiteMapUrl;
                    if (SiteMapUrl.ToLower() == PageName.ToLower())
                        ClassName = "active";
                    return ClassName;
                }
        }

        
        

        return "hide";
    }
}
