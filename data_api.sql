-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2026 at 02:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `street` varchar(100) DEFAULT NULL,
  `suite` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `street`, `suite`, `city`, `zipcode`) VALUES
(1, 0, '-', '', 'Jakarta', '-'),
(2, 1, 'Kulas Light', 'Apt. 556', 'Gwenborough', '92998-3874'),
(3, 2, 'Victor Plains', 'Suite 879', 'Wisokyburgh', '90566-7771'),
(4, 3, 'Douglas Extension', 'Suite 847', 'McKenziehaven', '59590-4157'),
(5, 4, 'Hoeger Mall', 'Apt. 692', 'South Elvis', '53919-4257'),
(6, 5, 'Skiles Walks', 'Suite 351', 'Roscoeview', '33263'),
(7, 6, 'Norberto Crossing', 'Apt. 950', 'South Christy', '23505-1337'),
(8, 7, 'Rex Trail', 'Suite 280', 'Howemouth', '58804-1099'),
(9, 8, 'Ellsworth Summit', 'Suite 729', 'Aliyaview', '45169'),
(10, 9, 'Dayna Park', 'Suite 449', 'Bartholomebury', '76495-3109'),
(11, 10, 'Kattie Turnpike', 'Suite 198', 'Lebsackbury', '31428-2261');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `catch_phrase` varchar(255) DEFAULT NULL,
  `bs` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `user_id`, `name`, `catch_phrase`, `bs`) VALUES
(1, 0, 'pt jawa', 'Member Baru', 'new user'),
(2, 1, 'Romaguera-Crona', 'Multi-layered client-server neural-net', 'harness real-time e-markets'),
(3, 2, 'Deckow-Crist', 'Proactive didactic contingency', 'synergize scalable supply-chains'),
(4, 3, 'Romaguera-Jacobson', 'Face to face bifurcated interface', 'e-enable strategic applications'),
(5, 4, 'Robel-Corkery', 'Multi-tiered zero tolerance productivity', 'transition cutting-edge web services'),
(6, 5, 'Keebler LLC', 'User-centric fault-tolerant solution', 'revolutionize end-to-end systems'),
(7, 6, 'Considine-Lockman', 'Synchronised bottom-line interface', 'e-enable innovative applications'),
(8, 7, 'Johns Group', 'Configurable multimedia task-force', 'generate enterprise e-tailers'),
(9, 8, 'Abernathy Group', 'Implemented secondary concept', 'e-enable extensible e-tailers'),
(10, 9, 'Yost and Sons', 'Switchable contextually-based project', 'aggregate real-time technologies'),
(11, 10, 'Hoeger LLC', 'Centralized empowering task-force', 'target end-to-end models');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `address`, `email`, `phone`, `website`) VALUES
(0, 'Reni Aulia', 'dsfds', NULL, 'reniauliaa05@gmail.com', '089987676', 'example.com'),
(1, 'Leanne Graham', 'Bret', NULL, 'Sincere@april.biz', '1-770-736-8031 x56442', 'hildegard.org'),
(2, 'Ervin Howell', 'Antonette', NULL, 'Shanna@melissa.tv', '010-692-6593 x09125', 'anastasia.net'),
(3, 'Clementine Bauch', 'Samantha', NULL, 'Nathan@yesenia.net', '1-463-123-4447', 'ramiro.info'),
(4, 'Patricia Lebsack', 'Karianne', NULL, 'Julianne.OConner@kory.org', '493-170-9623 x156', 'kale.biz'),
(5, 'Chelsey Dietrich', 'Kamren', NULL, 'Lucio_Hettinger@annie.ca', '(254)954-1289', 'demarco.info'),
(6, 'Mrs. Dennis Schulist', 'Leopoldo_Corkery', NULL, 'Karley_Dach@jasper.info', '1-477-935-8478 x6430', 'ola.org'),
(7, 'Kurtis Weissnat', 'Elwyn.Skiles', NULL, 'Telly.Hoeger@billy.biz', '210.067.6132', 'elvis.io'),
(8, 'Nicholas Runolfsdottir V', 'Maxime_Nienow', NULL, 'Sherwood@rosamond.me', '586.493.6943 x140', 'jacynthe.com'),
(9, 'Glenna Reichert', 'Delphine', NULL, 'Chaim_McDermott@dana.io', '(775)976-6794 x41206', 'conrad.com'),
(10, 'Clementina DuBuque', 'Moriah.Stanton', NULL, 'Rey.Padberg@karina.biz', '024-648-3804', 'ambrose.net');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
