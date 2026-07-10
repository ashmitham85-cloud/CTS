using NUnit.Framework;
using LeapYearCalculatorLib;

namespace LeapYearCalculatorLib.Tests
{
    [TestFixture]
    public class LeapYearCalculatorTests
    {
        private LeapYearCalculator calculator;

        [SetUp]
        public void Setup()
        {
            calculator = new LeapYearCalculator();
        }

        [Test]
        public void IsLeapYear_2024_Returns1()
        {
            Assert.That(calculator.IsLeapYear(2024), Is.EqualTo(1));
        }

        [Test]
        public void IsLeapYear_2023_Returns0()
        {
            Assert.That(calculator.IsLeapYear(2023), Is.EqualTo(0));
        }

        [Test]
        public void IsLeapYear_2000_Returns1()
        {
            Assert.That(calculator.IsLeapYear(2000), Is.EqualTo(1));
        }

        [Test]
        public void IsLeapYear_1900_Returns0()
        {
            Assert.That(calculator.IsLeapYear(1900), Is.EqualTo(0));
        }

        [Test]
        public void IsLeapYear_Below1753_ReturnsMinus1()
        {
            Assert.That(calculator.IsLeapYear(1700), Is.EqualTo(-1));
        }

        [Test]
        public void IsLeapYear_Above9999_ReturnsMinus1()
        {
            Assert.That(calculator.IsLeapYear(10000), Is.EqualTo(-1));
        }
    }
}