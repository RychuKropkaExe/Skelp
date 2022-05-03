drop procedure if exists changeUserPassword;
delimiter //
create procedure changeUserPassword(user_id int, newPassword varchar(100))
begin
    update Users set password = newPassword where id = user_id;
end //

# call insertUser('Asia', 'Asia', 'ajzia', 'czesc', 'user');
# call insertUser('Maciek', 'Maciek', 'flowyh', 'siema', 'user');
# call insertUser('Rychu', 'Rychu', 'rychu', 'ryhu', 'user');
#
# call changeUserPassword(1,'hesj', 'hej');