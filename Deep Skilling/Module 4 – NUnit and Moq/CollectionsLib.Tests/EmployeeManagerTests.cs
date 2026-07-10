using NUnit.Framework;
using CollectionsLib;
using System.Collections.Generic;

namespace CollectionsLib.Tests
{
    [TestFixture]
    public class EmployeeManagerTests
    {
        private EmployeeManager manager;

        [SetUp]
        public void Setup()
        {
            manager = new EmployeeManager();
        }

        [Test]
        public void GetEmployees_ShouldReturnAllEmployees()
        {
            List<Employee> employees = manager.GetEmployees();

            Assert.That(employees, Is.Not.Null);
            Assert.That(employees.Count, Is.EqualTo(4));
        }

        [Test]
        public void GetEmployeesWhoJoinedInPreviousYears_ShouldReturnEmployees()
        {
            List<Employee> employees = manager.GetEmployeesWhoJoinedInPreviousYears();

            Assert.That(employees, Is.Not.Null);
            Assert.That(employees.Count, Is.EqualTo(4));
        }
    }
}