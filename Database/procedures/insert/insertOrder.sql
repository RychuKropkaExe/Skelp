drop procedure if exists insertOrder;

create procedure insertOrder(clientID int, orderValue int)
begin
    insert into Orders(client_id, order_date, value) value(clientID, current_date(), orderValue);
    select id from Orders where client_id = clientID order by id desc limit 1;
end;

