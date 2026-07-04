namespace BuilderPattern
{
    public class Director
    {
        public void Construct(ComputerBuilder builder)
        {
            builder.BuildCPU();
            builder.BuildRAM();
            builder.BuildStorage();
        }
    }
}