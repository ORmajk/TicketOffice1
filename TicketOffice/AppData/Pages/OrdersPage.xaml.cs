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
    /// Логика взаимодействия для OrdersPage.xaml
    /// </summary>
    public partial class OrdersPage : Page
    {
        public OrdersPage()
        {
            InitializeComponent();

            int userId = AppConnect.CurUser.id;

            // Только заказы текущего пользователя, новые сверху
            lvOrders.ItemsSource = AppConnect.model.Orders
                .Where(o => o.id_user == userId)
                .OrderByDescending(o => o.id)
                .ToList();
        }

        // Двойное нажатие открывает страницу с полной информацией о заказе
        private void lvOrders_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Orders order = lvOrders.SelectedItem as Orders;

            if (order == null)
            {
                return;
            }

            NavigationService.Navigate(new Pages.OrderInfoPage(order));
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.MainPage());
        }
    }
}
