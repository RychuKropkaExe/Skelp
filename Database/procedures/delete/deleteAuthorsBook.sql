drop procedure if exists deleteAuthorsBook;

delimiter //
create procedure deleteAuthorsBook(bookID int, authorID int)
begin
    if(select exists(select distinct book_id from Book_author where book_id = bookID and author_id = authorID)) then
        delete from Book where id = bookID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //