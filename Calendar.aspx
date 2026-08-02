<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Calendar.aspx.cs"
    Inherits="TO_DO_LIST_APPLICATION.Calendar" %>

<!DOCTYPE html>

<html>

<head runat="server">

<title>Task Calendar</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css" rel="stylesheet"/>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>

</head>

<body>

<form runat="server">

<div class="container mt-4">

<h2>📅 Task Calendar</h2>

<a href="Default.aspx" class="btn btn-secondary mb-3">
← Dashboard
</a>

<div id="calendar"></div>

<asp:HiddenField
ID="hfEvents"
runat="server"/>

</div>

<script>

document.addEventListener('DOMContentLoaded', function () {

var calendar = new FullCalendar.Calendar(

document.getElementById('calendar'),

{

initialView:'dayGridMonth',

height:700,

events: JSON.parse(document.getElementById('<%=hfEvents.ClientID%>').value),

eventClick:function(info){

window.location='EditTask.aspx?id='+

info.event.id;

}

});

calendar.render();

});

</script>

</form>

</body>

</html>