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

-- Genre
insert into Genre (name)
values ('Fantasy'),
       ('Adventure'),
       ('Romance'),
       ('Mystery'),
       ('Horror'),
       ('Thriller'),
       ('Science Fiction'),
       ('Young Adult'),
       ('Documentary'),
       ('Motivational'),
       ('Travel'),
       ('Cooking'),
       ('Graphic Novel'),
       ('Biography'),
       ('Erotic');

-- Author
insert into Author(name, surname)
values ('Jane', 'Austen'),
       ('Charles', 'Dickens'),
       ('John', 'Green'),
       ('Rick', 'Riordan'),
       ('Nigella', 'Lawson'),
       ('Cassandra', 'Clare'),
       ('Fiodor', 'Dostojewski'),
       ('Michaił', 'Bułhakow'),
       ('Andrzej', 'Sapkowski'),
       ('Dan', 'Brown'),
       ('Paulo', 'Coelho'),
       ('J.R.R', 'Tolkien'),
       ('J.K', 'Rowling'),
       ('Remigiusz', 'Mróz'),
       ('Krzysztof', 'Gonciarz');

-- Publisher
insert into Publisher(name)
values ('Pearson'),
       ('RELX'),
       ('Thomson Reuters'),
       ('Penguin Random House'),
       ('Hachette Livre'),
       ('Harper Collins'),
       ('Macmillan Publishers'),
       ('Bertelsmann'),
       ('Scholastic Corporation'),
       ('McGraw-Hill Education'),
       ('TCK Publishing'),
       ('Simon & Schuster'),
       ('Phoenix Yard Books'),
       ('Bloomsbury Publishing'),
       ('Arcade Publishing');

-- Book names
create table if not exists Book_names
(
    opening varchar(40) not null check (opening <> ''),
    name      varchar(40) not null check (name <> ''),
    addition  varchar(40) not null check (addition <> '')
);

insert into Book_names
values ('Amazing', ' Pottery', ' Escapade'),
       ('Mesmerizing', ' Frozen Yeti', ': The World You Never Knew Existed'),
       ('Fantastic', ' Captain Porkey', ' with the Cow'),
       ('Breathtaking', ' Journey', ' to the End'),
       ('Thought-provoking', ' Love Story', ' of the Century'),
       ('Great', ' Princess', ' and the Corn Field'),
       ('Rich', ' Mine', ' Wars'),
       ('Dead', ' Cow', ' Uprising'),
       ('Missing', ' Shoe', ' and the Power of Friendship'),
       ('Forbidden', ' Fruit', ' of Mischief'),
       ('A Tragic Story of', ' My Life', ' in a Nutshell'),
       ('Goodbye', ' Sweet World', ' of Mine'),
       ('Kingdom of', ' Lost Souls', ' that are Alive'),
       ('The Screaming of', ' Pleasure', ': Aliens are Coming!'),
       ('Tasty Adventure into the', ' Kitchen', ' with Tips and Tricks');


-- deleteAuthor;
delimiter //
create trigger deleteAuthor before delete on Author
for each row
begin
    declare authorID, bookID, done int default 0;

    declare books cursor for select distinct book_id from Book_author where
            author_id = (select id from Author where name = old.name and surname = old.surname);

    declare continue handler for not found set done = 1;

        set authorID = (select id from Author where name = old.name and surname = old.surname);

        open books;

        while(done != 1) do
            fetch books into bookID;
            delete from Book where id = bookID;
        end while;

        close books;

end //

-- deleteBook;
delimiter //
create trigger deleteBook before delete on Book
for each row
begin
    delete from Book_author where book_id = old.id;

    delete from Book_genre where book_id = old.id;
end //

-- deleteGenre;
delimiter //
create trigger deleteGenre before delete on Genre
for each row
begin
    declare bookID, done int default 0;

    declare books cursor for select distinct b.id from Book b
                             join Book_genre Bg on b.id = Bg.book_id
                             join Genre g on Bg.genre_id = g.id
                             where name = old.name;

    declare continue handler for not found set done = 1;

    open books;

    while(done != 1) do
        fetch books into bookID;
        delete from Book where id = bookID;
    end while;

end //

