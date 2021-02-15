using Facebook;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ServiceCube
{
    public partial class FB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string accessToken = "CAAKULT7DxOYBAI4ZBSvRZBjzq2xa1LXY7ZB6GDid8aDTmqGOgFqPZA4BZBiYq7enW16Fwg1KPz4i9QsmhP56pzRpgGZAPZBl0BKpK5Dy7JA6lSIeZBJaLUoHeae3L0qZBTbZAUNrDzIJSiOMM2tBN8ZA0MZCoBDPj4uqhJrtzOVpklO4CsHqYHsvq7Wv7jajKwjSpRI8OEeDCqIZCfQZDZD";
            FacebookClient fbc = new FacebookClient(accessToken);
            //fbc.AppId = "725872000877798";

            var client = new FacebookClient(accessToken);
            dynamic result = client.Get("me", new { fields = "id,name,email" });

            Label1.Text += "<br />" + result.id;
            Label1.Text += "<br />" + result.name;
            Label1.Text += "<br />" + result.email;
            //Label1.Text += "<br />" + result.user_photos;

            
            //JSONObject codesamplezObject = fbc.Get("/me");

        }
    }
}