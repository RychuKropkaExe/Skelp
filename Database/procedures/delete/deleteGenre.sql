drop procedure if exists deleteGenre;

delimiter //
create procedure deleteGenre(genreID int)
begin
    if(select exists(select id from Genre where id = genreID)) then
        delete from Genre where id = genreID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

call deleteGenre(14);