-- deletePublisher;
delimiter //
create trigger deletePublisher before delete on Publisher
for each row
begin
    declare bookID, done int default 0;

    declare books cursor for select distinct id from Book where
            publisher_id = (select id from Publisher where name = old.name);

    declare continue handler for not found set done = 1;

    open books;

    while(done != 1) do
        fetch books into bookID;
        delete from Book where id = bookID;
    end while;

    close books;

end //

-- insertProduct;
create trigger insertProduct after insert on Book
for each row
    insert into Products(name, publisher)
    value (new.title, (select name from Publisher where Publisher.id = new.publisher_id));

-- registerAuthor;
delimiter //
create trigger registerAuthor after insert on Users
    for each row
    begin

    declare number, max, count_id int;

    set count_id = (select max(id) + 1 from Author);

    if(new.Type = 'author') then
        insert into Author(id, name, surname) value (count_id, new.name, new.surname);

        set number = (select count(name) from Author where name = new.name and surname = new.surname);

        if (number > 1) then
            set max = (select max(id) from Author where name = new.name and surname = new.surname);
            delete from Author where name = new.name and surname = new.surname and id = max;
        end if;

    end if;

end //

-- bookTitle;
delimiter //
create procedure bookTitle(ile int)
begin
    declare x, y, z varchar(50);
    declare publisher_id int;
    declare price int;

    while(ile != 0)
        do
            set x = (select opening from Book_names order by rand() limit 1);
            set y = (select name from Book_names order by rand() limit 1);
            set z = (select addition from Book_names order by rand() limit 1);

            set publisher_id = floor(rand() * (select count(id) from Publisher) + 1);
            set price = floor(rand() * (2137 - 13 + 1) + 13);

            insert into Book(title, publisher_id, price)
            value (concat(x, y, z), publisher_id, price);

            set ile = ile - 1;

        end while;
end //
call bookTitle(100);
drop table if exists Book_names;

-- generateBookAuthor
delimiter //
create procedure generateBookAuthor()
begin
    declare books, number, authorID int default 0;
    declare bookID int default 1;
    set books = (select count(id) from Book);

    while(bookID <= books) do
        set number = floor(rand() * 3 + 1);

        while(number > 0) do
            set authorID = (select id from Author order by rand() limit 1);

            if (!exists(select book_id from Book_author where book_id = bookID and author_id = authorID)) then
                insert into Book_author value (bookID, authorID);
                set number = number - 1;
            end if;

        end while;

        set bookID = bookID + 1;
    end while ;
end //
call generateBookAuthor();

-- generateBookGenre
delimiter //
create procedure generateBookGenre()
begin
    declare booksQuantity, numberOfGenres, genreID int;
    declare pointer int default 1;
    set booksQuantity = (select count(id) from Book);

    while(pointer != booksQuantity + 1) do
        set numberOfGenres = floor(rand() * 3 + 1);

        while(numberOfGenres != 0) do
            set genreId = (select id from Genre order by rand() limit 1);

            if (!exists(select book_id from Book_genre where book_id = pointer and genre_id = genreId)) then
                insert into Book_genre(book_id, genre_id) value(pointer, genreID);
                set numberOfGenres = numberOfGenres - 1;
            end if;

        end while;

        set pointer = pointer + 1;
    end while;
end //
call generateBookGenre();

-- checkLogin;
create procedure checkLogin(checkLogin varchar(50))
begin
    select exists(select login from Users where login = checkLogin) as result;
end;

-- displayAllBooks
create procedure displayAllBooks()
begin
    select b.id, title, group_concat(distinct g.name) as genre,
           group_concat(distinct concat(a.name, ' ', a.surname)) as author,
           p.name as publisher, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author ba on b.id = ba.book_id
        join Author a on ba.author_id = a.id
        join Book_genre bg on b.id = bg.book_id
        join Genre g on bg.genre_id = g.id
        group by b.id, title, p.name, price;
end;

-- displayAuthorsBooks;
create procedure displayAuthorsBooks(authorID int)
begin
    select b.id, title, group_concat(distinct G.name) as genre, p.name as publisher, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author Ba on b.id = Ba.book_id
        join Book_genre Bg on b.id = Bg.book_id
        join Genre G on Bg.genre_id = G.id
        where author_id = authorID
        group by b.id, title, p.name, price;
