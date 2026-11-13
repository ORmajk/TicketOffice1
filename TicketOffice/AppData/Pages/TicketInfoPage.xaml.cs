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
    /// Логика взаимодействия для TicketInfoPage.xaml
    /// </summary>
    public partial class TicketInfoPage : Page
    {
        // Билет, который показываем
        private Tickets curTicket;

        public TicketInfoPage(Tickets ticket)
        {
            InitializeComponent();

            curTicket = ticket;

            tbName.Text = curTicket.nameTicket;
            tbSeat.Text = $"Ряд: {curTicket.row_number}, место: {curTicket.seat_number}";
            tbPrice.Text = $"{curTicket.NewPrice:N2} руб.";

            if (curTicket.CategoryTickets != null)
            {
                tbCategoryTicket.Text = $"Категория билета: {curTicket.CategoryTickets.categoryTicket}";
            }

            if (curTicket.TicketStatuses != null)
            {
                tbStatus.Text = $"Статус: {curTicket.TicketStatuses.ticketStatus}";
            }

            // Старая цена и скидка показываются только если они есть
            if (curTicket.HasDiscount)
            {
                tbOldPrice.Text = $"{curTicket.oldPrice:N2} руб.";
                tbDiscount.Text = $"Скидка {curTicket.discountPercent}%";
                tbOldPrice.Visibility = Visibility.Visible;
                tbDiscount.Visibility = Visibility.Visible;
            }

            // Купить можно только свободный билет
            if (curTicket.id_ticketStatus != AppConnect.TicketFree)
            {
                btnAddToCart.Visibility = Visibility.Collapsed;
            }

            Schedule schedule = curTicket.Schedule;

            if (schedule == null)
            {
                return;
            }

            tbDate.Text = $"Дата и время: {schedule.datetime:dd.MM.yyyy HH:mm}";

            if (schedule.Events != null)
            {
                tbEvent.Text = schedule.Events.nameEvent;

                // Фото афиши из базы (путь вида /Images/файл.jpg)
                if (!string.IsNullOrWhiteSpace(schedule.Events.image))
                {
                    imgPoster.Source = new BitmapImage(new Uri(schedule.Events.image, UriKind.Relative));
                }

                if (schedule.Events.CategoryEvents != null)
                {
                    tbCategoryEvent.Text = $"Категория: {schedule.Events.CategoryEvents.categoryEvents1}";
                }

                if (schedule.Events.Organizers != null)
                {
                    tbOrganizer.Text = $"Организатор: {schedule.Events.Organizers.organizer}";
                }
            }

            if (schedule.Halls != null)
            {
                tbHall.Text = $"Зал: {schedule.Halls.hall}";

                if (schedule.Halls.Plases != null)
                {
                    tbPlace.Text = $"Площадка: {schedule.Halls.Plases.namePlace}";
                }
            }
        }

        private void btnAddToCart_Click(object sender, RoutedEventArgs e)
        {
            if (AppConnect.cart.Contains(curTicket))
            {
                MessageBox.Show("Этот билет уже в корзине", "Билет", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            AppConnect.cart.Add(curTicket);
            MessageBox.Show("Билет добавлен в корзину", "Билет", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        // Возврат на страницу, с которой открыли билет (каталог или заказ)
        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            if (NavigationService.CanGoBack)
            {
                NavigationService.GoBack();
            }
            else
            {
                NavigationService.Navigate(new Pages.CatalogPage());
            }
        }
    }
}
