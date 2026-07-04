namespace BuilderPattern
{
    public class GamingComputerBuilder : ComputerBuilder
    {
        public override void BuildCPU()
        {
            computer.CPU = "Intel i9";
        }

        public override void BuildRAM()
        {
            computer.RAM = "32GB";
        }

        public override void BuildStorage()
        {
            computer.Storage = "1TB SSD";
        }
    }
}