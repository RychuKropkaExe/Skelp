drop procedure if exists insertBookOrder;

delimiter //
create procedure insertBookOrder(orderID int, book_id int)
begin
    declare flag boolean default false;

    start transaction;

    if(exists(select id from Book where id = book_id)) then
        insert into Order_book
    value (orderID, book_id);
    else
        set flag = true;
    end if;

    if flag then
        rollback;
    else
        commit;
    end if;

end //