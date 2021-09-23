<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSiteSurveyReport.master" AutoEventWireup="true" CodeFile="SiteSurvey_Report.aspx.cs" Inherits="SiteSurvey_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
	<%--kew add for datepicker--%>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<form id="form1" runat="server">
    <div id="content-container">
        <div id="page-head">
            <!--Page Title-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <div id="page-title">
                <h1 class="page-header text-overflow">Site Survey Report</h1>
            </div>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End page title-->
            <!--Breadcrumb-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <ol class="breadcrumb">
                <li><a href="#"><i class="demo-pli-home"></i></a></li>
                <li><a href="#">Reports</a></li>
                <li class="active">Site Survey Report</li>
            </ol>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End breadcrumb-->
        </div>
        <div id="page-content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title text-bold ">Auto Load excel file</h3>
                        </div>
                        <div class="panel-body">
                            <div class="input-group">
								<div class="custom-file">
									<table>
										<tr>
											<td>
												<asp:FileUpload ID="FileUpload1" runat="server" />
											</td>
											<td>
												<asp:Button ID="btnUpload" runat="server" class="btn btn-success btn-rounded"  Text="Load" OnClick="btnUpload_Click" />
											</td>
										</tr>
									</table>

								</div>
							</div>
						<asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                    </div> 
                </div>
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
							<table style="width:100%;" >
								<tr>
									<td style="width:50%;text-align:left">
										<h3 class="panel-title text-bold ">Report Viewer</h3>
									</td>
									<td style="width:50%;text-align:right">										
										<asp:TextBox ID="txtTotalRecord" runat="server" BorderStyle="None"></asp:TextBox>
									</td>
								</tr>
							</table>
                           
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                            <div class="table-responsive" style="overflow-x: inherit;">
                        <table>
						<tr>
							<td style="width: 120px">
								<label style="margin-top:10px">Team Leader: </label>
							</td>
							<td>
								<asp:DropDownList ID="ddlTeamLeader" runat="server"  AutoPostBack="true">
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td>
								<label style="margin-top:10px">District: </label>
							</td>
							<td>
								<asp:DropDownList ID="ddlDistrict" runat="server"  AutoPostBack="true">
								</asp:DropDownList>
								</td>
						</tr>
<%--						<tr>
							<td>
								<label>Date range: </label>
							</td>
							<td>
								<asp:DropDownList ID="ddlDate" runat="server" AutoPostBack="true">
									<asp:ListItem Text="ALL" Value="ALL" Selected="true"></asp:ListItem>
									<asp:ListItem Text="Last 1 day" Value="day"></asp:ListItem>
									<asp:ListItem Text="1 week" Value="week"></asp:ListItem>
									<asp:ListItem Text="1 month" Value="month"></asp:ListItem>
								</asp:DropDownList>
								
							</td>
						</tr>--%>
						<tr>
							<td>
								<label style="margin-top:10px">Date range: </label>
							</td>
							<td>
								<asp:TextBox ID="startdatepicker" ClientIDMode="Static" style="width:100px;border-width:thin" runat="server" AutoPostBack="true" autocomplete="off"></asp:TextBox> - <asp:TextBox ID="enddatepicker" ClientIDMode="Static" style="width:100px;border-width:thin"  runat="server"  AutoPostBack="true" autocomplete="off"></asp:TextBox>							
							</td>
						</tr>

					</table>
						<div style="margin-top: 10px;">
						<asp:Label ID="lblSuccessMessage" Text="" runat="server" ForeColor="Green" Font-Size="30px" />
						<asp:Label ID="lblErrorMessage" Text="" runat="server" ForeColor="Red" Font-Size="30px" />
						<asp:GridView ID="gvEmployees" runat="server" class="table table-striped table-bordered" AutoGenerateColumns="False" AllowSorting="True" ShowFooter="True"
							DataKeyNames="ID" 
							 ShowHeaderWhenEmpty="True" EmptyDataText="No records Found">
							<Columns>
								<asp:TemplateField HeaderText="FormID">
									<ItemTemplate>
										<asp:LinkButton Text='<%# Eval("FormID") %>' runat="server" OnClick="Report_Click" OnClientClick="document.forms[0].target = '_blank';" CommandName="DownloadReport" CommandArgument='<%# Eval("FormID") %>'  Width="70"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>

								<asp:TemplateField HeaderText="TeamLeader">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("TeamLeader") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtMobile" Text='<%# Eval("TeamLeader") %>' runat="server"  />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtMobileFooter" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

								<asp:TemplateField HeaderText="TeamMember">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("TeamMember") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtEmail" Text='<%# Eval("TeamMember") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtEmailFooter" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

								<asp:TemplateField HeaderText="SiteComment">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("SiteComment") %>' runat="server"  Width="100"/>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("SiteComment") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtSalaryFooter" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

					
								<asp:TemplateField HeaderText="SIm Card No">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("SImCardNo") %>' runat="server"  Width="100" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("SImCardNo") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtSImCardNo" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

					
								<asp:TemplateField HeaderText="New Or Existing">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("NewOrExisting") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("NewOrExisting") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtNewOrExisting" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

					
<%--								<asp:TemplateField HeaderText="Site Info">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("SiteInfo") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("SiteInfo") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtSiteInfo" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>--%>

					
								<asp:TemplateField HeaderText="Type">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("type") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("type") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtType" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

					
								<%--<asp:TemplateField HeaderText="New Sites In District">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("NewSitesInDistrict") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("NewSitesInDistrict") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtNewSitesInDistrict" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>--%>

					
								<asp:TemplateField HeaderText="District">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("District") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("District") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtDistrict" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>

					
								<asp:TemplateField HeaderText="AddedTime">
									<ItemTemplate>
										<asp:Label Text='<%# Eval("AddedTime") %>' runat="server" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="txtSalary" Text='<%# Eval("AddedTime") %>' runat="server" />
									</EditItemTemplate>
									<FooterTemplate>
										<asp:TextBox ID="txtAddedTime" runat="server" />
									</FooterTemplate>
								</asp:TemplateField>
				
							</Columns>
						</asp:GridView>
					</div>
                            </div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>


            </div>
		
        </div>
    </div>
	</form>
	 <form id="frmdownload" method="post" action="DownloadRawdata.aspx">
       
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">

    <script type="text/javascript"> 
		  $( function() {
			  $("#startdatepicker").datepicker({dateFormat: "yy-mm-dd"});
			  $("#enddatepicker").datepicker({ dateFormat: "yy-mm-dd" });

			  function SetTarget() {
					document.forms[0].target = "_blank";
				}
		  } );
    </script>
</asp:Content>

