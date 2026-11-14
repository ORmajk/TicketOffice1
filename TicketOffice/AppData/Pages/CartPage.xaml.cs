using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace TicketOffice.AppData.Pages
{
    /// <summary>
    /// Логика взаимодействия для CartPage.xaml
    /// </summary>
    public partial class CartPage : Page
    {
        public CartPage()
        {
            InitializeComponent();

            cbMethodPay.ItemsSource = AppConnect.model.MethodPay.ToList();
            cbMethodPay.SelectedIndex = 0;

            UpdateCart();
        }

        // Общая стоимость билетов с учетом скидок
        public static decimal CalculateTotalPrice(List<Tickets> tickets)
        {
            decimal total = 0;

            foreach (Tickets ticket in tickets)
            {
                total += ticket.NewPrice;
            }

            return total;
        }

        private void UpdateCart()
        {
            lvCart.ItemsSource = null;
            lvCart.ItemsSource = AppConnect.cart;
            tbTotal.Text = $"Итого: {CalculateTotalPrice(AppConnect.cart):N2} руб.";
        }

        private void btnRemoveFromCart_Click(object sender, RoutedEventArgs e)
        {
            Tickets ticket = lvCart.SelectedItem as Tickets;

            if (ticket == null)
            {
                MessageBox.Show("Выберите билет", "Корзина", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            AppConnect.cart.Remove(ticket);
            UpdateCart();
        }

        private void btnMakeOrder_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (AppConnect.cart.Count == 0)
                {
                    MessageBox.Show("Корзина пустая", "Корзина", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                MethodPay methodPay = cbMethodPay.SelectedItem as MethodPay;
                if (methodPay == null)
                {
                    MessageBox.Show("Выберите способ оплаты", "Корзина", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                // Пока билет лежал в корзине, его могли купить
                foreach (Tickets ticket in AppConnect.cart)
                {
                    if (ticket.id_ticketStatus != AppConnect.TicketFree)
                    {
                        MessageBox.Show($"Билет уже занят, уберите его из корзины:\n{ticket.nameTicket}", "Корзина", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                }

                int orderId = 1;
                if (AppConnect.model.Orders.Any())
                {
                    orderId = AppConnect.model.Orders.Max(o => o.id) + 1;
                }

                int orderTicketId = 1;
                if (AppConnect.model.OrderTickets.Any())
                {
                    orderTicketId = AppConnect.model.OrderTickets.Max(o => o.id) + 1;
                }

                int payId = 1;
                if (AppConnect.model.Pay.Any())
                {
                    payId = AppConnect.model.Pay.Max(p => p.id) + 1;
                }

                Orders order = AppConnect.model.Orders.Create();
                order.id = orderId;
                order.id_user = AppConnect.CurUser.id;
                order.dateOrder = DateTime.Today;
                order.sum = (double)CalculateTotalPrice(AppConnect.cart);
                order.id_orderStatus = AppConnect.OrderPaid;
                AppConnect.model.Orders.Add(order);

                foreach (Tickets ticket in AppConnect.cart)
                {
                    OrderTickets orderTicket = AppConnect.model.OrderTickets.Create();
                    orderTicket.id = orderTicketId;
                    orderTicket.id_order = orderId;
                    orderTicket.id_ticket = ticket.id;
                    AppConnect.model.OrderTickets.Add(orderTicket);
                    orderTicketId++;

                    ticket.id_ticketStatus = AppConnect.TicketSold;
                }

                Pay pay = AppConnect.model.Pay.Create();
                pay.id = payId;
                pay.id_order = orderId;
                pay.datePay = DateTime.Today.ToString("dd.MM.yyyy");
                pay.id_methodPay = methodPay.id;
                pay.id_stausPay = AppConnect.PayDone;
                AppConnect.model.Pay.Add(pay);

                AppConnect.model.SaveChanges();
                AppConnect.cart.Clear();

                MessageBox.Show($"Заказ №{orderId} оформлен!", "Корзина", MessageBoxButton.OK, MessageBoxImage.Information);
                NavigationService.Navigate(new Pages.OrdersPage());
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось оформить заказ.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);

                // Отменяем несохраненные изменения
                int userId = AppConnect.CurUser.id;
                AppConnect.model = new TicketOfficeEntities();
                AppConnect.CurUser = AppConnect.model.Users.FirstOrDefault(u => u.id == userId);
                AppConnect.cart.Clear();
                UpdateCart();
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.CatalogPage());
        }
    }
}
