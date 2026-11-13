-- TicketOffice database: tables, data, foreign keys
-- Generated 13.11.2026 22:00
USE [master]
GO
IF DB_ID('TicketOffice') IS NULL CREATE DATABASE [TicketOffice]
GO
USE [TicketOffice]
GO

CREATE TABLE [dbo].[CategoryEvents](
	[id] int NOT NULL,
	[categoryEvents] nvarchar(50) NULL,
	CONSTRAINT [PK_CategoryEvents] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[CategoryPlases](
	[id] int NOT NULL,
	[categoryPlace] nvarchar(255) NULL,
	CONSTRAINT [PK_CategoryPlases] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[CategoryTickets](
	[id] int NOT NULL,
	[categoryTicket] nvarchar(255) NULL,
	CONSTRAINT [PK_CategoryTickets] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Events](
	[id] int NOT NULL,
	[nameEvent] nvarchar(255) NOT NULL,
	[id_categoryEvent] int NULL,
	[id_organizer] int NULL,
	[image] nvarchar(255) NULL,
	CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Halls](
	[id] int NOT NULL,
	[hall] nvarchar(255) NULL,
	[id_place] int NULL,
	CONSTRAINT [PK_Halls] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[MethodPay](
	[id] int NOT NULL,
	[methodPay] nvarchar(50) NULL,
	CONSTRAINT [PK_MethodPay] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Orders](
	[id] int NOT NULL,
	[id_user] int NULL,
	[dateOrder] date NULL,
	[sum] float NULL,
	[id_orderStatus] int NULL,
	CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[OrderStatus](
	[id] int NOT NULL,
	[ticketStatuses] nvarchar(50) NULL,
	CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[OrderTickets](
	[id] int NOT NULL,
	[id_order] int NULL,
	[id_ticket] int NULL,
	CONSTRAINT [PK_OrderTickets] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Organizers](
	[id] int NOT NULL,
	[organizer] nvarchar(255) NULL,
	CONSTRAINT [PK_Organizers] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Pay](
	[id] int NOT NULL,
	[id_order] int NULL,
	[datePay] nvarchar(50) NULL,
	[id_methodPay] int NULL,
	[id_stausPay] int NULL,
	CONSTRAINT [PK_Pay] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Plases](
	[id] int NOT NULL,
	[namePlace] nvarchar(50) NULL,
	[id_categoryPlace] int NULL,
	CONSTRAINT [PK_Plases] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Roles](
	[id] int NOT NULL,
	[role] nvarchar(255) NULL,
	CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Schedule](
	[id] int NOT NULL,
	[id_hall] int NULL,
	[id_event] int NULL,
	[datetime] datetime NULL,
	CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[StausPay](
	[id] int NOT NULL,
	[statusPay] nvarchar(50) NULL,
	CONSTRAINT [PK_StausPay] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Tickets](
	[id] int NOT NULL,
	[nameTicket] nvarchar(255) NULL,
	[id_categoryTicket] int NULL,
	[price] decimal(18, 2) NULL,
	[row_number] int NULL,
	[seat_number] int NULL,
	[id_ticketStatus] int NULL,
	[id_shedule] int NULL,
	[oldPrice] decimal(18, 2) NULL,
	[discountPercent] int NULL,
	[image] nvarchar(255) NULL,
	CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[TicketStatuses](
	[id] int NOT NULL,
	[ticketStatus] nvarchar(255) NULL,
	CONSTRAINT [PK_TicketStatuses] PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE TABLE [dbo].[Users](
	[id] int NOT NULL,
	[fio] nvarchar(255) NULL,
	[mail] nvarchar(255) NOT NULL,
	[number] nvarchar(255) NULL,
	[password] nvarchar(255) NULL,
	[id_role] int NULL,
	CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([id])
)
GO

-- CategoryEvents: 6
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (1, N'Концерт')
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (2, N'Спектакль')
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (3, N'Стендап')
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (4, N'Кино')
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (5, N'Спорт')
INSERT INTO [dbo].[CategoryEvents] ([id], [categoryEvents]) VALUES (6, N'Выставка')
GO
-- CategoryPlases: 6
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (1, N'Концертный зал')
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (2, N'Театр')
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (3, N'Кинотеатр')
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (4, N'Стадион')
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (5, N'Клуб')
INSERT INTO [dbo].[CategoryPlases] ([id], [categoryPlace]) VALUES (6, N'Выставочный центр')
GO
-- CategoryTickets: 5
INSERT INTO [dbo].[CategoryTickets] ([id], [categoryTicket]) VALUES (1, N'Стандарт')
INSERT INTO [dbo].[CategoryTickets] ([id], [categoryTicket]) VALUES (2, N'Партер')
INSERT INTO [dbo].[CategoryTickets] ([id], [categoryTicket]) VALUES (3, N'Балкон')
INSERT INTO [dbo].[CategoryTickets] ([id], [categoryTicket]) VALUES (4, N'VIP')
INSERT INTO [dbo].[CategoryTickets] ([id], [categoryTicket]) VALUES (5, N'Фан-зона')
GO
-- Events: 10
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (1, N'Концерт группы «Кино-Трибьют»', 1, 1, N'/Images/kino-tribiut.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (2, N'Симфонический рок-вечер', 1, 1, N'/Images/Symphonic-rock-evening.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (3, N'Спектакль «Ревизор»', 2, 2, N'/Images/plakat-revizor.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (4, N'Спектакль «Мастер и Маргарита»', 2, 2, N'/Images/The-Master-and-Margarita.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (5, N'Большой стендап-концерт', 3, 3, N'/Images/Big-Stand-up-Comedy-Show.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (6, N'Открытый микрофон', 3, 3, N'/Images/Open-Mic.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (7, N'Премьера «Космос 2026»', 4, 4, N'/Images/Cosmos-2026.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (8, N'Хоккей: Динамо — Спартак', 5, 5, N'/Images/Hockey-Dynamo-Spartak.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (9, N'Выставка «Цифровое искусство»', 6, 6, N'/Images/Digital-Art-Exhibition.jpg')
INSERT INTO [dbo].[Events] ([id], [nameEvent], [id_categoryEvent], [id_organizer], [image]) VALUES (10, N'Вечер джаза', 1, 1, N'/Images/Evening-of-Jazz.jpg')
GO
-- Halls: 9
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (1, N'Большой зал', 1)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (2, N'Малый зал', 1)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (3, N'Основная сцена', 2)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (4, N'Новая сцена', 2)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (5, N'Зал 1 IMAX', 3)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (6, N'Зал 2', 3)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (7, N'Главная арена', 4)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (8, N'Основной зал', 5)
INSERT INTO [dbo].[Halls] ([id], [hall], [id_place]) VALUES (9, N'Центральный павильон', 6)
GO
-- MethodPay: 4
INSERT INTO [dbo].[MethodPay] ([id], [methodPay]) VALUES (1, N'Банковская карта')
INSERT INTO [dbo].[MethodPay] ([id], [methodPay]) VALUES (2, N'СБП')
INSERT INTO [dbo].[MethodPay] ([id], [methodPay]) VALUES (3, N'Наличные в кассе')
INSERT INTO [dbo].[MethodPay] ([id], [methodPay]) VALUES (4, N'Подарочный сертификат')
GO
-- Orders: 16
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (1, 8, '2026-11-04', 5500, 4)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (2, 12, '2026-11-09', 5750, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (3, 7, '2026-11-12', 14750, 4)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (4, 9, '2026-11-11', 7000, 1)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (5, 8, '2026-11-02', 7500, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (6, 10, '2026-11-06', 11000, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (7, 10, '2026-11-04', 12750, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (8, 8, '2026-11-03', 4250, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (9, 8, '2026-11-05', 16500, 3)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (10, 9, '2026-11-10', 2250, 3)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (11, 12, '2026-11-04', 9500, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (12, 8, '2026-11-02', 15250, 1)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (13, 5, '2026-11-06', 3750, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (14, 7, '2026-11-13', 7750, 2)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (15, 5, '2026-11-08', 750, 1)
INSERT INTO [dbo].[Orders] ([id], [id_user], [dateOrder], [sum], [id_orderStatus]) VALUES (16, 4, '2026-11-13', 4500, 2)
GO
-- OrderStatus: 4
INSERT INTO [dbo].[OrderStatus] ([id], [ticketStatuses]) VALUES (1, N'Новый')
INSERT INTO [dbo].[OrderStatus] ([id], [ticketStatuses]) VALUES (2, N'Оплачен')
INSERT INTO [dbo].[OrderStatus] ([id], [ticketStatuses]) VALUES (3, N'Отменён')
INSERT INTO [dbo].[OrderStatus] ([id], [ticketStatuses]) VALUES (4, N'Возврат')
GO
-- OrderTickets: 36
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (1, 1, 15)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (2, 1, 114)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (3, 2, 14)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (4, 2, 96)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (5, 2, 71)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (6, 3, 20)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (7, 3, 35)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (8, 3, 37)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (9, 4, 78)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (10, 4, 27)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (11, 5, 92)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (12, 5, 44)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (13, 6, 111)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (14, 6, 88)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (15, 7, 82)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (16, 7, 34)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (17, 8, 65)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (18, 8, 63)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (19, 9, 33)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (20, 9, 7)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (21, 9, 12)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (22, 10, 106)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (23, 10, 55)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (24, 11, 36)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (25, 11, 6)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (26, 12, 1)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (27, 12, 43)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (28, 12, 17)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (29, 13, 99)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (30, 13, 105)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (31, 13, 21)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (32, 14, 57)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (33, 14, 116)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (34, 14, 98)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (35, 15, 72)
INSERT INTO [dbo].[OrderTickets] ([id], [id_order], [id_ticket]) VALUES (36, 16, 67)
GO
-- Organizers: 6
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (1, N'ООО «Шоу Продакшн»')
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (2, N'Театральное агентство «Кулиса»')
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (3, N'Stand-Up Club Moscow')
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (4, N'Синема Парк Ивент')
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (5, N'Спортивная лига «Арена»')
INSERT INTO [dbo].[Organizers] ([id], [organizer]) VALUES (6, N'Арт-группа «Холст»')
GO
-- Pay: 16
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (1, 1, N'04.11.2026', 1, 4)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (2, 2, N'09.11.2026', 4, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (3, 3, N'12.11.2026', 2, 4)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (4, 4, N'11.11.2026', 3, 1)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (5, 5, N'02.11.2026', 3, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (6, 6, N'06.11.2026', 4, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (7, 7, N'04.11.2026', 4, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (8, 8, N'03.11.2026', 2, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (9, 9, N'05.11.2026', 1, 3)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (10, 10, N'10.11.2026', 2, 3)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (11, 11, N'04.11.2026', 2, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (12, 12, N'02.11.2026', 3, 1)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (13, 13, N'06.11.2026', 1, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (14, 14, N'13.11.2026', 1, 2)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (15, 15, N'08.11.2026', 2, 1)
INSERT INTO [dbo].[Pay] ([id], [id_order], [datePay], [id_methodPay], [id_stausPay]) VALUES (16, 16, N'13.11.2026', 1, 2)
GO
-- Plases: 6
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (1, N'Крокус Сити Холл', 1)
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (2, N'Театр им. Вахтангова', 2)
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (3, N'Кинотеатр «Октябрь»', 3)
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (4, N'ВТБ Арена', 4)
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (5, N'Клуб «16 тонн»', 5)
INSERT INTO [dbo].[Plases] ([id], [namePlace], [id_categoryPlace]) VALUES (6, N'Манеж', 6)
GO
-- Roles: 3
INSERT INTO [dbo].[Roles] ([id], [role]) VALUES (1, N'Администратор')
INSERT INTO [dbo].[Roles] ([id], [role]) VALUES (2, N'Менеджер')
INSERT INTO [dbo].[Roles] ([id], [role]) VALUES (3, N'Клиент')
GO
-- Schedule: 20
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (1, 1, 1, '2026-12-04T13:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (2, 1, 1, '2026-12-24T20:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (3, 2, 2, '2026-12-18T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (4, 2, 2, '2026-11-30T20:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (5, 3, 3, '2026-12-07T16:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (6, 3, 3, '2026-12-11T13:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (7, 4, 4, '2026-12-14T13:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (8, 4, 4, '2026-12-12T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (9, 8, 5, '2026-12-19T13:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (10, 8, 5, '2026-11-25T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (11, 8, 6, '2026-12-26T16:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (12, 8, 6, '2026-11-22T16:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (13, 6, 7, '2026-11-25T16:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (14, 5, 7, '2026-12-14T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (15, 7, 8, '2026-12-30T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (16, 7, 8, '2026-12-13T19:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (17, 9, 9, '2026-12-07T13:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (18, 9, 9, '2026-12-24T16:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (19, 2, 10, '2026-12-19T20:00:00')
INSERT INTO [dbo].[Schedule] ([id], [id_hall], [id_event], [datetime]) VALUES (20, 2, 10, '2026-12-30T16:00:00')
GO
-- StausPay: 4
INSERT INTO [dbo].[StausPay] ([id], [statusPay]) VALUES (1, N'Ожидает оплаты')
INSERT INTO [dbo].[StausPay] ([id], [statusPay]) VALUES (2, N'Оплачено')
INSERT INTO [dbo].[StausPay] ([id], [statusPay]) VALUES (3, N'Ошибка оплаты')
INSERT INTO [dbo].[StausPay] ([id], [statusPay]) VALUES (4, N'Возвращено')
GO
-- Tickets: 120
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (1, N'Концерт группы «Кино-Трибьют» — ряд 1, место 1', 4, 6500.00, 1, 1, 2, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (2, N'Концерт группы «Кино-Трибьют» — ряд 1, место 2', 2, 2750.00, 1, 2, 1, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (3, N'Концерт группы «Кино-Трибьют» — ряд 1, место 3', 2, 3000.00, 1, 3, 1, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (4, N'Концерт группы «Кино-Трибьют» — ряд 2, место 1', 3, 2000.00, 2, 1, 1, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (5, N'Концерт группы «Кино-Трибьют» — ряд 2, место 2', 2, 2750.00, 2, 2, 1, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (6, N'Концерт группы «Кино-Трибьют» — ряд 2, место 3', 4, 6500.00, 2, 3, 3, 1, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (7, N'Концерт группы «Кино-Трибьют» — ряд 1, место 1', 2, 3500.00, 1, 1, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (8, N'Концерт группы «Кино-Трибьют» — ряд 1, место 2', 3, 2500.00, 1, 2, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (9, N'Концерт группы «Кино-Трибьют» — ряд 1, место 3', 2, 3000.00, 1, 3, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (10, N'Концерт группы «Кино-Трибьют» — ряд 2, место 1', 2, 2750.00, 2, 1, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (11, N'Концерт группы «Кино-Трибьют» — ряд 2, место 2', 4, 6500.00, 2, 2, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (12, N'Концерт группы «Кино-Трибьют» — ряд 2, место 3', 4, 7000.00, 2, 3, 1, 2, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (13, N'Симфонический рок-вечер — ряд 1, место 1', 4, 7000.00, 1, 1, 1, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (14, N'Симфонический рок-вечер — ряд 1, место 2', 3, 1750.00, 1, 2, 3, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (15, N'Симфонический рок-вечер — ряд 1, место 3', 2, 3500.00, 1, 3, 4, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (16, N'Симфонический рок-вечер — ряд 2, место 1', 2, 2500.00, 2, 1, 1, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (17, N'Симфонический рок-вечер — ряд 2, место 2', 2, 2750.00, 2, 2, 2, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (18, N'Симфонический рок-вечер — ряд 2, место 3', 4, 6250.00, 2, 3, 1, 3, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (19, N'Симфонический рок-вечер — ряд 1, место 1', 4, 7000.00, 1, 1, 1, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (20, N'Симфонический рок-вечер — ряд 1, место 2', 4, 6000.00, 1, 2, 4, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (21, N'Симфонический рок-вечер — ряд 1, место 3', 3, 2500.00, 1, 3, 3, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (22, N'Симфонический рок-вечер — ряд 2, место 1', 4, 7000.00, 2, 1, 1, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (23, N'Симфонический рок-вечер — ряд 2, место 2', 4, 6500.00, 2, 2, 1, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (24, N'Симфонический рок-вечер — ряд 2, место 3', 4, 6000.00, 2, 3, 1, 4, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (25, N'Спектакль «Ревизор» — ряд 1, место 1', 4, 6000.00, 1, 1, 1, 5, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (26, N'Спектакль «Ревизор» — ряд 1, место 2', 4, 6500.00, 1, 2, 1, 5, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (27, N'Спектакль «Ревизор» — ряд 1, место 3', 4, 6500.00, 1, 3, 2, 5, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (28, N'Спектакль «Ревизор» — ряд 2, место 1', 2, 2400.00, 2, 1, 1, 5, 3000.00, 20, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (29, N'Спектакль «Ревизор» — ряд 2, место 2', 3, 1750.00, 2, 2, 1, 5, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (30, N'Спектакль «Ревизор» — ряд 2, место 3', 3, 1500.00, 2, 3, 1, 5, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (31, N'Спектакль «Ревизор» — ряд 1, место 1', 4, 6500.00, 1, 1, 1, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (32, N'Спектакль «Ревизор» — ряд 1, место 2', 4, 6250.00, 1, 2, 1, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (33, N'Спектакль «Ревизор» — ряд 1, место 3', 4, 6000.00, 1, 3, 1, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (34, N'Спектакль «Ревизор» — ряд 2, место 1', 4, 6500.00, 2, 1, 3, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (35, N'Спектакль «Ревизор» — ряд 2, место 2', 4, 6250.00, 2, 2, 4, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (36, N'Спектакль «Ревизор» — ряд 2, место 3', 2, 3000.00, 2, 3, 3, 6, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (37, N'Спектакль «Мастер и Маргарита» — ряд 1, место 1', 2, 2500.00, 1, 1, 4, 7, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (38, N'Спектакль «Мастер и Маргарита» — ряд 1, место 2', 4, 6500.00, 1, 2, 1, 7, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (39, N'Спектакль «Мастер и Маргарита» — ряд 1, место 3', 3, 1500.00, 1, 3, 1, 7, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (40, N'Спектакль «Мастер и Маргарита» — ряд 2, место 1', 2, 3000.00, 2, 1, 1, 7, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (41, N'Спектакль «Мастер и Маргарита» — ряд 2, место 2', 3, 1750.00, 2, 2, 1, 7, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (42, N'Спектакль «Мастер и Маргарита» — ряд 2, место 3', 2, 2475.00, 2, 3, 1, 7, 2750.00, 10, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (43, N'Спектакль «Мастер и Маргарита» — ряд 1, место 1', 4, 6000.00, 1, 1, 2, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (44, N'Спектакль «Мастер и Маргарита» — ряд 1, место 2', 2, 3500.00, 1, 2, 3, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (45, N'Спектакль «Мастер и Маргарита» — ряд 1, место 3', 2, 2750.00, 1, 3, 1, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (46, N'Спектакль «Мастер и Маргарита» — ряд 2, место 1', 2, 3500.00, 2, 1, 1, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (47, N'Спектакль «Мастер и Маргарита» — ряд 2, место 2', 4, 6250.00, 2, 2, 1, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (48, N'Спектакль «Мастер и Маргарита» — ряд 2, место 3', 3, 2500.00, 2, 3, 1, 8, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (49, N'Большой стендап-концерт — ряд 1, место 1', 1, 600.00, 1, 1, 1, 9, 750.00, 20, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (50, N'Большой стендап-концерт — ряд 1, место 2', 5, 4500.00, 1, 2, 1, 9, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (51, N'Большой стендап-концерт — ряд 1, место 3', 5, 4500.00, 1, 3, 1, 9, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (52, N'Большой стендап-концерт — ряд 2, место 1', 5, 3500.00, 2, 1, 1, 9, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (53, N'Большой стендап-концерт — ряд 2, место 2', 1, 750.00, 2, 2, 1, 9, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (54, N'Большой стендап-концерт — ряд 2, место 3', 1, 1000.00, 2, 3, 1, 9, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (55, N'Большой стендап-концерт — ряд 1, место 1', 1, 750.00, 1, 1, 1, 10, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (56, N'Большой стендап-концерт — ряд 1, место 2', 1, 375.00, 1, 2, 1, 10, 500.00, 25, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (57, N'Большой стендап-концерт — ряд 1, место 3', 1, 500.00, 1, 3, 3, 10, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (58, N'Большой стендап-концерт — ряд 2, место 1', 1, 500.00, 2, 1, 1, 10, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (59, N'Большой стендап-концерт — ряд 2, место 2', 1, 1000.00, 2, 2, 1, 10, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (60, N'Большой стендап-концерт — ряд 2, место 3', 1, 750.00, 2, 3, 1, 10, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (61, N'Открытый микрофон — ряд 1, место 1', 5, 4500.00, 1, 1, 1, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (62, N'Открытый микрофон — ряд 1, место 2', 1, 750.00, 1, 2, 1, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (63, N'Открытый микрофон — ряд 1, место 3', 5, 3750.00, 1, 3, 3, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (64, N'Открытый микрофон — ряд 2, место 1', 5, 4500.00, 2, 1, 1, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (65, N'Открытый микрофон — ряд 2, место 2', 1, 500.00, 2, 2, 3, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (66, N'Открытый микрофон — ряд 2, место 3', 1, 1500.00, 2, 3, 1, 11, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (67, N'Открытый микрофон — ряд 1, место 1', 5, 4500.00, 1, 1, 3, 12, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (68, N'Открытый микрофон — ряд 1, место 2', 5, 4500.00, 1, 2, 1, 12, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (69, N'Открытый микрофон — ряд 1, место 3', 1, 500.00, 1, 3, 1, 12, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (70, N'Открытый микрофон — ряд 2, место 1', 1, 1200.00, 2, 1, 1, 12, 1500.00, 20, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (71, N'Открытый микрофон — ряд 2, место 2', 5, 3500.00, 2, 2, 3, 12, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (72, N'Открытый микрофон — ряд 2, место 3', 1, 750.00, 2, 3, 2, 12, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (73, N'Премьера «Космос 2026» — ряд 1, место 1', 1, 1500.00, 1, 1, 1, 13, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (74, N'Премьера «Космос 2026» — ряд 1, место 2', 1, 1500.00, 1, 2, 1, 13, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (75, N'Премьера «Космос 2026» — ряд 1, место 3', 1, 1000.00, 1, 3, 1, 13, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (76, N'Премьера «Космос 2026» — ряд 2, место 1', 4, 6250.00, 2, 1, 1, 13, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (77, N'Премьера «Космос 2026» — ряд 2, место 2', 1, 1125.00, 2, 2, 1, 13, 1500.00, 25, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (78, N'Премьера «Космос 2026» — ряд 2, место 3', 1, 500.00, 2, 3, 2, 13, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (79, N'Премьера «Космос 2026» — ряд 1, место 1', 1, 500.00, 1, 1, 1, 14, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (80, N'Премьера «Космос 2026» — ряд 1, место 2', 1, 750.00, 1, 2, 1, 14, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (81, N'Премьера «Космос 2026» — ряд 1, место 3', 4, 7000.00, 1, 3, 1, 14, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (82, N'Премьера «Космос 2026» — ряд 2, место 1', 4, 6250.00, 2, 1, 3, 14, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (83, N'Премьера «Космос 2026» — ряд 2, место 2', 4, 6000.00, 2, 2, 1, 14, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (84, N'Премьера «Космос 2026» — ряд 2, место 3', 1, 1350.00, 2, 3, 1, 14, 1500.00, 10, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (85, N'Хоккей: Динамо — Спартак — ряд 1, место 1', 1, 1500.00, 1, 1, 1, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (86, N'Хоккей: Динамо — Спартак — ряд 1, место 2', 4, 7000.00, 1, 2, 1, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (87, N'Хоккей: Динамо — Спартак — ряд 1, место 3', 4, 7000.00, 1, 3, 1, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (88, N'Хоккей: Динамо — Спартак — ряд 2, место 1', 5, 4500.00, 2, 1, 3, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (89, N'Хоккей: Динамо — Спартак — ряд 2, место 2', 1, 750.00, 2, 2, 1, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (90, N'Хоккей: Динамо — Спартак — ряд 2, место 3', 4, 6250.00, 2, 3, 1, 15, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (91, N'Хоккей: Динамо — Спартак — ряд 1, место 1', 1, 400.00, 1, 1, 1, 16, 500.00, 20, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (92, N'Хоккей: Динамо — Спартак — ряд 1, место 2', 5, 4000.00, 1, 2, 3, 16, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (93, N'Хоккей: Динамо — Спартак — ряд 1, место 3', 1, 500.00, 1, 3, 1, 16, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (94, N'Хоккей: Динамо — Спартак — ряд 2, место 1', 5, 4500.00, 2, 1, 1, 16, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (95, N'Хоккей: Динамо — Спартак — ряд 2, место 2', 5, 3750.00, 2, 2, 1, 16, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (96, N'Хоккей: Динамо — Спартак — ряд 2, место 3', 1, 500.00, 2, 3, 3, 16, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (97, N'Выставка «Цифровое искусство» — ряд 1, место 1', 1, 500.00, 1, 1, 1, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (98, N'Выставка «Цифровое искусство» — ряд 1, место 2', 1, 750.00, 1, 2, 3, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (99, N'Выставка «Цифровое искусство» — ряд 1, место 3', 1, 500.00, 1, 3, 3, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (100, N'Выставка «Цифровое искусство» — ряд 2, место 1', 1, 500.00, 2, 1, 1, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (101, N'Выставка «Цифровое искусство» — ряд 2, место 2', 1, 1500.00, 2, 2, 1, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (102, N'Выставка «Цифровое искусство» — ряд 2, место 3', 1, 1000.00, 2, 3, 1, 17, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (103, N'Выставка «Цифровое искусство» — ряд 1, место 1', 1, 1000.00, 1, 1, 1, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (104, N'Выставка «Цифровое искусство» — ряд 1, место 2', 1, 1000.00, 1, 2, 1, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (105, N'Выставка «Цифровое искусство» — ряд 1, место 3', 1, 750.00, 1, 3, 3, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (106, N'Выставка «Цифровое искусство» — ряд 2, место 1', 1, 1500.00, 2, 1, 1, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (107, N'Выставка «Цифровое искусство» — ряд 2, место 2', 1, 500.00, 2, 2, 1, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (108, N'Выставка «Цифровое искусство» — ряд 2, место 3', 1, 1500.00, 2, 3, 1, 18, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (109, N'Вечер джаза — ряд 1, место 1', 4, 6000.00, 1, 1, 1, 19, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (110, N'Вечер джаза — ряд 1, место 2', 2, 2750.00, 1, 2, 1, 19, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (111, N'Вечер джаза — ряд 1, место 3', 4, 6500.00, 1, 3, 3, 19, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (112, N'Вечер джаза — ряд 2, место 1', 2, 2400.00, 2, 1, 1, 19, 3000.00, 20, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (113, N'Вечер джаза — ряд 2, место 2', 2, 2750.00, 2, 2, 1, 19, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (114, N'Вечер джаза — ряд 2, место 3', 3, 2000.00, 2, 3, 4, 19, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (115, N'Вечер джаза — ряд 1, место 1', 2, 3500.00, 1, 1, 1, 20, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (116, N'Вечер джаза — ряд 1, место 2', 4, 6500.00, 1, 2, 3, 20, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (117, N'Вечер джаза — ряд 1, место 3', 4, 6000.00, 1, 3, 1, 20, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (118, N'Вечер джаза — ряд 2, место 1', 4, 6500.00, 2, 1, 1, 20, NULL, NULL, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (119, N'Вечер джаза — ряд 2, место 2', 4, 4500.00, 2, 2, 1, 20, 6000.00, 25, NULL)
INSERT INTO [dbo].[Tickets] ([id], [nameTicket], [id_categoryTicket], [price], [row_number], [seat_number], [id_ticketStatus], [id_shedule], [oldPrice], [discountPercent], [image]) VALUES (120, N'Вечер джаза — ряд 2, место 3', 2, 3000.00, 2, 3, 1, 20, NULL, NULL, NULL)
GO
-- TicketStatuses: 4
INSERT INTO [dbo].[TicketStatuses] ([id], [ticketStatus]) VALUES (1, N'Свободен')
INSERT INTO [dbo].[TicketStatuses] ([id], [ticketStatus]) VALUES (2, N'Забронирован')
INSERT INTO [dbo].[TicketStatuses] ([id], [ticketStatus]) VALUES (3, N'Продан')
INSERT INTO [dbo].[TicketStatuses] ([id], [ticketStatus]) VALUES (4, N'Возвращён')
GO
-- Users: 12
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (1, N'Иванов Иван Иванович', N'ivanov@mail.ru', N'+79002867825', N'i123', 1)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (2, N'Петрова Анна Сергеевна', N'petrova@mail.ru', N'+79001419610', N'p123', 2)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (3, N'Сидоров Алексей Петрович', N'sidorov@mail.ru', N'+79005614226', N'sidorov123', 2)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (4, N'Кузнецова Мария Андреевна', N'kuznetsova@mail.ru', N'+79005108603', N'k123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (5, N'Смирнов Дмитрий Олегович', N'smirnov@mail.ru', N'+79004744854', N'smirnov123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (6, N'Волкова Екатерина Игоревна', N'volkova@mail.ru', N'+79003341057', N'volkova123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (7, N'Морозов Никита Павлович', N'morozov@mail.ru', N'+79002719583', N'morozov123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (8, N'Лебедева Ольга Викторовна', N'lebedeva@mail.ru', N'+79002458591', N'lebedeva123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (9, N'Козлов Артём Денисович', N'kozlov@mail.ru', N'+79008078673', N'kozlov123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (10, N'Новикова Дарья Романовна', N'novikova@mail.ru', N'+79001533224', N'novikova123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (11, N'Фёдоров Максим Ильич', N'fedorov@mail.ru', N'+79001499914', N'fedorov123', 3)
INSERT INTO [dbo].[Users] ([id], [fio], [mail], [number], [password], [id_role]) VALUES (12, N'Соколова Полина Евгеньевна', N'sokolova@mail.ru', N'+79002571945', N'sokolova123', 3)
GO

ALTER TABLE [dbo].[Events] WITH CHECK ADD CONSTRAINT [FK_Events_CategoryEvents] FOREIGN KEY([id_categoryEvent]) REFERENCES [dbo].[CategoryEvents] ([id])
GO
ALTER TABLE [dbo].[Events] WITH CHECK ADD CONSTRAINT [FK_Events_Organizers] FOREIGN KEY([id_organizer]) REFERENCES [dbo].[Organizers] ([id])
GO
ALTER TABLE [dbo].[Halls] WITH CHECK ADD CONSTRAINT [FK_Halls_Plases] FOREIGN KEY([id_place]) REFERENCES [dbo].[Plases] ([id])
GO
ALTER TABLE [dbo].[Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY([id_orderStatus]) REFERENCES [dbo].[OrderStatus] ([id])
GO
ALTER TABLE [dbo].[Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_Users] FOREIGN KEY([id_user]) REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[OrderTickets] WITH CHECK ADD CONSTRAINT [FK_OrderTickets_Orders] FOREIGN KEY([id_order]) REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[OrderTickets] WITH CHECK ADD CONSTRAINT [FK_OrderTickets_Tickets] FOREIGN KEY([id_ticket]) REFERENCES [dbo].[Tickets] ([id])
GO
ALTER TABLE [dbo].[Pay] WITH CHECK ADD CONSTRAINT [FK_Pay_MethodPay] FOREIGN KEY([id_methodPay]) REFERENCES [dbo].[MethodPay] ([id])
GO
ALTER TABLE [dbo].[Pay] WITH CHECK ADD CONSTRAINT [FK_Pay_Orders] FOREIGN KEY([id_order]) REFERENCES [dbo].[Orders] ([id])
GO
ALTER TABLE [dbo].[Pay] WITH CHECK ADD CONSTRAINT [FK_Pay_StausPay] FOREIGN KEY([id_stausPay]) REFERENCES [dbo].[StausPay] ([id])
GO
ALTER TABLE [dbo].[Plases] WITH CHECK ADD CONSTRAINT [FK_Plases_CategoryPlases] FOREIGN KEY([id_categoryPlace]) REFERENCES [dbo].[CategoryPlases] ([id])
GO
ALTER TABLE [dbo].[Schedule] WITH CHECK ADD CONSTRAINT [FK_Schedule_Events] FOREIGN KEY([id_event]) REFERENCES [dbo].[Events] ([id])
GO
ALTER TABLE [dbo].[Schedule] WITH CHECK ADD CONSTRAINT [FK_Schedule_Halls] FOREIGN KEY([id_hall]) REFERENCES [dbo].[Halls] ([id])
GO
ALTER TABLE [dbo].[Tickets] WITH CHECK ADD CONSTRAINT [FK_Tickets_CategoryTickets] FOREIGN KEY([id_categoryTicket]) REFERENCES [dbo].[CategoryTickets] ([id])
GO
ALTER TABLE [dbo].[Tickets] WITH CHECK ADD CONSTRAINT [FK_Tickets_Schedule] FOREIGN KEY([id_shedule]) REFERENCES [dbo].[Schedule] ([id])
GO
ALTER TABLE [dbo].[Tickets] WITH CHECK ADD CONSTRAINT [FK_Tickets_TicketStatuses1] FOREIGN KEY([id_ticketStatus]) REFERENCES [dbo].[TicketStatuses] ([id])
GO
ALTER TABLE [dbo].[Users] WITH CHECK ADD CONSTRAINT [FK_Users_Roles] FOREIGN KEY([id_role]) REFERENCES [dbo].[Roles] ([id])
GO
