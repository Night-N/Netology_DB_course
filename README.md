# SQL. Часть 1
## Домашнее задание. Горбунов Владимир

## Содержание

- [Задание 1](#задание-1)
- [Задание 2](#задание-2)  
- [Задание 3](#задание-3)  
- [Задание 4](#задание-4)
- [Задание 5](#задание-5)  
- [Задание 6](#задание-6)  

>Задание выполняется на учебной базе MySQL https://downloads.mysql.com/docs/sakila-db.zip 
>Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1
>Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.
```sql
select
    distinct district
from
    address
where
    left (district, 1) = 'K' and right (district, 1) = 'a' and district not like '% %'
order by district;
```

### Задание 2
>Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых превышает 10.00.
```sql
select
    amount,
    customer_id,
    last_update,
    payment_date,
    payment_id,
    rental_id,
    staff_id
from
    payment
where 
    date(payment_date) between 20050615 and 20050618;
```
либо 
```sql
...
where
    payment_date between 20050615000000  and 20050618235959;
```
### Задание 3
>Получите последние пять аренд фильмов.
```sql
select
    rental_date,
    rental_id,
    inventory_id
from
    rental
order by
    rental_date desc
limit
    5;
```
### Задание 4
>Одним запросом получите активных покупателей, имена которых Kelly или Willie. 
>Сформируйте вывод в результат таким образом:
>- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
>- замените буквы 'll' в именах на 'pp'.
```sql
select
    customer_id,
    replace(lower(first_name), 'll', 'pp') as first_name,
    replace(lower(last_name), 'll', 'pp') as last_name,
    email,
    active
from
    customer
where active = 1 and first_name = 'kelly' or active = 1 and first_name = 'willie';
```
### Задание 5
>Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.
```sql
select
    substring_index(email, '@' , 1) as email_name,
    substring_index(email, '@' , -1) as email_server
from
    customer;
```
### Задание 6
>Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.
```sql
select
    concat(upper(substr(substring_index(email, '@' , 1), 1, 1)), lower(substr(substring_index(email, '@' , 1), 2))) as formated_email_name,
    concat(upper(substr(substring_index(email, '@' , -1), 1, 1)), lower(substr(substring_index(email, '@' , -1), 2))) as formated_email_server
from
    customer;
```
