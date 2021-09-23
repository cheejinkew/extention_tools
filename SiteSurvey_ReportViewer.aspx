<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SiteSurvey_ReportViewer.aspx.cs" Inherits="SiteSurvey_ReportViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
		<style>
		#ReportViewer2 {
			width: auto !important;
			height: auto !important;
		}

	</style>
</head>
<body>
	<form id="form1" runat="server">
		<br />
		<hr style="border-color: black" />
		<label style="font-size: large">Report Viewer</label>
		<hr style="border-color: black" />
		<br />
		<div>
			<asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
			<rsweb:ReportViewer ID="ReportViewer2" runat="server"></rsweb:ReportViewer>
		</div>
    </form>
</body>
</html>
