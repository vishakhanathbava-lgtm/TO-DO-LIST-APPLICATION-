using System;

namespace TO_DO_LIST_APPLICATION.Models
{
    [Serializable]
    public class TaskItem
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public DateTime DueDate { get; set; }

        public string Priority { get; set; }

        public bool Reminder { get; set; }

        public bool IsCompleted { get; set; }

       

        public string ReminderTime { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public string Category { get; set; }

        

    }
}