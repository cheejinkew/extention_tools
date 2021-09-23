using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
/// <summary>
/// Summary description for SHA
/// </summary>
public class SHA
{
	public SHA()
	{
		 
	}

    public string Signature(string Key)
    {
        SHA1CryptoServiceProvider objSHA1 = new SHA1CryptoServiceProvider();

        objSHA1.ComputeHash(System.Text.Encoding.UTF8.GetBytes(Key.ToCharArray()));

        byte[] buffer = objSHA1.Hash;
        string HashValue = System.Convert.ToBase64String(buffer);

        return HashValue;
    }

    public string szComputeSHA256Hash(string sz_Key)
    {
        string szHashValue = "";
        SHA256 objSHA256 = null;
        byte[] btHashbuffer = null;

        try
        {
            objSHA256 = new SHA256Managed();
            objSHA256.ComputeHash(System.Text.Encoding.ASCII.GetBytes(sz_Key));
            btHashbuffer = objSHA256.Hash;
            szHashValue = szWriteHex(btHashbuffer).ToLower();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if ((objSHA256 != null))
                objSHA256 = null;
        }

        return szHashValue;
    }

    public string szWriteHex(byte[] bt_Array)
    {
        string szHex = "";
        int iCounter = 0;

        for (iCounter = 0; iCounter <= (bt_Array.Length - 1); iCounter++)
        {
            szHex += bt_Array[iCounter].ToString("X2");
        }

        return szHex;
    }
     

 
 
}