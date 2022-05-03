drop procedure if exists getPublisherId;

delimiter //
create procedure getPublisherId(publisher_name varchar(50))
begin
    select id from Publisher where name = publisher_name;
end //

# call getPublisherId('RELX');