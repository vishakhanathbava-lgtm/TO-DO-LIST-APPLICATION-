using System;
using System.Collections.Generic;
using System.Linq;
using TO_DO_LIST_APPLICATION.Helpers;
using TO_DO_LIST_APPLICATION.Models;

namespace TO_DO_LIST_APPLICATION
{
    public partial class EditTask : System.Web.UI.Page
    {
        private int taskId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out taskId))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadTask();
            }
        }

        private void LoadTask()
        {
            List<TaskItem> tasks = JsonHelper.GetTasks();

            TaskItem task = tasks.FirstOrDefault(x => x.Id == taskId);

            if (task == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            txtTitle.Text = task.Title;
            txtDescription.Text = task.Description;
            txtDueDate.Text = task.DueDate.ToString("yyyy-MM-dd");
            ddlPriority.SelectedValue = task.Priority;
            chkReminder.Checked = task.Reminder;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            List<TaskItem> tasks = JsonHelper.GetTasks();

            TaskItem task = tasks.FirstOrDefault(x => x.Id == taskId);

            if (task != null)
            {
                task.Title = txtTitle.Text;
                task.Description = txtDescription.Text;
                task.DueDate = Convert.ToDateTime(txtDueDate.Text);
                task.Priority = ddlPriority.SelectedValue;
                task.Reminder = chkReminder.Checked;

                JsonHelper.SaveTasks(tasks);
            }

            Response.Redirect("Default.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}