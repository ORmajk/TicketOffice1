using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketOffice.AppData
{
    internal class AppConnect
    {
        public static AppData.TicketOfficeEntities model;

        public static Users CurUser;

        // Корзина текущего пользователя (хранится пока открыто приложение)
        public static List<Tickets> cart = new List<Tickets>();

        // Роли (таблица Roles)
        public const int RoleAdmin = 1;
        public const int RoleManager = 2;
        public const int RoleClient = 3;

        // Статусы билетов (таблица TicketStatuses)
        public const int TicketFree = 1;
        public const int TicketSold = 3;

        // Статус заказа (таблица OrderStatus)
        public const int OrderPaid = 2;

        // Статус оплаты (таблица StausPay)
        public const int PayDone = 2;
    }
}
