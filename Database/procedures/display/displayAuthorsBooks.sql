drop procedure if exists displayAuthorsBooks;

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

call displayAuthorsBooks(1);