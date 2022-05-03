drop procedure if exists insertAuthor;

delimiter //
create procedure insertAuthor(author_name varchar(50), author_surname varchar(50))
begin
    declare number, author_id int default 0;

    start transaction;

    set author_id = (select max(id) + 1 from Author);
    insert into Author(id, name, surname) value(author_id, author_name, author_surname);

    set number = (select count(name) from Author where name = author_name and surname = author_surname);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end //

# call insertAuthor('Jane', 'Austen');
# call insertAuthor('Asia', 'Austen');
