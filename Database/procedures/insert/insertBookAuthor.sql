drop procedure if exists insertBookAuthor;

delimiter //
create procedure insertBookAuthor (bookID int, new_name varchar(50), new_surname varchar(50))
begin
    declare number, count int;

    call insertAuthor(new_name, new_surname);

    set number = (select id from Author where name = new_name and surname = new_surname);

    insert into Book_author(book_id, author_id) value (bookID, number);

    set count = (select count(book_id) from Book_author b
                    join Author a on b.author_id = a.id
                    where a.name = new_name and a.surname = new_surname);

    if (count > 1) then
        delete from Book_author where book_id = bookID and author_id = number;
        insert into Book_author(book_id, author_id) value (bookID, number);

    end if;
end //

# call insertBookAuthor(100, 'Jane', 'Austen');
