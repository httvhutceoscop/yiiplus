/*
SQLyog Enterprise - MySQL GUI v8.05 
MySQL - 5.5.5-10.1.10-MariaDB : Database - yiiplus
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`yiiplus` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `yiiplus`;

/*Table structure for table `auth_assignment` */

DROP TABLE IF EXISTS `auth_assignment`;

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_assignment` */

insert  into `auth_assignment`(`item_name`,`user_id`,`created_at`) values ('admin',1,NULL),('admin',3,NULL),('admin',6,NULL),('create-branch',2,NULL),('create-branch',6,NULL);

/*Table structure for table `auth_item` */

DROP TABLE IF EXISTS `auth_item`;

CREATE TABLE `auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `rule_name` varchar(64) DEFAULT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_item` */

insert  into `auth_item`(`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) values ('admin',1,'admin can create branches and companies',NULL,NULL,NULL,NULL),('create-branch',1,'allow a user to add a branch',NULL,NULL,NULL,NULL),('create-company',1,'allow user to create a company',NULL,NULL,NULL,NULL);

/*Table structure for table `auth_item_child` */

DROP TABLE IF EXISTS `auth_item_child`;

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_item_child` */

insert  into `auth_item_child`(`parent`,`child`) values ('admin','create-branch'),('admin','create-company');

/*Table structure for table `auth_rule` */

DROP TABLE IF EXISTS `auth_rule`;

CREATE TABLE `auth_rule` (
  `name` varchar(64) NOT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_rule` */

/*Table structure for table `branches` */

DROP TABLE IF EXISTS `branches`;

CREATE TABLE `branches` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `companies_company_id` int(11) DEFAULT NULL,
  `branch_name` varchar(100) DEFAULT NULL,
  `branch_address` varchar(255) DEFAULT NULL,
  `branch_created_date` datetime DEFAULT NULL,
  `branch_status` enum('active','inactive') DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `companies_company_id` (`companies_company_id`),
  CONSTRAINT `branches_ibfk_1` FOREIGN KEY (`companies_company_id`) REFERENCES `companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `branches` */

insert  into `branches`(`branch_id`,`companies_company_id`,`branch_name`,`branch_address`,`branch_created_date`,`branch_status`) values (1,2,'main branch','366 doi can','2016-07-20 06:33:05','active'),(3,2,'lan va diep','chan cau 222222','2016-07-20 09:02:28','active'),(4,3,'TIMER','44 timer','2016-07-20 09:18:38','active'),(5,3,'San Pham Loi','trunghoa nhan chinh','2016-08-17 10:37:22','active');

/*Table structure for table `companies` */

DROP TABLE IF EXISTS `companies`;

CREATE TABLE `companies` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) DEFAULT NULL,
  `company_email` varchar(100) DEFAULT NULL,
  `company_address` varchar(255) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `company_start_date` date DEFAULT NULL,
  `company_created_date` datetime DEFAULT NULL,
  `company_status` enum('active','inactive') DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `companies` */

insert  into `companies`(`company_id`,`company_name`,`company_email`,`company_address`,`logo`,`company_start_date`,`company_created_date`,`company_status`) values (2,'ABC','abc@gmail.com','266 doi can',NULL,NULL,'2016-07-20 06:22:37','active'),(3,'toialmit','toilamit@gmail.com','Ha Noi',NULL,NULL,'2016-07-20 09:17:47','active'),(4,'ALH','ALH@gmail.com','HILA',NULL,'2016-11-29','2016-11-29 00:00:00','active'),(5,'HuUHoa','huuhoa@gmail.com','44 Tran Khat Chan','uploads/HuUHoa.jpg',NULL,'2016-07-21 03:43:41','active');

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customers` */

/*Table structure for table `departments` */

DROP TABLE IF EXISTS `departments`;

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `branches_branch_id` int(11) NOT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  `companies_company_id` int(11) NOT NULL,
  `department_created_date` datetime DEFAULT NULL,
  `department_satus` enum('active','inactive') DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `branches_branch_id` (`branches_branch_id`),
  KEY `companies_company_id` (`companies_company_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`companies_company_id`) REFERENCES `companies` (`company_id`),
  CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`branches_branch_id`) REFERENCES `branches` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `departments` */

insert  into `departments`(`department_id`,`branches_branch_id`,`department_name`,`companies_company_id`,`department_created_date`,`department_satus`) values (1,1,'hhhh',2,'2016-07-20 06:48:21','active');

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `zip_code` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `locations` */

insert  into `locations`(`location_id`,`zip_code`,`city`,`province`) values (1,'1111','Colombo','Weston'),(2,'2222','Galle','Southern');

/*Table structure for table `migration` */

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `migration` */

insert  into `migration`(`version`,`apply_time`) values ('m000000_000000_base',1465533934),('m130524_201442_init',1465533951);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`last_name`,`first_name`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`email`,`status`,`created_at`,`updated_at`) values (1,NULL,NULL,'admin','ZtQOqj6xgJtgRyxZy554Nv_uO9qQAYa8','$2y$13$Z24HSeSkWgB359yHIOa0eO/rohO.JN9Jd/Wm7K9rsMTzFNq9jvvUa','UIMQpC-KSOXOMYp2wqyeLmiyqLA9wHRJ_1465540941','nguyen.tien.viet@miyatsu.vn',10,1465540817,1465540941),(2,NULL,NULL,'httv','6qkXU3UX8jcEbaptC4MZYEXvQCPeOmCk','$2y$13$RLN55icqDppWmIR/fTNcIeard5JG9CbyG0bWJbhX221DA9pq1ObtC',NULL,'2nguyen.tien.viet@miyatsu.vn',10,1468981815,1468981815),(3,'Nguyen','Viet','aaa','6BfGdzJGOiHQatyPq8e_7E1CETrTRzWr','$2y$13$TKNPoZmvvy5UC56/xorHu.SQVcgfRLPCBoePeTlggXWR.8vEWr5LG',NULL,'nguyen.tien.viet@miyatsu.vn1',10,1468982771,1468982771),(4,'AnyName','Somename','sam','3LPJg5EajgbmgjJJaFPoR4_DnWl-yNYC','$2y$13$8JzVdj5W5/6WellzOUDDC.AcCq7ab3d53cVBYgyJcLJoIbkD.XOA.',NULL,'winston@travelprologue.com',10,1471574035,1471574035),(5,'Lao','Cuba','tabao','ACUwE7JEjiKslIxRNWH2wiNrn1xq8_cW','$2y$13$tuZLa9X8Ltbos/6sa9Hh/.T2yNdq2VIs12WDILI7atSRIXEsXR/Me',NULL,'winston@travelprologue.com1',10,1471574231,1471574231),(6,'sdfsdf','sdfsdf','dssdf','eb1ytkAVf1Ag06nhDKB0TwcYTUZqNpV8','$2y$13$dd8mc8rRoi/GDBzvK1rkGO7ccgmti5XGuN4ZRBI/aQR5qH06sdXza',NULL,'winsdfston@travelprologue.com',10,1471574831,1471574831);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
