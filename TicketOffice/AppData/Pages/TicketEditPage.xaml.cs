using System;
using System.Collections.Generic;
using System.Globalization;
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
    /// Логика взаимодействия для TicketEditPage.xaml
    /// </summary>
    public partial class TicketEditPage : Page
    {
        // Билет, который изменяем (null - добавляем новый)
        private Tickets curTicket;

        public TicketEditPage(Tickets ticket)
        {
            InitializeComponent();

            curTicket = ticket;

            cbSchedule.ItemsSource = AppConnect.model.Schedule.OrderBy(s => s.datetime).ToList();
            cbCategory.ItemsSource = AppConnect.model.CategoryTickets.ToList();
            cbStatus.ItemsSource = AppConnect.model.TicketStatuses.ToList();

            if (curTicket == null)
            {
                cbStatus.SelectedIndex = 0;
                return;
            }

            tbTitle.Text = "Изменение билета";
            tbName.Text = curTicket.nameTicket;
            cbSchedule.SelectedItem = curTicket.Schedule;
            cbCategory.SelectedItem = curTicket.CategoryTickets;
            cbStatus.SelectedItem = curTicket.TicketStatuses;
            tbRow.Text = curTicket.row_number.ToString();
            tbSeat.Text = curTicket.seat_number.ToString();
            tbOldPrice.Text = curTicket.oldPrice.ToString();
            tbDiscount.Text = curTicket.discountPercent.ToString();
            tbPrice.Text = curTicket.price.ToString();
        }

        // Новая цена = старая цена минус процент скидки
        public static decimal CalculateNewPrice(decimal oldPrice, int discountPercent)
        {
            return Math.Round(oldPrice * (100 - discountPercent) / 100, 2);
        }

        // Перевод текста в цену (можно и с точкой, и с запятой)
        public static bool TryParsePrice(string text, out decimal price)
        {
            price = 0;

            if (string.IsNullOrWhiteSpace(text))
            {
                return false;
            }

            return decimal.TryParse(text.Trim().Replace(',', '.'), NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture, out price);
        }

        private void btnSaveChanges_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string name = tbName.Text.Trim();
                Schedule schedule = cbSchedule.SelectedItem as Schedule;
                CategoryTickets category = cbCategory.SelectedItem as CategoryTickets;
                TicketStatuses status = cbStatus.SelectedItem as TicketStatuses;

                if (name == "")
                {
                    MessageBox.Show("Введите название билета", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (schedule == null || category == null || status == null)
                {
                    MessageBox.Show("Выберите сеанс, категорию и статус", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                int row;
                if (!int.TryParse(tbRow.Text.Trim(), out row) || row < 1 || row > 1000)
                {
                    MessageBox.Show("Ряд должен быть числом от 1 до 1000", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                int seat;
                if (!int.TryParse(tbSeat.Text.Trim(), out seat) || seat < 1 || seat > 1000)
                {
                    MessageBox.Show("Место должно быть числом от 1 до 1000", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                bool hasOldPrice = tbOldPrice.Text.Trim() != "";
                bool hasDiscount = tbDiscount.Text.Trim() != "";

                if (hasOldPrice != hasDiscount)
                {
                    MessageBox.Show("Старая цена и скидка заполняются вместе", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                decimal price;
                decimal? oldPrice = null;
                int? discount = null;

                if (hasOldPrice)
                {
                    decimal oldPriceValue;
                    if (!TryParsePrice(tbOldPrice.Text, out oldPriceValue) || oldPriceValue <= 0 || oldPriceValue > 1000000)
                    {
                        MessageBox.Show("Старая цена должна быть числом от 0 до 1 000 000", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }

                    int discountValue;
                    if (!int.TryParse(tbDiscount.Text.Trim(), out discountValue) || discountValue < 1 || discountValue > 99)
                    {
                        MessageBox.Show("Скидка должна быть числом от 1 до 99", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }

                    oldPrice = oldPriceValue;
                    discount = discountValue;
                    price = CalculateNewPrice(oldPriceValue, discountValue);
                }
                else
                {
                    if (!TryParsePrice(tbPrice.Text, out price) || price <= 0 || price > 1000000)
                    {
                        MessageBox.Show("Цена должна быть числом от 0 до 1 000 000", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                }

                // На одно место одного сеанса может быть только один билет
                int curId = 0;
                if (curTicket != null)
                {
                    curId = curTicket.id;
                }

                if (AppConnect.model.Tickets.Any(t => t.id_shedule == schedule.id && t.row_number == row && t.seat_number == seat && t.id != curId))
                {
                    MessageBox.Show("Билет на это место уже есть", "Билет", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (curTicket == null)
                {
                    int newId = 1;
                    if (AppConnect.model.Tickets.Any())
                    {
                        newId = AppConnect.model.Tickets.Max(t => t.id) + 1;
                    }

                    curTicket = new Tickets();
                    curTicket.id = newId;
                    AppConnect.model.Tickets.Add(curTicket);
                }

                curTicket.nameTicket = name;
                curTicket.id_shedule = schedule.id;
                curTicket.id_categoryTicket = category.id;
                curTicket.id_ticketStatus = status.id;
                curTicket.row_number = row;
                curTicket.seat_number = seat;
                curTicket.oldPrice = oldPrice;
                curTicket.discountPercent = discount;
                curTicket.price = price;

                AppConnect.model.SaveChanges();

                MessageBox.Show("Билет сохранен", "Билет", MessageBoxButton.OK, MessageBoxImage.Information);
                NavigationService.Navigate(new Pages.CatalogPage());
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось сохранить билет.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.CatalogPage());
        }
    }
}
