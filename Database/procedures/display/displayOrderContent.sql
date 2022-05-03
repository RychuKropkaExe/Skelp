drop procedure if exists  displayOrderContent;

create procedure displayOrderContent(userID int, orderID int)
begin
    select p.name as title, p.publisher as publisher, count(p.name) as quantity from Order_book ob
        join Products p on ob.product_id = p.id
        join Orders o on ob.order_id = o.id
    where order_id = orderID and client_id = userID
    group by order_id, p.name, p.publisher;
end;

# call displayOrderContent(3);
#
# call insertUser('mój', 'stary', '42229', '22','user');
#
# insert into Orders(client_id, order_data, value) value (1, current_date, 440), (1, current_date, 440), (1, current_date, 440);
# insert into Order_book(order_id, product_id)
# values (3,3), (3,4), (3,15), (3,23), (4,4), (4,10), (4,13), (4,2);
#
# select id from Book where title = 'Forbidden Cow that are Alive'

