drop procedure if exists insertUser;

delimiter //
create procedure insertUser(newName varchar(50), newSurname varchar(50), newLogin varchar(50), newPassword varchar(100), newType enum ('admin', 'user', 'author'))
begin
    declare number, user_id int default 0;

    start transaction;

    set user_id = (select max(id) + 1 from Users);
    insert into Users(name, surname, login, password, type) value(newName, newSurname, newLogin, newPassword, newType);

    set number = (select count(login) from Users where login = newLogin);

    if number > 1 then
        rollback;
    else
        commit;
    end if;
end //