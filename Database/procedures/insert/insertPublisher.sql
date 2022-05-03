drop procedure if exists insertPublisher;

delimiter //
create procedure insertPublisher(publisher_name varchar(50))
begin
    declare number, publisher_id int default 0;

    start transaction;

    set publisher_id = (select max(id) + 1 from Publisher);
    insert into Publisher(id, name) value(publisher_id, publisher_name);

    set number = (select count(name) from Publisher where name = publisher_name);

    if number > 1 then
        rollback;
    else
        commit;
    end if;

end //

# call insertPublisher('Ajzias', 2001);
