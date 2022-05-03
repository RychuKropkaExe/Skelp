drop procedure if exists displayUserData;

create procedure displayUserData(userID int)
begin
    select id, name, surname, login, type from Users where id = userID;
end;

call displayUserData(1);

# insert into Users(name, surname, login, password, type) value ('Bisg', 'Chunguss', '123', '123', 'user');
# delete from Users where name = 'Bisg';

