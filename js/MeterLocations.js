$(function () {
    $.ajax({
        type: "POST",
        url: "GetMeterLocJson.aspx/GetMeterLocations",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            if (response.d != "N") { 
            }
            else {
                alert("Not Inserted");
            }
        },
        failure: function (response) {
            alert("Some Problem with database, Please Try Again later.");
        }
    });
});