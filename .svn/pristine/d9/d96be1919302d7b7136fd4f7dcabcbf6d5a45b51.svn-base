using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

public class ChatHub : Hub
{
    public ChatHub()
    {

    }
    public void Hello()
    {
        Clients.All.hello();
    }

    public void registerConId(string UserID, string TicketID)
    {
        if (UserID.ToString() == "" || TicketID.ToString() == "") return;

        string Query = "s_Clients_Add";
        using (SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString))
        {
            using (SqlCommand oCommand = new SqlCommand(Query, oConn))
            {
                oCommand.Parameters.AddWithValue("@ConnectionID", Context.ConnectionId);
                oCommand.Parameters.AddWithValue("@EmpID", UserID);
                oCommand.Parameters.AddWithValue("@TicketID", TicketID);
                oCommand.CommandType = System.Data.CommandType.StoredProcedure;
                if (oConn.State == System.Data.ConnectionState.Closed) oConn.Open();
                oCommand.ExecuteNonQuery();
            }
        }
    }

    public void disconnectConId(string UserID, string TicketID)
    {
        if (UserID.ToString() == "" || TicketID.ToString() == "") return;

        string Query = "s_Clients_Remove";
        using (SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString))
        {
            using (SqlCommand oCommand = new SqlCommand(Query, oConn))
            {
                oCommand.Parameters.AddWithValue("@ConnectionID", Context.ConnectionId);
                oCommand.Parameters.AddWithValue("@EmpID", UserID);
                oCommand.Parameters.AddWithValue("@TicketID", TicketID);
                oCommand.CommandType = System.Data.CommandType.StoredProcedure;
                if (oConn.State == System.Data.ConnectionState.Closed) oConn.Open();
                oCommand.ExecuteNonQuery();
            }
        }
    }

    public override Task OnDisconnected(bool stopCalled)
    {
        try
        {
            string Query = "s_Clients_Delete";
            using (SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString))
            {
                using (SqlCommand oCommand = new SqlCommand(Query, oConn))
                {
                    oCommand.Parameters.AddWithValue("@ConnectionID", Context.ConnectionId);                    
                    oCommand.CommandType = System.Data.CommandType.StoredProcedure;
                    if (oConn.State == System.Data.ConnectionState.Closed) oConn.Open();
                    oCommand.ExecuteNonQuery();
                }
            }
        }
        catch (Exception) { }
        
        return base.OnDisconnected(stopCalled);
    }

    public static void SendClientMsg(string empid, string ticketid, string message, string reload)   //connID not needed
    {
        var context = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();
        List<string> ConnectionIDs = new List<string>();

        string Query = "s_Clients_Get";
        using (SqlConnection oConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ServiceCubeConnectionString"].ConnectionString))
        {
            using (SqlCommand oCommand = new SqlCommand(Query, oConn))
            {
                oCommand.Parameters.AddWithValue("@TicketID", ticketid);
                oCommand.Parameters.AddWithValue("@EmpID", empid);
                oCommand.CommandType = System.Data.CommandType.StoredProcedure;
                if (oConn.State == System.Data.ConnectionState.Closed) oConn.Open();
                SqlDataReader oReader = oCommand.ExecuteReader();

                while (oReader.Read())
                {
                    ConnectionIDs.Add(oReader["ConnectionID"].ToString());
                }

                oReader.Close();
            }
        }

        context.Clients.Clients(ConnectionIDs).broadcastMessage(empid, ticketid, message, reload);

    }
}