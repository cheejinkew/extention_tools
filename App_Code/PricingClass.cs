using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for Pricing
/// </summary>
public class PricingClass : Datatypes
{
    public PricingStruct GetPrice()
    {
        PricingStruct Str = new PricingStruct();
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["sqlserverconnection"]);
        try
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter("select * from thb_pricing_table", conn);
            da.Fill(ds);
            for (int i = 0; i < ds.Tables[0].Rows.Count ; i++)
            {
                Str.QuarterlyUSD = double.Parse(double.Parse(ds.Tables[0].Rows[0]["ThreeMonthsUSD"].ToString()).ToString("0"));
                Str.QuarterlyMYR = double.Parse(double.Parse(ds.Tables[0].Rows[0]["ThreeMonthsMYR"].ToString()).ToString("0"));
                Str.HalfYearlyUSD = double.Parse(double.Parse(ds.Tables[0].Rows[0]["SixMonthsUSD"].ToString()).ToString("0"));
                Str.HalfYearlyMYR = double.Parse(double.Parse(ds.Tables[0].Rows[0]["SixMonthsMYR"].ToString()).ToString("0"));
                Str.YearlyUSD = double.Parse(double.Parse(ds.Tables[0].Rows[0]["YearUSD"].ToString()).ToString("0"));
                Str.YearlyMYR = double.Parse(double.Parse(ds.Tables[0].Rows[0]["YearMYR"].ToString()).ToString("0"));
            }
            
        }
        catch (Exception)
        {

        }
        return Str;

    }
  
}