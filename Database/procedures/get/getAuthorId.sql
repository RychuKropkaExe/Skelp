drop procedure if exists getAuthorId;

delimiter //
create procedure getAuthorId(author_name varchar(50), author_surname varchar(50))
begin
    select id from Author where name = author_name and surname = author_surname;
end //

call getAuthorId('Charles', 'Dickens');