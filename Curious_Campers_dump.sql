CREATE DATABASE  IF NOT EXISTS `curious_camper` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `curious_camper`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: curious_camper
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  PRIMARY KEY (`admin_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin_101','admin101@yahoo.com','9300266790','Bahamas_101pass'),('admin_Apr','apriladmin@gmail.com','5687521369','April_Hazeadmin'),('admin_Aug','admincampsiteaug@yahoomail.com','9863147324','Mobstercookie00'),('admin09020002','AquaAdmin@rediffmail.com','7609200002','Aqua2000_pass'),('admin1','admin1@example.com','1234567890','adminpass1'),('admin1199','SagAdmin@gmail.com','8992501309','AllowAccess_admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `amenity_Id` int NOT NULL,
  `amenity_Name` varchar(255) NOT NULL,
  `street_number` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `state` char(20) NOT NULL,
  `city` varchar(64) NOT NULL,
  `zipcode` char(5) NOT NULL,
  `distance_from_campsite` decimal(10,2) NOT NULL,
  `type_Name` varchar(255) DEFAULT NULL,
  `campsiteId` int DEFAULT NULL,
  PRIMARY KEY (`amenity_Id`),
  KEY `campsiteId` (`campsiteId`),
  KEY `type_Name` (`type_Name`),
  CONSTRAINT `amenities_ibfk_1` FOREIGN KEY (`campsiteId`) REFERENCES `campsite` (`campsiteId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amenities_ibfk_2` FOREIGN KEY (`type_Name`) REFERENCES `amenity_type` (`type_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (2,'Electrical Charge',5,'Mozart Street','NY','Townsville','67890',0.30,'Gas Station',2),(3,'St Vincent Hospital',879,'Parker Avenue','NY','Townsville','67892',1.20,'Hospital',2),(4,'Supreme Market',4,'Pine Boulevard','MA','Salem','02175',0.90,'General Store',4),(6,'CVS Pharmacy',74,'Fenil Street','CO','Denver','80200',1.50,'Pharmacy',3),(7,'New Amenity',10,'Main Street','CA','Cityville','12345',1.50,'Hospital',2),(8,'pharmacy',45,'Dalrymple','WA','Seattle','55641',1.00,'Pharmacy',4),(9,'Bharat Gas Station',322,'Nehru Park','CO','Denver','45865',0.25,'Gas Station',5);
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amenity_type`
--

DROP TABLE IF EXISTS `amenity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenity_type` (
  `type_Name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenity_type`
--

LOCK TABLES `amenity_type` WRITE;
/*!40000 ALTER TABLE `amenity_type` DISABLE KEYS */;
INSERT INTO `amenity_type` VALUES ('Gas station'),('General Store'),('Grocery Store'),('Hospital'),('Pharmacy'),('Restaurants');
/*!40000 ALTER TABLE `amenity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_Id` int DEFAULT NULL,
  `booking_Date` date NOT NULL,
  `start_Date` date NOT NULL,
  `end_Date` date NOT NULL,
  `price_Total` decimal(10,2) NOT NULL,
  `number_of_Guests` int NOT NULL,
  `booking_Status` varchar(255) NOT NULL,
  `user_Name` varchar(255) NOT NULL,
  `campsiteId` int NOT NULL,
  PRIMARY KEY (`user_Name`,`booking_Date`,`campsiteId`),
  UNIQUE KEY `booking_Id` (`booking_Id`),
  KEY `campsiteId` (`campsiteId`),
  KEY `idx_booking_Id` (`booking_Id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_Name`) REFERENCES `user` (`user_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`campsiteId`) REFERENCES `campsite` (`campsiteId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (2,'2023-02-09','2023-12-10','2023-12-15',1125.00,3,'Confirmed','Eithan',2),(11,'2023-12-07','2023-12-01','2023-12-10',85.00,1,'Confirmed','grafea',4),(13,'2023-12-08','2023-12-09','2023-12-16',275.00,5,'Confirmed','grafea',5),(12,'2023-12-08','2024-02-01','2024-02-10',105.00,3,'Confirmed','grafea',6),(4,'2023-04-02','2023-04-05','2023-04-08',1785.00,7,'Cancelled','Leo',4),(14,'2023-12-08','2023-12-16','2023-12-23',170.00,2,'Confirmed','Leo',4),(10,'2023-12-07','2023-12-08','2023-12-09',75.00,1,'Confirmed','mauria',2);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campsite`
--

DROP TABLE IF EXISTS `campsite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campsite` (
  `campsiteId` int NOT NULL,
  `campsite_name` varchar(255) NOT NULL,
  `street_number` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(5) NOT NULL,
  `zipcode` char(5) NOT NULL,
  `spots_available` int NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  PRIMARY KEY (`campsiteId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campsite`
--

LOCK TABLES `campsite` WRITE;
/*!40000 ALTER TABLE `campsite` DISABLE KEYS */;
INSERT INTO `campsite` VALUES (2,'Happy Trails',456,'Maple Avenue','Townsville','NY','67890',4,75.00),(3,'Whispering Pines',85,'Park Street','Denver','CO','80202',0,40.00),(4,'Ghost Camp',13,'Cactus Boulevard','Salem','MA','02175',48,85.00),(5,'The Campfire Chronicles',333,'Evergreen Lane','Seattle','WA','98101',40,55.00),(6,'Serene Sunsets',789,'Palmetto Avenue','Charleston','SC','29401',5,35.00),(7,'New Campsite',10,'Main Street','Cityville','CA','12345',7,560.00),(9,'Travel Tuesdays',85,'Manhattan Sr','Connecticut','NY','54856',7,50.00);
/*!40000 ALTER TABLE `campsite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_ID` int NOT NULL,
  `payment_Date` date NOT NULL,
  `total_Amount` decimal(10,2) NOT NULL,
  `payment_Method` varchar(255) NOT NULL,
  `user_Name` varchar(255) NOT NULL,
  `booking_Id` int DEFAULT NULL,
  `payment_Status` varchar(20) NOT NULL,
  PRIMARY KEY (`user_Name`,`payment_ID`),
  UNIQUE KEY `payment_ID` (`payment_ID`),
  UNIQUE KEY `payment_ID_2` (`payment_ID`),
  KEY `booking_Id` (`booking_Id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_Name`) REFERENCES `user` (`user_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`booking_Id`) REFERENCES `booking` (`booking_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'2023-12-07',85.00,'Credit Card','grafea',11,'Success'),(2,'2023-12-08',105.00,'Credit Card','grafea',12,'Success'),(3,'2023-12-08',275.00,'Credit card','grafea',13,'Success'),(4,'2023-12-08',170.00,'Credit card','Leo',14,'Success');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `rating` decimal(3,2) NOT NULL,
  `comments` text NOT NULL,
  `date_review_posted` date NOT NULL,
  `user_Name` varchar(255) DEFAULT NULL,
  `campsiteId` int DEFAULT NULL,
  KEY `user_Name` (`user_Name`),
  KEY `campsiteId` (`campsiteId`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_Name`) REFERENCES `user` (`user_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`campsiteId`) REFERENCES `campsite` (`campsiteId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (3.00,'Nice location but could be cleaner.','2023-09-20','grafea',6),(1.00,'Too crowded, poor arrangements, Too expensive, NOT worth it!!','2023-04-20','Leo',4),(5.00,'Amazing experience, definitely going again','2023-05-22','Leo',2),(4.00,'The ghost theme is perfect for Salem!!','2023-01-20','mauria',4),(9.00,'Amazing ','2023-12-07','Leo',4),(4.00,'Can improve more','2023-12-08','mauria',3);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_ticket`
--

DROP TABLE IF EXISTS `support_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_ticket` (
  `ticket_ID` int NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `issue_Type` varchar(255) DEFAULT NULL,
  `issue_Description` text,
  `resolution` text,
  `issue_Date` date DEFAULT NULL,
  `resolution_Date` date DEFAULT NULL,
  `user_Name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_Name`,`ticket_ID`),
  UNIQUE KEY `ticket_ID` (`ticket_ID`),
  CONSTRAINT `support_ticket_ibfk_1` FOREIGN KEY (`user_Name`) REFERENCES `user` (`user_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_ticket`
--

LOCK TABLES `support_ticket` WRITE;
/*!40000 ALTER TABLE `support_ticket` DISABLE KEYS */;
INSERT INTO `support_ticket` VALUES (1,'Resolved','Technical Issue','I am experiencing issues with my account.','The issue has been resolved. Thank you for your patience.','2023-11-29','2023-11-29','beerbiceps'),(3,'Resolved','payment issue','issue is with eodnig payment\r\n','resolved','2023-12-07','2023-12-08','beerbiceps'),(2,'Resolved','Payment Issue','I am experiencing issues with my payment.','Resolved ','2023-11-29','2023-12-08','grafea'),(5,'Open','payment issue','payement ',NULL,'2023-12-08',NULL,'grafea'),(4,'Resolved','payment issue','PAYMENT NOT DONE','Please check your payment method and credentials, we have not received the payment, ','2023-12-07','2023-12-08','Leo');
/*!40000 ALTER TABLE `support_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_Name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`user_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('beerbiceps','bicepswithbeer','8765432109','beer_biceps@gmail.com'),('Eithan','eithanprod','7744330139','eithan@gmail.com'),('ghibliarchives','ghiblipass','9876543210','ghibhli@gmail.com'),('grafea','grafeabag222','2259743586','grafeamoon@gmail.com'),('Leo','Leo_bordercollie','5698710325','newemail@gmail.com'),('mauria','mauriaandcucmberes','9756841203','cucumbers@yahoomail.com'),('rahulrai','rahulraitalents','4141100473','rahul@henrytalents.com'),('user2','userpass2','8765432109','user2@example.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'curious_camper'
--
/*!50003 DROP FUNCTION IF EXISTS `CalculatePricePerNight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculatePricePerNight`(
    p_campsiteId INT
) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE nightlyPrice DECIMAL(10, 2);

    -- Get the nightly price from the campsite table
    SELECT price_per_night INTO nightlyPrice
    FROM campsite
    WHERE campsiteId = p_campsiteId;

    RETURN nightlyPrice;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CountBookingsByDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CountBookingsByDate`(check_date DATE) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE booking_count INT;

    SELECT COUNT(*)
    INTO booking_count
    FROM booking
    WHERE check_date BETWEEN booking.start_date AND booking.end_date;

    RETURN booking_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `GetAverageRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetAverageRating`(campsite_id INT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE avg_rating FLOAT;

    SELECT AVG(rating)
    INTO avg_rating
    FROM review
    WHERE campsiteId = campsite_id;

    RETURN avg_rating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `IsBookingConfirmed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `IsBookingConfirmed`(p_userName VARCHAR(255), p_bookingDate DATE, p_campsiteId INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE isConfirmed BOOLEAN;

    -- Check if there is a confirmed booking for the specified user, booking date, and campsite
    SELECT COUNT(*) INTO isConfirmed
    FROM booking
    WHERE user_Name = p_userName
        AND booking_Date = p_bookingDate
        AND campsiteId = p_campsiteId
        AND booking_Status = 'Confirmed';

    RETURN isConfirmed;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UpdateBookingPrices` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `UpdateBookingPrices`() RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE updatedCount INT DEFAULT 0;

    -- Update prices for bookings with null price_Total
    UPDATE booking
    SET price_Total = (
        SELECT price_per_night * number_of_guests * DATEDIFF(end_Date, start_Date)
        FROM campsite
        WHERE campsite.campsiteId = booking.campsiteId
    )
    WHERE price_Total IS NULL;

    SET updatedCount = ROW_COUNT();

    RETURN updatedCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UsernameExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `UsernameExists`(p_userName VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE userCount INT;

    SELECT COUNT(*) INTO userCount
    FROM user
    WHERE user_Name = p_userName;

    RETURN userCount > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddAmenities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAmenities`(
    IN p_adminUsername VARCHAR(255),
    IN p_amenityName VARCHAR(255),
    IN p_streetNumber INT,
    IN p_streetName VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state CHAR(10),
    IN p_zipcode CHAR(6),
    IN p_distance DECIMAL(10, 2),
    IN p_typeName VARCHAR(255),
    IN p_campsiteId INT
)
BEGIN
    DECLARE isAdmin INT;
    DECLARE p_amenityId INT;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM admin
    WHERE admin_username = p_adminUsername;

    IF isAdmin > 0 THEN
        -- Admin is authorized to perform the action
        SET p_amenityId = (SELECT COALESCE(MAX(amenity_Id), 0) + 1 FROM amenities);

        -- Add new amenity
        INSERT INTO amenities (
            amenity_Id,
            amenity_Name,
            street_number,
            street_name,
            city,
            state,
            zipcode,
            distance_from_campsite,
            type_Name,
            campsiteId
        )
        VALUES (
            p_amenityId,
            p_amenityName,
            p_streetNumber,
            p_streetName,
            p_city,
            p_state,
            p_zipcode,
            p_distance,
            p_typeName,
            p_campsiteId
        );

        SELECT CONCAT('Amenity "', p_amenityName, '" added successfully.') AS Message;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User is not authorized to manage amenities.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCampsite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCampsite`(
    IN p_adminUsername VARCHAR(255),
    IN p_campsiteName VARCHAR(255),
    IN p_streetNumber INT,
    IN p_streetName VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state CHAR(10),
    IN p_zipcode CHAR(5),
    IN p_soptsAvailable INT,
    IN p_price_per_night DECIMAL(10, 2)
)
BEGIN
    DECLARE isAdmin INT;
    DECLARE p_campsiteId INT;
    
    -- Check if the user is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM admin
    WHERE admin_username = p_adminUsername;

    IF isAdmin > 0 THEN
        -- Admin is authorized to perform the action
       
            SET p_campsiteId = (SELECT COALESCE(MAX(campsiteId), 0) + 1 FROM campsite);

            -- Add new amenity
            INSERT INTO campsite (
                campsiteId,
                campsite_name,
                street_number,
                street_name,
                city,
                state,
                zipcode,
                spots_available,
                price_per_night
            )
            VALUES (
                p_campsiteId,
                p_campsiteName,
                p_streetNumber,
                p_streetName,
                p_city,
                p_state,
                p_zipcode,
                p_soptsAvailable,
                p_price_per_night
            );

            SELECT CONCAT('Campsite "', p_campsiteName, '" added successfully.') AS Message;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User is not authorized to add campsite.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddReview`(
    IN p_userName VARCHAR(255),
    IN p_campsiteId INT,
    IN p_rating DECIMAL(3, 2),
    IN p_comments TEXT
    
)
BEGIN
    -- Check if the user and campsite exist
    DECLARE userExists INT;
    DECLARE campsiteExists INT;

    SELECT COUNT(*) INTO userExists FROM user WHERE user_Name = p_userName;
    SELECT COUNT(*) INTO campsiteExists FROM campsite WHERE campsiteId = p_campsiteId;

    IF userExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User does not exist';
    END IF;

    IF campsiteExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Campsite does not exist';
    END IF;

    -- Add the review
    INSERT INTO review (rating, comments, date_review_posted, user_Name, campsiteId)
   VALUES (p_rating, p_comments, CURDATE(), p_userName, p_campsiteId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AlterBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterBooking`(
    IN p_userName VARCHAR(255),
    IN p_bookingId INT,
    IN p_newStartDate DATE,
    IN p_newEndDate DATE,
    IN p_newNumGuests INT
)
BEGIN
    DECLARE isUserAuthorized BOOLEAN;
    DECLARE campsiteAvailable BOOLEAN;
    DECLARE newPrice DECIMAL(10, 2);

    -- Check if the user is authorized to alter the booking
    SELECT COUNT(*) INTO isUserAuthorized
    FROM booking
    WHERE user_Name = p_userName AND booking_Id = p_bookingId;

    IF isUserAuthorized = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: You are not authorized to alter this booking';
    ELSE
        -- Check if the campsite is available for the new dates
        SELECT spots_available >= p_newNumGuests INTO campsiteAvailable
        FROM campsite
        WHERE campsiteId = (SELECT campsiteId FROM booking WHERE booking_Id = p_bookingId);

        IF NOT campsiteAvailable THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: The campsite is not available for the new dates';
        ELSE
            -- Update the booking details
            UPDATE booking
            SET start_Date = p_newStartDate,
                end_Date = p_newEndDate,
                number_of_Guests = p_newNumGuests,
                booking_Status = 'Confirmed'
            WHERE booking_Id = p_bookingId;

            -- Manually update prices for bookings after the update
            UPDATE booking
            SET price_Total = (
                SELECT price_per_night * number_of_guests * DATEDIFF(end_Date, start_Date)
                FROM campsite
                WHERE campsite.campsiteId = booking.campsiteId
            )
            WHERE booking_Id = p_bookingId;

            -- Optionally, you can retrieve the updated total price
            SELECT price_Total INTO newPrice
            FROM booking
            WHERE booking_Id = p_bookingId;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BookCampsite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookCampsite`(
    IN p_userName VARCHAR(255),
    IN p_campsiteId INT,
    IN p_startDate DATE,
    IN p_endDate DATE,
    IN p_numGuests INT,
    IN payment_Method VARCHAR(255)
)
BEGIN
    DECLARE campsiteExists INT;
    DECLARE userExists INT;
    DECLARE availableSpots INT;
    DECLARE p_booking_id INT;
    DECLARE price INT;
    DECLARE paymentId INT;
    DECLARE p_payment_Status VARCHAR(20);
   

    -- Check if the campsite and user exist
    SELECT COUNT(*) INTO campsiteExists FROM campsite WHERE campsiteId = p_campsiteId;
    SELECT COUNT(*) INTO userExists FROM user WHERE user_Name = p_userName;

    IF campsiteExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Campsite does not exist';
    END IF;

    IF userExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User does not exist';
    END IF;

    -- Check if the campsite has enough available spots
    SELECT spots_available INTO availableSpots FROM campsite WHERE campsiteId = p_campsiteId;

    IF availableSpots < p_numGuests THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Not enough available spots for booking';
    END IF;
    
    SET p_booking_id = (SELECT COALESCE(MAX(booking_id), 0) + 1 FROM booking);
    -- Check if payment is confirmed
    
    SET price = p_numGuests*(SELECT price_per_night FROM campsite where campsiteId = p_campsiteId);

    SET paymentId = (SELECT COALESCE(MAX(payment_ID), 0) + 1 FROM payment);
    SET p_payment_Status = 'Success';
    -- Perform the booking with auto-generated booking ID
    -- IF isPaymentConfirmed THEN
		
    -- Perform the booking with auto-generated booking ID
    
		INSERT INTO booking (booking_Id, booking_Date, start_Date, end_Date, price_Total, number_of_Guests, booking_Status, user_Name, campsiteId)
		VALUES (
			p_booking_id, CURDATE(), p_startDate, p_endDate, price, p_numGuests, 'Confirmed', p_userName, p_campsiteId
		);
    /*ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Payment is not confirmed. Booking not allowed.';*/
        INSERT INTO payment (payment_ID, payment_Date, total_Amount, payment_Method, user_Name, booking_Id, payment_Status)
		VALUES (
			paymentId, CURDATE(), price, payment_Method, p_userName, p_booking_id, p_payment_Status);

    -- Update the available spots in the campsite table
    UPDATE campsite SET spots_available = spots_available - p_numGuests WHERE campsiteId = p_campsiteId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CancelBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(
    IN p_userName VARCHAR(255),
    IN p_bookingId INT
)
BEGIN
    DECLARE isUserAuthorized BOOLEAN;
    DECLARE isBookingConfirmed BOOLEAN;
    DECLARE bookedSpots INT;
    DECLARE campsiteId INT;

    -- Check if the user is authorized to cancel the booking
    SELECT COUNT(*) INTO isUserAuthorized
    FROM booking
    WHERE user_Name = p_userName AND booking_Id = p_bookingId;

    IF isUserAuthorized = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: You are not authorized to cancel this booking';
    ELSE
        -- Get the campsiteId and bookedSpots associated with the booking
        SELECT campsiteId, number_of_Guests INTO campsiteId, bookedSpots
        FROM booking
        WHERE booking_Id = p_bookingId;

        -- Check if the booking is confirmed
        SELECT COUNT(*) INTO isBookingConfirmed
        FROM booking
        WHERE booking_Id = p_bookingId AND booking_Status = 'Confirmed';

        IF isBookingConfirmed = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: This booking is not confirmed and cannot be canceled';
        ELSE
            -- Cancel the booking
            UPDATE booking
            SET booking_Status = 'Cancelled'
            WHERE booking_Id = p_bookingId;

            -- Update available spots for the corresponding campsite
            UPDATE campsite
            SET spots_available = (SELECT spots_available + bookedSpots FROM (SELECT spots_available, campsiteId FROM campsite) AS c WHERE c.campsiteId = campsiteId)
            WHERE campsiteId = campsiteId;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckCampsiteAvailability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckCampsiteAvailability`(IN input_state VARCHAR(255), 
											IN input_guests INT)
BEGIN

    SELECT * FROM campsite
    WHERE state = input_state 
    AND spots_available >= input_guests;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteAmenities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAmenities`(
    IN p_adminUsername VARCHAR(255),
    IN p_amenityId INT
)
BEGIN
    DECLARE isAdmin INT;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM admin
    WHERE admin_username = p_adminUsername;

    IF isAdmin > 0 THEN
        -- Admin is authorized to perform the action
            -- Delete existing amenity
            DELETE FROM amenities
            WHERE amenity_Id = p_amenityId;

            #SELECT CONCAT('Amenity "', p_amenityName, '" deleted successfully.') AS Message;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User is not authorized to manage amenities.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCampsite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCampsite`(
    IN p_adminUsername VARCHAR(255),
    IN p_campsiteId INT
)
BEGIN
    DECLARE isAdmin INT;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM admin
    WHERE admin_username = p_adminUsername;

    IF isAdmin > 0 THEN
        -- Admin is authorized to perform the action
            -- Delete existing campsite
            DELETE FROM campsite
            WHERE campsiteId = p_campsiteId;


    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User is not authorized to delete campsite.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerateSupportTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateSupportTicket`(
    IN p_userName VARCHAR(255),
    IN p_issueType VARCHAR(255),
    IN p_issueDescription TEXT,
    OUT p_ticketId INT
)
BEGIN
    DECLARE userExists INT;

    -- Check if the user exists
    SELECT COUNT(*) INTO userExists
    FROM user
    WHERE user_Name = p_userName;

    -- If the user exists, generate a support ticket
    IF userExists > 0 THEN
        -- Generate a unique ticket ID
        SET p_ticketId = (SELECT COALESCE(MAX(ticket_ID), 0) + 1 FROM support_Ticket);

        -- Insert the support ticket
        INSERT INTO support_Ticket (ticket_ID, status, issue_Type, issue_Description, issue_Date, user_Name)
        VALUES (p_ticketId, 'Open', p_issueType, p_issueDescription, CURDATE(), p_userName);

        -- Print a message indicating successful ticket generation
        SELECT CONCAT('Support ticket ', p_ticketId, ' has been generated.') AS Message;
    ELSE
        -- Print an error message if the user does not exist
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User does not exist. Cannot generate support ticket.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ManageCampsites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ManageCampsites`(
    IN p_adminUsername VARCHAR(255),
    IN p_action VARCHAR(50), -- 'add' or 'delete'
    IN p_campsiteId INT, -- Provide for deletion, can be NULL for addition
    IN p_campsiteName VARCHAR(255),
    IN p_st_number INT,
    IN p_St_Name varchar(64),
    IN p_spotsAvailable INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_Zip int ,
    IN p_pricePerNight DECIMAL(10, 2)
)
BEGIN
    DECLARE isAdmin BOOLEAN;
    Declare lastCampsiteID int;

    -- Check if the user is an admin
    SELECT COUNT(*) INTO isAdmin
    FROM admin
    WHERE admin_Username = p_adminUsername;

    IF isAdmin = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: You do not have permission to manage campsites';
    ELSE
		-- get last campsite id
        select max(campsiteId) into lastcampsiteID from campsite;
        -- Perform action based on 'add' or 'delete'
        IF p_action = 'add' THEN
            -- Add new campsite
            INSERT INTO campsite (campsiteId, campsite_name, spots_available, street_name, street_number, city, state, zipcode, price_per_night)
            VALUES (lastcampsiteID + 1, p_campsiteName, p_spotsAvailable, p_st_Name ,p_St_number,p_city, p_state, p_Zip,  p_pricePerNight);

            SELECT LAST_INSERT_ID() AS new_campsite_id; -- Return the new campsite ID
        ELSEIF p_action = 'delete' THEN
            -- Delete existing campsite
            DELETE FROM campsite WHERE campsiteId = lastcampsiteID;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Invalid action. Use "add" or "delete"';
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ResolveSupportTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ResolveSupportTicket`(
    IN p_ticketId INT,
    IN p_resolution TEXT
)
BEGIN
    -- Check if the support ticket exists
    DECLARE ticketExists INT;

    SELECT COUNT(*) INTO ticketExists
    FROM support_Ticket
    WHERE ticket_ID = p_ticketId;

    IF ticketExists > 0 THEN
        -- Update the support ticket status and resolution
        UPDATE support_Ticket
        SET status = 'Resolved',
            resolution = p_resolution,
            resolution_Date = CURDATE()
        WHERE ticket_ID = p_ticketId;

        SELECT CONCAT('Support ticket ', p_ticketId, ' has been resolved.') AS Message;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Support ticket does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateBookingStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBookingStatus`(
    IN p_bookingId INT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE booking
    SET booking_status = p_status
    WHERE booking_id = p_bookingId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserProfile`(
    IN p_userName VARCHAR(255),
    IN p_newName VARCHAR(255),
    IN p_newEmail VARCHAR(255),
    IN p_newPhoneNumber VARCHAR(20)
)
BEGIN
    -- Check if the user exists
    IF NOT UsernameExists(p_userName) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: User does not exist';
    END IF;

    -- Update the user profile
    UPDATE user
    SET user_Name = p_newName,
        email = p_newEmail,
        phone = p_newPhoneNumber
    WHERE user_Name = p_userName;
END ;;
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

-- Dump completed on 2023-12-08 23:24:47
