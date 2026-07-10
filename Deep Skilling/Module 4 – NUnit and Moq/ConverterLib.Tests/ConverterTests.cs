using NUnit.Framework;
using Moq;
using ConverterLib;
using CurrencyConverterApp;

namespace ConverterLib.Tests
{
    [TestFixture]
    public class ConverterTests
    {
        private Converter converter;
        private Mock<IDollarToEuroExchangeRateFeed> mockFeed;

        [SetUp]
        public void Setup()
        {
            mockFeed = new Mock<IDollarToEuroExchangeRateFeed>();

            mockFeed.Setup(x => x.GetActualUSDollarValue())
                    .Returns(0.85);

            converter = new Converter(mockFeed.Object);
        }

        [Test]
        public void CelsiusToKelvin_ShouldReturnCorrectValue()
        {
            Assert.That(converter.CelsiusToKelvin(0), Is.EqualTo(273.15));
        }

        [Test]
        public void KilogramToPound_ShouldReturnCorrectValue()
        {
            Assert.That(converter.KilogramToPound(1), Is.EqualTo(2.205));
        }

        [Test]
        public void KilometerToMile_ShouldReturnCorrectValue()
        {
            Assert.That(converter.KilometerToMile(1.609), Is.EqualTo(1).Within(0.001));
        }

        [Test]
        public void LiterToGallon_ShouldReturnCorrectValue()
        {
            Assert.That(converter.LiterToGallon(3.785), Is.EqualTo(1).Within(0.001));
        }

        [Test]
        public void USDToEuro_ShouldUseMockExchangeRate()
        {
            double result = converter.USDToEuro(100);

            Assert.That(result, Is.EqualTo(85));
        }
    }
}