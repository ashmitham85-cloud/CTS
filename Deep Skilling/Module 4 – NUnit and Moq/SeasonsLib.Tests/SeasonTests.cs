using NUnit.Framework;
using SeasonsLib;

namespace SeasonsLib.Tests
{
    [TestFixture]
    public class SeasonTests
    {
        private SeasonTeller seasonTeller;

        [SetUp]
        public void Setup()
        {
            seasonTeller = new SeasonTeller();
        }

        [Test]
        public void DisplaySeasonBy_February_ReturnsSpring()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("February"), Is.EqualTo("Spring"));
        }

        [Test]
        public void DisplaySeasonBy_April_ReturnsSummer()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("April"), Is.EqualTo("Summer"));
        }

        [Test]
        public void DisplaySeasonBy_July_ReturnsMonsoon()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("July"), Is.EqualTo("Monsoon"));
        }

        [Test]
        public void DisplaySeasonBy_October_ReturnsAutumn()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("October"), Is.EqualTo("Autumn"));
        }

        [Test]
        public void DisplaySeasonBy_December_ReturnsWinter()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("December"), Is.EqualTo("Winter"));
        }

        [Test]
        public void DisplaySeasonBy_InvalidMonth_ReturnsInvalidSeason()
        {
            Assert.That(seasonTeller.DisplaySeasonBy("Hello"), Is.EqualTo("Invalid Season"));
        }
    }
}