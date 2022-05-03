drop procedure if exists deletePublisher;

delimiter //
create procedure deletePublisher(publisherID int)
begin
    if(select exists(select id from Publisher where id = publisherID)) then
        delete from Publisher where id = publisherID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end //

call deletePublisher(3);