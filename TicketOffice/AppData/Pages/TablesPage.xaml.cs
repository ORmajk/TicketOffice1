using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Linq;
using System.Reflection;
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
    /// Логика взаимодействия для TablesPage.xaml
    /// </summary>
    public partial class TablesPage : Page
    {
        // Название выбранной таблицы
        private string curTable = "";

        public TablesPage()
        {
            InitializeComponent();

            // Удалять записи может только администратор
            if (AppConnect.CurUser.id_role != AppConnect.RoleAdmin)
            {
                btnDeleteRow.Visibility = Visibility.Collapsed;
            }

            // Меню таблиц: название для пользователя и имя таблицы в базе
            AddTable("Билеты", "Tickets");
            AddTable("Категории билетов", "CategoryTickets");
            AddTable("Статусы билетов", "TicketStatuses");
            AddTable("Мероприятия", "Events");
            AddTable("Категории мероприятий", "CategoryEvents");
            AddTable("Организаторы", "Organizers");
            AddTable("Расписание", "Schedule");
            AddTable("Залы", "Halls");
            AddTable("Площадки", "Plases");
            AddTable("Категории площадок", "CategoryPlases");
            AddTable("Заказы", "Orders");
            AddTable("Билеты в заказах", "OrderTickets");
            AddTable("Статусы заказов", "OrderStatus");
            AddTable("Оплаты", "Pay");
            AddTable("Способы оплаты", "MethodPay");
            AddTable("Статусы оплаты", "StausPay");
            AddTable("Пользователи", "Users");
            AddTable("Роли", "Roles");

            lbTables.SelectedIndex = 0;
        }

        // Добавление таблицы в меню
        private void AddTable(string name, string table)
        {
            ListBoxItem item = new ListBoxItem();
            item.Content = name;
            item.Tag = table;
            lbTables.Items.Add(item);
        }

        private void lbTables_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListBoxItem item = lbTables.SelectedItem as ListBoxItem;

            if (item == null)
            {
                return;
            }

            curTable = item.Tag.ToString();
            tbTableName.Text = item.Content.ToString();
            LoadTable();
        }

        // Загрузка выбранной таблицы в DataGrid
        private void LoadTable()
        {
            try
            {
                // Менеджер пользователей только смотрит
                dgTable.IsReadOnly = curTable == "Users" && AppConnect.CurUser.id_role != AppConnect.RoleAdmin;
                dgTable.ItemsSource = null;

                switch (curTable)
                {
                    case "Tickets":
                        AppConnect.model.Tickets.Load();
                        dgTable.ItemsSource = AppConnect.model.Tickets.Local;
                        break;
                    case "CategoryTickets":
                        AppConnect.model.CategoryTickets.Load();
                        dgTable.ItemsSource = AppConnect.model.CategoryTickets.Local;
                        break;
                    case "TicketStatuses":
                        AppConnect.model.TicketStatuses.Load();
                        dgTable.ItemsSource = AppConnect.model.TicketStatuses.Local;
                        break;
                    case "Events":
                        AppConnect.model.Events.Load();
                        dgTable.ItemsSource = AppConnect.model.Events.Local;
                        break;
                    case "CategoryEvents":
                        AppConnect.model.CategoryEvents.Load();
                        dgTable.ItemsSource = AppConnect.model.CategoryEvents.Local;
                        break;
                    case "Organizers":
                        AppConnect.model.Organizers.Load();
                        dgTable.ItemsSource = AppConnect.model.Organizers.Local;
                        break;
                    case "Schedule":
                        AppConnect.model.Schedule.Load();
                        dgTable.ItemsSource = AppConnect.model.Schedule.Local;
                        break;
                    case "Halls":
                        AppConnect.model.Halls.Load();
                        dgTable.ItemsSource = AppConnect.model.Halls.Local;
                        break;
                    case "Plases":
                        AppConnect.model.Plases.Load();
                        dgTable.ItemsSource = AppConnect.model.Plases.Local;
                        break;
                    case "CategoryPlases":
                        AppConnect.model.CategoryPlases.Load();
                        dgTable.ItemsSource = AppConnect.model.CategoryPlases.Local;
                        break;
                    case "Orders":
                        AppConnect.model.Orders.Load();
                        dgTable.ItemsSource = AppConnect.model.Orders.Local;
                        break;
                    case "OrderTickets":
                        AppConnect.model.OrderTickets.Load();
                        dgTable.ItemsSource = AppConnect.model.OrderTickets.Local;
                        break;
                    case "OrderStatus":
                        AppConnect.model.OrderStatus.Load();
                        dgTable.ItemsSource = AppConnect.model.OrderStatus.Local;
                        break;
                    case "Pay":
                        AppConnect.model.Pay.Load();
                        dgTable.ItemsSource = AppConnect.model.Pay.Local;
                        break;
                    case "MethodPay":
                        AppConnect.model.MethodPay.Load();
                        dgTable.ItemsSource = AppConnect.model.MethodPay.Local;
                        break;
                    case "StausPay":
                        AppConnect.model.StausPay.Load();
                        dgTable.ItemsSource = AppConnect.model.StausPay.Local;
                        break;
                    case "Users":
                        AppConnect.model.Users.Load();
                        dgTable.ItemsSource = AppConnect.model.Users.Local;
                        break;
                    case "Roles":
                        AppConnect.model.Roles.Load();
                        dgTable.ItemsSource = AppConnect.model.Roles.Local;
                        break;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось загрузить таблицу.\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        // Отмена всех несохраненных изменений
        private void ResetModel()
        {
            int userId = AppConnect.CurUser.id;

            AppConnect.model = new TicketOfficeEntities();
            AppConnect.CurUser = AppConnect.model.Users.FirstOrDefault(u => u.id == userId);
            AppConnect.cart.Clear();
        }

        // В таблице показываем только обычные поля (без связей с другими таблицами)
        private void dgTable_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            PropertyDescriptor property = e.PropertyDescriptor as PropertyDescriptor;
            bool isSimpleType = e.PropertyType.IsValueType || e.PropertyType == typeof(string);

            if (!isSimpleType || (property != null && property.IsReadOnly))
            {
                e.Cancel = true;
                return;
            }

            // Чтобы в заголовке не пропадал знак "_"
            e.Column.Header = e.PropertyName.Replace("_", "__");

            // Пароли видит только администратор
            if (e.PropertyName == "password" && AppConnect.CurUser.id_role != AppConnect.RoleAdmin)
            {
                e.Cancel = true;
            }
        }

        // Новой записи сразу ставим следующий код
        private void dgTable_InitializingNewItem(object sender, InitializingNewItemEventArgs e)
        {
            PropertyInfo idProperty = e.NewItem.GetType().GetProperty("id");

            if (idProperty == null)
            {
                return;
            }

            int maxId = 0;
            foreach (object row in dgTable.ItemsSource)
            {
                int rowId = (int)idProperty.GetValue(row);
                if (rowId > maxId)
                {
                    maxId = rowId;
                }
            }

            idProperty.SetValue(e.NewItem, maxId + 1);
        }

        // Есть ли записи в других таблицах, которые ссылаются на эту запись
        private bool IsRowUsed(object row)
        {
            foreach (PropertyInfo property in row.GetType().GetProperties())
            {
                object value = property.GetValue(row);

                // Связанные записи лежат в свойствах-списках (например Roles.Users)
                System.Collections.IEnumerable list = value as System.Collections.IEnumerable;
                if (list == null || value is string || value is byte[])
                {
                    continue;
                }

                foreach (object item in list)
                {
                    return true;
                }
            }

            return false;
        }

        // Проверка данных перед сохранением
        private bool CheckData()
        {
            foreach (Users user in AppConnect.model.Users.Local)
            {
                if (!RegistrationPage.CheckFio(user.fio) || !RegistrationPage.CheckMail(user.mail) || !RegistrationPage.CheckNumber(user.number))
                {
                    MessageBox.Show($"Пользователь с кодом {user.id}: проверьте ФИО, почту и телефон (+7XXXXXXXXXX)", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
                    return false;
                }

                if (string.IsNullOrWhiteSpace(user.password) || user.id_role == null)
                {
                    MessageBox.Show($"Пользователь с кодом {user.id}: заполните пароль и код роли", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
                    return false;
                }
            }

            foreach (Tickets ticket in AppConnect.model.Tickets.Local)
            {
                if (ticket.price == null || ticket.price <= 0 || ticket.price > 1000000)
                {
                    MessageBox.Show($"Билет с кодом {ticket.id}: цена должна быть от 0 до 1 000 000", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
                    return false;
                }

                if (ticket.discountPercent != null && (ticket.discountPercent < 1 || ticket.discountPercent > 99))
                {
                    MessageBox.Show($"Билет с кодом {ticket.id}: скидка должна быть от 1 до 99", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
                    return false;
                }
            }

            return true;
        }

        private void btnSaveChanges_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                dgTable.CommitEdit(DataGridEditingUnit.Row, true);

                if (!CheckData())
                {
                    return;
                }

                AppConnect.model.SaveChanges();
                MessageBox.Show("Изменения сохранены", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (DbEntityValidationException)
            {
                MessageBox.Show("Заполните обязательные поля и проверьте длину текста", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (DbUpdateException)
            {
                MessageBox.Show("Не удалось сохранить. Проверьте, что коды не повторяются и связанные записи существуют. Изменения отменены.", "Таблицы", MessageBoxButton.OK, MessageBoxImage.Error);
                ResetModel();
                LoadTable();
            }
        }

        private void btnDeleteRow_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                object row = dgTable.SelectedItem;

                if (row == null || row == CollectionView.NewItemPlaceholder)
                {
                    MessageBox.Show("Выберите запись", "Удаление", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                // Билет из заказа удалять нельзя
                Tickets ticket = row as Tickets;
                if (ticket != null && AppConnect.model.OrderTickets.Any(o => o.id_ticket == ticket.id))
                {
                    MessageBox.Show("Невозможно удалить билет, так как он присутствует в одном или нескольких заказах.", "Удаление", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                Users user = row as Users;
                if (user != null && user.id == AppConnect.CurUser.id)
                {
                    MessageBox.Show("Нельзя удалить самого себя", "Удаление", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (IsRowUsed(row))
                {
                    MessageBox.Show("Невозможно удалить запись, так как она используется в других таблицах.", "Удаление", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                if (MessageBox.Show("Удалить выбранную запись?", "Удаление", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes)
                {
                    return;
                }

                AppConnect.model.Entry(row).State = EntityState.Deleted;
                AppConnect.model.SaveChanges();
            }
            catch (DbUpdateException)
            {
                MessageBox.Show("Невозможно удалить запись, так как она используется в других таблицах.", "Удаление", MessageBoxButton.OK, MessageBoxImage.Error);
                ResetModel();
                LoadTable();
            }
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            // Несохраненные изменения не должны попасть в базу позже
            if (AppConnect.model.ChangeTracker.HasChanges())
            {
                ResetModel();
            }

            NavigationService.Navigate(new Pages.MainPage());
        }
    }
}
