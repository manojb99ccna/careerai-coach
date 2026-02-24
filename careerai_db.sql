-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2026 at 06:54 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `master_study_materials`
--

CREATE TABLE `master_study_materials` (
  `id` int(11) NOT NULL,
  `master_milestone_id` int(11) NOT NULL,
  `content_type` enum('text','markdown','link','video_embed','pdf') DEFAULT 'markdown',
  `title` varchar(255) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(3, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 05:53:28');

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
  `questions_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`questions_json`)),
  `score` float DEFAULT NULL,
  `time_taken` int(11) DEFAULT 0,
  `passed` tinyint(1) DEFAULT 0,
  `last_attempt_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  ADD KEY `fk_quiz_progress` (`user_milestone_progress_id`);

--
-- Indexes for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_quiz_attempt_question` (`user_quiz_attempt_id`,`master_quiz_question_id`),
  ADD KEY `fk_quizans_question` (`master_quiz_question_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `training_plans`
--
ALTER TABLE `training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_login_details`
--
ALTER TABLE `user_login_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `fk_quiz_progress` FOREIGN KEY (`user_milestone_progress_id`) REFERENCES `user_milestone_progress` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  ADD CONSTRAINT `fk_quizans_attempt` FOREIGN KEY (`user_quiz_attempt_id`) REFERENCES `user_quiz_attempts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_quizans_question` FOREIGN KEY (`master_quiz_question_id`) REFERENCES `master_quiz_questions` (`id`);

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
