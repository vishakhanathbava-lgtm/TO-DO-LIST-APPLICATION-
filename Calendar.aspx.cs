using System;
using System.Linq;
using System.Web.Script.Serialization;
using TO_DO_LIST_APPLICATION.Helpers;

namespace TO_DO_LIST_APPLICATION
{
    public partial class Calendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var tasks = JsonHelper.GetTasks();

            var events = tasks.Select(t => new
            {
                id = t.Id,

                title = t.Title,

                start = t.DueDate.ToString("yyyy-MM-dd"),

                color =
                    t.IsCompleted ? "#0d6efd" :
                    t.Priority == "High" ? "#dc3545" :
                    t.Priority == "Medium" ? "#ffc107" :
                    "#198754"

            }).ToList();

            JavaScriptSerializer js =
                new JavaScriptSerializer();

            hfEvents.Value =
                js.Serialize(events);
        }
    }
}