-- Genre
insert into Genre (name)
values ('Fantasy'),
       ('Adventure'),
       ('Romance'),
       ('Mystery'),
       ('Horror'),
       ('Thriller'),
       ('Science Fiction'),
       ('Young Adult'),
       ('Documentary'),
       ('Motivational'),
       ('Travel'),
       ('Cooking'),
       ('Graphic Novel'),
       ('Biography'),
       ('Erotic');

-- Author
insert into Author(name, surname)
values ('Jane', 'Austen'),
       ('Charles', 'Dickens'),
       ('John', 'Green'),
       ('Rick', 'Riordan'),
       ('Nigella', 'Lawson'),
       ('Cassandra', 'Clare'),
       ('Fiodor', 'Dostojewski'),
       ('Michaił', 'Bułhakow'),
       ('Andrzej', 'Sapkowski'),
       ('Dan', 'Brown'),
       ('Paulo', 'Coelho'),
       ('J.R.R', 'Tolkien'),
       ('J.K', 'Rowling'),
       ('Remigiusz', 'Mróz'),
       ('Krzysztof', 'Gonciarz');

-- Publisher
insert into Publisher(name)
values ('Pearson'),
       ('RELX'),
       ('Thomson Reuters'),
       ('Penguin Random House'),
       ('Hachette Livre'),
       ('Harper Collins'),
       ('Macmillan Publishers'),
       ('Bertelsmann'),
       ('Scholastic Corporation'),
       ('McGraw-Hill Education'),
       ('TCK Publishing'),
       ('Simon & Schuster'),
       ('Phoenix Yard Books'),
       ('Bloomsbury Publishing'),
       ('Arcade Publishing');

-- Book names
create table if not exists Book_names
(
    opening varchar(40) not null check (opening <> ''),
    name      varchar(40) not null check (name <> ''),
    addition  varchar(40) not null check (addition <> '')
);

insert into Book_names
values ('Amazing', ' Pottery', ' Escapade'),
       ('Mesmerizing', ' Frozen Yeti', ': The World You Never Knew Existed'),
       ('Fantastic', ' Captain Porkey', ' with the Cow'),
       ('Breathtaking', ' Journey', ' to the End'),
       ('Thought-provoking', ' Love Story', ' of the Century'),
       ('Great', ' Princess', ' and the Corn Field'),
       ('Rich', ' Mine', ' Wars'),
       ('Dead', ' Cow', ' Uprising'),
       ('Missing', ' Shoe', ' and the Power of Friendship'),
       ('Forbidden', ' Fruit', ' of Mischief'),
       ('A Tragic Story of', ' My Life', ' in a Nutshell'),
       ('Goodbye', ' Sweet World', ' of Mine'),
       ('Kingdom of', ' Lost Souls', ' that are Alive'),
       ('The Screaming of', ' Pleasure', ': Aliens are Coming!'),
       ('Tasty Adventure into the', ' Kitchen', ' with Tips and Tricks');
