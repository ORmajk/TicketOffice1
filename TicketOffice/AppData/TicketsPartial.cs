using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketOffice.AppData
{
    // Дополнение к классу Tickets из модели (для каталога)
    public partial class Tickets
    {
        // Есть ли у билета скидка
        public bool HasDiscount
        {
            get { return oldPrice != null && discountPercent != null; }
        }

        // Цена билета с учетом скидки
        public decimal NewPrice
        {
            get
            {
                if (HasDiscount)
                {
                    return Pages.TicketEditPage.CalculateNewPrice(oldPrice.Value, discountPercent.Value);
                }

                if (price == null)
                {
                    return 0;
                }

                return price.Value;
            }
        }

        // Дорогой билет (выделяется в каталоге)
        public bool IsExpensive
        {
            get { return NewPrice > 1000; }
        }
    }
}
