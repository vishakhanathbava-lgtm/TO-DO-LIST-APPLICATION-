<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="TO_DO_LIST_APPLICATION.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>To-Do List Application</title>
     <meta name="viewport" content="width=device-width, initial-scale=1" />
<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link href="Content/site.css" rel="stylesheet" />
    <link href="Content/Dark.css" rel="stylesheet" />


</head>

<body class="bg-light">

<form id="form1" runat="server">
    <div class="container-fluid mt-4 px-3">

    
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded shadow mb-4">

    <div class="container-fluid">

        <a class="navbar-brand" href="#">
            <i class="bi bi-list-task"></i>
            To-Do Dashboard
        </a>
        </div>
       </nav>
<div class="row g-2 mt-2">

    <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6 col-12">
        <asp:Button
            ID="btnAdd"
            runat="server"
            Text="+ Add Task"
            CssClass="btn btn-success w-100"
            OnClick="btnAdd_Click" />
    </div>

    <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6 col-12">
        <asp:Button
            ID="btnExportPdf"
            runat="server"
            Text="📄 Export PDF"
            CssClass="btn btn-danger w-100"
            OnClick="btnExportPdf_Click" />
    </div>

    <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6 col-12">
        <asp:Button
            ID="btnExportExcel"
            runat="server"
            Text="📊 Export Excel"
            CssClass="btn btn-success w-100"
            OnClick="btnExportExcel_Click" />
    </div>

    <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6 col-12">
        <asp:Button
            ID="btnCalendar"
            runat="server"
            Text="📅 Calendar"
            CssClass="btn btn-primary w-100"
            PostBackUrl="Calendar.aspx" />
    </div>

    <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6 col-12">
        <asp:Button
    ID="btnTheme"
    runat="server"
    Text="🌙 Dark Mode"
    CssClass="btn btn-dark w-100"
    OnClientClick="toggleTheme(); return false;" />
    </div>

</div>
       
    
    <!-- Search -->

    <div class="row mb-4">

        <div class="col-md-10">

            <asp:TextBox
                ID="txtSearch"
                runat="server"
                CssClass="form-control"
                placeholder="Search task...">
            </asp:TextBox>

        </div>

       <div class="col-md-2">

    <asp:Button
        ID="btnSearch"
        runat="server"
        Text="Search"
        CssClass="btn btn-primary w-100"
        OnClick="btnSearch_Click" />

</div>

    </div>
       
    <asp:Panel
    ID="pnlReminder"
    runat="server"
    CssClass="alert alert-danger"
    Visible="false">

    <asp:Label
        ID="lblReminder"
        runat="server">
    </asp:Label>

</asp:Panel>
<!-- Statistics -->

   <!-- Statistics -->

<div class="row g-3 mb-4">

    <!-- Total -->
    <div class="col-lg-3 col-md-6 col-sm-12">

        <asp:LinkButton
            ID="lnkTotal"
            runat="server"
            CssClass="text-decoration-none d-block"
            OnClick="lnkTotal_Click">

            <div class="card text-white shadow"
                style="background:linear-gradient(135deg,#0d6efd,#4dabf7);">

                <div class="card-body text-center">

                    <h5>Total</h5>

                    <asp:Label
                        ID="lblTotal"
                        runat="server"
                        Font-Size="XX-Large">
                    </asp:Label>

                </div>

            </div>

        </asp:LinkButton>

    </div>

    <!-- Pending -->
    <div class="col-lg-3 col-md-6 col-sm-12">

        <asp:LinkButton
            ID="lnkPending"
            runat="server"
            CssClass="text-decoration-none d-block"
            OnClick="lnkPending_Click">

            <div class="card shadow"
                style="background:linear-gradient(135deg,#ffc107,#ffda6a);color:black;">

                <div class="card-body text-center">

                    <h5>Pending</h5>

                    <asp:Label
                        ID="lblPending"
                        runat="server"
                        Font-Size="XX-Large">
                    </asp:Label>

                </div>

            </div>

        </asp:LinkButton>

    </div>

    <!-- Completed -->
    <div class="col-lg-3 col-md-6 col-sm-12">

        <asp:LinkButton
            ID="lnkCompleted"
            runat="server"
            CssClass="text-decoration-none d-block"
            OnClick="lnkCompleted_Click">

            <div class="card text-white shadow"
                style="background:linear-gradient(135deg,#198754,#20c997);">

                <div class="card-body text-center">

                    <h5>Completed</h5>

                    <asp:Label
                        ID="lblCompleted"
                        runat="server"
                        Font-Size="XX-Large">
                    </asp:Label>

                </div>

            </div>

        </asp:LinkButton>

    </div>

    <!-- Overdue -->
    <div class="col-lg-3 col-md-6 col-sm-12">

        <asp:LinkButton
            ID="lnkOverdue"
            runat="server"
            CssClass="text-decoration-none d-block"
            OnClick="lnkOverdue_Click">

            <div class="card text-white shadow"
                style="background:linear-gradient(135deg,#dc3545,#ff6b6b);">

                <div class="card-body text-center">

                    <h5>Overdue</h5>

                    <asp:Label
                        ID="lblOverdue"
                        runat="server"
                        Font-Size="XX-Large">
                    </asp:Label>

                </div>

            </div>

        </asp:LinkButton>

    </div>

