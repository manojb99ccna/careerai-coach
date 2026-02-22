-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2026 at 02:40 PM
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
-- Database: `careerai_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `experience_levels`
--

CREATE TABLE `experience_levels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `experience_levels`
--

INSERT INTO `experience_levels` (`id`, `name`, `sort_order`, `is_active`) VALUES
(1, 'Fresher (0–1 year)', 1, 1),
(2, 'Junior (1–3 years)', 2, 1),
(3, 'Mid-level (3–5 years)', 3, 1),
(4, 'Senior (5+ years) ', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `is_active`) VALUES
(1, 'Software Developer', 1),
(2, 'Frontend Developer', 1),
(3, 'Backend Developer', 1),
(4, 'Data Analyst', 1),
(5, 'Data Scientist', 1),
(6, 'AI Engineer', 1),
(7, 'ML Engineer', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `face_encoding` text NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `profile_image`, `name`, `email`, `phone`, `face_encoding`, `created_at`) VALUES
(1, NULL, 'Manoj', 'mydatab99@gmail.com', '9760894418', '0.3921568691730499,0.3803921639919281,0.45490196347236633,0.3803921639919281,0.22745098173618317,0.4117647111415863,0.4274509847164154,0.3803921639919281,0.40392157435417175,0.3960784375667572,0.18431372940540314,0.4156862795352936,0.43921568989753723,0.3960784375667572,0.40392157435417175,0.23137255012989044,0.3843137323856354,0.3803921639919281,0.45098039507865906,0.3960784375667572,0.21176470816135406,0.20392157137393951,0.1725490242242813,0.18431372940540314,0.2235294133424759,0.4156862795352936,0.18431372940540314,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.32549020648002625,0.41960784792900085,0.3529411852359772,0.29019609093666077,0.32156863808631897,0.40392157435417175,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2666666805744171,0.18431372940540314,0.20392157137393951,0.40392157435417175,0.2823529541492462,0.3490196168422699,0.32549020648002625,0.3333333432674408,0.30588236451148987,0.2666666805744171,0.3450980484485626,0.1921568661928177,0.25882354378700256,0.32549020648002625,0.3294117748737335,0.1882352977991104,0.3529411852359772,0.29019609093666077,0.3294117748737335,0.2705882489681244,0.3333333432674408,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2823529541492462,0.2862745225429535,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.46666666865348816,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.45490196347236633,0.3843137323856354,0.4313725531101227,0.32156863808631897,0.4745098054409027,0.3333333432674408,0.41960784792900085,0.3921568691730499,0.26274511218070984,0.2862745225429535,0.27450981736183167,0.40784314274787903,0.3529411852359772,0.34117648005485535,0.4117647111415863,0.2549019753932953,0.2823529541492462,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.40784314274787903,0.3490196168422699,0.20000000298023224,0.30588236451148987,0.46666666865348816,0.2549019753932953', '2026-02-21 23:16:27.262197');

-- --------------------------------------------------------

--
-- Table structure for table `user_login_details`
--

CREATE TABLE `user_login_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login_method` enum('face','email','google','linkedin') DEFAULT 'face',
  `face_encoding` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`face_encoding`)),
  `face_image_path` varchar(500) DEFAULT NULL,
  `confidence_score` float DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `device_info` varchar(255) DEFAULT NULL,
  `browser_info` varchar(255) DEFAULT NULL,
  `os_info` varchar(100) DEFAULT NULL,
  `login_status` enum('success','failed') NOT NULL,
  `failure_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_onboarding`
--

CREATE TABLE `user_onboarding` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `experience_level_id` int(11) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `resume_file_name` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updated_at` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_onboarding`
--

INSERT INTO `user_onboarding` (`id`, `user_id`, `role_id`, `experience_level_id`, `skills`, `resume_file_name`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 1, 'php', 'resume-test.pdf', '2026-02-22 00:26:15.588702', '2026-02-22 00:26:15.588702');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `experience_levels`
--
ALTER TABLE `experience_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_experience_levels_name` (`name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `ix_users_id` (`id`);

--
-- Indexes for table `user_login_details`
--
ALTER TABLE `user_login_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_login_status` (`login_status`);

--
-- Indexes for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_onboarding_user` (`user_id`),
  ADD KEY `fk_user_onboarding_role` (`role_id`),
  ADD KEY `fk_user_onboarding_experience` (`experience_level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `experience_levels`
--
ALTER TABLE `experience_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_login_details`
--
ALTER TABLE `user_login_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_login_details`
--
ALTER TABLE `user_login_details`
  ADD CONSTRAINT `user_login_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD CONSTRAINT `fk_user_onboarding_experience` FOREIGN KEY (`experience_level_id`) REFERENCES `experience_levels` (`id`),
  ADD CONSTRAINT `fk_user_onboarding_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_user_onboarding_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
