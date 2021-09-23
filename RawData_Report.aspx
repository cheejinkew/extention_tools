<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RawData_Report.aspx.cs" Inherits="RawData_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="content-container">
        <div id="page-head">
            <!--Page Title-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <div id="page-title">
                <h1 class="page-header text-overflow">Raw Data Report</h1>
            </div>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End page title-->
            <!--Breadcrumb-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <ol class="breadcrumb">
                <li><a href="#"><i class="demo-pli-home"></i></a></li>
                <li><a href="#">Reports</a></li>
                <li class="active">Raw Data Report</li>
            </ol>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End breadcrumb-->
        </div>
        <div id="page-content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title text-bold ">Raw Data Report</h3>
                        </div>
                        <div class="panel-body">
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>
                                        Client</label>
                                    <select class="form-control  input-sm" style="background-color: #3b75e1; color: white;" id="ddlServer">
                                        <option value="SAJ">SAJ</option>
                                        <option value="SAMB">SAMB</option>
                                        <option value="SABAH">SABAH</option>
                                        <option value="LABUAN">LABUAN</option>
                                        <option value="SATU">SATU</option>
                                        <option value="SAINS">SAINS</option>
                                        <option value="PAHANG">PAHANG</option>
                                        <option value="PERLIS">PERLIS</option>
										<option value="MAB">MAB</option>
										<option value="AS">AirSelangor</option>
										<option value="SILO">SILO</option>
										<option value="JBALB">JBALB</option>
										 <option value="AUTOPUMP">AUTOPUMP</option>
										 <option value="SADA">SADA</option>
										 <option value="LABUANNEW">LABUAN NEW</option>
										  <option value="LAP">LAP</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>
                                        Version</label>
                                    <select class="form-control  input-sm" style="background-color: #3b75e1; color: white;" id="ddlVersion">
                                        <option value="M5">M5</option>
										<option value="SMSM5">SMS M5</option>
                                        <option value="M5N">M5 New</option>
										<option value="M6">M6</option>
										<option value="M7">M7</option>
                                        <option value="S1">S1</option>
										<option value="AUTOPUMP">AUTOPUMP</option>
                                    </select>
                                </div>
                            </div>
                             <div class="col-md-2">
                                <div class="form-group">
                                    <label>
                                        Sim No/UnitID</label>
                                   <input type="text" class="form-control input-sm" placeholder="Sim Number"
                                    id="txtsimno" />
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>
                                        Period</label>
                                    <div id="reportrange" style="background: #3b75e1; color: white; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
                                        <i class="fa fa-calendar"></i>&nbsp;
                                     <span></span><i class="fa fa-caret-down"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
								 <a role="button" onclick="DownloadData()" class="btn btn-info btn-rounded pull-right" style="margin-top: 20px;">Download</a>
                                    <a role="button" onclick="Getdata()" class="btn btn-success btn-rounded pull-right" style="margin-top: 20px;">View Data</a>
                                 
								</div>
                            </div>
                        </div>
                    </div> 
                </div>
                <div class="col-sm-12">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title text-bold ">Raw Data</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                            <div class="table-responsive" style="overflow-x: inherit;">
                                <table id="demo-dt-basic" class="table table-striped table-bordered" cellspacing="0"
                                    width="100%">
                                    <thead>
                                        <tr>
                                            <th>Sno
                                            </th> 
                                            <th>Unit ID
                                            </th>
                                            <th>
                                                TimeStamp
                                            </th>
                                            <th>Raw Data
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>

            </div>
        </div>
    </div>
	 <form id="frmdownload" method="post" action="DownloadRawdata.aspx">
       
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
   

    <script type="text/javascript"> 
        $(function () {
            var start = moment().subtract(29, 'days');
            var end = moment();

            function cb(start, end) {
                $('#reportrange span').html(start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD'));
            }

            $('#reportrange').daterangepicker({
                startDate: start,
                endDate: end,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            }, cb);

            cb(start, end);

        });
        function Getdata() {
            var startdate = $("#reportrange").data('daterangepicker').startDate.format('YYYY/MM/DD');
            var enddate = $("#reportrange").data('daterangepicker').endDate.format('YYYY/MM/DD');
            $.ajax({
                type: "POST",
                url: "RawData_Report.aspx/getCartData",
                data: '{server: \"' + $("#ddlServer").val() + '\",version: \"' + $("#ddlVersion").val() + '\",simno: \"' + $("#txtsimno").val() + '\",startdate: \"' + startdate + '\",enddate: \"' + enddate + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var res = response.d;
                    table = $("#demo-dt-basic").dataTable();
                    table._fnProcessingDisplay(true);
                    oSettings = table.fnSettings();
                    table.fnClearTable(this);
                    for (var i = 0; i < res.length; i++) {
                        table.oApi._fnAddData(oSettings, res[i]);
                    }
                    oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
                    table._fnProcessingDisplay(false);

                    table.fnDraw();

                    return false;
                },
                failure: function (response) {
                    alert("Some Problem with database, Please Try Again later.");
                }
            });
        }
		
		function DownloadData() { 
            var objfrmdownload = document.getElementById("frmdownload");
            objfrmdownload.submit();
        }

    </script>
</asp:Content>

