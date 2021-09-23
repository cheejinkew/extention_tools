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

public partial class Rawdata_Currpted : System.Web.UI.Page
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
    public static ArrayList getCartData(string server, string startdate, string enddate)
    {

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlconncetion" + server]);
        ArrayList aa = new ArrayList();
        DataTable dt = new DataTable();
        dt.Columns.Add("Sno");
        dt.Columns.Add("SimNo"); 
        dt.Columns.Add("datacount");
        try
        {
            SqlCommand command = new SqlCommand();
            SqlDataReader dr;
            command.CommandType = CommandType.Text;
            command.Connection = conn;
            
                command.CommandText = "select distinct unitid,count(data) datacount FROM gprs_inbox_table WHERE dtimestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "' and len(data)> 70 and data LIKE '%[abcdefghijklmnopqrstuvwxyz=><:()?]%' collate Latin1_General_CS_AS group by unitid";
            
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
                r[1] = dr["unitid"].ToString();
                r[2] = dr["datacount"].ToString(); 
                dt.Rows.Add(r);

                a = new ArrayList();
                a.Add(i + 1);
                a.Add(dr["unitid"].ToString());
                a.Add("<a style = 'cursor:pointer;font-weight :bold ;' class='text-info' onclick=\"javascript :GetCurruptdata('" + server + "','" + dr["unitid"].ToString() + "')\">" + dr["datacount"].ToString() + "</a>"); 
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

    [System.Web.Services.WebMethod()]
    public static ArrayList getCUrreptData(string server, string unitid, string startdate, string enddate)
    {

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlconncetion" + server]);
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
            command.CommandText = "select unitid as simno,data,dtimestamp as timestamp FROM gprs_inbox_table WHERE unitid='" + unitid +"' and dtimestamp between '" + Convert.ToDateTime(startdate).ToString("yyyy/MM/dd 00:00:00") + "' and '" + Convert.ToDateTime(enddate).ToString("yyyy/MM/dd 23:59:59") + "'  and len(data)>70 and data LIKE '%[abcdefghijklmnopqrstuvwxyz=><:()?]%' collate Latin1_General_CS_AS";
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
                r[3] = dr["data"].ToString().Replace("<", "").Replace(">", "");
                dt.Rows.Add(r);

                a = new ArrayList();
                a.Add(i + 1);
                a.Add(dr["simno"].ToString());
                a.Add(Convert.ToDateTime(dr["timestamp"]).ToString("yyyy/MM/dd HH:mm:ss"));
                a.Add(dr["data"].ToString().Replace("<", "").Replace(">", ""));
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