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

public partial class RawData_Report : System.Web.UI.Page
{
    public StringBuilder sbregions;
    public StringBuilder sbgroups;
    public StringBuilder sbsites;
    public StringBuilder sbzones;
    public StringBuilder sbdatapints;
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    [System.Web.Services.WebMethod()]
    public static ArrayList getCartData(string server, string version, string simno, string startdate, string enddate)
    {

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlconncetion"+server]);
        ArrayList aa = new ArrayList();
		 DataTable dt = new DataTable();
        dt.Columns.Add("Sno");
        dt.Columns.Add("SimNo");
        dt.Columns.Add("Timestamp");
        dt.Columns.Add("Data"); 
        try
        { 
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            command.CommandType = CommandType.Text;
            command.Connection = conn;
			//if(server =="SILO" )
			//{
			//	if(version=="M5"){
			//	  command.CommandText = "select simno,timestamp,data from vmi_gprs_inbox_table where simno='" + simno + "' and timestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";
				//} 
			//	else{
				//  command.CommandText = "select simno,timestamp,data from vmi_gprs_inbox_table where simno='6666' and timestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";

				//}
		//	}
			//else{
			
            if (version == "M5")
            {
                command.CommandText = "select simno,timestamp,data from telemetry_inbox_table where simno='" + simno + "' and timestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";
            }
			else if (version == "SMSM5")
            {
                command.CommandText = "select source as simno,dtimestamp as timestamp,data from sms_inbox_table where source='" + simno + "' and dtimestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";
            }
            else if (version == "M5N" || version == "S1" || version == "M6" || version == "M7")
            {
                command.CommandText = "select unitid as simno,dtimestamp timestamp,data  from gprs_inbox_table where unitid='" + simno + "' and dtimestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'";
            }
			  else if (version == "AUTOPUMP")
            {
                command.CommandText = "select '' as simno,getdate() as timestamp,data  from gprs_inbox_autopump_table";
            }
			//}
           // HttpContext.Current.Response.Write(command.CommandText);
            conn.Open();
            dr = command.ExecuteReader(); 
            ArrayList a = new ArrayList();
            int i = 0;
			DataRow r;
            while (dr.Read())
            {    
				r = dt.NewRow(); 
				r[0] = (i + 1).ToString(); 
                r[1] = dr["simno"].ToString();
                r[2] = Convert.ToDateTime(dr["timestamp"]).ToString("dd/MM/yyyy HH:mm:ss");
                r[3] = dr["data"].ToString().Replace("<","").Replace(">","");
                dt.Rows.Add(r);
				
                a = new ArrayList();
                a.Add(i + 1);
                a.Add(dr["simno"].ToString());  
                a.Add(Convert.ToDateTime( dr["timestamp"]).ToString("yyyy/MM/dd HH:mm:ss"));
                a.Add(dr["data"].ToString().Replace("<","").Replace(">","")); 
                aa.Add(a);
                i = i + 1;
            } 
			HttpContext.Current.Session.Remove("rawdata");
           HttpContext.Current.Session["rawdata"] = dt;		
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }
        return aa;
    }


     
    
}