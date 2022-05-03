drop trigger if exists deleteBook;

delimiter //
create trigger deleteBook before delete on Book
for each row
begin
    delete from Book_author where book_id = old.id;

    delete from Book_genre where book_id = old.id;

end //
