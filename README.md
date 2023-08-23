# SQL. Индексы
## Домашнее задание. Горбунов Владимир

## Содержание

- [Задание 1](#задание-1)
- [Задание 2](#задание-2)  
- [Задание 3](#задание-3)  


>Задание выполняется на учебной базе MySQL https://downloads.mysql.com/docs/sakila-db.zip 
>Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

>Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```sql

```
<img src='./img/task1.jpg' width='800'>  


### Задание 2
>Выполните explain analyze следующего запроса:
> select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)  
from payment p, rental r, customer c, inventory i, film f  
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
>перечислите узкие места;
>оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.
```sql

```
![](./img/task2.jpg)

### Задание 3
>Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.
