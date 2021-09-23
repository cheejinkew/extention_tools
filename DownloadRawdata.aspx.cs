using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DownloadRawdata : System.Web.UI.Page
{
    StringBuilder sbExceltable;
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        sbExceltable = new StringBuilder();
        try
        { 
        dt = (DataTable)Session["rawdata"];
		  Response.Write("<table  style='font-family: Verdana; font-size: 14px; border-collapse: collapse; ' border='1' >");
        Response.Write("<thead><tr ><td colspan='4' style='text-align:center;' ><h3>Raw Data Report</h3></td></tr><tr><td colspan='4'></td></tr>");
        Response.Write("<thead  id='thead' background-color='#3c8dbc'><tr  ><th>#</th><th>Sim No/Unit ID</th><th>DateTime</th><th>Data</th> </tr></thead>");
        Response.Write("<tbody>");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            { 
                Response.Write("<tr><td>" + dt.Rows[i]["sno"] + "</td>");
                Response.Write("<td>" + dt.Rows[i]["SimNo"] + "</td>");
                Response.Write("<td>" + dt.Rows[i]["Timestamp"] + "</td>");
                Response.Write("<td>" + dt.Rows[i]["Data"] + "</td></tr>"); 
            }
        }
        Response.Write("</tbody>");
        Response.Write("</table>");
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment; filename=Raw_Data_Report_" + DateTime.Now .Ticks.ToString()+ ".xls;"); 
        Response.Flush(); // Sends all currently buffered output to the client.
        Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
        ApplicationInstance.CompleteRequest(); // Causes ASP.NET to bypass all events and filtering in the HTTP pipeline chain of execution and directly execute the EndRequest event.
        Response.End(); 
        }
        catch (Exception ex)
        {
            Response.Write("error:" + ex.Message);
        }
    }
}