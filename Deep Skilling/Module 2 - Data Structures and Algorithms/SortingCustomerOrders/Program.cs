using System;

namespace SortingCustomerOrders
{
    class Order
    {
        public int OrderId;
        public string CustomerName;
        public double TotalPrice;

        public Order(int orderId, string customerName, double totalPrice)
        {
            OrderId = orderId;
            CustomerName = customerName;
            TotalPrice = totalPrice;
        }
    }

    class Program
    {
        static void DisplayOrders(Order[] orders)
        {
            foreach (Order order in orders)
            {
                Console.WriteLine($"Order ID: {order.OrderId}, Customer: {order.CustomerName}, Total Price: {order.TotalPrice}");
            }
        }

        static void BubbleSort(Order[] orders)
        {
            int n = orders.Length;

            for (int i = 0; i < n - 1; i++)
            {
                for (int j = 0; j < n - i - 1; j++)
                {
                    if (orders[j].TotalPrice > orders[j + 1].TotalPrice)
                    {
                        Order temp = orders[j];
                        orders[j] = orders[j + 1];
                        orders[j + 1] = temp;
                    }
                }
            }
        }

        static int Partition(Order[] orders, int low, int high)
        {
            double pivot = orders[high].TotalPrice;
            int i = low - 1;

            for (int j = low; j < high; j++)
            {
                if (orders[j].TotalPrice < pivot)
                {
                    i++;

                    Order temp = orders[i];
                    orders[i] = orders[j];
                    orders[j] = temp;
                }
            }

            Order temp1 = orders[i + 1];
            orders[i + 1] = orders[high];
            orders[high] = temp1;

            return i + 1;
        }

        static void QuickSort(Order[] orders, int low, int high)
        {
            if (low < high)
            {
                int pi = Partition(orders, low, high);

                QuickSort(orders, low, pi - 1);
                QuickSort(orders, pi + 1, high);
            }
        }

        static void Main(string[] args)
        {
            Order[] orders =
            {
                new Order(101, "Zeba", 2500),
                new Order(102, "Ayesha", 1200),
                new Order(103, "Rahul", 4200),
                new Order(104, "Priya", 1800)
            };

            Console.WriteLine("Original Orders:");
            DisplayOrders(orders);

            BubbleSort(orders);
            Console.WriteLine("\nAfter Bubble Sort:");
            DisplayOrders(orders);

            Order[] orders2 =
            {
                new Order(101, "Zeba", 2500),
                new Order(102, "Ayesha", 1200),
                new Order(103, "Rahul", 4200),
                new Order(104, "Priya", 1800)
            };

            QuickSort(orders2, 0, orders2.Length - 1);

            Console.WriteLine("\nAfter Quick Sort:");
            DisplayOrders(orders2);
        }
    }
}