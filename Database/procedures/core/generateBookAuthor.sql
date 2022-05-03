drop procedure if exists generateBookAuthor;

delimiter //
create procedure generateBookAuthor()
begin
    declare books, number, authorID int default 0;
    declare bookID int default 1;
    set books = (select count(id) from Book);

    while(bookID <= books) do
        set number = floor(rand() * 3 + 1);

        while(number > 0) do
            set authorID = (select id from Author order by rand() limit 1);

            if (!exists(select book_id from Book_author where book_id = bookID and author_id = authorID)) then
                insert into Book_author value (bookID, authorID);
                set number = number - 1;
            end if;

        end while;

        set bookID = bookID + 1;
    end while ;
end //

call generateBookAuthor();
