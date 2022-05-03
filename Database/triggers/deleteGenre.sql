drop trigger if exists deleteGenre;

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

# delete from Genre where name = 'Erotic';
