use skelp;
drop user if exists 'auth'@'%';
create user 'auth'@'%' identified by 'thegreatcreator';
grant execute on procedure insertUser to 'auth'@'%';
grant execute on procedure getUserPassword to 'auth'@'%';
grant execute on procedure checkLogin to 'auth'@'%';
grant execute on procedure getUserId to 'auth'@'%';
grant execute on procedure getUserType to 'auth'@'%';
grant execute on procedure changeUserPassword to 'auth'@'%';

drop user if exists 'client'@'%';
create user 'client'@'%' identified by 'minion';
-- user's privileges
grant execute on procedure displayAllBooks to 'client'@'%'; # <------------------------ done
grant execute on procedure displayAuthorsBooks to 'client'@'%'; # <-------------------- done
grant execute on procedure displayOrderContent to 'client'@'%'; # <-------------------- done
grant execute on procedure displayPublishersBooks to 'client'@'%'; # <----------------- done
grant execute on procedure displayUserData to 'client'@'%'; # <------------------------ done
grant execute on procedure displayUserOrders to 'client'@'%'; # <---------------------- done
grant execute on procedure getAuthorId to 'client'@'%'; # <---------------------------- done
grant execute on procedure getBookPrice to 'client'@'%'; # <--------------------------- done
grant execute on procedure getPublisherId to 'client'@'%'; # <------------------------- done
grant execute on procedure insertBookOrder to 'client'@'%'; # <------------------------ done
grant execute on procedure insertOrder to 'client'@'%'; # <---------------------------- done

drop user if exists 'author'@'%';
create user 'author'@'%' identified by 'lessgreatcreator';
-- user's privileges
grant execute on procedure displayAllBooks to 'author'@'%';
grant execute on procedure displayAuthorsBooks to 'author'@'%';
grant execute on procedure displayOrderContent to 'author'@'%';
grant execute on procedure displayPublishersBooks to 'author'@'%';
grant execute on procedure displayUserData to 'author'@'%';
grant execute on procedure displayUserOrders to 'author'@'%';
grant execute on procedure getAuthorId to 'author'@'%';
grant execute on procedure getBookPrice to 'author'@'%';
grant execute on procedure getPublisherId to 'author'@'%';
grant execute on procedure insertBookOrder to 'author'@'%';
grant execute on procedure insertOrder to 'author'@'%';
-- author's privileges
grant execute on procedure deleteAuthorsBook to 'author'@'%'; #<--------------------- done
grant execute on procedure getGenreId to 'author'@'%';# <---------------------------- done
grant execute on procedure insertBook to 'author'@'%';# <---------------------------- done
grant execute on procedure insertBookAuthor to 'author'@'%'; #<---------------------- done
grant execute on procedure insertBookGenre to 'author'@'%';# <----------------------- done

drop user if exists 'admin'@'%';
create user 'admin'@'%' identified by 'greatcreatorsslave';
-- user's privileges
grant execute on procedure displayAllBooks to 'admin'@'%';
grant execute on procedure displayAuthorsBooks to 'admin'@'%';
grant execute on procedure displayOrderContent to 'admin'@'%';
grant execute on procedure displayPublishersBooks to 'admin'@'%';
grant execute on procedure displayUserData to 'admin'@'%';
grant execute on procedure displayUserOrders to 'admin'@'%';
grant execute on procedure getAuthorId to 'admin'@'%';
grant execute on procedure getBookPrice to 'admin'@'%';
grant execute on procedure getPublisherId to 'admin'@'%';
grant execute on procedure insertBookOrder to 'admin'@'%';
grant execute on procedure insertOrder to 'admin'@'%';
-- author's privileges
grant execute on procedure deleteAuthorsBook to 'admin'@'%';
grant execute on procedure getGenreId to 'admin'@'%';
grant execute on procedure insertBook to 'admin'@'%';
grant execute on procedure insertBookAuthor to 'admin'@'%';
grant execute on procedure insertBookGenre to 'admin'@'%';
-- admin's privileges
grant execute on procedure deleteAuthor to 'admin'@'%';
grant execute on procedure deleteBook to 'admin'@'%';
grant execute on procedure deleteGenre to 'admin'@'%';
grant execute on procedure deletePublisher to 'admin'@'%';
grant execute on procedure insertAuthor to 'admin'@'%';
grant execute on procedure insertGenre to 'admin'@'%';
grant execute on procedure insertPublisher to 'admin'@'%';
grant execute on procedure raise to 'admin'@'%';
grant execute on procedure sale to 'admin'@'%';

flush privileges;