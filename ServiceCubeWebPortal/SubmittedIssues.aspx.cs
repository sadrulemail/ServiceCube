using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ServiceCube
{
    public partial class SubmittedIssues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Submitted Issues - " + UserControl1.getValueOfKey("AppName");
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblStatus.Text = string.Format("Total Issues: <b>{0}</b>", e.AffectedRows);
        }
    }
}