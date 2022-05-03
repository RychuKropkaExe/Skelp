drop trigger if exists insertProduct;

create trigger insertProduct after insert on Book
for each row
    insert into Products(name, publisher)
    value (new.title, (select name from Publisher where Publisher.id = new.publisher_id));
