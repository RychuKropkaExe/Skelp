drop trigger if exists deleteAuthor;

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

# delete from Author where name = 'Jane' and surname = 'Austen';
