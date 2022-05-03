# Skelp - a database bookshop

## Created by:
- Joanna Kulig, [@ajzia](https://github.com/ajzia)
- [@RychuKropkaExe](https://github.com/RychuKropkaExe)

### Purpose of the project:

Creating a database simulating a bookshop. Database contains information about books and completed transactions.

### Types of users and their functional requirements:

- auth (before logging in):
  -  checks in new users to the database
  -  returns user's password
  -  authorizes logging in
  -  allows password change

- client can:
  - make an account in the system
  - browse available books
  - make an order
  - check his order history

- author:
  - has all the functionalities of a client
  - can add his own book to the database
  - can delete his own book from the database

- admin:
  - has all the functionalities of an author
  - can add/delete books, authors, genres and publishers from the database
  - cannot add/change/delete tables, triggers, functions, procedures
  - can use already exiting triggers, functions and procedures

### Entities in the database:
1. Book - represents book, has to have at least one autor, genre and one publisher
    - Book (id: int, title: varchar(100), genre_id: List<int>, author_id: List<int>, publisher_id: int)
  
2. Author - represents an author, can have many books
    - Author (id: int, name: varchar(50), surname: varchar(50))
  
3. Genre - represents a genre, can have many books
    - Genre (id: int, name varchar(30))
  
4. Publisher - represents a publisher, can have many books
    - Publisher (id: int, name: varchar(50))
  
5. Order - has to have a user, moreover, it has to have at least one book 
    - Orders (id: int, client_id, book_id: List<int>, price: int)
  
6. User - can have many orders
    - Users (id: int, name: varchar(50), surname: varchar(50))
  
7. Product - its every book that ever was in the database with its publisher
    - Products (id: int, title: varchar(100), publisher: varchar(50))
  
### Normalization of the database:

Database is normalized to 4NF.
