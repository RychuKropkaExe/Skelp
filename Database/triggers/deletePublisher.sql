drop trigger if exists deletePublisher;

delimiter //
create trigger deletePublisher before delete on Publisher
for each row
begin
    declare bookID, done int default 0;

    declare books cursor for select distinct id from Book where
            publisher_id = (select id from Publisher where name = old.name);

    declare continue handler for not found set done = 1;

    open books;

    while(done != 1) do
        fetch books into bookID;
        delete from Book where id = bookID;
    end while;

    close books;

end //

# delete from Publisher where name = 'Pearson';
