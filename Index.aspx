<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div id="content-container">
        <div id="page-head">
            <!--Page Title-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <div id="page-title">
                <h1 class="page-header text-overflow">
                   Dash Board</h1>
            </div>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End page title-->
            <!--Breadcrumb-->
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <ol class="breadcrumb">
                <li><a href="#"><i class="demo-pli-home"></i></a></li> 
                <li class="active">Dashboard</li>
            </ol>
            <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
            <!--End breadcrumb-->
        </div>
        <div id="page-content">
            <div class="row">
                <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              SAJ STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartsaj" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              SAMB STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartsamb" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              SABAH STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartsabah" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              SATU STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartsatu" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              SAINS STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartsains" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              LABUAN STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartlabuan" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              PERLIS STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartperlis" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
                 <div class="col-sm-3">
                    <div class="panel">
                        <div class="panel-heading">
                           <h3 class="panel-title text-bold ">
                              PAHANG STATUS</h3>
                        </div>
                        <!-- Striped Table -->
                        <!--===================================================-->
                        <div class="panel-body">
                          <div class="chart tab-pane active" id="package-chartpahang" style="position: relative;"></div>
                        </div>
                    </div>
                    <!--===================================================-->
                    <!-- End Striped Table -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" Runat="Server">
  
    <script type="text/javascript">
        $(function () {
            getSajdata("SAJ");
            getSAMBdata("SAMB");
            getSabahdata("SABAH");
            getSatudata("SATU");
            getLabuandata("LABUAN");
            getSainsdata("SAINS");
            getPerilsdata("PERLIS");
            getpahangdata("PAHANG");
            
        });
        function showdata(status) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetSatusSummaryDataJson",
                data: '{sDist: \"' + sDist + '\" , status: \"' + status + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var table = $("#tblRenewpkgs");
                    $("#cttbody").empty();
                    var sno = 1;
                    for (var i = 0; i < response.d.length; i++) {
                        $("#cttbody").append("<tr><td>" + sno + "</td><td>" + response.d[i].District + "</td><td>" + response.d[i].Type + "</td><td>" + response.d[i].SiteName + "</td><td>" + response.d[i].TimeStamp + "</td><td>" + response.d[i].Level + "</td></tr>");
                        sno = sno + 1;
                    }
                    $("#OperationModal").modal('show');
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });
        }

        function getSajdata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartsaj', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'SAJ Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getSAMBdata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd; 
                    Highcharts.chart('package-chartsamb', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'SAMB Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            } 
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getSabahdata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartsabah', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'SABAH Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getSatudata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartsatu', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'SATU Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getLabuandata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartlabuan', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'LABUAN Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getSainsdata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartsains', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'SAINS Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                               dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getPerilsdata(server) {
            var sDist = 'ALL';
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartperlis', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'PERLIS Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                               dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }

        function getpahangdata(server) { 
            $.ajax({
                type: "POST",
                url: "index.aspx/GetDashBoardJson",
                data: '{server: \"' + server + '\"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var seriesdata = response.d.sd;
                    var updatestatud = response.d.dd;
                    Highcharts.chart('package-chartpahang', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'PAHANG Data Status'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
								enabled: true,
								format: '<b>{point.y}</b><br/>{point.percentage:.1f} %',
								distance: -50,
								filter: {
									property: 'percentage',
									operator: '>',
									value: 4
								}
							},
                                showInLegend: true
                            }
                        },
                        series: [{
                            name: 'Status',
                            colorByPoint: true,
                            data: [{
                                name: 'Data Stopped',
                                y: updatestatud.stopped,
                                sliced: true,
                                selected: true,
                                color: '#FF0000'
                            }, {
                                name: 'Data Delay',
                                y: updatestatud.delay,
                                color: '#F75905'
                            }, {
                                name: 'Data Updated',
                                y: updatestatud.updated,
                                color: '#1170F4'
                            }
                            ]
                        }]
                    });
                },
                failure: function (response) {
                    alertbox("Failed");
                }
            });

        }




</script>
</asp:Content>

