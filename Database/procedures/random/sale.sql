drop procedure if exists sale;

delimiter //
create procedure sale(percent int, publisher int)
begin
    declare min int;

    start transaction;

    update Book
        set price = price*(1 - percent / 100)
    where publisher_id = publisher;

    set min = (select min(price) from Book where publisher_id = publisher);

    if min < 13 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;

end //

# call sale(10, 4);
