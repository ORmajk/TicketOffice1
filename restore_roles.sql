-- Восстановление данных, испорченных автоматической проверкой 13.11.2026:
-- удалена роль "Клиент" (id = 3), у пользователей 4-12 обнулился id_role,
-- добавлен тестовый пользователь id = 13 (testov@mail.ru).
-- Скрипт возвращает всё как было. Запускать один раз в базе TicketOffice.
USE [TicketOffice]
GO
SET XACT_ABORT ON
BEGIN TRAN

IF NOT EXISTS (SELECT 1 FROM Roles WHERE id = 3)
    INSERT INTO Roles (id, role) VALUES (3, N'Клиент')

UPDATE Users SET id_role = 3 WHERE id BETWEEN 4 AND 12 AND id_role IS NULL

DELETE FROM Users WHERE id = 13 AND mail = 'testov@mail.ru'

COMMIT
GO
SELECT * FROM Roles
SELECT id, fio, id_role FROM Users
