drop procedure if exists insertBook;

delimiter //
create procedure insertBook(newTitle varchar(100), newPublisher varchar(50), newPrice int)
begin
    declare publisherID int;
    call insertPublisher(newPublisher);
    set publisherID = (select id from Publisher where name = newPublisher);
    insert into Book(title, publisher_id, price) value (newTitle, publisherID, newPrice);
    select last_insert_id() as result;
end //