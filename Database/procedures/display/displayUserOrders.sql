drop procedure if exists displayUserOrders;

create procedure displayUserOrders(userID int)
begin
    select id, order_date, value from Orders where client_id = userID;
end;

call displayUserOrders(1);