using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class SiteSurvey_ReportViewer : System.Web.UI.Page
{
	string connectionString = @"Server=121.121.9.121;Database=SITESERVEY;User ID = gussbee28; Password=$mango#17;MultipleActiveResultSets=True;Max Pool Size=10000;Pooling=true";

	protected void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
		{
			PrintReport();
		}
	}
		void PrintReport()
		{
			SqlConnection sqlCon = new SqlConnection(connectionString);
			SqlCommand sqlCmd = new SqlCommand();

			string formId = "";

			if (Request.QueryString["id"] != null)
			{
				formId = Request.QueryString["id"];
			}

			sqlCmd.Connection = sqlCon;
			sqlCmd.CommandText = "selectAllRecordByFormId";
			sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
			sqlCmd.Parameters.Add(new SqlParameter("@FormId", formId));

			sqlCon.Open();
			SqlDataReader dr = sqlCmd.ExecuteReader();
			DataTable dt = new DataTable();
			dt.Load(dr);
			sqlCon.Close();
			ReportViewer2.Reset();
			ReportViewer2.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
			ReportViewer2.LocalReport.ReportPath = Server.MapPath("~/Report/SiteSurveyForm report.rdlc");
			ReportViewer2.LocalReport.EnableHyperlinks = true;
		}	
}