drop procedure if exists checkLogin;

create procedure checkLogin(checkLogin varchar(50))
begin
    select exists(select login from Users where login = checkLogin) as result;
end;