end;

-- displayOrderContent;
create procedure displayOrderContent(userID int, orderID int)
begin
    select p.name as title, p.publisher as publisher, count(p.name) as quantity from Order_book ob
        join Products p on ob.product_id = p.id
        join Orders o on ob.order_id = o.id
    where order_id = orderID and client_id = userID
    group by order_id, p.name, p.publisher;
end;

-- displayUserData;
create procedure displayUserData(userID int)
begin
    select id, name, surname, login, type from Users where id = userID;
end;

-- displayUserOrders;
create procedure displayUserOrders(userID int)
begin
    select id, order_date, value from Orders where client_id = userID;
end;

-- insertAuthor;
delimiter //
create procedure insertAuthor(author_name varchar(50), author_surname varchar(50))
begin
    declare number, author_id int default 0;

    start transaction;

    set author_id = (select max(id) + 1 from Author);
    insert into Author(id, name, surname) value(author_id, author_name, author_surname);

    set number = (select count(name) from Author where name = author_name and surname = author_surname);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

-- insertBook
delimiter //
create procedure insertBook(newTitle varchar(100), newPublisher varchar(50), newPrice int)
begin
    declare publisherID int;
    call insertPublisher(newPublisher);
    set publisherID = (select id from Publisher where name = newPublisher);
    insert into Book(title, publisher_id, price) value (newTitle, publisherID, newPrice);
    select last_insert_id() as result;
end //

-- insertBookAuthor;
delimiter //
create procedure insertBookAuthor (bookID int, new_name varchar(50), new_surname varchar(50))
begin
    declare number, count int;

    call insertAuthor(new_name, new_surname);

    set number = (select id from Author where name = new_name and surname = new_surname);

    insert into Book_author(book_id, author_id) value (bookID, number);

    set count = (select count(book_id) from Book_author b
                    join Author a on b.author_id = a.id
                    where a.name = new_name and a.surname = new_surname);

    if (count > 1) then
        delete from Book_author where book_id = bookID and author_id = number;
        insert into Book_author(book_id, author_id) value (bookID, number);

    end if;
end //

-- insertGenre;
delimiter //
create procedure insertGenre(genre_name varchar(50))
begin
    declare number, genre_id int default 0;

    start transaction;

    set genre_id = (select max(id) + 1 from Genre);
    insert into Genre(id, name) value(genre_id, genre_name);

    set number = (select count(name) from Genre where name = genre_name);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

-- insertBookGenre;
delimiter //
create procedure insertBookGenre(bookID int, new_genre varchar(30))
begin
    declare number, count int;

    call insertGenre(new_genre);

    set number = (select id from Genre where name = new_genre);

    insert into Book_genre(book_id, genre_id) value (bookID, number);

    set count = (select count(book_id) from Book_genre b
                    join Genre g on b.genre_id = g.id
                    where name = new_genre);

    if (count > 1) then
        delete from Book_genre where book_id = bookID and genre_id = number;
        insert into Book_genre(book_id, genre_id) value (bookID, number);

    end if;
end //

-- insertPublisher;
delimiter //
create procedure insertPublisher(publisher_name varchar(50))
begin
    declare number, publisher_id int default 0;

    start transaction;

    set publisher_id = (select max(id) + 1 from Publisher);
    insert into Publisher(id, name) value(publisher_id, publisher_name);

    set number = (select count(name) from Publisher where name = publisher_name);

    if number > 1 then
        rollback;
    else
        commit;
    end if;

end //

-- insertUser;
delimiter //
create procedure insertUser(newName varchar(50), newSurname varchar(50), newLogin varchar(50), newPassword varchar(100), newType enum ('admin', 'user', 'author'))
begin
    declare number, user_id int default 0;

    start transaction;

    set user_id = (select max(id) + 1 from Users);
    insert into Users(name, surname, login, password, type) value(newName, newSurname, newLogin, newPassword, newType);

    set number = (select count(login) from Users where login = newLogin);

    if number > 1 then
        rollback;
    else
        commit;
    end if;

end //

