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
    /// Логика взаимодействия для Login.xaml
    /// </summary>
    public partial class Login : Page
    {
        public Login()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(tblogin.Text.Trim()) || string.IsNullOrWhiteSpace(pbPssword.Password.Trim()))
                {
                    MessageBox.Show("Пустое/ые поля", "Авторизация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                string login = tblogin.Text.Trim();
                string password = pbPssword.Password.Trim();

                var user = AppConnect.model.Users.FirstOrDefault(u => (u.number == login || u.mail == login) && u.password == password);

                if (user == null)
                {
                    MessageBox.Show("Нет такого пользователя", "Авторизация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                MessageBox.Show($" Добро пожаловать!\n {user.fio}", "Авторизация", MessageBoxButton.OK, MessageBoxImage.Information);
                AppConnect.CurUser = user;
                NavigationService.Navigate(new Pages.MainPage());
            }
            catch (Exception ex)
            {
                MessageBox.Show($"{ex}","Критическая ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.RegistrationPage());

        }
    }
}
