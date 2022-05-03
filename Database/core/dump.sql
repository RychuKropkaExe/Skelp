-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: skelp
-- ------------------------------------------------------
-- Server version       8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Author`
--

DROP TABLE IF EXISTS `Author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Author` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Author_chk_1` CHECK ((`name` <> _utf8mb4'')),
  CONSTRAINT `Author_chk_2` CHECK ((`surname` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Author`
--

LOCK TABLES `Author` WRITE;
/*!40000 ALTER TABLE `Author` DISABLE KEYS */;
INSERT INTO `Author` VALUES (1,'Jane','Austen'),(2,'Charles','Dickens'),(3,'John','Green'),(4,'Rick','Riordan'),(5,'Nigella','Lawson'),(6,'Cassandra','Clare'),(7,'Fiodor','Dostojewski'),(8,'Michaił','Bułhakow'),(9,'Andrzej','Sapkowski'),(10,'Dan','Brown'),(11,'Paulo','Coelho'),(12,'J.R.R','Tolkien'),(13,'J.K','Rowling'),(14,'Remigiusz','Mróz'),(15,'Krzysztof','Gonciarz');
/*!40000 ALTER TABLE `Author` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `deleteAuthor` BEFORE DELETE ON `Author` FOR EACH ROW begin
    declare authorID, bookID, done int default 0;

    declare books cursor for select distinct book_id from Book_author where
            author_id = (select id from Author where name = old.name and surname = old.surname);

    declare continue handler for not found set done = 1;

        set authorID = (select id from Author where name = old.name and surname = old.surname);

        open books;

        while(done != 1) do
            fetch books into bookID;
            delete from Book where id = bookID;
        end while;

        close books;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `publisher_id` int unsigned NOT NULL,
  `price` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `Book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `Publisher` (`id`),
  CONSTRAINT `Book_chk_1` CHECK ((`title` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES (1,'The Screaming of Mine to the End',12,589),(2,'Missing Kitchen of the Century',6,1159),(3,'A Tragic Story of Fruit of the Century',10,1228),(4,'Forbidden Sweet World of Mine',4,893),(5,'Dead Pleasure: The World You Never Knew Existed',5,1664),(6,'Fantastic Sweet World and the Power of Friendship',7,1194),(7,'Missing Mine Escapade',4,246),(8,'The Screaming of Princess: The World You Never Knew Existed',1,1978),(9,'Thought-provoking Shoe with Tips and Tricks',3,1777),(10,'Forbidden Cow Escapade',3,883),(11,'Thought-provoking Love Story and the Corn Field',4,162),(12,'Tasty Adventure into the Lost Souls and the Corn Field',9,523),(13,'Rich Lost Souls: The World You Never Knew Existed',12,742),(14,'Dead Captain Porkey Uprising',9,325),(15,'Thought-provoking Pottery with Tips and Tricks',1,1544),(16,'Fantastic Mine of Mischief',9,1867),(17,'Forbidden Mine of Mischief',8,1531),(18,'Amazing My Life: The World You Never Knew Existed',9,1292),(19,'Tasty Adventure into the Captain Porkey of Mischief',5,287),(20,'Mesmerizing Pottery and the Corn Field',4,536),(21,'Rich Frozen Yeti: The World You Never Knew Existed',14,1857),(22,'Tasty Adventure into the Pottery in a Nutshell',8,2001),(23,'Dead Pleasure to the End',9,720),(24,'A Tragic Story of Kitchen of Mine',11,1893),(25,'Breathtaking Fruit that are Alive',13,1516),(26,'Amazing Princess and the Corn Field',3,1246),(27,'Forbidden Frozen Yeti that are Alive',14,591),(28,'A Tragic Story of Sweet World of Mine',11,1408),(29,'The Screaming of Kitchen Uprising',14,918),(30,'Dead Mine Escapade',4,1422),(31,'Mesmerizing Pottery with the Cow',10,1134),(32,'Missing Pottery Escapade',11,1158),(33,'Tasty Adventure into the Cow that are Alive',13,101),(34,'Rich Frozen Yeti of Mischief',3,1257),(35,'Fantastic Mine in a Nutshell',8,813),(36,'Breathtaking Shoe of Mine',11,2005),(37,'Kingdom of Kitchen: The World You Never Knew Existed',12,1437),(38,'Missing Journey Escapade',10,837),(39,'Amazing Fruit Escapade',7,608),(40,'Mesmerizing Sweet World Wars',5,1647),(41,'Breathtaking Journey Wars',1,1162),(42,'Tasty Adventure into the Frozen Yeti and the Power of Friendship',14,1249),(43,'The Screaming of Journey that are Alive',11,375),(44,'Tasty Adventure into the My Life of Mine',7,99),(45,'Rich Sweet World and the Corn Field',13,2100),(46,'Kingdom of Sweet World and the Corn Field',3,122),(47,'Goodbye Fruit Escapade',5,501),(48,'Amazing Lost Souls and the Power of Friendship',5,1275),(49,'Fantastic Cow of the Century',9,226),(50,'Mesmerizing Mine that are Alive',5,1921),(51,'Missing Sweet World Wars',7,887),(52,'Thought-provoking Shoe of Mine',3,1054),(53,'Fantastic Kitchen Escapade',8,1074),(54,'Amazing Pottery with the Cow',5,1354),(55,'Missing Shoe and the Corn Field',15,298),(56,'Missing Sweet World: The World You Never Knew Existed',2,1734),(57,'Kingdom of Princess Wars',12,1124),(58,'Missing My Life Wars',2,1065),(59,'Fantastic Kitchen of Mine',10,583),(60,'A Tragic Story of Sweet World of Mine',14,1977),(61,'Tasty Adventure into the Princess with Tips and Tricks',2,777),(62,'Goodbye Mine of Mine',11,1928),(63,'Thought-provoking Pottery that are Alive',2,1604),(64,'Goodbye Pottery Wars',1,530),(65,'Tasty Adventure into the Love Story of the Century',7,383),(66,'Tasty Adventure into the Princess of Mischief',3,988),(67,'Great Mine Escapade',10,780),(68,'Mesmerizing Sweet World: The World You Never Knew Existed',12,777),(69,'Fantastic Pottery: The World You Never Knew Existed',10,629),(70,'A Tragic Story of Pottery: The World You Never Knew Existed',15,1497),(71,'Goodbye Love Story Uprising',9,557),(72,'Breathtaking Lost Souls to the End',5,175),(73,'Thought-provoking Frozen Yeti with Tips and Tricks',14,1371),(74,'Mesmerizing Frozen Yeti of Mine',1,18),(75,'Mesmerizing My Life Escapade',10,1737),(76,'Forbidden Frozen Yeti with Tips and Tricks',10,328),(77,'Breathtaking Princess of the Century',10,697),(78,'Mesmerizing Sweet World of Mine',12,1266),(79,'Forbidden Sweet World that are Alive',14,107),(80,'A Tragic Story of Cow to the End',8,835),(81,'Fantastic Journey in a Nutshell',3,729),(82,'Amazing Princess with the Cow',9,625),(83,'Dead Princess: The World You Never Knew Existed',7,1611),(84,'Tasty Adventure into the Journey and the Power of Friendship',8,2079),(85,'The Screaming of Shoe Uprising',5,2096),(86,'Mesmerizing Frozen Yeti that are Alive',7,1074),(87,'A Tragic Story of Mine and the Corn Field',3,441),(88,'The Screaming of My Life in a Nutshell',3,1764),(89,'Mesmerizing Love Story with Tips and Tricks',11,1265),(90,'Kingdom of Love Story and the Power of Friendship',6,929),(91,'Dead Love Story of Mine',4,598),(92,'A Tragic Story of Kitchen of the Century',12,935),(93,'Rich Pottery: Aliens are Coming!',12,266),(94,'The Screaming of Cow of the Century',14,2112),(95,'Goodbye Shoe to the End',4,1458),(96,'Forbidden Fruit that are Alive',15,907),(97,'Fantastic Pleasure of the Century',4,1581),(98,'Kingdom of Mine Wars',9,1871),(99,'Mesmerizing My Life and the Power of Friendship',5,183),(100,'Breathtaking Fruit in a Nutshell',4,43);
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `insertProduct` AFTER INSERT ON `Book` FOR EACH ROW insert into Products(name, publisher)
    value (new.title, (select name from Publisher where Publisher.id = new.publisher_id)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `deleteBook` BEFORE DELETE ON `Book` FOR EACH ROW begin
    delete from Book_author where book_id = old.id;

    delete from Book_genre where book_id = old.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Book_author`
--

DROP TABLE IF EXISTS `Book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book_author` (
  `book_id` int unsigned NOT NULL,
  `author_id` int unsigned NOT NULL,
  KEY `book_id` (`book_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `Book_author_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `Book` (`id`),
  CONSTRAINT `Book_author_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `Author` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_author`
--

LOCK TABLES `Book_author` WRITE;
/*!40000 ALTER TABLE `Book_author` DISABLE KEYS */;
INSERT INTO `Book_author` VALUES (1,4),(1,10),(2,3),(3,12),(3,14),(4,7),(4,14),(5,4),(6,7),(7,11),(8,2),(9,6),(10,13),(10,1),(11,2),(12,12),(12,8),(13,8),(14,5),(14,11),(15,14),(16,6),(16,2),(17,9),(17,5),(18,8),(18,12),(18,1),(19,3),(20,2),(21,10),(22,8),(23,13),(24,8),(24,13),(24,12),(25,4),(25,2),(26,14),(26,8),(27,4),(27,7),(28,6),(28,11),(29,7),(30,8),(31,10),(31,12),(32,11),(33,1),(33,15),(33,12),(34,7),(35,14),(35,10),(36,4),(36,7),(37,12),(37,14),(38,2),(39,9),(40,1),(40,5),(41,12),(41,2),(41,14),(42,14),(42,11),(42,13),(43,6),(44,13),(45,10),(45,3),(45,8),(46,12),(47,1),(47,4),(47,11),(48,4),(48,11),(48,2),(49,8),(49,5),(49,11),(50,15),(50,3),(50,2),(51,11),(51,5),(52,13),(52,2),(53,8),(54,12),(54,14),(55,8),(56,2),(57,8),(58,15),(59,8),(59,1),(60,11),(61,7),(61,1),(61,14),(62,10),(62,4),(62,11),(63,1),(63,14),(63,5),(64,12),(64,4),(65,2),(65,4),(65,11),(66,3),(66,15),(67,13),(67,3),(68,6),(68,14),(69,5),(69,12),(70,8),(70,13),(70,9),(71,2),(71,5),(71,14),(72,4),(72,10),(73,2),(73,7),(73,12),(74,1),(74,6),(75,6),(76,13),(77,5),(78,13),(79,2),(79,10),(80,6),(81,3),(81,6),(81,5),(82,13),(83,12),(83,4),(84,8),(85,9),(86,3),(86,10),(87,14),(87,8),(87,7),(88,9),(89,2),(89,7),(89,13),(90,3),(90,15),(91,4),(92,13),(93,5),(93,6),(94,2),(94,12),(94,8),(95,13),(95,3),(96,10),(97,11),(97,15),(98,5),(99,1),(99,7),(100,9);
/*!40000 ALTER TABLE `Book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book_genre`
--

DROP TABLE IF EXISTS `Book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book_genre` (
  `book_id` int unsigned NOT NULL,
  `genre_id` int unsigned NOT NULL,
  KEY `book_id` (`book_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `Book_genre_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `Book` (`id`),
  CONSTRAINT `Book_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_genre`
--

LOCK TABLES `Book_genre` WRITE;
/*!40000 ALTER TABLE `Book_genre` DISABLE KEYS */;
INSERT INTO `Book_genre` VALUES (1,6),(2,13),(2,12),(3,10),(3,4),(4,7),(4,11),(5,1),(5,12),(5,10),(6,5),(6,13),(7,4),(7,1),(7,12),(8,7),(8,13),(8,9),(9,11),(10,10),(10,13),(10,9),(11,10),(11,8),(11,1),(12,4),(12,13),(12,11),(13,5),(14,4),(14,1),(15,6),(16,11),(16,15),(17,12),(17,15),(17,4),(18,6),(19,5),(19,2),(19,4),(20,3),(21,13),(21,9),(21,7),(22,5),(22,6),(22,12),(23,10),(23,6),(23,8),(24,13),(25,12),(25,11),(25,10),(26,7),(26,5),(26,9),(27,15),(27,11),(28,4),(28,7),(28,11),(29,6),(29,7),(29,10),(30,6),(30,12),(31,15),(31,4),(32,14),(32,6),(32,10),(33,14),(33,2),(33,13),(34,4),(34,6),(34,10),(35,2),(35,7),(35,14),(36,14),(36,12),(36,13),(37,1),(38,1),(38,6),(38,14),(39,11),(39,2),(40,6),(40,11),(40,15),(41,9),(41,7),(41,5),(42,3),(43,11),(43,2),(44,14),(44,2),(44,12),(45,6),(45,10),(46,6),(47,12),(47,9),(47,11),(48,3),(48,12),(48,9),(49,15),(49,5),(49,8),(50,14),(51,2),(51,11),(51,8),(52,7),(52,10),(52,12),(53,11),(53,12),(54,5),(54,14),(55,8),(56,9),(56,4),(57,8),(57,1),(58,10),(58,14),(59,8),(59,15),(59,10),(60,4),(61,11),(61,15),(62,11),(63,11),(63,1),(63,12),(64,14),(64,12),(64,11),(65,2),(65,14),(66,8),(66,3),(66,6),(67,15),(67,1),(68,9),(68,6),(68,5),(69,4),(69,3),(69,1),(70,15),(70,12),(70,1),(71,10),(71,9),(71,5),(72,6),(73,6),(73,3),(74,12),(74,7),(74,15),(75,13),(76,1),(76,6),(77,8),(78,13),(78,15),(79,13),(80,1),(80,4),(80,8),(81,7),(81,13),(82,12),(83,5),(83,15),(84,4),(85,8),(86,4),(86,13),(87,6),(87,8),(87,13),(88,4),(88,5),(89,11),(89,12),(90,10),(90,9),(91,1),(91,4),(92,10),(92,4),(92,14),(93,13),(93,1),(93,12),(94,9),(94,8),(94,11),(95,15),(96,5),(96,11),(97,12),(98,6),(98,4),(98,5),(99,1),(99,3),(100,12),(100,1),(100,9);
/*!40000 ALTER TABLE `Book_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book_names`
--

DROP TABLE IF EXISTS `Book_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book_names` (
  `opening` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `addition` varchar(40) NOT NULL,
  CONSTRAINT `Book_names_chk_1` CHECK ((`opening` <> _utf8mb4'')),
  CONSTRAINT `Book_names_chk_2` CHECK ((`name` <> _utf8mb4'')),
  CONSTRAINT `Book_names_chk_3` CHECK ((`addition` <> _utf8mb4''))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book_names`
--

LOCK TABLES `Book_names` WRITE;
/*!40000 ALTER TABLE `Book_names` DISABLE KEYS */;
INSERT INTO `Book_names` VALUES ('Amazing',' Pottery',' Escapade'),('Mesmerizing',' Frozen Yeti',': The World You Never Knew Existed'),('Fantastic',' Captain Porkey',' with the Cow'),('Breathtaking',' Journey',' to the End'),('Thought-provoking',' Love Story',' of the Century'),('Great',' Princess',' and the Corn Field'),('Rich',' Mine',' Wars'),('Dead',' Cow',' Uprising'),('Missing',' Shoe',' and the Power of Friendship'),('Forbidden',' Fruit',' of Mischief'),('A Tragic Story of',' My Life',' in a Nutshell'),('Goodbye',' Sweet World',' of Mine'),('Kingdom of',' Lost Souls',' that are Alive'),('The Screaming of',' Pleasure',': Aliens are Coming!'),('Tasty Adventure into the',' Kitchen',' with Tips and Tricks');
/*!40000 ALTER TABLE `Book_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Genre`
--

DROP TABLE IF EXISTS `Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Genre` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Genre_chk_1` CHECK ((`name` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genre`
--

LOCK TABLES `Genre` WRITE;
/*!40000 ALTER TABLE `Genre` DISABLE KEYS */;
INSERT INTO `Genre` VALUES (1,'Fantasy'),(2,'Adventure'),(3,'Romance'),(4,'Mystery'),(5,'Horror'),(6,'Thriller'),(7,'Science Fiction'),(8,'Young Adult'),(9,'Documentary'),(10,'Motivational'),(11,'Travel'),(12,'Cooking'),(13,'Graphic Novel'),(14,'Biography'),(15,'Erotic');
/*!40000 ALTER TABLE `Genre` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `deleteGenre` BEFORE DELETE ON `Genre` FOR EACH ROW begin
    declare bookID, done int default 0;

    declare books cursor for select distinct b.id from Book b
                             join Book_genre Bg on b.id = Bg.book_id
                             join Genre g on Bg.genre_id = g.id
                             where name = old.name;

    declare continue handler for not found set done = 1;

    open books;

    while(done != 1) do
        fetch books into bookID;
        delete from Book where id = bookID;
    end while;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order_book`
--

DROP TABLE IF EXISTS `Order_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_book` (
  `order_id` int unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Order_book_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`id`),
  CONSTRAINT `Order_book_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_book`
--

LOCK TABLES `Order_book` WRITE;
/*!40000 ALTER TABLE `Order_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int unsigned NOT NULL,
  `order_date` date NOT NULL,
  `value` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `publisher` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Products_chk_1` CHECK ((`name` <> _utf8mb4'')),
  CONSTRAINT `Products_chk_2` CHECK ((`publisher` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'The Screaming of Mine to the End','Simon & Schuster'),(2,'Missing Kitchen of the Century','Harper Collins'),(3,'A Tragic Story of Fruit of the Century','McGraw-Hill Education'),(4,'Forbidden Sweet World of Mine','Penguin Random House'),(5,'Dead Pleasure: The World You Never Knew Existed','Hachette Livre'),(6,'Fantastic Sweet World and the Power of Friendship','Macmillan Publishers'),(7,'Missing Mine Escapade','Penguin Random House'),(8,'The Screaming of Princess: The World You Never Knew Existed','Pearson'),(9,'Thought-provoking Shoe with Tips and Tricks','Thomson Reuters'),(10,'Forbidden Cow Escapade','Thomson Reuters'),(11,'Thought-provoking Love Story and the Corn Field','Penguin Random House'),(12,'Tasty Adventure into the Lost Souls and the Corn Field','Scholastic Corporation'),(13,'Rich Lost Souls: The World You Never Knew Existed','Simon & Schuster'),(14,'Dead Captain Porkey Uprising','Scholastic Corporation'),(15,'Thought-provoking Pottery with Tips and Tricks','Pearson'),(16,'Fantastic Mine of Mischief','Scholastic Corporation'),(17,'Forbidden Mine of Mischief','Bertelsmann'),(18,'Amazing My Life: The World You Never Knew Existed','Scholastic Corporation'),(19,'Tasty Adventure into the Captain Porkey of Mischief','Hachette Livre'),(20,'Mesmerizing Pottery and the Corn Field','Penguin Random House'),(21,'Rich Frozen Yeti: The World You Never Knew Existed','Bloomsbury Publishing'),(22,'Tasty Adventure into the Pottery in a Nutshell','Bertelsmann'),(23,'Dead Pleasure to the End','Scholastic Corporation'),(24,'A Tragic Story of Kitchen of Mine','TCK Publishing'),(25,'Breathtaking Fruit that are Alive','Phoenix Yard Books'),(26,'Amazing Princess and the Corn Field','Thomson Reuters'),(27,'Forbidden Frozen Yeti that are Alive','Bloomsbury Publishing'),(28,'A Tragic Story of Sweet World of Mine','TCK Publishing'),(29,'The Screaming of Kitchen Uprising','Bloomsbury Publishing'),(30,'Dead Mine Escapade','Penguin Random House'),(31,'Mesmerizing Pottery with the Cow','McGraw-Hill Education'),(32,'Missing Pottery Escapade','TCK Publishing'),(33,'Tasty Adventure into the Cow that are Alive','Phoenix Yard Books'),(34,'Rich Frozen Yeti of Mischief','Thomson Reuters'),(35,'Fantastic Mine in a Nutshell','Bertelsmann'),(36,'Breathtaking Shoe of Mine','TCK Publishing'),(37,'Kingdom of Kitchen: The World You Never Knew Existed','Simon & Schuster'),(38,'Missing Journey Escapade','McGraw-Hill Education'),(39,'Amazing Fruit Escapade','Macmillan Publishers'),(40,'Mesmerizing Sweet World Wars','Hachette Livre'),(41,'Breathtaking Journey Wars','Pearson'),(42,'Tasty Adventure into the Frozen Yeti and the Power of Friendship','Bloomsbury Publishing'),(43,'The Screaming of Journey that are Alive','TCK Publishing'),(44,'Tasty Adventure into the My Life of Mine','Macmillan Publishers'),(45,'Rich Sweet World and the Corn Field','Phoenix Yard Books'),(46,'Kingdom of Sweet World and the Corn Field','Thomson Reuters'),(47,'Goodbye Fruit Escapade','Hachette Livre'),(48,'Amazing Lost Souls and the Power of Friendship','Hachette Livre'),(49,'Fantastic Cow of the Century','Scholastic Corporation'),(50,'Mesmerizing Mine that are Alive','Hachette Livre'),(51,'Missing Sweet World Wars','Macmillan Publishers'),(52,'Thought-provoking Shoe of Mine','Thomson Reuters'),(53,'Fantastic Kitchen Escapade','Bertelsmann'),(54,'Amazing Pottery with the Cow','Hachette Livre'),(55,'Missing Shoe and the Corn Field','Arcade Publishing'),(56,'Missing Sweet World: The World You Never Knew Existed','RELX'),(57,'Kingdom of Princess Wars','Simon & Schuster'),(58,'Missing My Life Wars','RELX'),(59,'Fantastic Kitchen of Mine','McGraw-Hill Education'),(60,'A Tragic Story of Sweet World of Mine','Bloomsbury Publishing'),(61,'Tasty Adventure into the Princess with Tips and Tricks','RELX'),(62,'Goodbye Mine of Mine','TCK Publishing'),(63,'Thought-provoking Pottery that are Alive','RELX'),(64,'Goodbye Pottery Wars','Pearson'),(65,'Tasty Adventure into the Love Story of the Century','Macmillan Publishers'),(66,'Tasty Adventure into the Princess of Mischief','Thomson Reuters'),(67,'Great Mine Escapade','McGraw-Hill Education'),(68,'Mesmerizing Sweet World: The World You Never Knew Existed','Simon & Schuster'),(69,'Fantastic Pottery: The World You Never Knew Existed','McGraw-Hill Education'),(70,'A Tragic Story of Pottery: The World You Never Knew Existed','Arcade Publishing'),(71,'Goodbye Love Story Uprising','Scholastic Corporation'),(72,'Breathtaking Lost Souls to the End','Hachette Livre'),(73,'Thought-provoking Frozen Yeti with Tips and Tricks','Bloomsbury Publishing'),(74,'Mesmerizing Frozen Yeti of Mine','Pearson'),(75,'Mesmerizing My Life Escapade','McGraw-Hill Education'),(76,'Forbidden Frozen Yeti with Tips and Tricks','McGraw-Hill Education'),(77,'Breathtaking Princess of the Century','McGraw-Hill Education'),(78,'Mesmerizing Sweet World of Mine','Simon & Schuster'),(79,'Forbidden Sweet World that are Alive','Bloomsbury Publishing'),(80,'A Tragic Story of Cow to the End','Bertelsmann'),(81,'Fantastic Journey in a Nutshell','Thomson Reuters'),(82,'Amazing Princess with the Cow','Scholastic Corporation'),(83,'Dead Princess: The World You Never Knew Existed','Macmillan Publishers'),(84,'Tasty Adventure into the Journey and the Power of Friendship','Bertelsmann'),(85,'The Screaming of Shoe Uprising','Hachette Livre'),(86,'Mesmerizing Frozen Yeti that are Alive','Macmillan Publishers'),(87,'A Tragic Story of Mine and the Corn Field','Thomson Reuters'),(88,'The Screaming of My Life in a Nutshell','Thomson Reuters'),(89,'Mesmerizing Love Story with Tips and Tricks','TCK Publishing'),(90,'Kingdom of Love Story and the Power of Friendship','Harper Collins'),(91,'Dead Love Story of Mine','Penguin Random House'),(92,'A Tragic Story of Kitchen of the Century','Simon & Schuster'),(93,'Rich Pottery: Aliens are Coming!','Simon & Schuster'),(94,'The Screaming of Cow of the Century','Bloomsbury Publishing'),(95,'Goodbye Shoe to the End','Penguin Random House'),(96,'Forbidden Fruit that are Alive','Arcade Publishing'),(97,'Fantastic Pleasure of the Century','Penguin Random House'),(98,'Kingdom of Mine Wars','Scholastic Corporation'),(99,'Mesmerizing My Life and the Power of Friendship','Hachette Livre'),(100,'Breathtaking Fruit in a Nutshell','Penguin Random House');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Publisher` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Publisher_chk_1` CHECK ((`name` <> _utf8mb4''))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Publisher`
--

LOCK TABLES `Publisher` WRITE;
/*!40000 ALTER TABLE `Publisher` DISABLE KEYS */;
INSERT INTO `Publisher` VALUES (1,'Pearson'),(2,'RELX'),(3,'Thomson Reuters'),(4,'Penguin Random House'),(5,'Hachette Livre'),(6,'Harper Collins'),(7,'Macmillan Publishers'),(8,'Bertelsmann'),(9,'Scholastic Corporation'),(10,'McGraw-Hill Education'),(11,'TCK Publishing'),(12,'Simon & Schuster'),(13,'Phoenix Yard Books'),(14,'Bloomsbury Publishing'),(15,'Arcade Publishing');
/*!40000 ALTER TABLE `Publisher` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `deletePublisher` BEFORE DELETE ON `Publisher` FOR EACH ROW begin
    declare bookID, done int default 0;

    declare books cursor for select distinct id from Book where
            publisher_id = (select id from Publisher where name = old.name);

    declare continue handler for not found set done = 1;

    open books;

    while(done != 1) do
        fetch books into bookID;
        delete from Book where id = bookID;
    end while;

    close books;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` enum('admin','user','author') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `Users_chk_1` CHECK ((`name` <> _utf8mb4'')),
  CONSTRAINT `Users_chk_2` CHECK ((`surname` <> _utf8mb4'')),
  CONSTRAINT `Users_chk_3` CHECK ((`login` <> _utf8mb4'')),
  CONSTRAINT `Users_chk_4` CHECK ((`password` <> _utf8mb4'')),
  CONSTRAINT `Users_chk_5` CHECK ((`type` <> _utf8mb4''))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `registerAuthor` AFTER INSERT ON `Users` FOR EACH ROW begin

    declare number, max, count_id int;

    set count_id = (select max(id) + 1 from Author);

    if(new.Type = 'author') then
        insert into Author(id, name, surname) value (count_id, new.name, new.surname);

        set number = (select count(name) from Author where name = new.name and surname = new.surname);

        if (number > 1) then
            set max = (select max(id) from Author where name = new.name and surname = new.surname);
            delete from Author where name = new.name and surname = new.surname and id = max;
        end if;

    end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'skelp'
--
/*!50003 DROP PROCEDURE IF EXISTS `bookTitle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `bookTitle`(ile int)
begin
    declare x, y, z varchar(50);
    declare publisher_id int;
    declare price int;

    while(ile != 0)
        do
            set x = (select opening from Book_names order by rand() limit 1);
            set y = (select name from Book_names order by rand() limit 1);
            set z = (select addition from Book_names order by rand() limit 1);

            set publisher_id = floor(rand() * (select count(id) from Publisher) + 1);
            set price = floor(rand() * (2137 - 13 + 1) + 13);

            insert into Book(title, publisher_id, price)
            value (concat(x, y, z), publisher_id, price);

            set ile = ile - 1;

        end while;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `changeUserPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `changeUserPassword`(user_id int, newPassword varchar(100))
begin
    update Users set password = newPassword where id = user_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `checkLogin`(checkLogin varchar(50))
begin
    select exists(select login from Users where login = checkLogin) as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteAuthor`(authorID int)
begin
    if(select exists(select id from Author where id = authorID)) then
        delete from Author where id = authorID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteAuthorsBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteAuthorsBook`(bookID int, authorID int)
begin
    if(select exists(select distinct book_id from Book_author where book_id = bookID and author_id = authorID)) then
        delete from Book where id = bookID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteBook`(bookID int)
begin
    if(select exists(select id from Book where id = bookID)) then
        delete from Book where id = bookID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deleteGenre`(genreID int)
begin
    if(select exists(select id from Genre where id = genreID)) then
        delete from Genre where id = genreID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deletePublisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `deletePublisher`(publisherID int)
begin
    if(select exists(select id from Publisher where id = publisherID)) then
        delete from Publisher where id = publisherID;
        select 1 as result;
    else
        select 0 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayAllBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayAllBooks`()
begin
    select b.id, title, group_concat(distinct g.name) as genre,
           group_concat(distinct concat(a.name, ' ', a.surname)) as author,
           p.name as publisher, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author ba on b.id = ba.book_id
        join Author a on ba.author_id = a.id
        join Book_genre bg on b.id = bg.book_id
        join Genre g on bg.genre_id = g.id
        group by b.id, title, p.name, price;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayAuthorsBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayAuthorsBooks`(authorID int)
begin
    select b.id, title, group_concat(distinct G.name) as genre, p.name as publisher, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author Ba on b.id = Ba.book_id
        join Book_genre Bg on b.id = Bg.book_id
        join Genre G on Bg.genre_id = G.id
        where author_id = authorID
        group by b.id, title, p.name, price;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayOrderContent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayOrderContent`(userID int, orderID int)
begin
    select p.name as title, p.publisher as publisher, count(p.name) as quantity from Order_book ob
        join Products p on ob.product_id = p.id
        join Orders o on ob.order_id = o.id
    where order_id = orderID and client_id = userID
    group by order_id, p.name, p.publisher;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayPublishersBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayPublishersBooks`(publisherID int)
begin
    select b.id, title, group_concat(distinct G.name) as genre,
           group_concat(distinct concat(a.name, ' ', a.surname)) as author, price from Book b
        join Publisher p on b.publisher_id = p.id
        join Book_author Ba on b.id = Ba.book_id
        join Book_genre Bg on b.id = Bg.book_id
        join Genre G on Bg.genre_id = G.id
        join Author a on Ba.author_id = a.id
        where publisher_id = publisherID
        group by b.id, title, price;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayUserData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayUserData`(userID int)
begin
    select id, name, surname, login, type from Users where id = userID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `displayUserOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `displayUserOrders`(userID int)
begin
    select id, order_date, value from Orders where client_id = userID;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generateBookAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `generateBookAuthor`()
begin
    declare books, number, authorID int default 0;
    declare bookID int default 1;
    set books = (select count(id) from Book);

    while(bookID <= books) do
        set number = floor(rand() * 3 + 1);

        while(number > 0) do
            set authorID = (select id from Author order by rand() limit 1);

            if (!exists(select book_id from Book_author where book_id = bookID and author_id = authorID)) then
                insert into Book_author value (bookID, authorID);
                set number = number - 1;
            end if;

        end while;

        set bookID = bookID + 1;
    end while ;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generateBookGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `generateBookGenre`()
begin
    declare booksQuantity, numberOfGenres, genreID int;
    declare pointer int default 1;
    set booksQuantity = (select count(id) from Book);

    while(pointer != booksQuantity + 1) do
        set numberOfGenres = floor(rand() * 3 + 1);

        while(numberOfGenres != 0) do
            set genreId = (select id from Genre order by rand() limit 1);

            if (!exists(select book_id from Book_genre where book_id = pointer and genre_id = genreId)) then
                insert into Book_genre(book_id, genre_id) value(pointer, genreID);
                set numberOfGenres = numberOfGenres - 1;
            end if;

        end while;

        set pointer = pointer + 1;
    end while;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAuthorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getAuthorId`(author_name varchar(50), author_surname varchar(50))
begin
    select id from Author where name = author_name and surname = author_surname;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBookPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getBookPrice`(bookID int)
begin
    if(exists(select price from Book where id = bookID)) then
        select price from Book where id = bookID;
    else
        select 0 as price;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getGenreId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getGenreId`(book_genre varchar(50))
begin
    select id from Genre where name = book_genre;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPublisherId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getPublisherId`(publisher_name varchar(50))
begin
    select id from Publisher where name = publisher_name;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getUserId`(user_login varchar(50))
select id from Users where login = user_login ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getUserPassword`(checkLogin varchar(50))
begin
    select password from Users where login = checkLogin;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getUserType`(user_id int)
select type from Users where id = user_id ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertAuthor`(author_name varchar(50), author_surname varchar(50))
begin
    declare number, author_id int default 0;

    start transaction;

    set author_id = (select max(id) + 1 from Author);
    insert into Author(id, name, surname) value(author_id, author_name, author_surname);

    set number = (select count(name) from Author where name = author_name and surname = author_surname);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertBook`(newTitle varchar(100), newPublisher varchar(50), newPrice int)
begin
    declare publisherID int;
    call insertPublisher(newPublisher);
    set publisherID = (select id from Publisher where name = newPublisher);
    insert into Book(title, publisher_id, price) value (newTitle, publisherID, newPrice);
    select last_insert_id() as result;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBookAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertBookAuthor`(bookID int, new_name varchar(50), new_surname varchar(50))
begin
    declare number, count int;

    call insertAuthor(new_name, new_surname);

    set number = (select id from Author where name = new_name and surname = new_surname);

    insert into Book_author(book_id, author_id) value (bookID, number);

    set count = (select count(book_id) from Book_author b
                    join Author a on b.author_id = a.id
                    where a.name = new_name and a.surname = new_surname);

    if (count > 1) then
        delete from Book_author where book_id = bookID and author_id = number;
        insert into Book_author(book_id, author_id) value (bookID, number);

    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBookGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertBookGenre`(bookID int, new_genre varchar(30))
begin
    declare number, count int;

    call insertGenre(new_genre);

    set number = (select id from Genre where name = new_genre);

    insert into Book_genre(book_id, genre_id) value (bookID, number);

    set count = (select count(book_id) from Book_genre b
                    join Genre g on b.genre_id = g.id
                    where name = new_genre);

    if (count > 1) then
        delete from Book_genre where book_id = bookID and genre_id = number;
        insert into Book_genre(book_id, genre_id) value (bookID, number);

    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertBookOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertBookOrder`(orderID int, book_id int)
begin
    declare flag boolean default false;

    start transaction;

    if(exists(select id from Book where id = book_id)) then
        insert into Order_book
    value (orderID, book_id);
    else
        set flag = true;
    end if;

    if flag then
        rollback;
    else
        commit;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertGenre`(genre_name varchar(50))
begin
    declare number, genre_id int default 0;

    start transaction;

    set genre_id = (select max(id) + 1 from Genre);
    insert into Genre(id, name) value(genre_id, genre_name);

    set number = (select count(name) from Genre where name = genre_name);

    if number > 1 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertOrder`(clientID int, orderValue int)
begin
    insert into Orders(client_id, order_date, value) value(clientID, current_date(), orderValue);
    select id from Orders where client_id = clientID order by id desc limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPublisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertPublisher`(publisher_name varchar(50))
begin
    declare number, publisher_id int default 0;

    start transaction;

    set publisher_id = (select max(id) + 1 from Publisher);
    insert into Publisher(id, name) value(publisher_id, publisher_name);

    set number = (select count(name) from Publisher where name = publisher_name);

    if number > 1 then
        rollback;
    else
        commit;
    end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insertUser`(newName varchar(50), newSurname varchar(50), newLogin varchar(50), newPassword varchar(100), newType enum ('admin', 'user', 'author'))
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `raise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `raise`(percent int, publisher int)
begin
    declare max int;

    start transaction;

    update Book
        set price = price * (1 + percent / 100)
    where publisher_id = publisher;

    set max = (select max(price) from Book where publisher_id = publisher);

    if max > 2137 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sale`(percent int, publisher int)
begin
    declare min int;

    start transaction;

    update Book
        set price = price * (1 - percent / 100)
    where publisher_id = publisher;

    set min = (select min(price) from Book where publisher_id = publisher);

    if min < 13 then
        rollback;
        select 0 as result;
    else
        commit;
        select 1 as result;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;