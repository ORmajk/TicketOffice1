using System.Windows;
using System.Windows.Navigation;
using TicketOffice.AppData;

namespace TicketOffice
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            AppConnect.model = new TicketOfficeEntities();

            AppFrame.framemain = Frmain;

            Frmain.Navigate(new AppData.Pages.Login());
        }
    }
}
