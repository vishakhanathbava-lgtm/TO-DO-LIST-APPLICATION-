<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AddTask.aspx.cs"
    Inherits="TO_DO_LIST_APPLICATION.AddTask" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Task</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body class="bg-light">

<form id="form1" runat="server">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">
            <h3>Add New Task</h3>
        </div>

        
        <div class="card-body">

            <div class="mb-3">
                <label>Task Title</label>

                <asp:TextBox
                    ID="txtTitle"
                    runat="server"
                    CssClass="form-control">
                </asp:TextBox>
            </div>
           
            <div class="mb-3">
                           

<label>Category</label>

<asp:DropDownList
ID="ddlCategory"
runat="server"
CssClass="form-select">

<asp:ListItem>Work</asp:ListItem>
<asp:ListItem>Study</asp:ListItem>
<asp:ListItem>Personal</asp:ListItem>

</asp:DropDownList>

</div>

            <label>Reminder Time</label>

<asp:TextBox
ID="txtReminderTime"
runat="server"
TextMode="Time"
CssClass="form-control"/>
            <div class="mb-3">
                <label>Description</label>

                <asp:TextBox
                    ID="txtDescription"
                    runat="server"
                    TextMode="MultiLine"
                    Rows="4"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="mb-3">
                <label>Due Date</label>

                <asp:TextBox
                    ID="txtDueDate"
                    runat="server"
                    TextMode="Date"
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="mb-3">
                <label>Priority</label>

                <asp:DropDownList
                    ID="ddlPriority"
                    runat="server"
                    CssClass="form-select">

                    <asp:ListItem>High</asp:ListItem>
                    <asp:ListItem Selected="True">Medium</asp:ListItem>
                    <asp:ListItem>Low</asp:ListItem>

                </asp:DropDownList>
            </div>
        

           

            <div class="form-check mb-3">

                <asp:CheckBox
                    ID="chkReminder"
                    runat="server" />

                <label class="form-check-label">
                    Enable Reminder
                </label>

            </div>

            <asp:Button
                ID="btnSave"
                runat="server"
                Text="Save Task"
                CssClass="btn btn-success"
                OnClick="btnSave_Click" />

            <asp:Button
                ID="btnCancel"
                runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary"
                CausesValidation="false"
                OnClick="btnCancel_Click" />

        </div>

    </div>


</div>

    
   



<%# Convert.ToDateTime(Eval("CreatedDate"))
.ToString("dd MMM yyyy hh:mm tt") %>
   

    


</form>

</body>
</html>