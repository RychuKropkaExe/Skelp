drop procedure if exists raise;

delimiter //
create procedure raise(percent int, publisher int)
begin
    declare max int;

    start transaction;

    update Book
        set price = price * (1 + percent / 100)
    where publisher_id = publisher;

    set max = (select max(price) from Book where publisher_id = publisher);

    if max > 2137 then
        rollback;
    else
        commit;
    end if;

end //

# call raise(50, 12);