</div>

    <!-- Task List -->

    <asp:Repeater
        ID="rptTasks"
        runat="server"
        OnItemCommand="rptTasks_ItemCommand">

        <ItemTemplate>

            <div class="card shadow mb-3">

                <div class="card-body">

                    <h4><%# Eval("Title") %></h4>

                    <p><%# Eval("Description") %></p>

                    <p>
<b class="text-danger">
<i class="bi bi-calendar-event"></i>
Due :
</b>
                        <%# Convert.ToDateTime(Eval("DueDate")).ToString("dd-MMM-yyyy") %>

                    </p>

                    <p>

                        <b>Priority :</b>
<span class='badge <%#
Eval("Priority").ToString()=="High"
?"bg-danger":
Eval("Priority").ToString()=="Medium"
?"bg-warning text-dark":
"bg-success"
%>'>

<%# Eval("Priority") %>

</span>

                    </p>

             <p>

    <b>Status :</b>

    <span class='badge <%#
        Convert.ToBoolean(Eval("IsCompleted"))
            ? "bg-success"
            : "bg-warning text-dark"
    %>'>

        <%#
            Convert.ToBoolean(Eval("IsCompleted"))
                ? "Completed"
                : "Pending"
        %>

    </span>

</p>  

                    <asp:Button
                        ID="btnEdit"
                        runat="server"
                        Text="Edit"
                        CommandName="Edit"
                        CommandArgument='<%# Eval("Id") %>'
                        CssClass="btn btn-primary btn-sm" />

                    <asp:Button
                        ID="btnDelete"
                        runat="server"
                        Text="Delete"
                        CommandName="Delete"
                        CommandArgument='<%# Eval("Id") %>'
                        CssClass="btn btn-danger btn-sm ms-2" />

                    <asp:Button
                        ID="btnComplete"
                        runat="server"
                        Text="Complete"
                        CommandName="Complete"
                        CommandArgument='<%# Eval("Id") %>'
                        CssClass="btn btn-success btn-sm ms-2" />

                </div>

            </div>

        </ItemTemplate>

    </asp:Repeater>



<!-- Footer -->

<footer class="text-center mt-5 mb-3">

    <hr />

    <p class="text-muted">

        © 2026 To-Do List Application

        <br />

        Created by Priyanshu and Vishakha

    </p>

</footer>
</div>
</form>

   <script>
       function toggleTheme() {

           var body = document.body;
           var btn = document.getElementById("<%= btnTheme.ClientID %>");

    body.classList.toggle("dark-mode");

    if (body.classList.contains("dark-mode")) {

        // Button for switching back to Light Mode
        btn.value = "☀️ Light Mode";

        btn.classList.remove("btn-dark");
        btn.classList.add("btn-warning");

        localStorage.setItem("theme", "dark");

    } else {

        // Button for switching to Dark Mode
        btn.value = "🌙 Dark Mode";

        btn.classList.remove("btn-warning");
        btn.classList.add("btn-dark");

        localStorage.setItem("theme", "light");
    }
}

window.onload = function () {

    var btn = document.getElementById("<%= btnTheme.ClientID %>");

           if (localStorage.getItem("theme") == "dark") {

               document.body.classList.add("dark-mode");

               btn.value = "☀️ Light Mode";

               btn.classList.remove("btn-dark");
               btn.classList.add("btn-warning");

           } else {

               btn.value = "🌙 Dark Mode";

               btn.classList.remove("btn-warning");
               btn.classList.add("btn-dark");
           }
       };
   </script>
</body>

</html>

