drop procedure if exists bookTitle;

delimiter //
create procedure bookTitle(ile int)
begin
    declare x, y, z varchar(50);
    declare publisher_id int;
    declare price int;

    while(ile != 0)
        do
            set x = (select opening from Book_names order by rand() limit 1);
            set y = (select name from Book_names order by rand() limit 1);
            set z = (select addition from Book_names order by rand() limit 1);

            set publisher_id = floor(rand() * (select count(id) from Publisher) + 1);
            set price = floor(rand() * (2137 - 13 + 1) + 13);

            insert into Book(title, publisher_id, price)
            value (concat(x, y, z), publisher_id, price);

            set ile = ile - 1;

        end while;
end //

call bookTitle(100);

drop table if exists Book_names;