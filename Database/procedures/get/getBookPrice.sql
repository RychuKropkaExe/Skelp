drop procedure if exists getBookPrice;

create procedure getBookPrice(bookID int)
begin

    if(exists(select price from Book where id = bookID)) then
        select price from Book where id = bookID;
    else
        select 0 as price;
    end if;
end;

call getBookPrice(1);