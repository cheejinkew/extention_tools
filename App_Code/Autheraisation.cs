using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Autheraisation
/// </summary>
public class Autheraisation
{
    string name;
    string userid;
    bool ispay;
    bool access;
    int  status;
    bool isexpairy;
    string remarks;
    string rescode;
    string errorcode;
    public Autheraisation()
    { }
	public  authresponce autheraise()
	{
        authresponce responce = new authresponce();
        try
        {
            if (HttpContext.Current.Session["userid"] != null)
            {
                userid = (string)HttpContext.Current.Session["userid"];
                if (userid != null)
                {
                    status =Convert .ToInt16 ( HttpContext.Current.Session["status"]);
                    if (status != null)
                    {
                        if (status == 1 || status == 2)
                        {
                            access = (bool)HttpContext.Current.Session["access"];
                            if (access != null)
                            {
                                if (access == true)
                                {
                                    responce.responcecode = "01";
                                    if(status ==2)
                                    responce.errormsg = "Your Account is going to expire soon.Renual your account soon. Thank You.  ";
                                    else
                                    responce.errormsg = "";
                                }
                                else
                                {
                                    responce.responcecode = "04";
                                    responce.errormsg = "No Access";
                                }
                               
                            }
                            else
                            {
                                responce.responcecode = "05";
                                responce.errormsg = "Session Expired";
                            }
                        }
                        else if (status == 2) 
                        {
                            responce.responcecode = "02";
                            responce.errormsg = "Account is Blocked.";
                        }
                        
                    }
                    else
                    {
                        responce.responcecode = "05";
                        responce.errormsg = "Session Expired";
                    }

                }
                else
                {
                    responce.responcecode = "05";
                    responce.errormsg = "Session Expired";
                }
            }
            else
            {
                responce.responcecode = "05";
                responce.errormsg = "Session Expired";
            }
        }
        catch (Exception ex)
        {
            responce.responcecode = "06";
            responce.errormsg = ex.Message;
        }

        return responce;
	}

   
}
public  struct authresponce
{
    public string responcecode { get; set; }
    public string errormsg { get; set; }
}

public struct usersession
{
    public string name { get; set; }
    public string email { get; set; }
    public string userid { get; set; }
    public bool ispay { get; set; }
    public bool isexpairy { get; set; }
    public bool isaccess { get; set; }
    public string remarks { get; set; }
    public string imgurl { get; set; }

}