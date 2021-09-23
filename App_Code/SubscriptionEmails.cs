using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.IO;
using System.Text;
using System.Net.Mime;

/// <summary>
/// Summary description for SubscriptionEmails
/// </summary>
public class SubscriptionEmails : Datatypes
{
	public SubscriptionEmails()
	{ 
            
	}  

    public Emailresult SendEmail(string fromemail, UserInfo userdeatils)
    {
        Emailresult eres = new Emailresult();
        try
        {
            StreamReader reader = new StreamReader("C:/Inetpub/vhosts/thehungrybrains.com/beta.thehungrybrains.com/wwwroot/shedule/email_template_blue.html");
            StringBuilder readFile = new StringBuilder();
            readFile.Append(reader.ReadToEnd());
            string myString = "";
            string EmailString = "";
            myString = readFile.ToString();
            EmailString = myString.Replace("Customer,", userdeatils.Firstname + " " + userdeatils.lastname + ",").Replace("Date", Convert.ToDateTime(userdeatils.expairydate).ToString("yyyy/MM/dd"));
            MailMessage mail = new MailMessage();
            mail.IsBodyHtml = true;
            mail.AlternateViews.Add(getEmbeddedImage("C:/Inetpub/vhosts/thehungrybrains.com/beta.thehungrybrains.com/wwwroot/images/promo-bg.png", "C:/Inetpub/vhosts/The Silicon Valley School.com/beta.The Silicon Valley School.com/wwwroot/images/logo.png", EmailString));
            mail.From = new MailAddress(fromemail, "The Silicon Valley School Alert");
            mail.To.Add(userdeatils.emailid);
            mail.Subject = "Subscription Renewal";
            SmtpClient smtpClient = default(SmtpClient);

            smtpClient = new SmtpClient("mail.The Silicon Valley School.com", 587);
            smtpClient.Port = 26;
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(fromemail, "kW#ufF*yg2");

            smtpClient.Credentials = credentials;
            smtpClient.Send(mail);
            reader.Dispose();
            eres.flag = true;
            eres.errmsg = "Success";
        }
        catch (Exception ex)
        {
            eres.flag = true;
            eres.errmsg = ex.Message;
        }
        return eres;
    }

    private AlternateView getEmbeddedImage(string banner, string logo, string mailmsg)
    {
        LinkedResource inline = new LinkedResource(banner);
        inline.ContentId = Guid.NewGuid().ToString();
        LinkedResource inline1 = new LinkedResource(logo);
        inline1.ContentId = Guid.NewGuid().ToString();
        string htmlBody = mailmsg.Replace("src= \"", "src='cid:" + inline.ContentId + "'").Replace("src='logo'", "src='cid:" + inline1.ContentId + "'");
        AlternateView alternateView__1 = AlternateView.CreateAlternateViewFromString(htmlBody, null, MediaTypeNames.Text.Html);
        alternateView__1.LinkedResources.Add(inline);
        alternateView__1.LinkedResources.Add(inline1);
        return alternateView__1;
    }
}

