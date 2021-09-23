using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Data.OleDb;
//using Microsoft.Reporting.WebForms;

public partial class SiteSurvey_Report : System.Web.UI.Page
{
	//string startdate = reportrange.Text;
	string connectionString = @"Server=121.121.9.121;Database=SITESERVEY;User ID = gussbee28; Password=$mango#17;MultipleActiveResultSets=True;Max Pool Size=10000;Pooling=true";
	OleDbConnection Econ;
	SqlConnection con;
	string constr, Query, sqlconn;

	protected void Page_Load(object sender, EventArgs e)
	{


		if (!IsPostBack)
		{
			//PopulateGridview();
			BindDropDownlist();
		}

		using (SqlConnection sqlCon = new SqlConnection(connectionString))
		{
			SqlCommand sqlCmd = new SqlCommand();
			string teamLeader = ddlTeamLeader.SelectedValue;
			string district = ddlDistrict.SelectedValue;
			string date1;
			string date2;

			string startdate = startdatepicker.Text;
			string enddate = enddatepicker.Text;

			if (enddate != "")
			{
				DateTime eDate = Convert.ToDateTime(enddate);
				enddate = eDate.AddDays(1).ToString("yyyy-MM-dd");
			}

			if (teamLeader == "")
			{
				teamLeader = "ALL";
			}

			if (district == "")
			{
				district = "ALL";
			}

			//for kew gridview
			SqlDataAdapter sqlDa = new SqlDataAdapter("select * from tblSiteSurveyForm", sqlCon);
			DataTable dtbl = new DataTable();
			sqlDa.Fill(dtbl);

			sqlCmd.Connection = sqlCon;
			sqlCmd.CommandText = "selectAllRecord";
			sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
			sqlCmd.Parameters.Add(new SqlParameter("@TeamLeader", teamLeader));
			sqlCmd.Parameters.Add(new SqlParameter("@District", district));
			sqlCmd.Parameters.Add(new SqlParameter("@date1", startdate));
			sqlCmd.Parameters.Add(new SqlParameter("@date2", enddate));

			sqlCon.Open();
			SqlDataReader dr = sqlCmd.ExecuteReader();
			DataTable dt = new DataTable();
			dt.Load(dr);

			gvEmployees.DataSource = dt;
			gvEmployees.DataBind();
			//txtTotalRecord.Text = dt.Rows.Count.ToString();
			txtTotalRecord.Text = "Total record:" + dt.Rows.Count.ToString();
			sqlCon.Close();
		}
	}

	protected void btnUpload_Click(object sender, EventArgs e)
	{
		try
		{

			string excelPath = string.Concat(Server.MapPath("~/UploadFile/" + FileUpload1.PostedFile.FileName));
			FileUpload1.SaveAs(excelPath);

			InsertExcelRecords(excelPath);
			lblMessage.Text = "Your file uploaded successful";
			lblMessage.ForeColor = System.Drawing.Color.Green;
			BindDropDownlist();
			BindGridview();

		}
		catch (Exception ex)
		{
			lblMessage.Text = "Your file not uploaded";
			lblMessage.ForeColor = System.Drawing.Color.Red;
			Console.WriteLine(ex.Message);
		}
		//}
	}


	protected void Report_Click(object sender, EventArgs e)
	{
		LinkButton btn = (LinkButton)(sender);
		string Id = btn.CommandArgument;
		//Response.Redirect("SiteSurvey_ReportViewer.aspx?Id=" + Id);
		//Response.Write("<script>window.open ('SiteSurvey_ReportViewer.aspx?Id=" + Id + "','_blank');</script>");

		Response.Write("<script>");
		Response.Write("window.open('SiteSurvey_ReportViewer.aspx?Id=" + Id + "' ,'_blank')");
		Response.Write("</script>");

	}


	//way 2


