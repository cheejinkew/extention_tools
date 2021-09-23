using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
/// <summary>
/// Summary description for SendEmail
/// </summary>
public class SendEmail
{
	public SendEmail()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string  EmailSend(string From,string To,string cc,string subjet,string body,string pwd)
    {
        string result;
        try
        {
            MailMessage mailMsg = new MailMessage();
            mailMsg.To.Add(new MailAddress(To));
            if(cc!="")
            mailMsg.CC.Add(new MailAddress(cc));
            // mailMsg.CC.Add(new MailAddress("pravin@g1.com.my"));
            mailMsg.From = new MailAddress(From , "The Hungry Brains");
            mailMsg.Subject = subjet;
            mailMsg.SubjectEncoding = System.Text.Encoding.UTF8;
            mailMsg.Body = body;
            mailMsg.BodyEncoding = System.Text.Encoding.UTF8;

            mailMsg.IsBodyHtml = true;

            mailMsg.Priority = MailPriority.High;

            SmtpClient smtpClient;

            smtpClient = new SmtpClient("mail.thehungrybrains.com", 587);
            smtpClient.Port = 26;
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(From, pwd);

            smtpClient.Credentials = credentials;

            smtpClient.Send(mailMsg);
            result = "Y";
        }
        catch (Exception ex)
        {
            result = ex.Message;
        }

        return result;
    }

}