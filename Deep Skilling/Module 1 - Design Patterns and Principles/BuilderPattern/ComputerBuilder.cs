namespace BuilderPattern
{
    public abstract class ComputerBuilder
    {
        protected Computer computer = new Computer();

        public abstract void BuildCPU();
        public abstract void BuildRAM();
        public abstract void BuildStorage();

        public Computer GetComputer()
        {
            return computer;
        }
    }
}