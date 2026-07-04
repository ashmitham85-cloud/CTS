namespace BuilderPattern
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Director director = new Director();

            ComputerBuilder builder = new GamingComputerBuilder();

            director.Construct(builder);

            Computer computer = builder.GetComputer();

            computer.ShowConfiguration();
        }
    }
}