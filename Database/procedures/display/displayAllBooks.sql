drop procedure if exists displayAllBooks;

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

call displayAllBooks();