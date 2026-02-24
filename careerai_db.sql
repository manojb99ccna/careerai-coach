-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2026 at 12:45 PM
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
-- Table structure for table `master_milestones`
--

CREATE TABLE `master_milestones` (
  `id` int(11) NOT NULL,
  `training_plan_id` int(11) NOT NULL,
  `milestone_number` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `estimated_days` int(11) DEFAULT 7,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_milestones`
--

INSERT INTO `master_milestones` (`id`, `training_plan_id`, `milestone_number`, `title`, `description`, `estimated_days`, `sort_order`) VALUES
(1, 1, 1, 'Foundations in Programming', 'Mastering basic programming concepts is essential for any software engineer.', 10, 1),
(2, 1, 2, 'Math Fundamentals for Machine Learning', 'Developing an understanding of mathematical concepts is crucial for machine learning engineers.', 10, 2),
(3, 1, 3, 'Python Programming for Machine Learning', 'Mastering Python programming is essential for any machine learning engineer.', 15, 3),
(4, 1, 4, 'Machine Learning Fundamentals', 'Mastering machine learning concepts is crucial for any machine learning engineer.', 20, 4),
(5, 1, 5, 'Machine Learning Deployment and Portfolio Building', 'Building a portfolio and deploying machine learning models is essential for any machine learning engineer.', 15, 5),
(6, 1, 6, 'Real-World Machine Learning Projects', 'Working on real-world machine learning projects is essential for any machine learning engineer.', 20, 6);

-- --------------------------------------------------------

--
-- Table structure for table `master_quiz_questions`
--

CREATE TABLE `master_quiz_questions` (
  `id` int(11) NOT NULL,
  `master_milestone_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('multiple_choice','true_false','short_answer') DEFAULT 'multiple_choice',
  `difficulty` enum('easy','medium','hard') NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `correct_answer` varchar(100) NOT NULL,
  `explanation` text DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_quiz_questions`
--

INSERT INTO `master_quiz_questions` (`id`, `master_milestone_id`, `question_text`, `question_type`, `difficulty`, `options`, `correct_answer`, `explanation`, `tags`, `created_at`) VALUES
(1, 1, 'What is the main purpose of a variable in programming?', 'multiple_choice', 'easy', '[\"A. To store data\", \"B. To perform calculations\", \"C. To create objects\", \"D. To loop through arrays\"]', 'A', 'Variables are used to store and manipulate data in programs.', NULL, '2026-02-24 15:12:05'),
(2, 1, 'What is the purpose of a function in programming?', 'multiple_choice', 'easy', '[\"A. To create objects\", \"B. To store data\", \"C. To perform calculations\", \"D. To group code together\"]', 'D', 'Functions are used to group code together and reuse it throughout a program.', NULL, '2026-02-24 15:12:05'),
(3, 1, 'What is the difference between a for loop and a while loop?', 'multiple_choice', 'easy', '[\"A. A for loop only works with arrays\", \"B. A while loop only works with integers\", \"C. A for loop continues until a condition is met, while a while loop repeats until a condition is met\", \"D. A for loop can\'t be used to iterate through strings\"]', 'C', 'A for loop and a while loop are both used for repetition in programming, but the conditions for stopping differ.', NULL, '2026-02-24 15:12:05'),
(4, 1, 'Easy practice question 4 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(5, 1, 'Easy practice question 5 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(6, 1, 'Easy practice question 6 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(7, 1, 'Easy practice question 7 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(8, 1, 'Easy practice question 8 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(9, 1, 'Easy practice question 9 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(10, 1, 'Easy practice question 10 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(11, 1, 'Easy practice question 11 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(12, 1, 'Easy practice question 12 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(13, 1, 'Easy practice question 13 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(14, 1, 'Easy practice question 14 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(15, 1, 'Easy practice question 15 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(16, 1, 'Easy practice question 16 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(17, 1, 'Easy practice question 17 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(18, 1, 'Easy practice question 18 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(19, 1, 'Easy practice question 19 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(20, 1, 'Easy practice question 20 for Foundations in Programming', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(21, 1, 'Medium practice question 21 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(22, 1, 'Medium practice question 22 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(23, 1, 'Medium practice question 23 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(24, 1, 'Medium practice question 24 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(25, 1, 'Medium practice question 25 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(26, 1, 'Medium practice question 26 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(27, 1, 'Medium practice question 27 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(28, 1, 'Medium practice question 28 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(29, 1, 'Medium practice question 29 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(30, 1, 'Medium practice question 30 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(31, 1, 'Medium practice question 31 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(32, 1, 'Medium practice question 32 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(33, 1, 'Medium practice question 33 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(34, 1, 'Medium practice question 34 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(35, 1, 'Medium practice question 35 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(36, 1, 'Medium practice question 36 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(37, 1, 'Medium practice question 37 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(38, 1, 'Medium practice question 38 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(39, 1, 'Medium practice question 39 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(40, 1, 'Medium practice question 40 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(41, 1, 'Medium practice question 41 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(42, 1, 'Medium practice question 42 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(43, 1, 'Medium practice question 43 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(44, 1, 'Medium practice question 44 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(45, 1, 'Medium practice question 45 for Foundations in Programming', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(46, 1, 'Hard practice question 46 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(47, 1, 'Hard practice question 47 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(48, 1, 'Hard practice question 48 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(49, 1, 'Hard practice question 49 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(50, 1, 'Hard practice question 50 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(51, 1, 'Hard practice question 51 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(52, 1, 'Hard practice question 52 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(53, 1, 'Hard practice question 53 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(54, 1, 'Hard practice question 54 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(55, 1, 'Hard practice question 55 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(56, 1, 'Hard practice question 56 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(57, 1, 'Hard practice question 57 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(58, 1, 'Hard practice question 58 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(59, 1, 'Hard practice question 59 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(60, 1, 'Hard practice question 60 for Foundations in Programming', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Foundations in Programming. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(61, 2, 'What is a vector in linear algebra?', 'multiple_choice', 'easy', '[\"A. A one-dimensional array\", \"B. A two-dimensional array\", \"C. A three-dimensional array\", \"D. A collection of numbers\"]', 'D', 'Vectors are used to represent quantities with both magnitude and direction.', NULL, '2026-02-24 15:12:05'),
(62, 2, 'What is the purpose of descriptive statistics?', 'multiple_choice', 'easy', '[\"A. To summarize data\", \"B. To visualize data\", \"C. To identify patterns in data\", \"D. To make predictions about data\"]', 'A', 'Descriptive statistics are used to summarize and describe the main characteristics of a dataset.', NULL, '2026-02-24 15:12:05'),
(63, 2, 'What is the primary difference between a derivative and an integral?', 'multiple_choice', 'easy', '[\"A. Derivatives are used for optimization, while integrals are used for accumulation\", \"B. Derivatives are used for accumulation, while integrals are used for optimization\", \"C. Derivatives describe how something changes, while integrals describe the total amount of change\", \"D. Derivatives describe the rate of change, while integrals describe the area under a curve\"]', 'D', 'Derivatives and integrals are used to analyze and understand real-world phenomena.', NULL, '2026-02-24 15:12:05'),
(64, 2, 'Easy practice question 4 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(65, 2, 'Easy practice question 5 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(66, 2, 'Easy practice question 6 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(67, 2, 'Easy practice question 7 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(68, 2, 'Easy practice question 8 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(69, 2, 'Easy practice question 9 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(70, 2, 'Easy practice question 10 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(71, 2, 'Easy practice question 11 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(72, 2, 'Easy practice question 12 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(73, 2, 'Easy practice question 13 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(74, 2, 'Easy practice question 14 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(75, 2, 'Easy practice question 15 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(76, 2, 'Easy practice question 16 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(77, 2, 'Easy practice question 17 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(78, 2, 'Easy practice question 18 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(79, 2, 'Easy practice question 19 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(80, 2, 'Easy practice question 20 for Math Fundamentals for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(81, 2, 'Medium practice question 21 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(82, 2, 'Medium practice question 22 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(83, 2, 'Medium practice question 23 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(84, 2, 'Medium practice question 24 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(85, 2, 'Medium practice question 25 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(86, 2, 'Medium practice question 26 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(87, 2, 'Medium practice question 27 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(88, 2, 'Medium practice question 28 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(89, 2, 'Medium practice question 29 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(90, 2, 'Medium practice question 30 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(91, 2, 'Medium practice question 31 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(92, 2, 'Medium practice question 32 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(93, 2, 'Medium practice question 33 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(94, 2, 'Medium practice question 34 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(95, 2, 'Medium practice question 35 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(96, 2, 'Medium practice question 36 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(97, 2, 'Medium practice question 37 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(98, 2, 'Medium practice question 38 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(99, 2, 'Medium practice question 39 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(100, 2, 'Medium practice question 40 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(101, 2, 'Medium practice question 41 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(102, 2, 'Medium practice question 42 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(103, 2, 'Medium practice question 43 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(104, 2, 'Medium practice question 44 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(105, 2, 'Medium practice question 45 for Math Fundamentals for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(106, 2, 'Hard practice question 46 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(107, 2, 'Hard practice question 47 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(108, 2, 'Hard practice question 48 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(109, 2, 'Hard practice question 49 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(110, 2, 'Hard practice question 50 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(111, 2, 'Hard practice question 51 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(112, 2, 'Hard practice question 52 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(113, 2, 'Hard practice question 53 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(114, 2, 'Hard practice question 54 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(115, 2, 'Hard practice question 55 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(116, 2, 'Hard practice question 56 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(117, 2, 'Hard practice question 57 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(118, 2, 'Hard practice question 58 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(119, 2, 'Hard practice question 59 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(120, 2, 'Hard practice question 60 for Math Fundamentals for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Math Fundamentals for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(121, 3, 'What is the main purpose of a while loop in Python?', 'multiple_choice', 'easy', '[\"A. To iterate through arrays\", \"B. To repeat a block of code until a condition is met\", \"C. To create objects\", \"D. To perform calculations\"]', 'B', 'While loops are used to repeat a block of code as long as a certain condition is true.', NULL, '2026-02-24 15:12:05'),
(122, 3, 'What is the main difference between a list and a tuple in Python?', 'multiple_choice', 'easy', '[\"A. A list can be modified, while a tuple cannot\", \"B. A list can only contain integers, while a tuple can only contain strings\", \"C. A list is used for arrays, while a tuple is used for dictionaries\", \"D. A list is used for data visualization, while a tuple is used for statistical analysis\"]', 'A', 'Lists and tuples are both used to store collections of values, but lists can be modified after creation, while tuples cannot.', NULL, '2026-02-24 15:12:05'),
(123, 3, 'What is the purpose of NumPy in Python?', 'multiple_choice', 'easy', '[\"A. To create objects\", \"B. To perform calculations\", \"C. To iterate through arrays\", \"D. To store data\"]', 'B', 'NumPy is used to perform numerical computations and array operations in Python.', NULL, '2026-02-24 15:12:05'),
(124, 3, 'Easy practice question 4 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(125, 3, 'Easy practice question 5 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(126, 3, 'Easy practice question 6 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(127, 3, 'Easy practice question 7 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05');
INSERT INTO `master_quiz_questions` (`id`, `master_milestone_id`, `question_text`, `question_type`, `difficulty`, `options`, `correct_answer`, `explanation`, `tags`, `created_at`) VALUES
(128, 3, 'Easy practice question 8 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(129, 3, 'Easy practice question 9 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(130, 3, 'Easy practice question 10 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(131, 3, 'Easy practice question 11 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(132, 3, 'Easy practice question 12 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(133, 3, 'Easy practice question 13 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(134, 3, 'Easy practice question 14 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(135, 3, 'Easy practice question 15 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(136, 3, 'Easy practice question 16 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(137, 3, 'Easy practice question 17 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(138, 3, 'Easy practice question 18 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(139, 3, 'Easy practice question 19 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(140, 3, 'Easy practice question 20 for Python Programming for Machine Learning', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(141, 3, 'Medium practice question 21 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(142, 3, 'Medium practice question 22 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(143, 3, 'Medium practice question 23 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(144, 3, 'Medium practice question 24 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(145, 3, 'Medium practice question 25 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(146, 3, 'Medium practice question 26 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(147, 3, 'Medium practice question 27 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(148, 3, 'Medium practice question 28 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(149, 3, 'Medium practice question 29 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(150, 3, 'Medium practice question 30 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(151, 3, 'Medium practice question 31 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(152, 3, 'Medium practice question 32 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(153, 3, 'Medium practice question 33 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(154, 3, 'Medium practice question 34 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(155, 3, 'Medium practice question 35 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(156, 3, 'Medium practice question 36 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(157, 3, 'Medium practice question 37 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(158, 3, 'Medium practice question 38 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(159, 3, 'Medium practice question 39 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(160, 3, 'Medium practice question 40 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(161, 3, 'Medium practice question 41 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(162, 3, 'Medium practice question 42 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(163, 3, 'Medium practice question 43 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(164, 3, 'Medium practice question 44 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(165, 3, 'Medium practice question 45 for Python Programming for Machine Learning', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(166, 3, 'Hard practice question 46 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(167, 3, 'Hard practice question 47 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(168, 3, 'Hard practice question 48 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(169, 3, 'Hard practice question 49 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(170, 3, 'Hard practice question 50 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(171, 3, 'Hard practice question 51 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(172, 3, 'Hard practice question 52 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(173, 3, 'Hard practice question 53 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(174, 3, 'Hard practice question 54 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(175, 3, 'Hard practice question 55 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(176, 3, 'Hard practice question 56 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(177, 3, 'Hard practice question 57 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(178, 3, 'Hard practice question 58 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(179, 3, 'Hard practice question 59 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(180, 3, 'Hard practice question 60 for Python Programming for Machine Learning', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Python Programming for Machine Learning. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(181, 4, 'What is the purpose of dimensionality reduction in machine learning?', 'multiple_choice', 'easy', '[\"A. To reduce the amount of memory required for training\", \"B. To increase the speed of model training\", \"C. To improve the accuracy of predictions\", \"D. To visualize high-dimensional data\"]', 'D', 'Dimensionality reduction is used to simplify complex datasets and improve visualization.', NULL, '2026-02-24 15:12:05'),
(182, 4, 'What is the primary difference between supervised and unsupervised learning?', 'multiple_choice', 'easy', '[\"A. Supervised learning involves labeling data, while unsupervised learning does not\", \"B. Supervised learning involves clustering data, while unsupervised learning involves classification\", \"C. Supervised learning involves regression, while unsupervised learning involves dimensionality reduction\", \"D. Supervised learning is used for prediction, while unsupervised learning is used for visualization\"]', 'A', 'Supervised learning involves using labeled data to train models, while unsupervised learning involves discovering patterns in unlabeled data.', NULL, '2026-02-24 15:12:05'),
(183, 4, 'What is the primary difference between a decision tree and a random forest?', 'multiple_choice', 'easy', '[\"A. Decision trees are used for classification, while random forests are used for regression\", \"B. Decision trees are used for regression, while random forests are used for classification\", \"C. Decision trees are used for clustering, while random forests are used for dimensionality reduction\", \"D. Decision trees are more interpretable than random forests\"]', 'A', 'Decision trees are used for classification or regression, while random forests are ensembles of decision trees that improve accuracy and reduce overfitting.', NULL, '2026-02-24 15:12:05'),
(184, 4, 'Easy practice question 4 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(185, 4, 'Easy practice question 5 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(186, 4, 'Easy practice question 6 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(187, 4, 'Easy practice question 7 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(188, 4, 'Easy practice question 8 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(189, 4, 'Easy practice question 9 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(190, 4, 'Easy practice question 10 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(191, 4, 'Easy practice question 11 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(192, 4, 'Easy practice question 12 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(193, 4, 'Easy practice question 13 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(194, 4, 'Easy practice question 14 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(195, 4, 'Easy practice question 15 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(196, 4, 'Easy practice question 16 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(197, 4, 'Easy practice question 17 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(198, 4, 'Easy practice question 18 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(199, 4, 'Easy practice question 19 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(200, 4, 'Easy practice question 20 for Machine Learning Fundamentals', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(201, 4, 'Medium practice question 21 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(202, 4, 'Medium practice question 22 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(203, 4, 'Medium practice question 23 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(204, 4, 'Medium practice question 24 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(205, 4, 'Medium practice question 25 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(206, 4, 'Medium practice question 26 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(207, 4, 'Medium practice question 27 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(208, 4, 'Medium practice question 28 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(209, 4, 'Medium practice question 29 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(210, 4, 'Medium practice question 30 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(211, 4, 'Medium practice question 31 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(212, 4, 'Medium practice question 32 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(213, 4, 'Medium practice question 33 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(214, 4, 'Medium practice question 34 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(215, 4, 'Medium practice question 35 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(216, 4, 'Medium practice question 36 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(217, 4, 'Medium practice question 37 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(218, 4, 'Medium practice question 38 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(219, 4, 'Medium practice question 39 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(220, 4, 'Medium practice question 40 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(221, 4, 'Medium practice question 41 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(222, 4, 'Medium practice question 42 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(223, 4, 'Medium practice question 43 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(224, 4, 'Medium practice question 44 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(225, 4, 'Medium practice question 45 for Machine Learning Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(226, 4, 'Hard practice question 46 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(227, 4, 'Hard practice question 47 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(228, 4, 'Hard practice question 48 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(229, 4, 'Hard practice question 49 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(230, 4, 'Hard practice question 50 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(231, 4, 'Hard practice question 51 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(232, 4, 'Hard practice question 52 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(233, 4, 'Hard practice question 53 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(234, 4, 'Hard practice question 54 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(235, 4, 'Hard practice question 55 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(236, 4, 'Hard practice question 56 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(237, 4, 'Hard practice question 57 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(238, 4, 'Hard practice question 58 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(239, 4, 'Hard practice question 59 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(240, 4, 'Hard practice question 60 for Machine Learning Fundamentals', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Fundamentals. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(241, 5, 'What is the main purpose of deploying a machine learning model?', 'multiple_choice', 'easy', '[\"A. To train a new model\", \"B. To test a new dataset\", \"C. To use the model for prediction\", \"D. To share the model with others\"]', 'D', 'Deploying a machine learning model involves sharing it with others and using it to make predictions or take actions.', NULL, '2026-02-24 15:12:05'),
(242, 5, 'What is the main purpose of sharing machine learning projects online?', 'multiple_choice', 'easy', '[\"A. To get feedback from others\", \"B. To showcase skills\", \"C. To collaborate with others\", \"D. To make money\"]', 'B', 'Sharing machine learning projects online helps to showcase skills and attract potential employers or collaborators.', NULL, '2026-02-24 15:12:05'),
(243, 5, 'What is the primary difference between a personal website and a blog?', 'multiple_choice', 'easy', '[\"A. A website is used for sharing projects, while a blog is used for writing articles\", \"B. A website is used for writing articles, while a blog is used for sharing projects\", \"C. A website is used for sharing tutorials, while a blog is used for sharing projects\", \"D. A website is used for sharing datasets, while a blog is used for sharing projects\"]', 'A', 'A personal website is used to share projects and accomplishments, while a blog is used to write articles and share knowledge.', NULL, '2026-02-24 15:12:05'),
(244, 5, 'Easy practice question 4 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(245, 5, 'Easy practice question 5 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(246, 5, 'Easy practice question 6 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(247, 5, 'Easy practice question 7 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(248, 5, 'Easy practice question 8 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(249, 5, 'Easy practice question 9 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(250, 5, 'Easy practice question 10 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05');
INSERT INTO `master_quiz_questions` (`id`, `master_milestone_id`, `question_text`, `question_type`, `difficulty`, `options`, `correct_answer`, `explanation`, `tags`, `created_at`) VALUES
(251, 5, 'Easy practice question 11 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(252, 5, 'Easy practice question 12 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(253, 5, 'Easy practice question 13 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(254, 5, 'Easy practice question 14 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(255, 5, 'Easy practice question 15 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(256, 5, 'Easy practice question 16 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(257, 5, 'Easy practice question 17 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(258, 5, 'Easy practice question 18 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(259, 5, 'Easy practice question 19 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(260, 5, 'Easy practice question 20 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(261, 5, 'Medium practice question 21 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(262, 5, 'Medium practice question 22 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(263, 5, 'Medium practice question 23 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(264, 5, 'Medium practice question 24 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(265, 5, 'Medium practice question 25 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(266, 5, 'Medium practice question 26 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(267, 5, 'Medium practice question 27 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(268, 5, 'Medium practice question 28 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(269, 5, 'Medium practice question 29 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(270, 5, 'Medium practice question 30 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(271, 5, 'Medium practice question 31 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(272, 5, 'Medium practice question 32 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(273, 5, 'Medium practice question 33 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(274, 5, 'Medium practice question 34 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(275, 5, 'Medium practice question 35 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(276, 5, 'Medium practice question 36 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(277, 5, 'Medium practice question 37 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(278, 5, 'Medium practice question 38 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(279, 5, 'Medium practice question 39 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(280, 5, 'Medium practice question 40 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(281, 5, 'Medium practice question 41 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(282, 5, 'Medium practice question 42 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(283, 5, 'Medium practice question 43 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(284, 5, 'Medium practice question 44 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(285, 5, 'Medium practice question 45 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(286, 5, 'Hard practice question 46 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(287, 5, 'Hard practice question 47 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(288, 5, 'Hard practice question 48 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(289, 5, 'Hard practice question 49 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(290, 5, 'Hard practice question 50 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(291, 5, 'Hard practice question 51 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(292, 5, 'Hard practice question 52 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(293, 5, 'Hard practice question 53 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(294, 5, 'Hard practice question 54 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(295, 5, 'Hard practice question 55 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(296, 5, 'Hard practice question 56 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(297, 5, 'Hard practice question 57 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(298, 5, 'Hard practice question 58 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(299, 5, 'Hard practice question 59 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(300, 5, 'Hard practice question 60 for Machine Learning Deployment and Portfolio Building', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Machine Learning Deployment and Portfolio Building. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(301, 6, 'What is the main purpose of data preprocessing in machine learning?', 'multiple_choice', 'easy', '[\"A. To reduce the amount of memory required for training\", \"B. To improve the accuracy of predictions\", \"C. To visualize high-dimensional data\", \"D. To prepare data for model training\"]', 'D', 'Data preprocessing is used to prepare data for model training by handling missing values, scaling features, and transforming variables.', NULL, '2026-02-24 15:12:05'),
(302, 6, 'What is the main purpose of deploying a machine learning model?', 'multiple_choice', 'easy', '[\"A. To train a new model\", \"B. To test a new dataset\", \"C. To use the model for prediction\", \"D. To share the model with others\"]', 'C', 'Deploying a machine learning model involves using it to make predictions or take actions, such as classifying images or recommending products.', NULL, '2026-02-24 15:12:05'),
(303, 6, 'What is the primary difference between feature engineering and feature selection?', 'multiple_choice', 'easy', '[\"A. Feature engineering involves selecting features, while feature selection involves creating new ones\", \"B. Feature engineering involves creating new features, while feature selection involves selecting existing ones\", \"C. Feature engineering is used for regression, while feature selection is used for classification\", \"D. Feature engineering is used for dimensionality reduction, while feature selection is used for clustering\"]', 'B', 'Feature engineering involves creating new features that improve model performance, while feature selection involves selecting existing features to reduce overfitting.', NULL, '2026-02-24 15:12:05'),
(304, 6, 'Easy practice question 4 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(305, 6, 'Easy practice question 5 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(306, 6, 'Easy practice question 6 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(307, 6, 'Easy practice question 7 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(308, 6, 'Easy practice question 8 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(309, 6, 'Easy practice question 9 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(310, 6, 'Easy practice question 10 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(311, 6, 'Easy practice question 11 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(312, 6, 'Easy practice question 12 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(313, 6, 'Easy practice question 13 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(314, 6, 'Easy practice question 14 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(315, 6, 'Easy practice question 15 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(316, 6, 'Easy practice question 16 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(317, 6, 'Easy practice question 17 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(318, 6, 'Easy practice question 18 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(319, 6, 'Easy practice question 19 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(320, 6, 'Easy practice question 20 for Real-World Machine Learning Projects', 'multiple_choice', 'easy', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic easy question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(321, 6, 'Medium practice question 21 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(322, 6, 'Medium practice question 22 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(323, 6, 'Medium practice question 23 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(324, 6, 'Medium practice question 24 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(325, 6, 'Medium practice question 25 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(326, 6, 'Medium practice question 26 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(327, 6, 'Medium practice question 27 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(328, 6, 'Medium practice question 28 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(329, 6, 'Medium practice question 29 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(330, 6, 'Medium practice question 30 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(331, 6, 'Medium practice question 31 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(332, 6, 'Medium practice question 32 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(333, 6, 'Medium practice question 33 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(334, 6, 'Medium practice question 34 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(335, 6, 'Medium practice question 35 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(336, 6, 'Medium practice question 36 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(337, 6, 'Medium practice question 37 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(338, 6, 'Medium practice question 38 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(339, 6, 'Medium practice question 39 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(340, 6, 'Medium practice question 40 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(341, 6, 'Medium practice question 41 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(342, 6, 'Medium practice question 42 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(343, 6, 'Medium practice question 43 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(344, 6, 'Medium practice question 44 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(345, 6, 'Medium practice question 45 for Real-World Machine Learning Projects', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(346, 6, 'Hard practice question 46 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(347, 6, 'Hard practice question 47 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(348, 6, 'Hard practice question 48 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(349, 6, 'Hard practice question 49 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(350, 6, 'Hard practice question 50 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(351, 6, 'Hard practice question 51 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(352, 6, 'Hard practice question 52 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(353, 6, 'Hard practice question 53 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(354, 6, 'Hard practice question 54 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(355, 6, 'Hard practice question 55 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(356, 6, 'Hard practice question 56 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(357, 6, 'Hard practice question 57 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(358, 6, 'Hard practice question 58 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(359, 6, 'Hard practice question 59 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05'),
(360, 6, 'Hard practice question 60 for Real-World Machine Learning Projects', 'multiple_choice', 'hard', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic hard question to reinforce Real-World Machine Learning Projects. Option A reflects the correct core idea.', NULL, '2026-02-24 15:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `master_study_materials`
--

CREATE TABLE `master_study_materials` (
  `id` int(11) NOT NULL,
  `master_milestone_id` int(11) NOT NULL,
  `content_type` enum('text','markdown','link','video_embed','pdf') DEFAULT 'markdown',
  `title` varchar(255) DEFAULT NULL,
  `short_description` text NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_study_materials`
--

INSERT INTO `master_study_materials` (`id`, `master_milestone_id`, `content_type`, `title`, `short_description`, `content`, `sort_order`) VALUES
(1, 1, 'text', 'Introduction to Programming', '', 'Learn the basics of programming, including variables, data types, and control structures.', 1),
(2, 1, 'markdown', 'Variables and Data Types', '', '# Variables and Data Types\nThis topic covers the basic concepts of variables and data types in programming.', 2),
(3, 1, 'text', 'Control Structures', '', 'Understand how if-else statements, for loops, and while loops work in programming.', 3),
(4, 1, 'markdown', 'Functions', '', '# Functions\nThis topic covers the basics of functions in programming, including function definitions and calls.', 4),
(5, 1, 'text', 'Object-Oriented Programming', '', 'Learn the basics of object-oriented programming, including classes, objects, and inheritance.', 5),
(6, 2, 'text', 'Linear Algebra', '', 'Understand the basics of linear algebra, including vectors, matrices, and operations.', 1),
(7, 2, 'markdown', 'Calculus', '', '# Calculus\nThis topic covers the fundamentals of calculus, including limits, derivatives, and integrals.', 2),
(8, 2, 'text', 'Statistics', '', 'Learn the basics of statistics, including data visualization, descriptive statistics, and inferential statistics.', 3),
(9, 2, 'text', 'Recommended Reading 4 for Math Fundamentals for Machine Learning', '', 'Please research core concepts of Math Fundamentals for Machine Learning to build a strong foundation. Focus on official documentation and community best practices.', 4),
(10, 2, 'text', 'Recommended Reading 5 for Math Fundamentals for Machine Learning', '', 'Please research core concepts of Math Fundamentals for Machine Learning to build a strong foundation. Focus on official documentation and community best practices.', 5),
(11, 3, 'text', 'Introduction to Python', '', 'Learn the basics of Python, including syntax, data types, and control structures.', 1),
(12, 3, 'markdown', 'Python Libraries for Machine Learning', '', '# Python Libraries for Machine Learning\nThis topic covers popular libraries used in machine learning, such as NumPy, pandas, and scikit-learn.', 2),
(13, 3, 'text', 'Recommended Reading 3 for Python Programming for Machine Learning', '', 'Please research core concepts of Python Programming for Machine Learning to build a strong foundation. Focus on official documentation and community best practices.', 3),
(14, 3, 'text', 'Recommended Reading 4 for Python Programming for Machine Learning', '', 'Please research core concepts of Python Programming for Machine Learning to build a strong foundation. Focus on official documentation and community best practices.', 4),
(15, 3, 'text', 'Recommended Reading 5 for Python Programming for Machine Learning', '', 'Please research core concepts of Python Programming for Machine Learning to build a strong foundation. Focus on official documentation and community best practices.', 5),
(16, 4, 'text', 'Introduction to Machine Learning', '', 'Learn the basics of machine learning, including supervised and unsupervised learning, regression, classification, clustering, and dimensionality reduction.', 1),
(17, 4, 'markdown', 'Supervised Learning', '', '# Supervised Learning\nThis topic covers the basics of supervised learning, including linear regression, logistic regression, decision trees, random forests, and support vector machines.', 2),
(18, 4, 'text', 'Recommended Reading 3 for Machine Learning Fundamentals', '', 'Please research core concepts of Machine Learning Fundamentals to build a strong foundation. Focus on official documentation and community best practices.', 3),
(19, 4, 'text', 'Recommended Reading 4 for Machine Learning Fundamentals', '', 'Please research core concepts of Machine Learning Fundamentals to build a strong foundation. Focus on official documentation and community best practices.', 4),
(20, 4, 'text', 'Recommended Reading 5 for Machine Learning Fundamentals', '', 'Please research core concepts of Machine Learning Fundamentals to build a strong foundation. Focus on official documentation and community best practices.', 5),
(21, 5, 'text', 'Deploying Machine Learning Models', '', 'Learn how to deploy machine learning models using popular frameworks such as TensorFlow and scikit-learn.', 1),
(22, 5, 'markdown', 'Building a Portfolio', '', '# Building a Portfolio\nThis topic covers the basics of building a portfolio for machine learning engineers, including creating a personal website, writing a blog, and sharing projects on platforms like GitHub and Kaggle.', 2),
(23, 5, 'text', 'Recommended Reading 3 for Machine Learning Deployment and Portfolio Building', '', 'Please research core concepts of Machine Learning Deployment and Portfolio Building to build a strong foundation. Focus on official documentation and community best practices.', 3),
(24, 5, 'text', 'Recommended Reading 4 for Machine Learning Deployment and Portfolio Building', '', 'Please research core concepts of Machine Learning Deployment and Portfolio Building to build a strong foundation. Focus on official documentation and community best practices.', 4),
(25, 5, 'text', 'Recommended Reading 5 for Machine Learning Deployment and Portfolio Building', '', 'Please research core concepts of Machine Learning Deployment and Portfolio Building to build a strong foundation. Focus on official documentation and community best practices.', 5),
(26, 6, 'text', 'Choosing a Real-World Project', '', 'Learn how to choose a real-world project that aligns with your interests and skills.', 1),
(27, 6, 'markdown', 'Working on a Real-World Project', '', '# Working on a Real-World Project\nThis topic covers the basics of working on a real-world machine learning project, including data preprocessing, feature engineering, model training, and deployment.', 2),
(28, 6, 'text', 'Recommended Reading 3 for Real-World Machine Learning Projects', '', 'Please research core concepts of Real-World Machine Learning Projects to build a strong foundation. Focus on official documentation and community best practices.', 3),
(29, 6, 'text', 'Recommended Reading 4 for Real-World Machine Learning Projects', '', 'Please research core concepts of Real-World Machine Learning Projects to build a strong foundation. Focus on official documentation and community best practices.', 4),
(30, 6, 'text', 'Recommended Reading 5 for Real-World Machine Learning Projects', '', 'Please research core concepts of Real-World Machine Learning Projects to build a strong foundation. Focus on official documentation and community best practices.', 5);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 99,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `sort_order`, `is_active`) VALUES
(1, 'Software Developer', 1, 1),
(2, 'Frontend Developer', 2, 1),
(3, 'Backend Developer', 3, 1),
(4, 'Data Analyst', 4, 1),
(5, 'Data Scientist', 5, 1),
(6, 'AI Engineer', 6, 1),
(7, 'ML Engineer', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `training_plans`
--

CREATE TABLE `training_plans` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `experience_level_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_generated` tinyint(1) NOT NULL DEFAULT 0,
  `generated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `training_plans`
--

INSERT INTO `training_plans` (`id`, `role_id`, `experience_level_id`, `title`, `description`, `is_generated`, `generated_at`) VALUES
(1, 7, 1, 'ML Engineer - Fresher (0–1 year) Training Plan', 'AI-generated training plan based on your role, experience level, and skills.', 1, '2026-02-24 15:12:05');

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
(2, 'profile_77d7682f715a4fe3b09e31bc7f3bd7a9.jpg', 'Manoj', 'mydatab99@gmail.com', '9760894418', '0.3921568691730499,0.3803921639919281,0.45490196347236633,0.3803921639919281,0.22745098173618317,0.4117647111415863,0.4274509847164154,0.3803921639919281,0.40392157435417175,0.3960784375667572,0.18431372940540314,0.4156862795352936,0.43921568989753723,0.3960784375667572,0.40392157435417175,0.23137255012989044,0.3843137323856354,0.3803921639919281,0.45098039507865906,0.3960784375667572,0.21176470816135406,0.20392157137393951,0.1725490242242813,0.18431372940540314,0.2235294133424759,0.4156862795352936,0.18431372940540314,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.32549020648002625,0.41960784792900085,0.3529411852359772,0.29019609093666077,0.32156863808631897,0.40392157435417175,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2666666805744171,0.18431372940540314,0.20392157137393951,0.40392157435417175,0.2823529541492462,0.3490196168422699,0.32549020648002625,0.3333333432674408,0.30588236451148987,0.2666666805744171,0.3450980484485626,0.1921568661928177,0.25882354378700256,0.32549020648002625,0.3294117748737335,0.1882352977991104,0.3529411852359772,0.29019609093666077,0.3294117748737335,0.2705882489681244,0.3333333432674408,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2823529541492462,0.2862745225429535,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.46666666865348816,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.45490196347236633,0.3843137323856354,0.4313725531101227,0.32156863808631897,0.4745098054409027,0.3333333432674408,0.41960784792900085,0.3921568691730499,0.26274511218070984,0.2862745225429535,0.27450981736183167,0.40784314274787903,0.3529411852359772,0.34117648005485535,0.4117647111415863,0.2549019753932953,0.2823529541492462,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.40784314274787903,0.3490196168422699,0.20000000298023224,0.30588236451148987,0.46666666865348816,0.2549019753932953', '2026-02-22 22:22:20.416900');

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

--
-- Dumping data for table `user_login_details`
--

INSERT INTO `user_login_details` (`id`, `user_id`, `login_method`, `face_encoding`, `face_image_path`, `confidence_score`, `ip_address`, `device_info`, `browser_info`, `os_info`, `login_status`, `failure_reason`, `created_at`) VALUES
(1, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-22 17:31:16'),
(2, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-23 17:00:37'),
(3, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 05:53:28'),
(4, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 07:06:54'),
(5, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 08:41:33'),
(6, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 09:47:48'),
(7, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 11:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `user_milestone_progress`
--

CREATE TABLE `user_milestone_progress` (
  `id` int(11) NOT NULL,
  `user_training_plan_id` int(11) NOT NULL,
  `master_milestone_id` int(11) NOT NULL,
  `status` enum('locked','in_progress','completed') NOT NULL DEFAULT 'locked',
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `progress_percentage` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_milestone_progress`
--

INSERT INTO `user_milestone_progress` (`id`, `user_training_plan_id`, `master_milestone_id`, `status`, `started_at`, `completed_at`, `progress_percentage`) VALUES
(1, 1, 1, 'in_progress', NULL, NULL, 0),
(2, 1, 2, 'locked', NULL, NULL, 0),
(3, 1, 3, 'locked', NULL, NULL, 0),
(4, 1, 4, 'locked', NULL, NULL, 0),
(5, 1, 5, 'locked', NULL, NULL, 0),
(6, 1, 6, 'locked', NULL, NULL, 0);

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
(2, 2, 7, 1, 'php', 'resume_735934ff1957458eab6463371c0cdd20.pdf', '2026-02-22 22:22:38.195310', '2026-02-22 23:08:26.000000');

-- --------------------------------------------------------

--
-- Table structure for table `user_practice_answers`
--

CREATE TABLE `user_practice_answers` (
  `id` int(11) NOT NULL,
  `user_practice_session_id` int(11) NOT NULL,
  `master_quiz_question_id` int(11) NOT NULL,
  `user_selected_option` varchar(100) NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `time_spent_seconds` smallint(6) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_practice_sessions`
--

CREATE TABLE `user_practice_sessions` (
  `id` int(11) NOT NULL,
  `user_milestone_progress_id` int(11) NOT NULL,
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `ended_at` datetime DEFAULT NULL,
  `question_count` tinyint(4) NOT NULL DEFAULT 10,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `total_time_seconds` int(11) DEFAULT 0,
  `selected_questions_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`selected_questions_json`)),
  `correct_count` tinyint(4) DEFAULT 0,
  `wrong_count` tinyint(4) DEFAULT 0,
  `accuracy_percentage` tinyint(4) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_quiz_attempts`
--

CREATE TABLE `user_quiz_attempts` (
  `id` int(11) NOT NULL,
  `user_milestone_progress_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_questions` int(11) NOT NULL,
  `passed` tinyint(1) NOT NULL DEFAULT 0,
  `attempted_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_quiz_submitted_answers`
--

CREATE TABLE `user_quiz_submitted_answers` (
  `id` int(11) NOT NULL,
  `user_quiz_attempt_id` int(11) NOT NULL,
  `master_quiz_question_id` int(11) NOT NULL,
  `user_selected_option` varchar(100) NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `time_spent_seconds` smallint(6) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_study_material_progress`
