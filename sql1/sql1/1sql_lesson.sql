--создаем таблицу authors--
create table authors (
	id serial primary key,
	first_name VARCHAR(20),
	last_name VARCHAR(20)
);
--создаем таблицу authors--
create table books (
	id serial primary key,
	title VARCHAR(100),
	author_id INT,
	publication_year INT,
	foreign key (author_id) references authors(id)
)
--создаем таблицу sales--
create table sales(
	id SERIAL primary key,
	book_id INT,
	quantity INT,
	foreign key (book_id) references books(id)
);
--добавим авторов в таблицу authors--
insert into authors (first_name, last_name) values 
('Лев', 'Толстой'),
('Александр', 'Пушкин'),
('Федор', 'Достоевский');
--добавим книги для авторов--
insert into books (title, author_id, publication_year) values 
('Война и мир', 1, 1869),
('Анна Каренина', 1, 1877),
('Евгений Онегин', 2, 1831),
('Бедные люди', 3, 1845),
('Идиот', 3, 1869);
--добавим продажи книг--
insert into sales(book_id, quantity) values 
(1, 10),
(3, 5),
(4, 20),
(5, 15);
--книги и авторы--
SELECT 
    books.title, 
    authors.first_name, 
    authors.last_name
FROM books
INNER JOIN authors ON books.author_id = authors.id;
--авторы и книги
SELECT 
    authors.first_name, 
    authors.last_name, 
    books.title
FROM authors
LEFT JOIN books ON authors.id = books.author_id;
--Right Join--
SELECT 
    books.title, 
    authors.first_name, 
    authors.last_name
FROM books
RIGHT JOIN authors ON books.author_id = authors.id;
--Книги авторы и продажи--
SELECT 
    authors.last_name, 
    books.title, 
    sales.quantity
FROM authors
INNER JOIN books ON authors.id = books.author_id
INNER JOIN sales ON books.id = sales.book_id;



--создаем таблицу book_authors--
create table book_authors (
	book_id int,
	author_id int,
	primary key (book_id, author_id),
	foreign key (book_id) references books(id),
	foreign key (author_id) references authors(id)
);
--удаляем из таблицы book author_id--
alter table books drop column author_id;

--Добавили - книга с несколькими авторами--
--         - автор с несколькими книгами--
--         - автор без книг--
insert into authors (first_name, last_name) values
('Илья', 'Ильф'),
('Евгений', 'Петров'),
('Стивен', 'Кинг'),
('Агата', 'Кристи');

--добавили книги для предыдущего кода строки 1-3--
--потом книга без автора 4 строка--
--потом книга без продаж 5--
--потом книга с несколькими записями о продажах--
insert into books (title, publication_year) values
('Двенадцать стульев', 1927),
('Оно', 1986),
('Сияние', 1977),
('Клуб неисправимых оптимистов', 2009),
('Удивительная жизнь Эрнесто Че', 2012),
('Пока я не упал', 2010);

--связываем - книга с несколькими авторами--
insert into book_authors (book_id, author_id)
select books.id, authors.id
from books, authors
where books.title = 'Двенадцать стульев'
and authors.last_name in ('Ильф','Петров');

--автор с несколькими книгами--
insert into book_authors (book_id, author_id)
select books.id, authors.id
from books, authors
where books.title = 'Оно'
and authors.last_name = 'Кинг'

insert into book_authors (book_id, author_id)
select books.id, authors.id
from books, authors
where books.title = 'Сияние'
and authors.last_name = 'Кинг';

--автор без книг--
SELECT authors.first_name, authors.last_name
FROM authors
LEFT JOIN book_authors ON authors.id = book_authors.author_id
WHERE book_authors.book_id IS NULL

--книга без автора--
SELECT books.title
FROM books
LEFT JOIN book_authors ON books.id = book_authors.book_id
WHERE book_authors.author_id IS null;
--мы нашли 3 таких но должна быть одна все правильно просто я еще не указал с продажами и в конце будет одна книга--

--добавили продажи--
INSERT INTO sales (book_id, quantity) VALUES 
(11, 5),
(11, 10);
--книги и их авторы--
select books.title, authors.first_name, authors.last_name
from books
inner join book_authors on books.id = book_authors.book_id
inner join authors on book_authors.author_id = authors.id;
--все авторы и их книги--
select authors.first_name, authors.last_name, books.title
from authors
left join book_authors on authors.id = book_authors.author_id
left join books on book_authors.book_id = books.id;
--авторы без книг--
select authors.first_name, authors.last_name
from authors
left join book_authors on authors.id = book_authors.author_id
where book_authors.book_id is null;
--без продаж--
select books.title
from books
left join sales on books.id = sales.book_id 
where sales.id is null;
