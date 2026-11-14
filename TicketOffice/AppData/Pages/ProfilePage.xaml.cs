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
    /// Логика взаимодействия для ProfilePage.xaml
    /// </summary>
    public partial class ProfilePage : Page
    {
        public ProfilePage()
        {
            InitializeComponent();

            tbFio.Text = AppConnect.CurUser.fio;
            tbMail.Text = AppConnect.CurUser.mail;
            tbNumber.Text = AppConnect.CurUser.number;

            // Роль только показываем, менять ее нельзя
            // Название роли берем из справочника по коду роли
            Roles role = AppConnect.model.Roles.FirstOrDefault(r => r.id == AppConnect.CurUser.id_role);

            if (role != null)
            {
                tbRole.Text = $"Роль: {role.role}";
            }
        }

        private void btnSaveChanges_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string fio = tbFio.Text.Trim();
                string mail = tbMail.Text.Trim();
                string number = tbNumber.Text.Trim();
                string password = pbPassword.Password.Trim();
                int userId = AppConnect.CurUser.id;

                if (!RegistrationPage.CheckFio(fio))
                {
                    MessageBox.Show("Введите ФИО (только буквы)", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (!RegistrationPage.CheckMail(mail))
                {
                    MessageBox.Show("Неверный формат почты", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (!RegistrationPage.CheckNumber(number))
                {
                    MessageBox.Show("Телефон должен быть в формате +7XXXXXXXXXX", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (password != "" && !RegistrationPage.CheckPassword(password))
                {
                    MessageBox.Show("Пароль должен быть от 6 символов и содержать буквы и цифры", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (AppConnect.model.Users.Any(u => u.mail == mail && u.id != userId))
                {
                    MessageBox.Show("Эта почта уже занята", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (AppConnect.model.Users.Any(u => u.number == number && u.id != userId))
                {
                    MessageBox.Show("Этот телефон уже занят", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                AppConnect.CurUser.fio = fio;
                AppConnect.CurUser.mail = mail;
                AppConnect.CurUser.number = number;

                if (password != "")
                {
                    AppConnect.CurUser.password = password;
                }

                AppConnect.model.SaveChanges();

                MessageBox.Show("Данные сохранены", "Личный кабинет", MessageBoxButton.OK, MessageBoxImage.Information);
                NavigationService.Navigate(new Pages.MainPage());
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось сохранить данные.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.MainPage());
        }
    }
}
