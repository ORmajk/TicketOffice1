using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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
    /// Логика взаимодействия для RegistrationPage.xaml
    /// </summary>
    public partial class RegistrationPage : Page
    {
        public RegistrationPage()
        {
            InitializeComponent();
        }

        // ФИО: только буквы, пробелы и дефис, минимум 2 символа
        public static bool CheckFio(string fio)
        {
            if (string.IsNullOrWhiteSpace(fio))
            {
                return false;
            }

            return Regex.IsMatch(fio.Trim(), @"^[А-Яа-яЁёA-Za-z\- ]{2,255}$");
        }

        // Почта вида name@site.ru
        public static bool CheckMail(string mail)
        {
            if (string.IsNullOrWhiteSpace(mail))
            {
                return false;
            }

            return Regex.IsMatch(mail.Trim(), @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$");
        }

        // Телефон вида +7XXXXXXXXXX
        public static bool CheckNumber(string number)
        {
            if (string.IsNullOrWhiteSpace(number))
            {
                return false;
            }

            return Regex.IsMatch(number.Trim(), @"^\+7\d{10}$");
        }

        // Пароль: от 6 символов, есть хотя бы одна буква и одна цифра
        public static bool CheckPassword(string password)
        {
            if (string.IsNullOrWhiteSpace(password) || password.Length < 6)
            {
                return false;
            }

            return password.Any(char.IsLetter) && password.Any(char.IsDigit);
        }

        private void btnRegister_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string fio = tbFio.Text.Trim();
                string mail = tbMail.Text.Trim();
                string number = tbNumber.Text.Trim();
                string password = pbPassword.Password.Trim();

                if (!CheckFio(fio))
                {
                    MessageBox.Show("Введите ФИО (только буквы)", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (!CheckMail(mail))
                {
                    MessageBox.Show("Неверный формат почты", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (!CheckNumber(number))
                {
                    MessageBox.Show("Телефон должен быть в формате +7XXXXXXXXXX", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (!CheckPassword(password))
                {
                    MessageBox.Show("Пароль должен быть от 6 символов и содержать буквы и цифры", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (password != pbPasswordRepeat.Password.Trim())
                {
                    MessageBox.Show("Пароли не совпадают", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (AppConnect.model.Users.Any(u => u.mail == mail))
                {
                    MessageBox.Show("Пользователь с такой почтой уже есть", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (AppConnect.model.Users.Any(u => u.number == number))
                {
                    MessageBox.Show("Пользователь с таким телефоном уже есть", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                int newId = 1;
                if (AppConnect.model.Users.Any())
                {
                    newId = AppConnect.model.Users.Max(u => u.id) + 1;
                }

                Users user = new Users();
                user.id = newId;
                user.fio = fio;
                user.mail = mail;
                user.number = number;
                user.password = password;
                user.id_role = AppConnect.RoleClient;

                AppConnect.model.Users.Add(user);
                AppConnect.model.SaveChanges();

                MessageBox.Show("Вы зарегистрированы! Теперь можно войти", "Регистрация", MessageBoxButton.OK, MessageBoxImage.Information);
                NavigationService.Navigate(new Pages.Login());
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось зарегистрироваться.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.Login());
        }
    }
}
