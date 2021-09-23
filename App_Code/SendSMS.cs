using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for SendSMS
/// </summary>
public class SendSMS
{
	public SendSMS()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string SendMessage(string phno, string message,string sid)
    {
        string result = "N";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]);
        int res = 0;
        try
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.Text;
            command.Connection = conn; 
            conn.Open();
            command.CommandText = "insert into sms_outbox_temp_table(destination,smessage,application,sid) values('" + phno + "',N'" + message + "','2','"+sid+"')";
            res = command.ExecuteNonQuery();
            if (res > 0)
            {
                result = "Y";
            }
        }
        catch (Exception ex)
        {
            result = ex.Message;
        }
        finally
        {
            conn.Close();
        }
        return result;
    }
}