-- raise;
delimiter //
create procedure raise(percent int, publisher int)
begin
    declare max int;

    start transaction;

    update Book
        set price = price * (1 + percent / 100)
    where publisher_id = publisher;

    set max = (select max(price) from Book where publisher_id = publisher);

    if max > 2137 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

-- sale;
delimiter //
create procedure sale(percent int, publisher int)
begin
    declare min int;

    start transaction;

    update Book
        set price = price * (1 - percent / 100)
    where publisher_id = publisher;

    set min = (select min(price) from Book where publisher_id = publisher);

    if min < 13 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

-- changeUserPassword;
delimiter //
create procedure changeUserPassword(user_id int, newPassword varchar(100))
begin
    update Users set password = newPassword where id = user_id;
end //

-- getUserType;
create procedure getUserType(user_id int)
    select type from Users where id = user_id;

-- deleteAuthor;
delimiter //
create procedure deleteAuthor(authorID int)
begin
    if(select exists(select id from Author where id = authorID)) then
        delete from Author where id = authorID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

-- deleteAuthorsBook;
delimiter //
create procedure deleteAuthorsBook(bookID int, authorID int)
begin
    if(select exists(select distinct book_id from Book_author where book_id = bookID and author_id = authorID)) then
        delete from Book where id = bookID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

-- deleteBook;
delimiter //
create procedure deleteBook(bookID int)
begin
    if(select exists(select id from Book where id = bookID)) then
        delete from Book where id = bookID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

-- deleteGenre;
delimiter //
create procedure deleteGenre(genreID int)
begin
    if(select exists(select id from Genre where id = genreID)) then
        delete from Genre where id = genreID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

-- deletePublisher;
delimiter //
create procedure deletePublisher(publisherID int)
begin
    if(select exists(select id from Publisher where id = publisherID)) then
        delete from Publisher where id = publisherID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

-- displayPublishersBooks;
create procedure displayPublishersBooks(publisherID int)
begin
    select b.id, title, group_concat(distinct G.name) as genre,
           group_concat(distinct concat(a.name, ' ', a.surname)) as author, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author Ba on b.id = Ba.book_id
        join Book_genre Bg on b.id = Bg.book_id
        join Genre G on Bg.genre_id = G.id
        join Author a on Ba.author_id = a.id
        where publisher_id = publisherID
        group by b.id, title, price;
end;

-- getAuthorId;
delimiter //
create procedure getAuthorId(author_name varchar(50), author_surname varchar(50))
begin
    select id from Author where name = author_name and surname = author_surname;
end //

-- getBookPrice;
create procedure getBookPrice(bookID int)
begin
    if(exists(select price from Book where id = bookID)) then
        select price from Book where id = bookID;
    else
        select 0 as price;
    end if;
end;

-- getGenreId;
delimiter //
create procedure getGenreId(book_genre varchar(50))
begin
    select id from Genre where name = book_genre;
end //

-- getPublisherId;
delimiter //
create procedure getPublisherId(publisher_name varchar(50))
begin
    select id from Publisher where name = publisher_name;
end //

-- getUserId;
create procedure getUserId(user_login varchar(50))
    select id from Users where login = user_login;

-- getUserPassword;
create procedure getUserPassword(checkLogin varchar(50))
begin
    select password from Users where login = checkLogin;
end;

-- insertBookOrder;
delimiter //
create procedure insertBookOrder(orderID int, book_id int)
begin
    declare flag boolean default false;

    start transaction;

    if(exists(select id from Book where id = book_id)) then
        insert into Order_book
    value (orderID, book_id);
    else
        set flag = true;
    end if;

    if flag then
        rollback;
    else
        commit;
    end if;
end //

-- insertOrder;
create procedure insertOrder(clientID int, orderValue int)
begin
    insert into Orders(client_id, order_date, value) value(clientID, current_date(), orderValue);
    select id from Orders where client_id = clientID order by id desc limit 1;
end;

use skelp;
drop user if exists 'auth'@'%';
create user 'auth'@'%' identified by 'thegreatcreator';
grant execute on procedure insertUser to 'auth'@'%';
grant execute on procedure getUserPassword to 'auth'@'%';
grant execute on procedure checkLogin to 'auth'@'%';
grant execute on procedure getUserId to 'auth'@'%';
grant execute on procedure getUserType to 'auth'@'%';
grant execute on procedure changeUserPassword to 'auth'@'%';

