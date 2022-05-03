drop procedure if exists deleteAuthor;

delimiter //
create procedure deleteAuthor(authorID int)
begin
    if(select exists(select id from Author where id = authorID)) then
        delete from Author where id = authorID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //