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
    /// Логика взаимодействия для MainPage.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        public MainPage()
        {
            InitializeComponent();

            tbHello.Text = AppConnect.CurUser.fio;

            // Название роли берем из справочника по коду роли
            Roles role = AppConnect.model.Roles.FirstOrDefault(r => r.id == AppConnect.CurUser.id_role);

            if (role != null)
            {
                tbRole.Text = $"Роль: {role.role}";
            }

            // Таблицы БД доступны только менеджеру и администратору
            if (AppConnect.CurUser.id_role != AppConnect.RoleManager && AppConnect.CurUser.id_role != AppConnect.RoleAdmin)
            {
                btnTables.Visibility = Visibility.Collapsed;
            }
        }

        private void btnCatalog_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.CatalogPage());
        }

        private void btnCart_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.CartPage());
        }

        private void btnOrders_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.OrdersPage());
        }

        private void btnProfile_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.ProfilePage());
        }

        private void btnTables_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.TablesPage());
        }

        // Выход из учетной записи
        private void btnLogout_Click(object sender, RoutedEventArgs e)
        {
            AppConnect.CurUser = null;
            AppConnect.cart.Clear();

            NavigationService.Navigate(new Pages.Login());

            // После выхода нельзя вернуться назад на страницы пользователя
            Dispatcher.BeginInvoke(new Action(ClearHistory), System.Windows.Threading.DispatcherPriority.ContextIdle);
        }

        // Очистка истории переходов (выполняется после открытия страницы входа)
        private void ClearHistory()
        {
            while (AppFrame.framemain.CanGoBack)
            {
                AppFrame.framemain.RemoveBackEntry();
            }
        }
    }
}