--

CREATE TABLE `user_study_material_progress` (
  `id` int(11) NOT NULL,
  `user_milestone_progress_id` int(11) NOT NULL,
  `master_study_material_id` int(11) NOT NULL,
  `is_completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_study_progress`
--

CREATE TABLE `user_study_progress` (
  `id` int(11) NOT NULL,
  `user_milestone_progress_id` int(11) NOT NULL,
  `master_study_material_id` int(11) NOT NULL,
  `viewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_training_plans`
--

CREATE TABLE `user_training_plans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `training_plan_id` int(11) NOT NULL,
  `assigned_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','completed','paused') NOT NULL DEFAULT 'active',
  `current_milestone_number` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_training_plans`
--

INSERT INTO `user_training_plans` (`id`, `user_id`, `training_plan_id`, `assigned_at`, `status`, `current_milestone_number`) VALUES
(1, 2, 1, '2026-02-24 15:12:05', 'active', 1);

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
-- Indexes for table `master_milestones`
--
ALTER TABLE `master_milestones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_milestone_plan_num` (`training_plan_id`,`milestone_number`);

--
-- Indexes for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_question_difficulty` (`master_milestone_id`,`difficulty`);

--
-- Indexes for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_study_milestone` (`master_milestone_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_name` (`name`);

--
-- Indexes for table `training_plans`
--
ALTER TABLE `training_plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_plan_role_exp` (`role_id`,`experience_level_id`),
  ADD KEY `fk_plan_exp` (`experience_level_id`);

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
-- Indexes for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_milestone` (`user_training_plan_id`,`master_milestone_id`),
  ADD KEY `fk_progress_milestone` (`master_milestone_id`);

--
-- Indexes for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_onboarding_user` (`user_id`),
  ADD KEY `fk_user_onboarding_role` (`role_id`),
  ADD KEY `fk_user_onboarding_experience` (`experience_level_id`);

--
-- Indexes for table `user_practice_answers`
--
ALTER TABLE `user_practice_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_practice_session_question` (`user_practice_session_id`,`master_quiz_question_id`),
  ADD KEY `fk_practiceans_question` (`master_quiz_question_id`);

--
-- Indexes for table `user_practice_sessions`
--
ALTER TABLE `user_practice_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_practice_progress` (`user_milestone_progress_id`);

--
-- Indexes for table `user_quiz_attempts`
--
ALTER TABLE `user_quiz_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_milestone_progress_id` (`user_milestone_progress_id`),
  ADD KEY `ix_user_quiz_attempts_id` (`id`);

--
-- Indexes for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_quiz_attempt_question` (`user_quiz_attempt_id`,`master_quiz_question_id`),
  ADD KEY `fk_quizans_question` (`master_quiz_question_id`);

--
-- Indexes for table `user_study_material_progress`
--
ALTER TABLE `user_study_material_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_milestone_progress_id` (`user_milestone_progress_id`),
  ADD KEY `master_study_material_id` (`master_study_material_id`),
  ADD KEY `ix_user_study_material_progress_id` (`id`);

--
-- Indexes for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_study_view` (`user_milestone_progress_id`,`master_study_material_id`),
  ADD KEY `fk_studyprog_material` (`master_study_material_id`);

--
-- Indexes for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_training_plan` (`user_id`),
  ADD KEY `fk_userplan_plan` (`training_plan_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `experience_levels`
--
ALTER TABLE `experience_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_milestones`
--
ALTER TABLE `master_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=361;

--
-- AUTO_INCREMENT for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `training_plans`
--
ALTER TABLE `training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_login_details`
--
ALTER TABLE `user_login_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_practice_answers`
--
ALTER TABLE `user_practice_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_practice_sessions`
--
ALTER TABLE `user_practice_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_quiz_attempts`
--
ALTER TABLE `user_quiz_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_study_material_progress`
--
ALTER TABLE `user_study_material_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `master_milestones`
--
ALTER TABLE `master_milestones`
  ADD CONSTRAINT `fk_milestone_plan` FOREIGN KEY (`training_plan_id`) REFERENCES `training_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  ADD CONSTRAINT `fk_question_milestone` FOREIGN KEY (`master_milestone_id`) REFERENCES `master_milestones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  ADD CONSTRAINT `fk_study_milestone` FOREIGN KEY (`master_milestone_id`) REFERENCES `master_milestones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `training_plans`
--
ALTER TABLE `training_plans`
  ADD CONSTRAINT `fk_plan_exp` FOREIGN KEY (`experience_level_id`) REFERENCES `experience_levels` (`id`),
  ADD CONSTRAINT `fk_plan_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_login_details`
--
ALTER TABLE `user_login_details`
  ADD CONSTRAINT `user_login_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  ADD CONSTRAINT `fk_progress_milestone` FOREIGN KEY (`master_milestone_id`) REFERENCES `master_milestones` (`id`),
  ADD CONSTRAINT `fk_progress_userplan` FOREIGN KEY (`user_training_plan_id`) REFERENCES `user_training_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  ADD CONSTRAINT `fk_user_onboarding_experience` FOREIGN KEY (`experience_level_id`) REFERENCES `experience_levels` (`id`),
  ADD CONSTRAINT `fk_user_onboarding_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_user_onboarding_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_practice_answers`
--
ALTER TABLE `user_practice_answers`
  ADD CONSTRAINT `fk_practiceans_question` FOREIGN KEY (`master_quiz_question_id`) REFERENCES `master_quiz_questions` (`id`),
  ADD CONSTRAINT `fk_practiceans_session` FOREIGN KEY (`user_practice_session_id`) REFERENCES `user_practice_sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_practice_sessions`
--
ALTER TABLE `user_practice_sessions`
  ADD CONSTRAINT `fk_practice_progress` FOREIGN KEY (`user_milestone_progress_id`) REFERENCES `user_milestone_progress` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_quiz_attempts`
--
ALTER TABLE `user_quiz_attempts`
  ADD CONSTRAINT `user_quiz_attempts_ibfk_1` FOREIGN KEY (`user_milestone_progress_id`) REFERENCES `user_milestone_progress` (`id`);

--
-- Constraints for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  ADD CONSTRAINT `fk_quizans_attempt` FOREIGN KEY (`user_quiz_attempt_id`) REFERENCES `user_quiz_attempts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_quizans_question` FOREIGN KEY (`master_quiz_question_id`) REFERENCES `master_quiz_questions` (`id`);

--
-- Constraints for table `user_study_material_progress`
--
ALTER TABLE `user_study_material_progress`
  ADD CONSTRAINT `user_study_material_progress_ibfk_1` FOREIGN KEY (`user_milestone_progress_id`) REFERENCES `user_milestone_progress` (`id`),
  ADD CONSTRAINT `user_study_material_progress_ibfk_2` FOREIGN KEY (`master_study_material_id`) REFERENCES `master_study_materials` (`id`);

--
-- Constraints for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  ADD CONSTRAINT `fk_studyprog_material` FOREIGN KEY (`master_study_material_id`) REFERENCES `master_study_materials` (`id`),
  ADD CONSTRAINT `fk_studyprog_progress` FOREIGN KEY (`user_milestone_progress_id`) REFERENCES `user_milestone_progress` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  ADD CONSTRAINT `fk_userplan_plan` FOREIGN KEY (`training_plan_id`) REFERENCES `training_plans` (`id`),
  ADD CONSTRAINT `fk_userplan_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
