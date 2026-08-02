using System;
using System.Collections.Generic;
using TO_DO_LIST_APPLICATION.Helpers;
using TO_DO_LIST_APPLICATION.Models;

namespace TO_DO_LIST_APPLICATION
{
    public partial class AddTask : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            List<TaskItem> tasks = JsonHelper.GetTasks();

            TaskItem task = new TaskItem
            {
                Id = tasks.Count + 1,
                Title = txtTitle.Text,
                Description = txtDescription.Text,
                DueDate = Convert.ToDateTime(txtDueDate.Text),
                Priority = ddlPriority.SelectedValue,
                Category = ddlCategory.SelectedValue,
                Reminder = chkReminder.Checked,
                IsCompleted = false,
                CreatedDate = DateTime.Now,
                ReminderTime = txtReminderTime.Text

            };

            tasks.Add(task);

            JsonHelper.SaveTasks(tasks);

            Response.Redirect("Default.aspx");
        }
       
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}