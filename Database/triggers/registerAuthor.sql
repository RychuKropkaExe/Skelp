drop trigger if exists registerAuthor;

delimiter //
create trigger registerAuthor after insert on Users
    for each row
    begin

    declare number, max, count_id int;

    set count_id = (select max(id) + 1 from Author);

    if(new.Type = 'author') then
        insert into Author(id, name, surname) value (count_id, new.name, new.surname);

        set number = (select count(name) from Author where name = new.name and surname = new.surname);

        if (number > 1) then
            set max = (select max(id) from Author where name = new.name and surname = new.surname);
            delete from Author where name = new.name and surname = new.surname and id = max;
        end if;

    end if;

end //

# insert into Users(name, surname, login, password, type)
# value ('Jane', 'S', 'blackrose3', 'rosa', 'author');
#
