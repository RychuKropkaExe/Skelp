drop procedure if exists generateBookGenre;

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