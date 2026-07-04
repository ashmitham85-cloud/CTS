using System;

namespace TaskManagementSystem
{
    class Task
    {
        public int TaskId;
        public string TaskName;
        public string Status;
        public Task Next;

        public Task(int taskId, string taskName, string status)
        {
            TaskId = taskId;
            TaskName = taskName;
            Status = status;
            Next = null;
        }
    }

    class TaskLinkedList
    {
        private Task head;

        public void AddTask(int id, string name, string status)
        {
            Task newTask = new Task(id, name, status);

            if (head == null)
            {
                head = newTask;
                return;
            }

            Task temp = head;
            while (temp.Next != null)
            {
                temp = temp.Next;
            }

            temp.Next = newTask;
        }

        public void TraverseTasks()
        {
            Console.WriteLine("\nTask List:");
            Task temp = head;

            while (temp != null)
            {
                Console.WriteLine($"ID: {temp.TaskId}, Name: {temp.TaskName}, Status: {temp.Status}");
                temp = temp.Next;
            }
        }

        public void SearchTask(int id)
        {
            Task temp = head;

            while (temp != null)
            {
                if (temp.TaskId == id)
                {
                    Console.WriteLine($"Found: {temp.TaskName}, Status: {temp.Status}");
                    return;
                }
                temp = temp.Next;
            }

            Console.WriteLine("Task not found.");
        }

        public void DeleteTask(int id)
        {
            if (head == null)
                return;

            if (head.TaskId == id)
            {
                head = head.Next;
                Console.WriteLine("Task deleted successfully.");
                return;
            }

            Task temp = head;

            while (temp.Next != null && temp.Next.TaskId != id)
            {
                temp = temp.Next;
            }

            if (temp.Next != null)
            {
                temp.Next = temp.Next.Next;
                Console.WriteLine("Task deleted successfully.");
            }
            else
            {
                Console.WriteLine("Task not found.");
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            TaskLinkedList tasks = new TaskLinkedList();

            tasks.AddTask(101, "Design UI", "Pending");
            tasks.AddTask(102, "Develop Backend", "In Progress");
            tasks.AddTask(103, "Testing", "Pending");

            tasks.TraverseTasks();

            Console.WriteLine("\nSearching Task ID 102:");
            tasks.SearchTask(102);

            Console.WriteLine("\nDeleting Task ID 102:");
            tasks.DeleteTask(102);

            tasks.TraverseTasks();
        }
    }
}