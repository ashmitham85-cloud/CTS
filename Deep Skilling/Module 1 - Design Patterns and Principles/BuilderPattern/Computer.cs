namespace BuilderPattern
{
    public class Computer
    {
        public string CPU { get; set; }
        public string RAM { get; set; }
        public string Storage { get; set; }

        public void ShowConfiguration()
        {
            Console.WriteLine("CPU: " + CPU);
            Console.WriteLine("RAM: " + RAM);
            Console.WriteLine("Storage: " + Storage);
        }
    }
}