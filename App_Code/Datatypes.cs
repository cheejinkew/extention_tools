using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Datatypes
/// </summary>
public class Datatypes
{
	public Datatypes()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public struct PricingStruct
    {
        public double QuarterlyUSD { get; set; }
        public double QuarterlyMYR { get; set; }
        public double HalfYearlyUSD { get; set; }
        public double HalfYearlyMYR { get; set; }
        public double YearlyUSD { get; set; }
        public double YearlyMYR { get; set; }
    }

    public struct Emailresult
    {
        public bool flag { get; set; }
        public string errmsg { get; set; }
    }
    public struct UserInfo
    {
        public ushort UserID { get; set; }
        public string Firstname { get; set; }
        public string lastname { get; set; }
        public string emailid { get; set; }
        public string expairydate { get; set; }
        public bool isexpairy { get; set; }
        public bool ispay { get; set; }
    }
}