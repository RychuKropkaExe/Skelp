drop procedure if exists insertGenre;

delimiter //
create procedure insertGenre(genre_name varchar(50))
begin
    declare number, genre_id int default 0;

    start transaction;

    set genre_id = (select max(id) + 1 from Genre);
    insert into Genre(id, name) value(genre_id, genre_name);

    set number = (select count(name) from Genre where name = genre_name);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

# call insertGenre('Ajzias');
# call insertGenre('Romance');
