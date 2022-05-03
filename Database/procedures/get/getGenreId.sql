drop procedure if exists getGenreId;

delimiter //
create procedure getGenreId(book_genre varchar(50))
begin
    select id from Genre where name = book_genre;
end //

# call getGenreId('Fantasy');