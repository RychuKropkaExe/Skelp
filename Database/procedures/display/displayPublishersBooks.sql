drop procedure if exists displayPublishersBooks;

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

call displayPublishersBooks(1);