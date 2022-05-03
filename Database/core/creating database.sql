-- creating database
# create database skelp;

-- Genre
drop table if exists Genre;
create table if not exists Genre
(
    id   int unsigned not null auto_increment,
    name varchar(30)  not null check (name <> ''),
    primary key (id)
);

-- Author
drop table if exists Author;
create table if not exists Author
(
    id      int unsigned not null auto_increment,
    name    varchar(50)  not null check (name <> ''),
    surname varchar(50)  not null check (surname <> ''),
    primary key (id)
);

-- Publisher
drop table if exists Publisher;
create table if not exists Publisher
(
    id   int unsigned not null auto_increment,
    name varchar(50)  not null check (name <> ''),
    primary key (id)
);

-- Book
drop table if exists Book;
create table if not exists Book
(
    id           int unsigned not null auto_increment,
    title        varchar(100) not null check (title <> ''),
    publisher_id int unsigned not null,
    price        int unsigned not null,
    primary key (id),
    foreign key (publisher_id) references Publisher (id)
);

-- Book_author
drop table if exists Book_author;
create table if not exists Book_author
(
    book_id   int unsigned not null,
    author_id int unsigned not null,
    foreign key (book_id) references Book (id),
    foreign key (author_id) references Author (id)
);

-- Book_genre
drop table if exists Book_genre;
create table if not exists Book_genre
(
    book_id  int unsigned not null,
    genre_id int unsigned not null,
    foreign key (book_id) references Book (id),
    foreign key (genre_id) references Genre (id)
);

-- Users
drop table if exists Users;
create table if not exists Users
(
    id       int unsigned                     not null auto_increment,
    name     varchar(50)                      not null check (name <> ''),
    surname  varchar(50)                      not null check (surname <> ''),
    login    varchar(50)                      not null check (login <> ''),
    password varchar(100)                      not null check (password <> ''),
    type     enum ('admin', 'user', 'author') not null check (type <> ''),
    primary key (id)
);

-- Orders
drop table if exists Orders;
create table if not exists Orders
(
    id         int unsigned not null auto_increment,
    client_id  int unsigned not null,
    order_date date         not null,
    value      int unsigned not null,
    primary key (id),
    foreign key (client_id) references Users (id)
);

-- Products
drop table if exists Products;
create table if not exists Products
(
    id        int unsigned not null auto_increment,
    name      varchar(100) not null check (name <> ''),
    publisher varchar(50)  not null check (publisher <> ''),
    primary key (id)
);

-- Order_book
drop table if exists Order_book;
create table if not exists Order_book
(
    order_id   int unsigned not null,
    product_id int unsigned not null,
    foreign key (order_id) references Orders (id),
    foreign key (product_id) references Products (id)
);
