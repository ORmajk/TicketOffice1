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
    /// Логика взаимодействия для OrderInfoPage.xaml
    /// </summary>
    public partial class OrderInfoPage : Page
    {
        // Заказ, который показываем
        private Orders curOrder;

        public OrderInfoPage(Orders order)
        {
            InitializeComponent();

            curOrder = order;

            tbTitle.Text = $"Заказ №{curOrder.id}";
            tbDate.Text = $"Дата заказа: {curOrder.dateOrder:dd.MM.yyyy}";
            tbSum.Text = $"Сумма: {curOrder.sum:N2} руб.";

            if (curOrder.OrderStatus != null)
            {
                tbStatus.Text = $"Статус: {curOrder.OrderStatus.ticketStatuses}";
            }

            if (curOrder.Users != null)
            {
                tbUser.Text = $"Покупатель: {curOrder.Users.fio}";
            }

            // Оплата заказа
            Pay pay = curOrder.Pay.FirstOrDefault();

            if (pay == null)
            {
                tbPayMethod.Text = "Оплаты пока нет";
            }
            else
            {
                tbPayDate.Text = $"Дата оплаты: {pay.datePay}";

                if (pay.MethodPay != null)
                {
                    tbPayMethod.Text = $"Способ оплаты: {pay.MethodPay.methodPay1}";
                }

                if (pay.StausPay != null)
                {
                    tbPayStatus.Text = $"Статус оплаты: {pay.StausPay.statusPay}";
                }
            }

            // Билеты из заказа
            List<Tickets> tickets = new List<Tickets>();

            foreach (OrderTickets orderTicket in curOrder.OrderTickets)
            {
                if (orderTicket.Tickets != null)
                {
                    tickets.Add(orderTicket.Tickets);
                }
            }

            lvOrderTickets.ItemsSource = tickets;
        }

        // Двойное нажатие открывает страницу с полной информацией о билете
        private void lvOrderTickets_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Tickets ticket = lvOrderTickets.SelectedItem as Tickets;

            if (ticket == null)
            {
                return;
            }

            NavigationService.Navigate(new Pages.TicketInfoPage(ticket));
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.OrdersPage());
        }
    }
}
