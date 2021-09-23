using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class OpcTestData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod()]
    public static ArrayList getCartData(string server, string version, string startdate, string enddate)
    {

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlconncetion" + server]);
        ArrayList aa = new ArrayList();
        try
        {
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            command.CommandType = CommandType.Text;
            command.Connection = conn;
            if(version== "Device_Data")
                  command.CommandText = "select * from Device_Data where  timestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";
            else
                 command.CommandText = "select * from Opc_test_out";

            // HttpContext.Current.Response.Write(command.CommandText);
            conn.Open();
            dr = command.ExecuteReader();
            ArrayList a = new ArrayList();
            int i = 0;
            DataRow r;
            if (version == "Device_Data")
            { 
                while (dr.Read())
                {
                    a = new ArrayList();
                    a.Add(i + 1);
                    a.Add(dr["DEVICE_ID"].ToString());
                    a.Add(Convert.ToDateTime(dr["timestamp"]).ToString("yyyy/MM/dd HH:mm:ss"));
                    a.Add(dr["INPUT1"].ToString());
                    a.Add(dr["FLOAT"].ToString());
                    aa.Add(a);
                    i = i + 1;
                }
            }
            else
            { 
                while (dr.Read())
                {
                    a = new ArrayList();
                    a.Add(i + 1);
                    a.Add(dr["DEVICE_ID"].ToString()); 
                    a.Add(dr["OUTPUT1"].ToString());
                    a.Add(dr["R_OUTPUT1"].ToString());
                    a.Add(dr["FLOAT1"].ToString());
                    a.Add(dr["R_FLOAT1"].ToString()); aa.Add(a);
                    i = i + 1;
                }
            } 
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }
        return aa;
    }

}