	private void InsertExcelRecords(string FilePath)
	{
		constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=Excel 12.0;");


		//constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 12.0;", FilePath);
		//constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C: \Users\cheej\Desktop\Site Survey form.xls;Extended Properties=Excel 12.0;");


		Econ = new OleDbConnection(constr);

		Query = string.Format("Select * FROM [{0}]", "Sheet1$");
		OleDbCommand Ecom = new OleDbCommand(Query, Econ);
		Econ.Open();
		DataSet ds = new DataSet();
		OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
		Econ.Close();

		oda.Fill(ds);
		DataTable Exceldt = ds.Tables[0];
		con = new SqlConnection(connectionString);

		//Clear record in tblSiteSurveyForm
		con.Open();
		string query = "DELETE FROM tblSiteSurveyForm";
		SqlCommand sqlCmd = new SqlCommand(query, con);
		sqlCmd.ExecuteNonQuery();
		con.Close();


		//creating object of SqlBulkCopy    
		SqlBulkCopy objbulk = new SqlBulkCopy(con);
		//assigning Destination table name    
		objbulk.DestinationTableName = "tblSiteSurveyForm";

		//Mapping Table column    
		objbulk.ColumnMappings.Add("Added Time", "AddedTime");
		objbulk.ColumnMappings.Add("IP Address", "IPAddress");
		objbulk.ColumnMappings.Add("Form ID", "FormID");
		objbulk.ColumnMappings.Add("TEAM LEADER", "TeamLeader");
		objbulk.ColumnMappings.Add("Team Member", "TeamMember");
		objbulk.ColumnMappings.Add("SITE COMMENT - Issues", "SiteComment");
		objbulk.ColumnMappings.Add("SIm Card No ( If any )", "SImCardNo");
		objbulk.ColumnMappings.Add("NEW or EXISTING ?", "NewOrExisting");
		objbulk.ColumnMappings.Add("SITE INFO", "SiteInfo");
		objbulk.ColumnMappings.Add("TYPE", "Type");
		objbulk.ColumnMappings.Add("NEW SITES in District", "NewSitesInDistrict");
		objbulk.ColumnMappings.Add("District", "District");
		objbulk.ColumnMappings.Add("WTP : Kota Tinggi", "WTP_KotaTinggi");
		objbulk.ColumnMappings.Add("WTP - Johor Bahru", "WTP_JohorBahru");
		objbulk.ColumnMappings.Add("BPH _ Kota tinggi", "BPH_KotaTinggi");
		objbulk.ColumnMappings.Add("BPH - Johor Bahru", "BPH_JohorBahru");
		objbulk.ColumnMappings.Add("BPH : Batu Pahat", "BPH_BatuPahat");
		objbulk.ColumnMappings.Add("BPH : Kluang", "BPH_Kluang");
		objbulk.ColumnMappings.Add("BPH : Pontian", "BPH_Pontian");
		objbulk.ColumnMappings.Add("BPH : Segamat", "BPH_Segamat");
		objbulk.ColumnMappings.Add("WTP : Batu Pahat", "WTP_BatuPahat");
		objbulk.ColumnMappings.Add("WTP : Kluang", "WTP_Kluang");
		objbulk.ColumnMappings.Add("WTP : Mersing", "WTP_Mersing");
		objbulk.ColumnMappings.Add("WTP : Muar", "WTP_Muar");
		objbulk.ColumnMappings.Add("WTP : Segamat", "WTP_Segamat");
		objbulk.ColumnMappings.Add("RMS : Kota Tinggi Selatan", "RMS_KotaTinggiSelatan");
		objbulk.ColumnMappings.Add("RMS : Kota Tinggu Utara", "RMS_KotaTingguUtara");
		objbulk.ColumnMappings.Add("RMS : JB Barat", "RMS_JBBarat");
		objbulk.ColumnMappings.Add("RMS : Jb Timur", "RMS_JbTimur");
		objbulk.ColumnMappings.Add("RMS : Mersing", "RMS_Mersing");
		objbulk.ColumnMappings.Add("RMS : Pontian", "RMS_Pontian");
		objbulk.ColumnMappings.Add("RMS : Segamat", "RMS_Segamat");
		objbulk.ColumnMappings.Add("RMS : Batu Pahat", "RMS_BatuPahat");
		objbulk.ColumnMappings.Add("RMS : Kluang", "RMS_Kluang");
		objbulk.ColumnMappings.Add("RMS : Muar", "RMS_Muar");
		objbulk.ColumnMappings.Add("CHANGED Any parts ?", "ChangedAnyParts");
		objbulk.ColumnMappings.Add("RMS : SPARE PARTS", "RMS_SpareParts");
		objbulk.ColumnMappings.Add("WTP/BPH : SPARE PARTS", "WTP_BPH_SpareParts");
		objbulk.ColumnMappings.Add("Remarks", "Remarks");
		objbulk.ColumnMappings.Add("Image Upload", "ImageUpload");
		objbulk.ColumnMappings.Add("Image Upload", "ImageUpload2");
		objbulk.ColumnMappings.Add("COMMENTS", "Comments");
		objbulk.ColumnMappings.Add("Submitter's Location", "SubmitterLocation");
		objbulk.ColumnMappings.Add("Submitter's Latitude", "SubmitterLatitude");
		objbulk.ColumnMappings.Add("Submitter's Longitude", "SubmitterLongitude");
		objbulk.ColumnMappings.Add("Date-Time", "DateTime");

		//inserting Datatable Records to DataBase    
		con.Open();
		objbulk.WriteToServer(Exceldt);
		con.Close();
	}

