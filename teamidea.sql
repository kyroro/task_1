--Задача: Схема БД интернет-магазина содержит таблицы Company – производители телефонов, Phone – возможные для приобретения телефоны.
--Составить запрос для поиска количества и общей стоимости телефонов каждого производителя (в момент времени в интернет-магазине может не быть телефонов конкретного производителя).

--company           phone
-----------         ---------
--companyId (PK)    phoneId (PK)
--companyName       phoneModel
--companyCountry    companyId (FK -> company.companyId)
--                  price


--Задача: для схемы данных из Задачи 1, составить запросы для:
--    a) поиска производителя телефона с наибольшей средней стоимостью телефона этого производителя;
--    b) определения количества китайских товаров;
--    c) получения списка самых дорогих моделей телефонов каждого производителя.








create table company
(
    companyId      serial primary key,
    companyName    varchar(100) not null,
    companyCountry varchar(100) not null
);

create table phone
(
    phoneId    serial primary key,
    phoneModel varchar(100) not null,
    companyId  integer references company (companyId),
    price      integer      not null
);

select *
from company

select *
from phone
    insert
into company (companyName, companycountry)
values
    ('Apple', 'USA'),
    ('Samsung', 'Korea'),
    ('Xiaomi', 'China'),
    ('Honor', 'China');

insert into phone (phoneModel, companyid, price)
values ('iphone x', 1, 10000),
       ('iphone xs max', 1, 12000),
       ('s20', 2, 8000),
       ('s21', 2, 10000),
       ('s22', 2, 12000),
       ('P100', 4, 5000);

-- 1
SELECT c.*, COUNT(p.companyid) AS phonesCount, SUM(p.price) AS phonesSumPrice
FROM company AS c
         LEFT JOIN phone AS p
                   ON c.companyid = p.companyid
GROUP BY c.companyid
ORDER BY c.companyid

SELECT c.*, COUNT(p.companyid) AS phonesCount, SUM(COALESCE(p.price, 0)) AS phonesSumPrice
FROM company AS c
         LEFT JOIN phone AS p
                   ON c.companyid = p.companyid
GROUP BY c.companyid
ORDER BY c.companyid


-- 2.1
SELECT c.*, AVG(COALESCE(p.price, 0)) AS avgPhonePrice
FROM company AS c
         LEFT JOIN phone AS p
                   ON c.companyid = p.companyid
GROUP BY c.companyid
ORDER BY avgPhonePrice DESC LIMIT 1


-- 2.2
SELECT COUNT(p.companyid) AS phonesCount
FROM company AS c
         LEFT JOIN phone AS p
                   ON c.companyid = p.companyid
WHERE c.companycountry = 'USA'
GROUP BY c.companycountry


-- 2.3
SELECT c.*, p.*
FROM company AS c
         LEFT JOIN (
    SELECT companyid, MAX(price) AS maxPrice
    FROM phone
    GROUP BY companyid
) AS mp
                   ON c.companyid = mp.companyId
         LEFT JOIN phone AS p
                   ON mp.maxPrice = p.price AND c.companyid = p.companyid

