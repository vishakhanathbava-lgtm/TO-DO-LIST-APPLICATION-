using System;
using System.Linq;
using System.Collections.Generic;
using TO_DO_LIST_APPLICATION.Helpers;
using TO_DO_LIST_APPLICATION.Models;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using ClosedXML.Excel;
using System.IO;

namespace TO_DO_LIST_APPLICATION
{
    public partial class Default : System.Web.UI.Page
    {
        protected void lnkPending_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            rptTasks.DataSource = tasks.Where(t => !t.IsCompleted).ToList();
            rptTasks.DataBind();
        }
        protected void lnkCompleted_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            rptTasks.DataSource = tasks.Where(t => t.IsCompleted).ToList();

            rptTasks.DataBind();
        }
        protected void lnkOverdue_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            rptTasks.DataSource = tasks
                .Where(t => !t.IsCompleted &&
                            t.DueDate.Date < DateTime.Today)
                .ToList();

            rptTasks.DataBind();
        }
        protected void lnkTotal_Click(object sender, EventArgs e)
        {
            LoadTasks();
        }
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            using (XLWorkbook wb = new XLWorkbook())
            {
                var ws = wb.Worksheets.Add("Tasks");

                // Header
                ws.Cell(1, 1).Value = "ID";
                ws.Cell(1, 2).Value = "Title";
                ws.Cell(1, 3).Value = "Description";
                ws.Cell(1, 4).Value = "Due Date";
                ws.Cell(1, 5).Value = "Priority";
                ws.Cell(1, 6).Value = "Category";
                ws.Cell(1, 7).Value = "Status";

                int row = 2;

                foreach (var task in tasks)
                {
                    ws.Cell(row, 1).Value = task.Id;
                    ws.Cell(row, 2).Value = task.Title;
                    ws.Cell(row, 3).Value = task.Description;
                    ws.Cell(row, 4).Value = task.DueDate.ToString("dd-MMM-yyyy");
                    ws.Cell(row, 5).Value = task.Priority;
                    ws.Cell(row, 6).Value = task.Category;
                    ws.Cell(row, 7).Value = task.IsCompleted ? "Completed" : "Pending";

                    row++;
                }

                ws.Columns().AdjustToContents();

                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);

                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType =
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                    Response.AddHeader(
                        "content-disposition",
                        "attachment;filename=Tasks.xlsx");

                    Response.BinaryWrite(stream.ToArray());
                    Response.End();
                }
            }
        }
        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            PdfDocument document = new PdfDocument();
            document.Info.Title = "To-Do Task Report";

            PdfPage page = document.AddPage();
            XGraphics gfx = XGraphics.FromPdfPage(page);

            XFont titleFont = new XFont("Arial", 18);
            XFont font = new XFont("Arial", 12);

            int y = 40;

            gfx.DrawString("TO-DO TASK REPORT",
                titleFont,
                XBrushes.DarkBlue,
                new XRect(0, y, page.Width, page.Height),
                XStringFormats.TopCenter);

            y += 40;

            foreach (var task in tasks)
            {
                string status = task.IsCompleted ? "Completed" : "Pending";

                gfx.DrawString(
                    "Title: " + task.Title,
                    font,
                    XBrushes.Black,
                    40,
                    y);

                y += 20;

                gfx.DrawString(
                    "Description: " + task.Description,
                    font,
                    XBrushes.Black,
                    40,
                    y);

                y += 20;

                gfx.DrawString(
                    "Due Date: " + task.DueDate.ToString("dd-MMM-yyyy"),
                    font,
                    XBrushes.Black,
                    40,
                    y);

                y += 20;

                gfx.DrawString(
                    "Priority: " + task.Priority,
                    font,
                    XBrushes.Black,
                    40,
                    y);

                y += 20;

                gfx.DrawString(
                    "Status: " + status,
                    font,
                    XBrushes.Black,
                    40,
                    y);

                y += 35;

                // Add a new page if the current one is full
                if (y > 750)
                {
                    page = document.AddPage();
                    gfx = XGraphics.FromPdfPage(page);
                    y = 40;
                }
            }

            MemoryStream stream = new MemoryStream();

            document.Save(stream, false);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Tasks.pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTasks();
            }

            if (Session["Theme"] != null && Session["Theme"].ToString() == "dark")
            {
                form1.Attributes["class"] = "bg-dark text-white";
            }
        }

       
        private void LoadTasks()
        {
            var tasks = JsonHelper.GetTasks();

            // Bind tasks to Repeater
            rptTasks.DataSource = tasks;
            rptTasks.DataBind();

            // Statistics
            lblTotal.Text = tasks.Count.ToString();
            lblCompleted.Text = tasks.Count(t => t.IsCompleted).ToString();
            lblPending.Text = tasks.Count(t => !t.IsCompleted).ToString();
            lblOverdue.Text = tasks.Count(t =>
                !t.IsCompleted &&
                t.DueDate.Date < DateTime.Today).ToString();

            // Overdue Reminder Notification
            int overdue = tasks.Count(t =>
                !t.IsCompleted &&
                t.DueDate.Date < DateTime.Today);

            if (overdue > 0)
            {
                pnlReminder.Visible = true;
                lblReminder.Text = "⚠ " + overdue + " task(s) are overdue.";
            }
            else
            {
                pnlReminder.Visible = false;
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTask.aspx");
        }
        
        protected void btnTheme_Click(object sender, EventArgs e)
        {
            if (Session["Theme"] == null || Session["Theme"].ToString() == "light")
                Session["Theme"] = "dark";
            else
                Session["Theme"] = "light";

            Response.Redirect(Request.RawUrl);
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            string keyword = txtSearch.Text.Trim().ToLower();

            var result = tasks.Where(t =>
                t.Title.ToLower().Contains(keyword) ||
                t.Description.ToLower().Contains(keyword))
                .ToList();

            rptTasks.DataSource = result;
            rptTasks.DataBind();
        }

      
        protected void rptTasks_ItemCommand(object source,
            System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            List<TaskItem> tasks = JsonHelper.GetTasks();

            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Delete")
            {
                tasks.RemoveAll(x => x.Id == id);

                JsonHelper.SaveTasks(tasks);

                LoadTasks();
            }

            if (e.CommandName == "Complete")
            {
                TaskItem task = tasks.FirstOrDefault(x => x.Id == id);

                if (task != null)
                    task.IsCompleted = true;

                JsonHelper.SaveTasks(tasks);

                LoadTasks();
            }

            if (e.CommandName == "Edit")
            {
                Response.Redirect("EditTask.aspx?id=" + id);
            }
        }
    }
}