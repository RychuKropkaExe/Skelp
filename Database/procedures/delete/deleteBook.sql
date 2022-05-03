drop procedure if exists deleteBook;

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