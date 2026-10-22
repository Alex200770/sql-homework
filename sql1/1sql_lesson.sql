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
--Все авторы книги и продажи--
