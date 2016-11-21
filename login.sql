/*
SQLyog Community v8.4 RC2
MySQL - 5.5.46-0ubuntu0.12.04.2 : Database - temp_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cmp` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cmp`;

/*Table structure for table `login_details` */

DROP TABLE IF EXISTS `login_details`;

CREATE TABLE login_details (
  login_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  user_name varchar(255) NOT NULL,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  login_user_pass varchar(255) NOT NULL,
  login_created_time datetime DEFAULT NULL,
  PRIMARY KEY (login_id)
);

/*Data for the table `login_details` */

insert  into login_details(login_id,user_name,first_name,last_name,login_user_pass,login_created_time) values (1,'ashwin.murthy1@wipro.com','ashwin','murthy','coeadmin','2015-11-22 13:44:25');
insert  into login_details(login_id,user_name,first_name,last_name,login_user_pass,login_created_time) values (2,'pravash.choubey@wipro.com','pravash','choubey','coeadmin','2015-11-22 13:44:25');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
