using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using System.Web;
using TO_DO_LIST_APPLICATION.Models;

namespace TO_DO_LIST_APPLICATION.Helpers
{
    public class JsonHelper
    {
        private static string FilePath
        {
            get
            {
                return HttpContext.Current.Server.MapPath("~/Data/tasks.json");
            }
        }

        public static List<TaskItem> GetTasks()
        {
            if (!File.Exists(FilePath))
            {
                File.WriteAllText(FilePath, "[]");
            }

            string json = File.ReadAllText(FilePath);

            return JsonConvert.DeserializeObject<List<TaskItem>>(json)
                   ?? new List<TaskItem>();
        }

        public static void SaveTasks(List<TaskItem> tasks)
        {
            string json = JsonConvert.SerializeObject(tasks, Formatting.Indented);

            File.WriteAllText(FilePath, json);
        }
    }
}