-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2023 at 12:07 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schoolecommerce1`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDeliveryOrder` (IN `p_delivery_personnel_ID` INT, IN `p_order_ID` INT, IN `p_est_delivery_date` DATE, IN `p_delivery_status` BOOLEAN, IN `p_courier_ID_id` INT, IN `p_date_delivered` DATE)   BEGIN
    INSERT INTO deliverypersonnel_courierorderdp (
        est_delivery_date,
        date_delivered,
        delivery_status,
        delivery_personnel_ID_id,
        order_ID_id
        
    ) VALUES (
        p_est_delivery_date,
        p_date_delivered,
        p_delivery_status,
        p_delivery_personnel_ID,
        p_order_ID      
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkcredentialsD` (IN `p_username` VARCHAR(200), IN `p_password` VARCHAR(200))   BEGIN
	DECLARE counter INT;
    SELECT 
            COUNT(*) INTO counter 
        from 
            deliverypersonnel_deliverypersonnel dp
        WHERE 
            dp.username = p_username 
        AND 
            dp.password = p_password;

        IF counter > 0 THEN
            SELECT 'login successful' as message;
        ELSE
            SELECT 'Incorrect username or password' as message;
        END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkcredentialsT` (IN `p_username` VARCHAR(200), IN `p_password` VARCHAR(200))   BEGIN
        DECLARE counter INT;

        SELECT 
            COUNT(*) INTO counter 
        from 
            deliverypersonnel_courier dc 
        WHERE 
            dc.username = p_username 
        AND 
            dc.password = p_password;

        IF counter > 0 THEN
            SELECT 'login successful' as message;
        ELSE
            SELECT 'Incorrect username or password' as message;
        END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDeliveryPersonnel` ()   BEGIN
	SELECT delivery_personnel_ID, name, contact_number, email, address
    FROM deliverypersonnel_deliverypersonnel;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourierName` (IN `sessionUsername` VARCHAR(255), OUT `resultName` VARCHAR(255))   BEGIN
    SELECT `name` INTO resultName
    FROM `deliverypersonnel_courier`
    WHERE `username` = sessionUsername;

    -- You can add additional logic or error handling here if needed.
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDeliveryOrders` (IN `p_delivery_personnel_id` INT)   BEGIN
    SELECT order_ID_id, est_delivery_date, date_delivered, delivery_status 
    FROM deliverypersonnel_courierorderdp
    WHERE delivery_personnel_ID_id = p_delivery_personnel_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDeliveryPersonnelID` (IN `p_username` VARCHAR(200))   BEGIN

SELECT delivery_personnel_ID
    FROM deliverypersonnel_deliverypersonnel
    WHERE username = p_username;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registerD` (IN `p_username` VARCHAR(200), IN `p_password` VARCHAR(200), IN `p_name` VARCHAR(200), IN `p_address` VARCHAR(200), IN `p_email` VARCHAR(200), IN `p_contactnumber` INT)   BEGIN
	DECLARE username_count INT;

    SELECT COUNT(*) INTO username_count FROM deliverypersonnel_deliverypersonnel WHERE username = p_username;

    IF username_count > 0 THEN
        SELECT 'Duplicate Username' AS message;
    ELSE
        INSERT INTO deliverypersonnel_deliverypersonnel (
            username, password, name, address, email, contact_number,
            person_type
        ) VALUES (
            p_username, p_password, p_name, p_address, p_email,
            p_contact_number, p_person_type
        );
		SELECT 'Success' AS message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registerT` (IN `p_username` VARCHAR(200), IN `p_password` VARCHAR(200), IN `p_name` VARCHAR(200), IN `p_address` VARCHAR(200), IN `p_email` VARCHAR(200), IN `p_contactnumber` INT)   BEGIN
	DECLARE username_count INT;

    SELECT COUNT(*) INTO username_count FROM deliverypersonnel_courier WHERE username = p_username;

    IF username_count > 0 THEN
        SELECT 'Duplicate Username' AS message;
    ELSE
        INSERT INTO deliverypersonnel_courier (
            username, password, name, address, email, contact_number,
            person_type
        ) VALUES (
            p_username, p_password, p_name, p_address, p_email,
            p_contact_number, p_person_type
        );
		SELECT 'Success' AS message;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDeliveryStatus` (IN `p_order_id` INT(200), IN `p_new_status` BOOLEAN, IN `p_date_delivered` DATE)   BEGIN
    UPDATE deliverypersonnel_courierorderdp
    SET delivery_status = p_new_status,
        date_delivered = p_date_delivered
    WHERE order_ID_id = p_order_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add customer', 7, 'add_customer'),
(26, 'Can change customer', 7, 'change_customer'),
(27, 'Can delete customer', 7, 'delete_customer'),
(28, 'Can view customer', 7, 'view_customer'),
(29, 'Can add cart', 8, 'add_cart'),
(30, 'Can change cart', 8, 'change_cart'),
(31, 'Can delete cart', 8, 'delete_cart'),
(32, 'Can view cart', 8, 'view_cart'),
(33, 'Can add checkout', 9, 'add_checkout'),
(34, 'Can change checkout', 9, 'change_checkout'),
(35, 'Can delete checkout', 9, 'delete_checkout'),
(36, 'Can view checkout', 9, 'view_checkout'),
(37, 'Can add order', 10, 'add_order'),
(38, 'Can change order', 10, 'change_order'),
(39, 'Can delete order', 10, 'delete_order'),
(40, 'Can view order', 10, 'view_order'),
(41, 'Can add order status', 11, 'add_orderstatus'),
(42, 'Can change order status', 11, 'change_orderstatus'),
(43, 'Can delete order status', 11, 'delete_orderstatus'),
(44, 'Can view order status', 11, 'view_orderstatus'),
(45, 'Can add approve merchant', 12, 'add_approvemerchant'),
(46, 'Can change approve merchant', 12, 'change_approvemerchant'),
(47, 'Can delete approve merchant', 12, 'delete_approvemerchant'),
(48, 'Can view approve merchant', 12, 'view_approvemerchant'),
(49, 'Can add school admin', 13, 'add_schooladmin'),
(50, 'Can change school admin', 13, 'change_schooladmin'),
(51, 'Can delete school admin', 13, 'delete_schooladmin'),
(52, 'Can view school admin', 13, 'view_schooladmin'),
(53, 'Can add transactions', 14, 'add_transactions'),
(54, 'Can change transactions', 14, 'change_transactions'),
(55, 'Can delete transactions', 14, 'delete_transactions'),
(56, 'Can view transactions', 14, 'view_transactions'),
(57, 'Can add product', 15, 'add_product'),
(58, 'Can change product', 15, 'change_product'),
(59, 'Can delete product', 15, 'delete_product'),
(60, 'Can view product', 15, 'view_product'),
(61, 'Can add product review', 16, 'add_productreview'),
(62, 'Can change product review', 16, 'change_productreview'),
(63, 'Can delete product review', 16, 'delete_productreview'),
(64, 'Can view product review', 16, 'view_productreview'),
(65, 'Can add merchant', 17, 'add_merchant'),
(66, 'Can change merchant', 17, 'change_merchant'),
(67, 'Can delete merchant', 17, 'delete_merchant'),
(68, 'Can view merchant', 17, 'view_merchant'),
(69, 'Can add courier', 18, 'add_courier'),
(70, 'Can change courier', 18, 'change_courier'),
(71, 'Can delete courier', 18, 'delete_courier'),
(72, 'Can view courier', 18, 'view_courier'),
(73, 'Can add delivery personnel', 19, 'add_deliverypersonnel'),
(74, 'Can change delivery personnel', 19, 'change_deliverypersonnel'),
(75, 'Can delete delivery personnel', 19, 'delete_deliverypersonnel'),
(76, 'Can view delivery personnel', 19, 'view_deliverypersonnel'),
(77, 'Can add courier order dp', 20, 'add_courierorderdp'),
(78, 'Can change courier order dp', 20, 'change_courierorderdp'),
(79, 'Can delete courier order dp', 20, 'delete_courierorderdp'),
(80, 'Can view courier order dp', 20, 'view_courierorderdp');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$3HrHsMTrnaT3hAagBJCmkR$KQgbzaldq3MgMMK6VIAgDswEqhc4DRxVF4155zerc40=', '2023-12-28 22:57:47.256425', 1, 'admin', '', '', 'a@gmail.com', 1, 1, '2023-12-28 22:50:26.684725');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_cart`
--

CREATE TABLE `cart_cart` (
  `cart_ID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `subtotal` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_cart`
--

INSERT INTO `cart_cart` (`cart_ID`, `quantity`, `price`, `subtotal`, `customer_id`, `product_id`) VALUES
(1, 2, 15, 30, 4, 4),
(2, 1, 45, 45, 2, 1),
(3, 2, 45, 90, 2, 2),
(4, 1, 10, 10, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cart_checkout`
--

CREATE TABLE `cart_checkout` (
  `checkout_ID` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `receive_by_date` date NOT NULL,
  `order_date` date NOT NULL,
  `confirm_order` tinyint(1) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_checkout`
--

INSERT INTO `cart_checkout` (`checkout_ID`, `total_amount`, `payment_method`, `receive_by_date`, `order_date`, `confirm_order`, `cart_id`, `customer_id`, `product_id`) VALUES
(1, 15, 'GCash', '2024-01-04', '2023-12-25', 1, 1, 4, 4),
(2, 45, 'GCash', '2024-01-05', '2023-12-23', 1, 2, 2, 1),
(3, 90, 'CoD', '2024-01-06', '2023-12-22', 1, 3, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `cart_order`
--

CREATE TABLE `cart_order` (
  `order_ID` int(11) NOT NULL,
  `checkout_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_orderstatus`
--

CREATE TABLE `cart_orderstatus` (
  `order_status_ID` bigint(20) NOT NULL,
  `order_status_change` datetime(6) NOT NULL,
  `order_status` varchar(30) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_customer`
--

CREATE TABLE `customer_customer` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `person_type` varchar(1) NOT NULL,
  `customer_ID` int(11) NOT NULL,
  `customer_wallet` double NOT NULL,
  `school_admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_customer`
--

INSERT INTO `customer_customer` (`username`, `password`, `name`, `contact_number`, `email`, `address`, `person_type`, `customer_ID`, `customer_wallet`, `school_admin_id`) VALUES
('hermi', 'hermi', 'Herminigildo Timtim', '245-5896', 'timtim@gmail.com', 'Dumanjug, Cebu', 'C', 1, 3000, 1),
('idul', 'idul', 'John Idul', '569-8954', 'idul@gmail.com', 'Yati, Liloan', 'C', 2, 5000, 1),
('rai', 'rai', 'Rai Cenas', '465-6542', 'rai@gmail.com', 'Lapu-lapu City, Cebu', 'C', 4, 6000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer_customer_transaction_history`
--

CREATE TABLE `customer_customer_transaction_history` (
  `id` bigint(20) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `transactions_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliverypersonnel_courier`
--

CREATE TABLE `deliverypersonnel_courier` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `person_type` varchar(1) NOT NULL,
  `courier_ID` bigint(20) NOT NULL,
  `commission` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliverypersonnel_courier`
--

INSERT INTO `deliverypersonnel_courier` (`username`, `password`, `name`, `contact_number`, `email`, `address`, `person_type`, `courier_ID`, `commission`) VALUES
('bit', 'bit', 'Bit Express', '09123456789', 'bitexpress@gmail.com', 'N. Bacalso Ave., Cebu City', 'T', 1, 0),
('micro', 'micro', 'Micro Fuentes', '09123456789', 'micro@gmail.com', 'Inayawan, Cebu City', 'T', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `deliverypersonnel_courierorderdp`
--

CREATE TABLE `deliverypersonnel_courierorderdp` (
  `id` bigint(20) NOT NULL,
  `est_delivery_date` date NOT NULL,
  `date_delivered` date DEFAULT NULL,
  `delivery_status` int(11) NOT NULL,
  `delivery_personnel_ID_id` bigint(20) NOT NULL,
  `order_ID_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliverypersonnel_courierorderdp`
--

INSERT INTO `deliverypersonnel_courierorderdp` (`id`, `est_delivery_date`, `date_delivered`, `delivery_status`, `delivery_personnel_ID_id`, `order_ID_id`) VALUES
(1, '2023-12-28', '2023-12-30', 1, 1, 1),
(2, '2023-12-28', '2023-12-29', 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `deliverypersonnel_courierorderdp_courier_id`
--

CREATE TABLE `deliverypersonnel_courierorderdp_courier_id` (
  `id` bigint(20) NOT NULL,
  `courierorderdp_id` bigint(20) NOT NULL,
  `courier_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliverypersonnel_courierorderdp_courier_id`
--

INSERT INTO `deliverypersonnel_courierorderdp_courier_id` (`id`, `courierorderdp_id`, `courier_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `deliverypersonnel_deliverypersonnel`
--

CREATE TABLE `deliverypersonnel_deliverypersonnel` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `person_type` varchar(1) NOT NULL,
  `delivery_personnel_ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliverypersonnel_deliverypersonnel`
--

INSERT INTO `deliverypersonnel_deliverypersonnel` (`username`, `password`, `name`, `contact_number`, `email`, `address`, `person_type`, `delivery_personnel_ID`) VALUES
('hark', 'hark', 'Hark Noel', '548-4789', 'hark@gmail.com', 'Talisay City, Cebu', 'D', 1),
('herald', 'herald', 'Herald Noel', '798-6689', 'herald@gmailcom', 'Talisay City, Cebu', 'D', 2);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-12-28 22:58:02.444681', '1', '1', 1, '[{\"added\": {}}]', 20, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(8, 'Cart', 'cart'),
(9, 'Cart', 'checkout'),
(10, 'Cart', 'order'),
(11, 'Cart', 'orderstatus'),
(5, 'contenttypes', 'contenttype'),
(7, 'Customer', 'customer'),
(18, 'DeliveryPersonnel', 'courier'),
(20, 'DeliveryPersonnel', 'courierorderdp'),
(19, 'DeliveryPersonnel', 'deliverypersonnel'),
(17, 'Merchant', 'merchant'),
(15, 'Product', 'product'),
(16, 'Product', 'productreview'),
(12, 'SchoolAdmin', 'approvemerchant'),
(13, 'SchoolAdmin', 'schooladmin'),
(6, 'sessions', 'session'),
(14, 'Transaction', 'transactions');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'Merchant', '0001_initial', '2023-12-28 22:49:46.915225'),
(2, 'SchoolAdmin', '0001_initial', '2023-12-28 22:49:46.944244'),
(3, 'Customer', '0001_initial', '2023-12-28 22:49:47.019788'),
(4, 'Cart', '0001_initial', '2023-12-28 22:49:47.172758'),
(5, 'Cart', '0002_initial', '2023-12-28 22:49:47.218820'),
(6, 'Product', '0001_initial', '2023-12-28 22:49:47.396506'),
(7, 'Cart', '0003_initial', '2023-12-28 22:49:47.520535'),
(8, 'Cart', '0004_alter_checkout_order_date_and_more', '2023-12-28 22:49:47.530525'),
(9, 'Cart', '0005_alter_checkout_order_date_and_more', '2023-12-28 22:49:47.540524'),
(10, 'Cart', '0006_alter_checkout_order_date_and_more', '2023-12-28 22:49:47.551546'),
(11, 'Cart', '0007_alter_checkout_order_date_and_more', '2023-12-28 22:49:47.563152'),
(12, 'Transaction', '0001_initial', '2023-12-28 22:49:47.656274'),
(13, 'Customer', '0002_initial', '2023-12-28 22:49:47.769077'),
(14, 'DeliveryPersonnel', '0001_initial', '2023-12-28 22:49:47.984528'),
(15, 'Merchant', '0002_initial', '2023-12-28 22:49:48.102076'),
(16, 'Product', '0002_alter_productreview_review_date', '2023-12-28 22:49:48.111096'),
(17, 'Product', '0003_alter_productreview_review_date', '2023-12-28 22:49:48.119175'),
(18, 'Product', '0004_alter_productreview_review_date', '2023-12-28 22:49:48.131178'),
(19, 'Product', '0005_alter_productreview_review_date', '2023-12-28 22:49:48.141176'),
(20, 'Transaction', '0002_alter_transactions_transaction_date', '2023-12-28 22:49:48.156203'),
(21, 'Transaction', '0003_alter_transactions_transaction_date', '2023-12-28 22:49:48.166286'),
(22, 'Transaction', '0004_alter_transactions_transaction_date', '2023-12-28 22:49:48.175285'),
(23, 'Transaction', '0005_alter_transactions_transaction_date', '2023-12-28 22:49:48.189293'),
(24, 'contenttypes', '0001_initial', '2023-12-28 22:49:48.220277'),
(25, 'auth', '0001_initial', '2023-12-28 22:49:48.579571'),
(26, 'admin', '0001_initial', '2023-12-28 22:49:48.668453'),
(27, 'admin', '0002_logentry_remove_auto_add', '2023-12-28 22:49:48.676452'),
(28, 'admin', '0003_logentry_add_action_flag_choices', '2023-12-28 22:49:48.682531'),
(29, 'contenttypes', '0002_remove_content_type_name', '2023-12-28 22:49:48.750516'),
(30, 'auth', '0002_alter_permission_name_max_length', '2023-12-28 22:49:48.794167'),
(31, 'auth', '0003_alter_user_email_max_length', '2023-12-28 22:49:48.809174'),
(32, 'auth', '0004_alter_user_username_opts', '2023-12-28 22:49:48.819155'),
(33, 'auth', '0005_alter_user_last_login_null', '2023-12-28 22:49:48.856172'),
(34, 'auth', '0006_require_contenttypes_0002', '2023-12-28 22:49:48.860730'),
(35, 'auth', '0007_alter_validators_add_error_messages', '2023-12-28 22:49:48.867712'),
(36, 'auth', '0008_alter_user_username_max_length', '2023-12-28 22:49:48.880761'),
(37, 'auth', '0009_alter_user_last_name_max_length', '2023-12-28 22:49:48.894781'),
(38, 'auth', '0010_alter_group_name_max_length', '2023-12-28 22:49:48.936917'),
(39, 'auth', '0011_update_proxy_permissions', '2023-12-28 22:49:48.952035'),
(40, 'auth', '0012_alter_user_first_name_max_length', '2023-12-28 22:49:48.967624'),
(41, 'sessions', '0001_initial', '2023-12-28 22:49:48.998615'),
(42, 'Cart', '0008_alter_checkout_order_date_and_more', '2023-12-28 22:49:56.249971'),
(43, 'Product', '0006_alter_productreview_review_date', '2023-12-28 22:49:56.286523'),
(44, 'Transaction', '0006_alter_transactions_transaction_date', '2023-12-28 22:49:56.332523'),
(45, 'Cart', '0009_alter_checkout_order_date_and_more', '2023-12-28 22:50:03.060867'),
(46, 'Product', '0007_alter_productreview_review_date', '2023-12-28 22:50:03.070939'),
(47, 'Transaction', '0007_alter_transactions_transaction_date', '2023-12-28 22:50:03.085491'),
(48, 'Cart', '0010_alter_checkout_order_date_and_more', '2023-12-28 22:50:09.288270'),
(49, 'Product', '0008_alter_productreview_review_date', '2023-12-28 22:50:09.300825'),
(50, 'Transaction', '0008_alter_transactions_transaction_date', '2023-12-28 22:50:09.311818'),
(51, 'Cart', '0011_alter_checkout_order_date_and_more', '2023-12-28 22:54:40.921375'),
(52, 'Product', '0009_alter_productreview_review_date', '2023-12-28 22:54:40.932544'),
(53, 'Transaction', '0009_alter_transactions_transaction_date', '2023-12-28 22:54:40.944578'),
(54, 'Cart', '0012_alter_checkout_order_date_and_more', '2023-12-28 22:54:52.993598'),
(55, 'Product', '0010_alter_productreview_review_date', '2023-12-28 22:54:53.004739'),
(56, 'Transaction', '0010_alter_transactions_transaction_date', '2023-12-28 22:54:53.018293'),
(57, 'Cart', '0013_alter_checkout_order_date_and_more', '2023-12-28 22:54:59.290598'),
(58, 'Product', '0011_alter_productreview_review_date', '2023-12-28 22:54:59.302640'),
(59, 'Transaction', '0011_alter_transactions_transaction_date', '2023-12-28 22:54:59.314633'),
(60, 'Cart', '0014_alter_checkout_order_date_and_more', '2023-12-28 22:55:12.770136'),
(61, 'Product', '0012_alter_productreview_review_date', '2023-12-28 22:55:12.782138'),
(62, 'Transaction', '0012_alter_transactions_transaction_date', '2023-12-28 22:55:12.796193'),
(63, 'Cart', '0015_alter_checkout_order_date_and_more', '2023-12-28 22:55:21.185652'),
(64, 'Product', '0013_alter_productreview_review_date', '2023-12-28 22:55:21.195639'),
(65, 'Transaction', '0013_alter_transactions_transaction_date', '2023-12-28 22:55:21.208641'),
(66, 'Cart', '0016_alter_checkout_order_date_and_more', '2023-12-28 22:55:27.641895'),
(67, 'Product', '0014_alter_productreview_review_date', '2023-12-28 22:55:27.675441'),
(68, 'Transaction', '0014_alter_transactions_transaction_date', '2023-12-28 22:55:27.702449');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('mlgrnta4t903k224ovcdbxhqttlga5tm', '.eJxVjMsOgyAQRf-FdUNAXtpl936DmYGhWFtIRFdN_72SuHF7zrn3y_ZKa4YPsTtLsC7sxibYtzQ1Ps3hwPLKEPxCuYnwgvws3Je8rTPylvDTVj6WQO_H2V4OEtR0rHtLzvbRq864aKMDaTEaGQNgEOCUHrRwSNaJriNDUislBUjoLfqBjGa_PxsePZY:1rIzPO:UIcLgpRlDfJcAWzDGrixDVZBnkj0sRzyHqPsW1bPGy4', '2024-01-11 23:03:22.505052');

-- --------------------------------------------------------

--
-- Table structure for table `merchant_merchant`
--

CREATE TABLE `merchant_merchant` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `merchant_ID` bigint(20) NOT NULL,
  `store_name` varchar(200) NOT NULL,
  `verification_status` tinyint(1) NOT NULL,
  `merchant_wallet` double NOT NULL,
  `person_type` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `merchant_merchant`
--

INSERT INTO `merchant_merchant` (`username`, `password`, `name`, `contact_number`, `email`, `address`, `merchant_ID`, `store_name`, `verification_status`, `merchant_wallet`, `person_type`) VALUES
('mor', 'mor', 'Mor Tamayo', '548-8754', 'mor@gmail.com', 'Masbate, Philippines', 1, 'Mor\'s Store', 1, 15000, 'M'),
('dom', 'dom', 'Dominic Canete', '698-9748', 'dominic@gmail.com', 'Toledo City, Cebu', 2, 'Dominic\'s Store', 1, 6000, 'M');

-- --------------------------------------------------------

--
-- Table structure for table `merchant_merchant_transaction_history`
--

CREATE TABLE `merchant_merchant_transaction_history` (
  `id` bigint(20) NOT NULL,
  `merchant_id` bigint(20) NOT NULL,
  `transactions_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_product`
--

CREATE TABLE `product_product` (
  `product_ID` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_details` longtext NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `product_availability` tinyint(1) NOT NULL,
  `product_stock` int(11) NOT NULL,
  `merchant_ID_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_product`
--

INSERT INTO `product_product` (`product_ID`, `product_name`, `product_details`, `product_price`, `product_availability`, `product_stock`, `merchant_ID_id`) VALUES
(1, 'Sprite', 'Spride Softdrink', 45.00, 1, 5, 2),
(2, 'Coke', 'Coca cola', 50.00, 1, 5, 2),
(3, 'Milo', 'Beat energy gap', 10.00, 1, 10, 1),
(4, 'Bear Brand', 'Laki sa gatas', 15.00, 1, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_productreview`
--

CREATE TABLE `product_productreview` (
  `product_review_ID` int(11) NOT NULL,
  `product_Rating` int(11) NOT NULL,
  `review` varchar(1000) NOT NULL,
  `review_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schooladmin_approvemerchant`
--

CREATE TABLE `schooladmin_approvemerchant` (
  `id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schooladmin_schooladmin`
--

CREATE TABLE `schooladmin_schooladmin` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `person_type` varchar(1) NOT NULL,
  `school_admin` int(11) NOT NULL,
  `school_name` varchar(200) NOT NULL,
  `school_address` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schooladmin_schooladmin`
--

INSERT INTO `schooladmin_schooladmin` (`username`, `password`, `name`, `contact_number`, `email`, `address`, `person_type`, `school_admin`, `school_name`, `school_address`) VALUES
('ramos', 'ramos', 'Ramos University', '0923564897', 'ramos@gmail.com', 'Ramos St., Spain', 'A', 1, 'Ramos University', 'Ramos St., Spain');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_transactions`
--

CREATE TABLE `transaction_transactions` (
  `transaction_ID` int(11) NOT NULL,
  `transaction_type` varchar(1) NOT NULL,
  `amount` double NOT NULL,
  `transaction_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `merchant_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `cart_cart`
--
ALTER TABLE `cart_cart`
  ADD PRIMARY KEY (`cart_ID`),
  ADD KEY `Cart_cart_customer_id_46f86f26_fk_Customer_customer_customer_ID` (`customer_id`),
  ADD KEY `Cart_cart_product_id_dbc15da8_fk_Product_product_product_ID` (`product_id`);

--
-- Indexes for table `cart_checkout`
--
ALTER TABLE `cart_checkout`
  ADD PRIMARY KEY (`checkout_ID`),
  ADD KEY `Cart_checkout_cart_id_7ad8dadb_fk_Cart_cart_cart_ID` (`cart_id`),
  ADD KEY `Cart_checkout_customer_id_c5ac812f_fk_Customer_` (`customer_id`),
  ADD KEY `Cart_checkout_product_id_67b42944_fk_Product_product_product_ID` (`product_id`);

--
-- Indexes for table `cart_order`
--
ALTER TABLE `cart_order`
  ADD PRIMARY KEY (`order_ID`),
  ADD KEY `Cart_order_checkout_id_eacffe21_fk_Cart_checkout_checkout_ID` (`checkout_id`);

--
-- Indexes for table `cart_orderstatus`
--
ALTER TABLE `cart_orderstatus`
  ADD PRIMARY KEY (`order_status_ID`),
  ADD KEY `Cart_orderstatus_order_id_a73033ea_fk_Cart_order_order_ID` (`order_id`);

--
-- Indexes for table `customer_customer`
--
ALTER TABLE `customer_customer`
  ADD PRIMARY KEY (`customer_ID`),
  ADD KEY `Customer_customer_school_admin_id_3b77885f_fk_SchoolAdm` (`school_admin_id`);

--
-- Indexes for table `customer_customer_transaction_history`
--
ALTER TABLE `customer_customer_transaction_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Customer_customer_transa_customer_id_transactions_1cb81f6c_uniq` (`customer_id`,`transactions_id`),
  ADD KEY `Customer_customer_tr_transactions_id_4b3dbd7d_fk_Transacti` (`transactions_id`);

--
-- Indexes for table `deliverypersonnel_courier`
--
ALTER TABLE `deliverypersonnel_courier`
  ADD PRIMARY KEY (`courier_ID`);

--
-- Indexes for table `deliverypersonnel_courierorderdp`
--
ALTER TABLE `deliverypersonnel_courierorderdp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DeliveryPersonnel_co_delivery_personnel_I_65c69b44_fk_DeliveryP` (`delivery_personnel_ID_id`),
  ADD KEY `DeliveryPersonnel_co_order_ID_id_1548ca82_fk_Cart_chec` (`order_ID_id`);

--
-- Indexes for table `deliverypersonnel_courierorderdp_courier_id`
--
ALTER TABLE `deliverypersonnel_courierorderdp_courier_id`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `DeliveryPersonnel_courie_courierorderdp_id_courie_13dc36bb_uniq` (`courierorderdp_id`,`courier_id`),
  ADD KEY `DeliveryPersonnel_co_courier_id_102503a3_fk_DeliveryP` (`courier_id`);

--
-- Indexes for table `deliverypersonnel_deliverypersonnel`
--
ALTER TABLE `deliverypersonnel_deliverypersonnel`
  ADD PRIMARY KEY (`delivery_personnel_ID`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `merchant_merchant`
--
ALTER TABLE `merchant_merchant`
  ADD PRIMARY KEY (`merchant_ID`);

--
-- Indexes for table `merchant_merchant_transaction_history`
--
ALTER TABLE `merchant_merchant_transaction_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Merchant_merchant_transa_merchant_id_transactions_e812507a_uniq` (`merchant_id`,`transactions_id`),
  ADD KEY `Merchant_merchant_tr_transactions_id_5648b2c3_fk_Transacti` (`transactions_id`);

--
-- Indexes for table `product_product`
--
ALTER TABLE `product_product`
  ADD PRIMARY KEY (`product_ID`),
  ADD KEY `Product_product_merchant_ID_id_267503fe_fk_Merchant_` (`merchant_ID_id`);

--
-- Indexes for table `product_productreview`
--
ALTER TABLE `product_productreview`
  ADD PRIMARY KEY (`product_review_ID`),
  ADD KEY `Product_productrevie_customer_id_16fdde5f_fk_Customer_` (`customer_id`),
  ADD KEY `Product_productreview_order_id_61299eb0_fk_Cart_order_order_ID` (`order_id`),
  ADD KEY `Product_productrevie_product_id_01463187_fk_Product_p` (`product_id`);

--
-- Indexes for table `schooladmin_approvemerchant`
--
ALTER TABLE `schooladmin_approvemerchant`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schooladmin_schooladmin`
--
ALTER TABLE `schooladmin_schooladmin`
  ADD PRIMARY KEY (`school_admin`);

--
-- Indexes for table `transaction_transactions`
--
ALTER TABLE `transaction_transactions`
  ADD PRIMARY KEY (`transaction_ID`),
  ADD KEY `Transaction_transact_customer_id_80327554_fk_Customer_` (`customer_id`),
  ADD KEY `Transaction_transact_merchant_id_b644259f_fk_Merchant_` (`merchant_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_cart`
--
ALTER TABLE `cart_cart`
  MODIFY `cart_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart_checkout`
--
ALTER TABLE `cart_checkout`
  MODIFY `checkout_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart_order`
--
ALTER TABLE `cart_order`
  MODIFY `order_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_orderstatus`
--
ALTER TABLE `cart_orderstatus`
  MODIFY `order_status_ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_customer`
--
ALTER TABLE `customer_customer`
  MODIFY `customer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer_customer_transaction_history`
--
ALTER TABLE `customer_customer_transaction_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliverypersonnel_courier`
--
ALTER TABLE `deliverypersonnel_courier`
  MODIFY `courier_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deliverypersonnel_courierorderdp`
--
ALTER TABLE `deliverypersonnel_courierorderdp`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deliverypersonnel_courierorderdp_courier_id`
--
ALTER TABLE `deliverypersonnel_courierorderdp_courier_id`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deliverypersonnel_deliverypersonnel`
--
ALTER TABLE `deliverypersonnel_deliverypersonnel`
  MODIFY `delivery_personnel_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `merchant_merchant`
--
ALTER TABLE `merchant_merchant`
  MODIFY `merchant_ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `merchant_merchant_transaction_history`
--
ALTER TABLE `merchant_merchant_transaction_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_product`
--
ALTER TABLE `product_product`
  MODIFY `product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_productreview`
--
ALTER TABLE `product_productreview`
  MODIFY `product_review_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schooladmin_approvemerchant`
--
ALTER TABLE `schooladmin_approvemerchant`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schooladmin_schooladmin`
--
ALTER TABLE `schooladmin_schooladmin`
  MODIFY `school_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `cart_cart`
--
ALTER TABLE `cart_cart`
  ADD CONSTRAINT `Cart_cart_customer_id_46f86f26_fk_Customer_customer_customer_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`customer_ID`),
  ADD CONSTRAINT `Cart_cart_product_id_dbc15da8_fk_Product_product_product_ID` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`product_ID`);

--
-- Constraints for table `cart_checkout`
--
ALTER TABLE `cart_checkout`
  ADD CONSTRAINT `Cart_checkout_cart_id_7ad8dadb_fk_Cart_cart_cart_ID` FOREIGN KEY (`cart_id`) REFERENCES `cart_cart` (`cart_ID`),
  ADD CONSTRAINT `Cart_checkout_customer_id_c5ac812f_fk_Customer_` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`customer_ID`),
  ADD CONSTRAINT `Cart_checkout_product_id_67b42944_fk_Product_product_product_ID` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`product_ID`);

--
-- Constraints for table `cart_order`
--
ALTER TABLE `cart_order`
  ADD CONSTRAINT `Cart_order_checkout_id_eacffe21_fk_Cart_checkout_checkout_ID` FOREIGN KEY (`checkout_id`) REFERENCES `cart_checkout` (`checkout_ID`);

--
-- Constraints for table `cart_orderstatus`
--
ALTER TABLE `cart_orderstatus`
  ADD CONSTRAINT `Cart_orderstatus_order_id_a73033ea_fk_Cart_order_order_ID` FOREIGN KEY (`order_id`) REFERENCES `cart_order` (`order_ID`);

--
-- Constraints for table `customer_customer`
--
ALTER TABLE `customer_customer`
  ADD CONSTRAINT `Customer_customer_school_admin_id_3b77885f_fk_SchoolAdm` FOREIGN KEY (`school_admin_id`) REFERENCES `schooladmin_schooladmin` (`school_admin`);

--
-- Constraints for table `customer_customer_transaction_history`
--
ALTER TABLE `customer_customer_transaction_history`
  ADD CONSTRAINT `Customer_customer_tr_customer_id_a250551d_fk_Customer_` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`customer_ID`),
  ADD CONSTRAINT `Customer_customer_tr_transactions_id_4b3dbd7d_fk_Transacti` FOREIGN KEY (`transactions_id`) REFERENCES `transaction_transactions` (`transaction_ID`);

--
-- Constraints for table `deliverypersonnel_courierorderdp`
--
ALTER TABLE `deliverypersonnel_courierorderdp`
  ADD CONSTRAINT `DeliveryPersonnel_co_delivery_personnel_I_65c69b44_fk_DeliveryP` FOREIGN KEY (`delivery_personnel_ID_id`) REFERENCES `deliverypersonnel_deliverypersonnel` (`delivery_personnel_ID`),
  ADD CONSTRAINT `DeliveryPersonnel_co_order_ID_id_1548ca82_fk_Cart_chec` FOREIGN KEY (`order_ID_id`) REFERENCES `cart_checkout` (`checkout_ID`);

--
-- Constraints for table `deliverypersonnel_courierorderdp_courier_id`
--
ALTER TABLE `deliverypersonnel_courierorderdp_courier_id`
  ADD CONSTRAINT `DeliveryPersonnel_co_courier_id_102503a3_fk_DeliveryP` FOREIGN KEY (`courier_id`) REFERENCES `deliverypersonnel_courier` (`courier_ID`),
  ADD CONSTRAINT `DeliveryPersonnel_co_courierorderdp_id_c612e1a7_fk_DeliveryP` FOREIGN KEY (`courierorderdp_id`) REFERENCES `deliverypersonnel_courierorderdp` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `merchant_merchant_transaction_history`
--
ALTER TABLE `merchant_merchant_transaction_history`
  ADD CONSTRAINT `Merchant_merchant_tr_merchant_id_1481d181_fk_Merchant_` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_merchant` (`merchant_ID`),
  ADD CONSTRAINT `Merchant_merchant_tr_transactions_id_5648b2c3_fk_Transacti` FOREIGN KEY (`transactions_id`) REFERENCES `transaction_transactions` (`transaction_ID`);

--
-- Constraints for table `product_product`
--
ALTER TABLE `product_product`
  ADD CONSTRAINT `Product_product_merchant_ID_id_267503fe_fk_Merchant_` FOREIGN KEY (`merchant_ID_id`) REFERENCES `merchant_merchant` (`merchant_ID`);

--
-- Constraints for table `product_productreview`
--
ALTER TABLE `product_productreview`
  ADD CONSTRAINT `Product_productrevie_customer_id_16fdde5f_fk_Customer_` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`customer_ID`),
  ADD CONSTRAINT `Product_productrevie_product_id_01463187_fk_Product_p` FOREIGN KEY (`product_id`) REFERENCES `product_product` (`product_ID`),
  ADD CONSTRAINT `Product_productreview_order_id_61299eb0_fk_Cart_order_order_ID` FOREIGN KEY (`order_id`) REFERENCES `cart_order` (`order_ID`);

--
-- Constraints for table `transaction_transactions`
--
ALTER TABLE `transaction_transactions`
  ADD CONSTRAINT `Transaction_transact_customer_id_80327554_fk_Customer_` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`customer_ID`),
  ADD CONSTRAINT `Transaction_transact_merchant_id_b644259f_fk_Merchant_` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_merchant` (`merchant_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
