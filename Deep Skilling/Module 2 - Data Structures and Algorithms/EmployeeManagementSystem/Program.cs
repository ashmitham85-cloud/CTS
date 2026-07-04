using System;

namespace EmployeeManagementSystem
{
    class Employee
    {
        public int EmployeeId;
        public string Name;
        public string Position;
        public double Salary;

        public Employee(int employeeId, string name, string position, double salary)
        {
            EmployeeId = employeeId;
            Name = name;
            Position = position;
            Salary = salary;
        }
    }

    class Program
    {
        static Employee[] employees = new Employee[10];
        static int count = 0;

        static void AddEmployee(Employee employee)
        {
            employees[count] = employee;
            count++;
        }

        static void SearchEmployee(int id)
        {
            for (int i = 0; i < count; i++)
            {
                if (employees[i].EmployeeId == id)
                {
                    Console.WriteLine($"Found: {employees[i].Name}, {employees[i].Position}, Salary: {employees[i].Salary}");
                    return;
                }
            }
            Console.WriteLine("Employee not found.");
        }

        static void TraverseEmployees()
        {
            Console.WriteLine("\nEmployee Records:");
            for (int i = 0; i < count; i++)
            {
                Console.WriteLine($"ID: {employees[i].EmployeeId}, Name: {employees[i].Name}, Position: {employees[i].Position}, Salary: {employees[i].Salary}");
            }
        }

        static void DeleteEmployee(int id)
        {
            for (int i = 0; i < count; i++)
            {
                if (employees[i].EmployeeId == id)
                {
                    for (int j = i; j < count - 1; j++)
                    {
                        employees[j] = employees[j + 1];
                    }
                    count--;
                    Console.WriteLine("Employee deleted successfully.");
                    return;
                }
            }
            Console.WriteLine("Employee not found.");
        }

        static void Main(string[] args)
        {
            AddEmployee(new Employee(101, "Zeba", "Developer", 50000));
            AddEmployee(new Employee(102, "Ayesha", "Tester", 45000));
            AddEmployee(new Employee(103, "Rahul", "Manager", 70000));

            TraverseEmployees();

            Console.WriteLine("\nSearching Employee ID 102:");
            SearchEmployee(102);

            Console.WriteLine("\nDeleting Employee ID 102:");
            DeleteEmployee(102);

            TraverseEmployees();
        }
    }
}