drop user if exists 'client'@'%';
create user 'client'@'%' identified by 'minion';
-- user's privileges
grant execute on procedure displayAllBooks to 'client'@'%'; # <------------------------ done
grant execute on procedure displayAuthorsBooks to 'client'@'%'; # <-------------------- done
grant execute on procedure displayOrderContent to 'client'@'%'; # <-------------------- done
grant execute on procedure displayPublishersBooks to 'client'@'%'; # <----------------- done
grant execute on procedure displayUserData to 'client'@'%'; # <------------------------ done
grant execute on procedure displayUserOrders to 'client'@'%'; # <---------------------- done
grant execute on procedure getAuthorId to 'client'@'%'; # <---------------------------- done
grant execute on procedure getBookPrice to 'client'@'%'; # <--------------------------- done
grant execute on procedure getPublisherId to 'client'@'%'; # <------------------------- done
grant execute on procedure insertBookOrder to 'client'@'%'; # <------------------------ done
grant execute on procedure insertOrder to 'client'@'%'; # <---------------------------- done

drop user if exists 'author'@'%';
create user 'author'@'%' identified by 'lessgreatcreator';
-- user's privileges
grant execute on procedure displayAllBooks to 'author'@'%';
grant execute on procedure displayAuthorsBooks to 'author'@'%';
grant execute on procedure displayOrderContent to 'author'@'%';
grant execute on procedure displayPublishersBooks to 'author'@'%';
grant execute on procedure displayUserData to 'author'@'%';
grant execute on procedure displayUserOrders to 'author'@'%';
grant execute on procedure getAuthorId to 'author'@'%';
grant execute on procedure getBookPrice to 'author'@'%';
grant execute on procedure getPublisherId to 'author'@'%';
grant execute on procedure insertBookOrder to 'author'@'%';
grant execute on procedure insertOrder to 'author'@'%';
-- author's privileges
grant execute on procedure deleteAuthorsBook to 'author'@'%'; #<--------------------- done
grant execute on procedure getGenreId to 'author'@'%';# <---------------------------- done
grant execute on procedure insertBook to 'author'@'%';# <---------------------------- done
grant execute on procedure insertBookAuthor to 'author'@'%'; #<---------------------- done
grant execute on procedure insertBookGenre to 'author'@'%';# <----------------------- done

drop user if exists 'admin'@'%';
create user 'admin'@'%' identified by 'greatcreatorsslave';
-- user's privileges
grant execute on procedure displayAllBooks to 'admin'@'%';
grant execute on procedure displayAuthorsBooks to 'admin'@'%';
grant execute on procedure displayOrderContent to 'admin'@'%';
grant execute on procedure displayPublishersBooks to 'admin'@'%';
grant execute on procedure displayUserData to 'admin'@'%';
grant execute on procedure displayUserOrders to 'admin'@'%';
grant execute on procedure getAuthorId to 'admin'@'%';
grant execute on procedure getBookPrice to 'admin'@'%';
grant execute on procedure getPublisherId to 'admin'@'%';
grant execute on procedure insertBookOrder to 'admin'@'%';
grant execute on procedure insertOrder to 'admin'@'%';
-- author's privileges
grant execute on procedure deleteAuthorsBook to 'admin'@'%';
grant execute on procedure getGenreId to 'admin'@'%';
grant execute on procedure insertBook to 'admin'@'%';
grant execute on procedure insertBookAuthor to 'admin'@'%';
grant execute on procedure insertBookGenre to 'admin'@'%';
-- admin's privileges
grant execute on procedure deleteAuthor to 'admin'@'%';
grant execute on procedure deleteBook to 'admin'@'%';
grant execute on procedure deleteGenre to 'admin'@'%';
grant execute on procedure deletePublisher to 'admin'@'%';
grant execute on procedure insertAuthor to 'admin'@'%';
grant execute on procedure insertGenre to 'admin'@'%';
grant execute on procedure insertPublisher to 'admin'@'%';
grant execute on procedure raise to 'admin'@'%';
grant execute on procedure sale to 'admin'@'%';

flush privileges;