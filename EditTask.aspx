<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EditTask.aspx.cs"
    Inherits="TO_DO_LIST_APPLICATION.EditTask" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Task</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body class="bg-light">

<form id="form1" runat="server">

<div class="container mt-5">

<div class="card shadow">

<div class="card-header bg-warning">

<h3>Edit Task</h3>

</div>

<div class="card-body">

<div class="mb-3">

<label>Title</label>

<asp:TextBox
ID="txtTitle"
runat="server"
CssClass="form-control"/>

</div>

<div class="mb-3">

<label>Description</label>

<asp:TextBox
ID="txtDescription"
runat="server"
TextMode="MultiLine"
Rows="4"
CssClass="form-control"/>

</div>

<div class="mb-3">

<label>Due Date</label>

<asp:TextBox
ID="txtDueDate"
runat="server"
TextMode="Date"
CssClass="form-control"/>

</div>

<div class="mb-3">

<label>Priority</label>

<asp:DropDownList
ID="ddlPriority"
runat="server"
CssClass="form-select">

<asp:ListItem>High</asp:ListItem>
<asp:ListItem>Medium</asp:ListItem>
<asp:ListItem>Low</asp:ListItem>

</asp:DropDownList>

</div>

<div class="form-check mb-3">

<asp:CheckBox
ID="chkReminder"
runat="server"/>

<label>Reminder</label>

</div>

<asp:Button
ID="btnUpdate"
runat="server"
Text="Update Task"
CssClass="btn btn-success"
OnClick="btnUpdate_Click"/>

<asp:Button
ID="btnCancel"
runat="server"
Text="Cancel"
CssClass="btn btn-secondary"
CausesValidation="false"
OnClick="btnCancel_Click"/>

</div>

</div>

</div>

</form>

</body>

</html>