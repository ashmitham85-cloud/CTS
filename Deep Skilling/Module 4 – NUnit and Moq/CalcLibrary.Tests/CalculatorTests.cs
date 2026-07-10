using NUnit.Framework;
using CalcLibrary;
using System;

namespace CalcLibrary.Tests
{
    [TestFixture]
    public class CalculatorTests
    {
        private Calculator calculator;

        [SetUp]
        public void Setup()
        {
            calculator = new Calculator();
        }

        [TearDown]
        public void TearDown()
        {
            calculator = null;
        }

        // Addition
        [TestCase(10, 20, 30)]
        [TestCase(5, 5, 10)]
        [TestCase(100, 200, 300)]
        public void TestAddition(int a, int b, int expected)
        {
            Assert.That(calculator.Add(a, b), Is.EqualTo(expected));
        }

        // Subtraction
        [TestCase(20, 10, 10)]
        [TestCase(50, 20, 30)]
        [TestCase(100, 50, 50)]
        public void TestSubtraction(int a, int b, int expected)
        {
            Assert.That(calculator.Subtract(a, b), Is.EqualTo(expected));
        }

        // Multiplication
        [TestCase(10, 5, 50)]
        [TestCase(8, 2, 16)]
        [TestCase(12, 3, 36)]
        public void TestMultiplication(int a, int b, int expected)
        {
            Assert.That(calculator.Multiply(a, b), Is.EqualTo(expected));
        }

        // Division
        [TestCase(20, 2, 10)]
        [TestCase(100, 10, 10)]
        public void TestDivision(int a, int b, int expected)
        {
            Assert.That(calculator.Divide(a, b), Is.EqualTo(expected));
        }

        [Test]
        public void TestDivisionByZero()
        {
            try
            {
                calculator.Divide(10, 0);
                Assert.Fail("Division by zero");
            }
            catch (ArgumentException ex)
            {
                Assert.That(ex.Message, Is.EqualTo("Division by zero"));
            }
        }

        // Void Method
        [Test]
        public void TestAddAndClear()
        {
            calculator.Add(20, 30);

            Assert.That(calculator.GetResult, Is.EqualTo(50));

            calculator.AllClear();

            Assert.That(calculator.GetResult, Is.EqualTo(0));
        }
    }
}