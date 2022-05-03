drop procedure if exists getUserPassword;
create procedure getUserPassword(checkLogin varchar(50))
begin
    select password from Users where login = checkLogin;
end;