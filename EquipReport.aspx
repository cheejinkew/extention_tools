<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EquipReport.aspx.cs" Inherits="EquipReport" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <div id="page-head">
            <!--Page Title-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <div id="page-title">
                <h1 class="page-header text-overflow">SAJ Equipment Report</h1>
            </div>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End page title-->
            <!--Breadcrumb-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <ol class="breadcrumb">
                <li><a href="#"><i class="demo-pli-home"></i></a></li>
                <li><a href="#">Reports</a></li>
                <li class="active">SAJ Equipment Report</li>
            </ol>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End breadcrumb-->
        </div>
        <div id="page-content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title text-bold ">SAJ Equipment Report</h3>
                        </div>
                    </div> 
                </div>
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title text-bold ">Equipment Report</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                            
                              <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                            <div class="table-responsive" style="overflow-x: inherit;">
                               <h4> Below display is updated Equipment Report . Please take a look on display via Excel sheet before download the report. </h4><br />
                                <br />
                                 <iframe width="405" height="350" frameborder="0" scrolling="no" src="https://onedrive.live.com/embed?resid=3FF184A14B2C22D2%21977&authkey=%21AACNwRJBQ6J2Mx0&em=2&wdAllowInteractivity=False&ActiveCell='Sheet1'!A1&wdDownloadButton=True&wdInConfigurator=True"></iframe>
                            </div>
                        </div>
                    
                    <!--===================================================-->
                    <!-- End Striped Table -->
                           
                            
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 
            </div>
        
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
   
</asp:Content>

