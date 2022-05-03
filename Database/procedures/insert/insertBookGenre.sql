drop procedure if exists insertBookGenre;

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

# call insertBookGenre(100, 'Documentary');
