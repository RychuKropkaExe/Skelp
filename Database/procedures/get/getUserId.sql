drop procedure if exists getUserId;

create procedure getUserId(user_login varchar(50))
    select id from Users where login = user_login;

