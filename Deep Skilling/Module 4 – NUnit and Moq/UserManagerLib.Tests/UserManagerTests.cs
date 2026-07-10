using NUnit.Framework;
using UserManagerLib;
using System;

namespace UserManagerLib.Tests
{
    [TestFixture]
    public class UserManagerTests
    {
        private User user;

        [SetUp]
        public void Setup()
        {
            user = new User();
        }

        [Test]
        public void ValidatePANCardNumber_ValidPAN_ReturnsValid()
        {
            Assert.That(user.ValidatePANCardNumber("ABCDE1234F"), Is.EqualTo("Valid"));
        }

        [Test]
        public void ValidatePANCardNumber_NullPAN_ThrowsNullReferenceException()
        {
            Assert.That(
                () => user.ValidatePANCardNumber(null),
                Throws.TypeOf<NullReferenceException>());
        }

        [Test]
        public void ValidatePANCardNumber_EmptyPAN_ThrowsNullReferenceException()
        {
            Assert.That(
                () => user.ValidatePANCardNumber(""),
                Throws.TypeOf<NullReferenceException>());
        }

        [Test]
        public void ValidatePANCardNumber_InvalidLength_ThrowsFormatException()
        {
            Assert.That(
                () => user.ValidatePANCardNumber("ABC123"),
                Throws.TypeOf<FormatException>());
        }

        [Test]
        public void CreateUser_WithValidPAN_DoesNotThrowException()
        {
            User newUser = new User
            {
                PANCardNo = "ABCDE1234F"
            };

            Assert.That(
                () => user.CreateUser(newUser),
                Throws.Nothing);
        }
    }
}