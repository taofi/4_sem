SELECT Дата_поставки
FROM     ЗАКАЗЫ
WHERE  (Дата_поставки > CONVERT(DATETIME, '2024-12-12 00:00:00', 102))

SELECT Цена_продажи
FROM     ЗАКАЗЫ
WHERE  (Цена_продажи > 50 AND Цена_продажи < 150)

SELECT Заказчик
FROM     ЗАКАЗЫ
WHERE  (Наименование_товара = N'book')

SELECT Номер_заказа
FROM     ЗАКАЗЫ
WHERE  (Заказчик = N'bstu')
ORDER BY Дата_поставки