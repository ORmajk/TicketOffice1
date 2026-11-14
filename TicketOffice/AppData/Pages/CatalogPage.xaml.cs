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
    /// Логика взаимодействия для CatalogPage.xaml
    /// </summary>
    public partial class CatalogPage : Page
    {
        // Пока страница не загрузилась, фильтры не применяем
        private bool isPageReady = false;

        public CatalogPage()
        {
            InitializeComponent();

            List<CategoryEvents> categories = AppConnect.model.CategoryEvents.ToList();
            categories.Insert(0, new CategoryEvents { id = 0, categoryEvents1 = "Все категории" });
            cbCategory.ItemsSource = categories;

            // Варианты сортировки
            cbSort.Items.Add("Без сортировки");
            cbSort.Items.Add("Сначала дешевые");
            cbSort.Items.Add("Сначала дорогие");
            cbSort.Items.Add("По названию");
            cbSort.Items.Add("По дате");
            cbCategory.SelectedIndex = 0;
            cbSort.SelectedIndex = 0;

            // Добавлять и изменять билеты могут менеджер и администратор, удалять - только администратор
            if (AppConnect.CurUser.id_role != AppConnect.RoleManager && AppConnect.CurUser.id_role != AppConnect.RoleAdmin)
            {
                btnAddTicket.Visibility = Visibility.Collapsed;
                btnEditTicket.Visibility = Visibility.Collapsed;
            }

            if (AppConnect.CurUser.id_role != AppConnect.RoleAdmin)
            {
                btnDeleteTicket.Visibility = Visibility.Collapsed;
            }

            isPageReady = true;
            UpdateTickets();
            UpdateCartButton();
        }

        // Поиск, фильтрация и сортировка билетов
        private void UpdateTickets()
        {
            if (!isPageReady)
            {
                return;
            }

            List<Tickets> allTickets = AppConnect.model.Tickets.ToList();
            List<Tickets> tickets = allTickets;

            string search = tbSearch.Text.Trim().ToLower();
            if (search != "")
            {
                // Ищем по названию билета и по названию мероприятия
                tickets = tickets.Where(t =>
                    (t.nameTicket != null && t.nameTicket.ToLower().Contains(search)) ||
                    (t.Schedule != null && t.Schedule.Events != null && t.Schedule.Events.nameEvent.ToLower().Contains(search))).ToList();
            }

            if (cbCategory.SelectedIndex > 0)
            {
                CategoryEvents category = (CategoryEvents)cbCategory.SelectedItem;
                tickets = tickets.Where(t => t.Schedule != null && t.Schedule.Events != null && t.Schedule.Events.id_categoryEvent == category.id).ToList();
            }

            if (dpDate.SelectedDate != null)
            {
                DateTime date = dpDate.SelectedDate.Value.Date;
                tickets = tickets.Where(t => t.Schedule != null && t.Schedule.datetime != null && t.Schedule.datetime.Value.Date == date).ToList();
            }

            if (chbOnlyFree.IsChecked == true)
            {
                tickets = tickets.Where(t => t.id_ticketStatus == AppConnect.TicketFree).ToList();
            }

            switch (cbSort.SelectedIndex)
            {
                case 1:
                    tickets = tickets.OrderBy(t => t.NewPrice).ToList();
                    break;
                case 2:
                    tickets = tickets.OrderByDescending(t => t.NewPrice).ToList();
                    break;
                case 3:
                    tickets = tickets.OrderBy(t => t.nameTicket).ToList();
                    break;
                case 4:
                    tickets = tickets.OrderBy(t => t.Schedule == null ? null : t.Schedule.datetime).ToList();
                    break;
            }

            lvTickets.ItemsSource = tickets;
            tbCount.Text = $"Показано: {tickets.Count} из {allTickets.Count}";
        }

        private void UpdateCartButton()
        {
            btnCart.Content = $"Корзина ({AppConnect.cart.Count})";
        }

        private void tbSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateTickets();
        }

        private void cbCategory_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTickets();
        }

        private void cbSort_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTickets();
        }

        private void dpDate_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateTickets();
        }

        private void chbOnlyFree_Click(object sender, RoutedEventArgs e)
        {
            UpdateTickets();
        }

        private void btnResetFilters_Click(object sender, RoutedEventArgs e)
        {
            isPageReady = false;
            tbSearch.Text = "";
            cbCategory.SelectedIndex = 0;
            cbSort.SelectedIndex = 0;
            dpDate.SelectedDate = null;
            chbOnlyFree.IsChecked = true;
            isPageReady = true;

            UpdateTickets();
        }

        private void btnAddToCart_Click(object sender, RoutedEventArgs e)
        {
            Tickets ticket = lvTickets.SelectedItem as Tickets;

            if (ticket == null)
            {
                MessageBox.Show("Выберите билет", "Каталог", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (ticket.id_ticketStatus != AppConnect.TicketFree)
            {
                MessageBox.Show("Этот билет уже занят", "Каталог", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (AppConnect.cart.Contains(ticket))
            {
                MessageBox.Show("Этот билет уже в корзине", "Каталог", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            AppConnect.cart.Add(ticket);
            UpdateCartButton();
            MessageBox.Show("Билет добавлен в корзину", "Каталог", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        // Двойное нажатие открывает страницу с полной информацией о билете
        private void lvTickets_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Tickets ticket = lvTickets.SelectedItem as Tickets;

            if (ticket == null)
            {
                return;
            }

            NavigationService.Navigate(new Pages.TicketInfoPage(ticket));
        }

        // При возврате со страницы билета обновляем список и корзину
        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            UpdateTickets();
            UpdateCartButton();
            SetDateHint();
        }

        // Подсказка в поле даты на русском языке (по умолчанию она на английском)
        private void SetDateHint()
        {
            dpDate.ApplyTemplate();
            System.Windows.Controls.Primitives.DatePickerTextBox dateBox =
                dpDate.Template.FindName("PART_TextBox", dpDate) as System.Windows.Controls.Primitives.DatePickerTextBox;

            if (dateBox == null)
            {
                return;
            }

            dateBox.ApplyTemplate();
            ContentControl hint = dateBox.Template.FindName("PART_Watermark", dateBox) as ContentControl;

            if (hint != null)
            {
                hint.Content = "Дата";
            }
        }

        private void btnCart_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.CartPage());
        }

        private void btnAddTicket_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.TicketEditPage(null));
        }

        private void btnEditTicket_Click(object sender, RoutedEventArgs e)
        {
            Tickets ticket = lvTickets.SelectedItem as Tickets;

            if (ticket == null)
            {
                MessageBox.Show("Выберите билет", "Каталог", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            NavigationService.Navigate(new Pages.TicketEditPage(ticket));
        }

        private void btnDeleteTicket_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Tickets ticket = lvTickets.SelectedItem as Tickets;

                if (ticket == null)
                {
                    MessageBox.Show("Выберите билет", "Каталог", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                // Билет из заказа удалять нельзя
                if (AppConnect.model.OrderTickets.Any(o => o.id_ticket == ticket.id))
                {
                    MessageBox.Show("Невозможно удалить билет, так как он присутствует в одном или нескольких заказах.", "Удаление", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (MessageBox.Show("Удалить выбранный билет?", "Удаление", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes)
                {
                    return;
                }

                AppConnect.cart.Remove(ticket);
                AppConnect.model.Tickets.Remove(ticket);
                AppConnect.model.SaveChanges();

                UpdateTickets();
                UpdateCartButton();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось удалить билет.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Pages.MainPage());
        }
    }
}
