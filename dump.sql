-- MariaDB dump 10.19  Distrib 10.4.22-MariaDB, for Linux (x86_64)
--
-- Host: p3nlmysql73plsk.secureserver.net    Database: studentapp
-- ------------------------------------------------------
-- Server version	5.5.51-38.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clubs` (
  `college_link` int(11) NOT NULL,
  `club_id` int(11) NOT NULL AUTO_INCREMENT,
  `club_name` varchar(100) NOT NULL,
  `club_description` text,
  `club_code` varchar(20) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `club_admin1` int(11) NOT NULL,
  `club_admin2` int(11) DEFAULT NULL,
  `latest_update_by` varchar(40) NOT NULL,
  PRIMARY KEY (`club_id`),
  UNIQUE KEY `club_id` (`club_id`),
  UNIQUE KEY `club_code` (`club_code`),
  KEY `clubs_fk0` (`college_link`),
  CONSTRAINT `clubs_fk0` FOREIGN KEY (`college_link`) REFERENCES `colleges` (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colleges`
--

DROP TABLE IF EXISTS `colleges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colleges` (
  `college_id` int(11) NOT NULL AUTO_INCREMENT,
  `college_name` varchar(60) NOT NULL,
  `about_college` text,
  `college_logo` varchar(255) DEFAULT NULL,
  `bigpicture_college` varchar(255) DEFAULT NULL,
  `college_admin_name` varchar(50) NOT NULL,
  `college_admin_password` varchar(50) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastedited_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latest_update_by` varchar(50) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE KEY `college_id` (`college_id`),
  UNIQUE KEY `college_name` (`college_name`),
  UNIQUE KEY `college_admin_name` (`college_admin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colleges`
--

LOCK TABLES `colleges` WRITE;
/*!40000 ALTER TABLE `colleges` DISABLE KEYS */;
INSERT INTO `colleges` VALUES (1,'Ramaiah Institute of Technology','RIT College',NULL,'https://firebasestorage.googleapis.com/v0/b/student-app-301bb.appspot.com/o/1?alt=media&token=b1cb71ef-f2bd-43a4-8829-0384c44a4ee5','rit@gmail.com','rit','2021-12-31 16:52:54','0000-00-00 00:00:00',''),(6,'BMS Institute of Technology','SHEESH.',NULL,'https://picsum.photos/200/300','jason@bmsit.com','jason','2021-10-24 15:28:53','0000-00-00 00:00:00',''),(8,'CMR Institute of Technology','CMRIT college ',NULL,'https://firebasestorage.googleapis.com/v0/b/student-app-301bb.appspot.com/o/8?alt=media&token=3c1e7e02-29c1-4fa4-a640-0c18f2c2ad60','admin@cmrit.com','','2021-10-26 17:22:56','0000-00-00 00:00:00',''),(10,'testing','test ',NULL,'https://firebasestorage.googleapis.com/v0/b/student-app-301bb.appspot.com/o/10?alt=media&token=1a6e4a1f-d825-424c-9a1a-dd47cefa6e02','testing@testing2.com','test','2021-10-26 17:41:01','0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `colleges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `college_link` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(50) NOT NULL,
  `office_help` text,
  `dept_admin_username` varchar(50) NOT NULL,
  `dept_admin_password` varchar(50) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastedited_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latest_update_by` varchar(50) NOT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `dept_id` (`dept_id`),
  KEY `departments_fk0` (`college_link`),
  CONSTRAINT `departments_fk0` FOREIGN KEY (`college_link`) REFERENCES `colleges` (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,'Information Science and Engineering','1111111111','iseadmin@gmail.com','password','2021-12-23 11:20:07','0000-00-00 00:00:00',''),(1,6,'Mechanical Engineering','9876543210','admin.mech@college.edu','passmechpass','2021-12-23 11:22:38','0000-00-00 00:00:00',''),(6,7,'Mechanical','9999999999','mech@bmsit.com','123456','2022-01-08 19:57:08','0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `dept_link` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `subject_note` varchar(50) DEFAULT NULL,
  `note_title` varchar(50) NOT NULL,
  `note_link` text NOT NULL,
  `created_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latest_update_by` varchar(50) NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `note_id` (`note_id`),
  KEY `notes_fk0` (`dept_link`),
  CONSTRAINT `notes_fk0` FOREIGN KEY (`dept_link`) REFERENCES `departments` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `dept_link` int(11) NOT NULL,
  `section_id` int(11) NOT NULL AUTO_INCREMENT,
  `section_name` varchar(50) NOT NULL,
  `section_batch_join` year(4) NOT NULL,
  `section_classcode` varchar(50) NOT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastedited_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latest_update_by` varchar(50) NOT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `section_id` (`section_id`),
  UNIQUE KEY `section_classcode` (`section_classcode`),
  KEY `sections_fk0` (`dept_link`),
  CONSTRAINT `sections_fk0` FOREIGN KEY (`dept_link`) REFERENCES `departments` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,3,'K update via flutter',2022,'KKKKKK','2021-12-31 20:02:26','0000-00-00 00:00:00',''),(1,4,'abcd',2000,'Sz4GC','2022-01-05 04:59:24','0000-00-00 00:00:00',''),(6,5,'mech section A',1999,'7NAcU','2022-01-05 07:16:24','0000-00-00 00:00:00',''),(1,6,'new update',2022,'L0pZV','2022-01-05 07:48:59','0000-00-00 00:00:00',''),(6,7,'mech section B',2021,'Dvftd','2022-01-05 07:52:38','0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_auth_table`
--

DROP TABLE IF EXISTS `student_auth_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_auth_table` (
  `id` varchar(50) NOT NULL,
  `student_name` varchar(64) NOT NULL,
  `student_email` varchar(50) NOT NULL,
  `student_password` varchar(50) NOT NULL,
  `student_phone_number` varchar(15) DEFAULT NULL,
  `auth_level` int(11) NOT NULL,
  `class_link` int(11) DEFAULT NULL,
  `clubs_joined` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `student_email` (`student_email`),
  KEY `FK_student_auth_table_sections` (`class_link`),
  CONSTRAINT `FK_student_auth_table_sections` FOREIGN KEY (`class_link`) REFERENCES `sections` (`section_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_auth_table`
--

LOCK TABLES `student_auth_table` WRITE;
/*!40000 ALTER TABLE `student_auth_table` DISABLE KEYS */;
INSERT INTO `student_auth_table` VALUES ('1MS19CS044','hh','abcd@gmail.com','password',NULL,0,4,NULL),('1MS19CS049','hariharan R','r.hariharan54@gmail.com','pass',NULL,0,4,NULL),('1MS19IS00','TesterOne','hellotester@gmail.com','password',NULL,0,4,NULL),('1MS20CS001','hhpostman','haran050403@gmail.com','abcd1234',NULL,0,5,NULL),('1MS20CS002','hhpostman','haran0504032@gmail.com','abcd1234',NULL,0,5,NULL),('1MS20CS003','hhpostman','haran05040325@gmail.com','abcd1234',NULL,0,5,NULL);
/*!40000 ALTER TABLE `student_auth_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `section_link` int(11) NOT NULL,
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(50) NOT NULL,
  `task_description` text,
  `task_deadline` datetime DEFAULT NULL,
  `create_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastedited_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `latest_update_by` varchar(50) NOT NULL,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `tasks_fk0` (`section_link`),
  CONSTRAINT `tasks_fk0` FOREIGN KEY (`section_link`) REFERENCES `sections` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (5,1,'Assignment submission-20 mark component','Submit asap ','2022-02-04 00:29:21','2022-01-30 18:59:31','0000-00-00 00:00:00',''),(5,2,'Prepare for presentation ','SE presentation','2022-02-01 00:30:14','2022-01-30 19:00:16','0000-00-00 00:00:00',''),(4,3,'Do MathPlotLib project','Complete as per instuctions given','2022-02-08 00:31:14','2022-01-30 19:01:18','0000-00-00 00:00:00',''),(4,4,'abcd','1234','2022-02-02 00:00:00','2022-01-31 19:19:29','0000-00-00 00:00:00',''),(5,5,'postman','installpostman','2022-04-05 00:00:00','2022-01-31 19:36:36','0000-00-00 00:00:00',''),(5,6,'postman','installpostman','2022-04-05 00:00:00','2022-02-01 15:25:56','0000-00-00 00:00:00',''),(4,7,'insert flutter','task flutter','2022-04-05 00:00:00','2022-02-01 15:53:50','0000-00-00 00:00:00',''),(4,8,'insert and view','testing','2022-02-25 00:00:00','2022-02-05 20:01:14','0000-00-00 00:00:00',''),(4,9,'insert and view','testing','2022-02-25 00:00:00','2022-02-05 20:05:29','0000-00-00 00:00:00',''),(4,10,'another new task','checking again ','2022-02-17 00:00:00','2022-02-12 13:58:06','0000-00-00 00:00:00',''),(4,11,'quick tedt','task 007','2022-02-24 00:00:00','2022-02-12 17:18:19','0000-00-00 00:00:00',''),(4,12,'test8','testing','2022-03-17 00:00:00','2022-02-16 16:47:56','0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-28 14:21:44