	void BindDropDownlist()
	{
		SqlConnection sqlCon = new SqlConnection(connectionString);
		string com = "select distinct TeamLeader from tblSiteSurveyForm";
		SqlDataAdapter adpt = new SqlDataAdapter(com, sqlCon);
		DataTable dt = new DataTable();
		adpt.Fill(dt);
		ddlTeamLeader.DataSource = dt;
		ddlTeamLeader.DataTextField = "TeamLeader";
		ddlTeamLeader.DataValueField = "TeamLeader";
		ddlTeamLeader.DataBind();
		ddlTeamLeader.Items.Insert(0, new ListItem("ALL", "ALL"));

		string com1 = "select distinct District from tblSiteSurveyForm";
		SqlDataAdapter adpt1 = new SqlDataAdapter(com1, sqlCon);
		DataTable dt1 = new DataTable();
		adpt1.Fill(dt1);
		ddlDistrict.DataSource = dt1;
		ddlDistrict.DataTextField = "District";
		ddlDistrict.DataValueField = "District";
		ddlDistrict.DataBind();
		ddlDistrict.Items.Insert(0, new ListItem("ALL", "ALL"));

		startdatepicker.Text = DateTime.Today.ToString("yyyy-MM-dd");
		enddatepicker.Text = DateTime.Today.ToString("yyyy-MM-dd");
	}

	void BindGridview()
	{
		using (SqlConnection sqlCon = new SqlConnection(connectionString))
		{
			SqlCommand sqlCmd = new SqlCommand();
			string teamLeader = ddlTeamLeader.SelectedValue;
			string district = ddlDistrict.SelectedValue;
			string date1;
			string date2;
			string startdate = startdatepicker.Text;
			string enddate = enddatepicker.Text;

			if (enddate != "")
			{
				DateTime eDate = Convert.ToDateTime(enddate);
				enddate = eDate.AddDays(1).ToString("yyyy-MM-dd");
			}


			if (teamLeader == "")
			{
				teamLeader = "ALL";
			}

			if (district == "")
			{
				district = "ALL";
			}

			//for kew gridview
			SqlDataAdapter sqlDa = new SqlDataAdapter("select * from tblSiteSurveyForm", sqlCon);
			DataTable dtbl = new DataTable();
			sqlDa.Fill(dtbl);

			sqlCmd.Connection = sqlCon;
			sqlCmd.CommandText = "selectAllRecord";
			sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
			sqlCmd.Parameters.Add(new SqlParameter("@TeamLeader", teamLeader));
			sqlCmd.Parameters.Add(new SqlParameter("@District", district));
			sqlCmd.Parameters.Add(new SqlParameter("@date1", "ALL"));
			sqlCmd.Parameters.Add(new SqlParameter("@date2", "ALL"));

			sqlCon.Open();
			SqlDataReader dr = sqlCmd.ExecuteReader();
			DataTable dt = new DataTable();
			dt.Load(dr);

			gvEmployees.DataSource = dt;
			gvEmployees.DataBind();
			txtTotalRecord.Text = "Total record:" + dt.Rows.Count.ToString();
			sqlCon.Close();
		}

	}

}