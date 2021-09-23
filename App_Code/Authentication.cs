using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for Authentication
/// </summary>
public class Authentication
{
	public Authentication()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public  string CheckLogin(string username, string password)
    {
        string result = "N";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]);
        SqlDataReader dr;
      
        try
        {
            SqlCommand command = new SqlCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.Connection = conn;
            command.CommandText = "sp_LoginChcek";
            command.Parameters.AddWithValue("@username", username);
            command.Parameters.AddWithValue("@pwd", password);
            conn.Open();
            dr = command.ExecuteReader();
            if (dr.Read())
            {
                HttpContext.Current.Session["companyname"] = dr["companyname"].ToString();
                HttpContext.Current.Session["username"] = dr["username"].ToString();
                HttpContext.Current.Session["userid"] = dr["userid"].ToString(); 
                result = "Y";
            }
            dr.Close();

            conn.Close();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            conn.Close();
        }
        return result;

    }
}