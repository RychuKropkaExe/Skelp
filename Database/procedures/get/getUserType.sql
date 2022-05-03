drop procedure if exists getUserType;

create procedure getUserType(user_id int)
    select type from Users where id = user_id;

# call getUserType(1);
