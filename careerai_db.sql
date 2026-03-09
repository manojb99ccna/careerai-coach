-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 09, 2026 at 08:18 AM
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
-- Table structure for table `face_login_attempts`
--

CREATE TABLE `face_login_attempts` (
  `id` int(11) NOT NULL,
  `matched_user_id` int(11) DEFAULT NULL,
  `match_type` varchar(20) NOT NULL DEFAULT 'none',
  `login_method` varchar(20) DEFAULT NULL,
  `face_image_path` varchar(500) DEFAULT NULL,
  `confidence_score` float DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `device_info` varchar(255) DEFAULT NULL,
  `browser_info` varchar(255) DEFAULT NULL,
  `os_info` varchar(100) DEFAULT NULL,
  `login_status` varchar(10) NOT NULL,
  `failure_reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `face_login_attempts`
--

INSERT INTO `face_login_attempts` (`id`, `matched_user_id`, `match_type`, `login_method`, `face_image_path`, `confidence_score`, `ip_address`, `device_info`, `browser_info`, `os_info`, `login_status`, `failure_reason`, `created_at`) VALUES
(1, 5, 'verified', 'face', 'login_a2f610de938844b4a14c1a349ed05c9f.jpg', 0.304183, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 12:31:14'),
(2, 5, 'verified', 'face', 'login_80298157e2924fef81c4c4e768c2caaf.jpg', 0.331661, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 12:39:54'),
(3, 5, 'verified', 'face', 'login_8ba5d60de907456ab3cfb33a7fd7df4f.jpg', 0.311064, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 12:44:06'),
(4, 5, 'verified', 'face', 'login_88622da9b6fb4b91a39cd74d209766e9.jpg', 0.344086, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 12:46:13');

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
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_content_generated` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_milestones`
--

INSERT INTO `master_milestones` (`id`, `training_plan_id`, `milestone_number`, `title`, `description`, `estimated_days`, `sort_order`, `is_content_generated`) VALUES
(28, 8, 1, 'Foundations of AI', 'Study the basics of artificial intelligence, including machine learning, neural networks, and data structures.', 15, 1, 1),
(29, 8, 2, 'Python Programming', 'Learn the Python programming language, focusing on its applications in AI and data science.', 10, 2, 1),
(30, 8, 3, 'AI Engineer Portfolio', 'Develop a portfolio of real-world projects showcasing AI engineering skills, including deployment and production readiness.', 20, 3, 1),
(31, 9, 1, 'Data Analysis Fundamentals', 'Understand data analysis concepts, data visualization, and data manipulation with Python.', 15, 1, 1),
(32, 9, 2, 'SQL and Data Storage', 'Learn to work with databases, including querying and data modeling, and understand data storage concepts.', 12, 2, 0),
(33, 9, 3, 'Real-World Data Analysis and Portfolio', 'Apply data analysis skills to real-world projects, create a portfolio, and prepare for production and deployment.', 18, 3, 0);

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
(890, 28, 'What is the primary goal of machine learning?', 'multiple_choice', 'easy', '[\"A. To improve computer hardware\", \"B. To develop natural language processing\", \"C. To create complex algorithms\", \"D. To enable systems to learn from data\"]', 'D', 'The primary goal of machine learning is to enable systems to learn from data and make predictions without being explicitly programmed.', NULL, '2026-02-27 12:51:43'),
(891, 28, 'What type of AI is machine learning?', 'multiple_choice', 'easy', '[\"A. Reinforcement Learning\", \"B. Computer Vision\", \"C. Machine Learning\", \"D. Natural Language Processing\"]', 'C', 'Machine learning is a type of artificial intelligence that enables systems to learn from data and make predictions without being explicitly programmed.', NULL, '2026-02-27 12:51:43'),
(892, 28, 'What are neural networks used for?', 'multiple_choice', 'easy', '[\"A. Computer Vision\", \"B. Pattern Recognition and Decision-Making\", \"C. Natural Language Processing\", \"D. Robotics\"]', 'B', 'Neural networks are a type of machine learning algorithm that mimic the way the human brain works, and they are used for pattern recognition and decision-making.', NULL, '2026-02-27 12:51:43'),
(893, 28, 'What is the primary component of a neural network?', 'multiple_choice', 'medium', '[\"A. Activation Function\", \"B. Output Layer\", \"C. Hidden Layers\", \"D. Input Layer\"]', 'C', 'The primary component of a neural network is the hidden layer, which is composed of interconnected nodes (neurons) that process and transmit information.', NULL, '2026-02-27 12:51:43'),
(894, 28, 'What is the purpose of an activation function in a neural network?', 'multiple_choice', 'medium', '[\"A. To connect input layers to output layers\", \"B. To introduce non-linearity into the model\", \"C. To improve the accuracy of predictions\", \"D. To decide when to stop learning\"]', 'B', 'The activation function is used in a neural network to introduce non-linearity into the model, allowing it to learn more complex patterns and relationships.', NULL, '2026-02-27 12:51:43'),
(895, 28, 'What type of machine learning algorithm uses labeled data?', 'multiple_choice', 'medium', '[\"A. Supervised Learning\", \"B. Transfer Learning\", \"C. Reinforcement Learning\", \"D. Unsupervised Learning\"]', 'A', 'Supervised learning is a type of machine learning that uses labeled data to train a model and make predictions.', NULL, '2026-02-27 12:51:43'),
(896, 28, 'What type of AI is reinforcement learning?', 'multiple_choice', 'medium', '[\"A. Natural Language Processing\", \"B. Reinforcement Learning\", \"C. Computer Vision\", \"D. Transfer Learning\"]', 'B', 'Reinforcement learning is a type of artificial intelligence that enables systems to learn from trial and error, receiving rewards or penalties for their actions.', NULL, '2026-02-27 12:51:43'),
(897, 28, 'What is the primary difference between supervised and unsupervised learning?', 'multiple_choice', 'hard', '[\"A. Transfer learning is a type of machine learning\", \"B. Supervised learning uses labeled data\", \"C. Reinforcement learning only works with images\", \"D. Unsupervised learning does not use labeled data\"]', 'B', 'The primary difference between supervised and unsupervised learning is that supervised learning uses labeled data, while unsupervised learning does not.', NULL, '2026-02-27 12:51:43'),
(898, 28, 'What is the term for the process by which an AI system becomes more accurate over time?', 'multiple_choice', 'hard', '[\"A. Learning\", \"B. Refining\", \"C. Improving\", \"D. Training\"]', 'A', 'The term for the process by which an AI system becomes more accurate over time is learning, which is achieved through machine learning algorithms and training data.', NULL, '2026-02-27 12:51:43'),
(899, 28, 'What type of machine learning algorithm does Netflix use?', 'multiple_choice', 'hard', '[\"A. Reinforcement Learning\", \"B. Unsupervised Learning\", \"C. Transfer Learning\", \"D. Supervised Learning\"]', 'D', 'Netflix uses supervised learning to train its recommendation systems, which analyze user preferences and recommend movies or TV shows based on their previous behavior.', NULL, '2026-02-27 12:51:43'),
(900, 28, 'What is the term for a machine learning algorithm that can be fine-tuned for a specific task?', 'multiple_choice', 'hard', '[\"A. Transfer learning\", \"B. Unsupervised learning\", \"C. Pre-trained model\", \"D. Supervised learning\"]', 'A', 'The term for a machine learning algorithm that can be fine-tuned for a specific task is transfer learning, which allows models to adapt to new tasks and datasets while still retaining knowledge from previous training.', NULL, '2026-02-27 12:51:43'),
(901, 28, 'Medium practice question 12 for Foundations of AI', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. It depends on context\", \"C. Concept is incorrect\", \"D. Concept is partially correct\"]', 'A', 'This is a synthetic medium question to reinforce Foundations of AI. Option A reflects the correct core idea.', NULL, '2026-02-27 12:51:43'),
(902, 29, 'What is the primary benefit of using an interpreted language like Python?', 'multiple_choice', 'easy', '[\"A. It\'s more secure than compiled languages\", \"B. It\'s faster than compiled languages\", \"C. It provides clear syntax and simplicity\", \"D. It allows for easy integration with other tools\"]', 'C', 'Python\'s interpreted nature makes it easier to learn and use, as you don\'t need to worry about compilation and linking.', NULL, '2026-02-27 13:11:12'),
(903, 29, 'Which Python library is commonly used for machine learning tasks?', 'multiple_choice', 'easy', '[\"A. Pandas\", \"B. Matplotlib\", \"C. Scikit-learn\", \"D. NumPy\"]', 'C', 'Scikit-learn provides a wide range of algorithms for classification, regression, clustering, and more.', NULL, '2026-02-27 13:11:12'),
(904, 29, 'What is the purpose of pre-processing data in machine learning?', 'multiple_choice', 'medium', '[\"A. To speed up model training\", \"B. To improve model accuracy\", \"C. To reduce data noise\", \"D. To increase computational resources\"]', 'C', 'Pre-processing data helps to remove noise and irrelevant information, making it easier for the model to learn patterns and make accurate predictions.', NULL, '2026-02-27 13:11:12'),
(905, 29, 'Which Python framework is often used for web development?', 'multiple_choice', 'easy', '[\"A. Django\", \"B. Pyramid\", \"C. Sanic\", \"D. Flask\"]', 'D', 'Flask provides a lightweight and flexible way to build web applications, making it a popular choice for beginners.', NULL, '2026-02-27 13:11:12'),
(906, 29, 'What is the primary goal of machine learning?', 'multiple_choice', 'medium', '[\"A. To predict future outcomes\", \"B. To classify existing data\", \"C. To automate decision-making\", \"D. To improve data visualization\"]', 'A', 'The primary goal of machine learning is to train models that can make accurate predictions on new, unseen data.', NULL, '2026-02-27 13:11:12'),
(907, 29, 'Which Python library is used for data manipulation and analysis?', 'multiple_choice', 'easy', '[\"A. Pandas\", \"B. Scikit-learn\", \"C. NumPy\", \"D. Matplotlib\"]', 'A', 'Pandas provides powerful data structures and operations for data manipulation, making it a popular choice for data scientists.', NULL, '2026-02-27 13:11:12'),
(908, 29, 'What is the purpose of splitting data into training and testing sets?', 'multiple_choice', 'medium', '[\"A. To evaluate model performance\", \"B. To reduce overfitting\", \"C. To improve model accuracy\", \"D. To speed up model training\"]', 'B', 'Splitting data helps to prevent a model from overfitting by providing an unbiased evaluation of its performance.', NULL, '2026-02-27 13:11:12'),
(909, 29, 'Which Python library is used for machine learning and deep learning tasks?', 'multiple_choice', 'medium', '[\"A. Keras\", \"B. TensorFlow\", \"C. OpenCV\", \"D. Scikit-learn\"]', 'B', 'TensorFlow provides a powerful platform for building and training machine learning models, especially those involving deep learning.', NULL, '2026-02-27 13:11:12'),
(910, 29, 'What is the primary benefit of using an interpreted language like Python?', 'multiple_choice', 'easy', '[\"A. It\'s faster than compiled languages\", \"B. It allows for easy integration with other tools\", \"C. It\'s more secure than compiled languages\", \"D. It provides clear syntax and simplicity\"]', 'D', 'Python\'s interpreted nature makes it easier to learn and use, as you don\'t need to worry about compilation and linking.', NULL, '2026-02-27 13:11:12'),
(911, 29, 'Which Python library is used for data visualization?', 'multiple_choice', 'easy', '[\"A. Seaborn\", \"B. Matplotlib\", \"C. NumPy\", \"D. Pandas\"]', 'B', 'Matplotlib provides a wide range of visualizations and tools for creating plots, charts, and graphs.', NULL, '2026-02-27 13:11:12'),
(912, 29, 'What is the purpose of deploying a trained machine learning model?', 'multiple_choice', 'medium', '[\"A. To speed up model training\", \"B. To make predictions on new data\", \"C. To evaluate model performance\", \"D. To improve model accuracy\"]', 'B', 'Deploying a trained model allows it to make predictions on new, unseen data, making it a crucial step in machine learning applications.', NULL, '2026-02-27 13:11:12'),
(913, 29, 'Which Python library is used for web development and building web frameworks?', 'multiple_choice', 'medium', '[\"A. Pyramid\", \"B. Flask\", \"C. Sanic\", \"D. Django\"]', 'D', 'Django provides a robust framework for building complex web applications, making it a popular choice for large-scale projects.', NULL, '2026-02-27 13:11:12'),
(914, 30, 'What is the primary goal of production readiness in AI engineering?', 'multiple_choice', 'easy', '[\"A. To optimize hyperparameters\", \"B. To improve model interpretability\", \"C. To ensure AI models are deployable\", \"D. To increase data preprocessing efficiency\"]', 'C', 'Production readiness focuses on preparing AI models for real-world deployment, ensuring they can handle production-level data and scale as needed.', NULL, '2026-02-27 13:14:48'),
(915, 30, 'What is the primary benefit of model interpretability?', 'multiple_choice', 'easy', '[\"A. To enhance trust and transparency\", \"B. To optimize hyperparameters\", \"C. To increase data preprocessing efficiency\", \"D. To improve model accuracy\"]', 'A', 'Model interpretability provides insights into the decision-making process, enabling better understanding and trust.', NULL, '2026-02-27 13:14:48'),
(916, 30, 'What is the purpose of training AI models on diverse datasets?', 'multiple_choice', 'medium', '[\"A. To improve model accuracy\", \"B. To ensure AI models are deployable\", \"C. To optimize hyperparameters\", \"D. To increase data preprocessing efficiency\"]', 'A', 'Training AI models on diverse datasets helps develop robust and generalize well, ensuring they perform consistently across different scenarios.', NULL, '2026-02-27 13:14:48'),
(917, 30, 'What is an example of a real-world application that requires model interpretability?', 'multiple_choice', 'medium', '[\"A. Self-driving cars\", \"B. Medical diagnosis systems\", \"C. Weather forecasting\", \"D. Customer service chatbots\"]', 'B', 'Medical diagnosis systems require model interpretability to provide doctors with personalized treatment recommendations and insights into the decision-making process.', NULL, '2026-02-27 13:14:48'),
(918, 30, 'What is an important consideration for achieving production readiness?', 'multiple_choice', 'medium', '[\"A. Data preprocessing efficiency\", \"B. Scalability\", \"C. Model accuracy\", \"D. Hyperparameter tuning\"]', 'B', 'Scalability is critical in achieving production readiness, as AI models must be able to handle large volumes of data and scale resources accordingly.', NULL, '2026-02-27 13:14:48'),
(919, 30, 'What is the purpose of hyperparameter tuning in AI engineering?', 'multiple_choice', 'hard', '[\"A. To optimize model accuracy\", \"B. To tune hyperparameters for optimal performance\", \"C. To improve model interpretability\", \"D. To increase data preprocessing efficiency\"]', 'B', 'Hyperparameter tuning is essential to find the optimal combination of parameters that balances model performance, scalability, and computational resources.', NULL, '2026-02-27 13:14:48'),
(920, 30, 'What is an important consideration for ensuring AI models are deployable?', 'multiple_choice', 'hard', '[\"A. Model accuracy\", \"B. Production-readiness assessment\", \"C. Scalability\", \"D. Data preprocessing efficiency\"]', 'B', 'A production-readiness assessment evaluates the readiness of AI models for real-world deployment, considering factors such as data quality, model performance, and scalability.', NULL, '2026-02-27 13:14:48'),
(921, 30, 'What is an example of a technique used to improve model interpretability?', 'multiple_choice', 'hard', '[\"A. Feature attribution\", \"B. Partial dependence plots\", \"C. Hyperparameter tuning\", \"D. Data preprocessing\"]', 'A', 'Feature attribution is a technique that assigns importance scores to input features, providing insights into the decision-making process and model behavior.', NULL, '2026-02-27 13:14:48'),
(922, 30, 'What is an important consideration for achieving AI model robustness?', 'multiple_choice', 'hard', '[\"A. Scalability\", \"B. Robustness to unexpected data patterns\", \"C. Model accuracy\", \"D. Data preprocessing efficiency\"]', 'B', 'Robustness to unexpected data patterns is crucial in AI engineering, as real-world data often exhibits unpredictable patterns and outliers.', NULL, '2026-02-27 13:14:48'),
(923, 30, 'What is an important consideration for ensuring AI models generalize well?', 'multiple_choice', 'hard', '[\"A. Model accuracy\", \"B. Scalability\", \"C. Data preprocessing efficiency\", \"D. Training on diverse datasets\"]', 'D', 'Training AI models on diverse datasets helps develop robustness and generalization capabilities, enabling consistent performance across different scenarios.', NULL, '2026-02-27 13:14:48'),
(924, 30, 'Medium practice question 11 for AI Engineer Portfolio', 'multiple_choice', 'medium', '[\"A. Concept is partially correct\", \"B. Concept is correct\", \"C. It depends on context\", \"D. Concept is incorrect\"]', 'B', 'This is a synthetic medium question to reinforce AI Engineer Portfolio. Option B reflects the correct core idea.', NULL, '2026-02-27 13:14:48'),
(925, 30, 'Medium practice question 12 for AI Engineer Portfolio', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. Concept is correct\", \"C. Concept is partially correct\", \"D. It depends on context\"]', 'B', 'This is a synthetic medium question to reinforce AI Engineer Portfolio. Option B reflects the correct core idea.', NULL, '2026-02-27 13:14:48'),
(926, 31, 'Medium practice question 1 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. Concept is partially correct\", \"C. Concept is correct\", \"D. It depends on context\"]', 'C', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option C reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(927, 31, 'Medium practice question 2 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option A reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(928, 31, 'Medium practice question 3 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is incorrect\", \"C. It depends on context\", \"D. Concept is partially correct\"]', 'A', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option A reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(929, 31, 'Medium practice question 4 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. It depends on context\", \"B. Concept is correct\", \"C. Concept is partially correct\", \"D. Concept is incorrect\"]', 'B', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option B reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(930, 31, 'Medium practice question 5 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. It depends on context\", \"C. Concept is correct\", \"D. Concept is partially correct\"]', 'C', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option C reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(931, 31, 'Medium practice question 6 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. It depends on context\", \"B. Concept is partially correct\", \"C. Concept is correct\", \"D. Concept is incorrect\"]', 'C', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option C reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(932, 31, 'Medium practice question 7 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. Concept is partially correct\", \"C. Concept is correct\", \"D. It depends on context\"]', 'C', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option C reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(933, 31, 'Medium practice question 8 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. It depends on context\", \"C. Concept is incorrect\", \"D. Concept is partially correct\"]', 'A', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option A reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(934, 31, 'Medium practice question 9 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is partially correct\", \"C. Concept is incorrect\", \"D. It depends on context\"]', 'A', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option A reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(935, 31, 'Medium practice question 10 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. It depends on context\", \"B. Concept is incorrect\", \"C. Concept is partially correct\", \"D. Concept is correct\"]', 'D', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option D reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(936, 31, 'Medium practice question 11 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. It depends on context\", \"B. Concept is incorrect\", \"C. Concept is correct\", \"D. Concept is partially correct\"]', 'C', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option C reflects the correct core idea.', NULL, '2026-03-04 09:13:37'),
(937, 31, 'Medium practice question 12 for Data Analysis Fundamentals', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. Concept is correct\", \"C. Concept is partially correct\", \"D. It depends on context\"]', 'B', 'This is a synthetic medium question to reinforce Data Analysis Fundamentals. Option B reflects the correct core idea.', NULL, '2026-03-04 09:13:37');

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
(117, 28, 'markdown', 'Machine Learning Basics', 'Machine learning is a type of artificial intelligence that enables systems to learn from data and make predictions without being explicitly programmed.', '**Concept Explanation:** Machine learning is a subset of artificial intelligence that enables systems to learn from data and make predictions without being explicitly programmed. This technology uses algorithms to analyze patterns in data, allowing the system to improve its performance over time. **Flow Explanation:** Input Data + Correct Answers ↓ Train Model ↓ Model Learns Patterns ↓ Predict New Data **Real-world Example:** Recommendation systems used by Netflix or Amazon are examples of machine learning in action. These systems learn user preferences and recommend movies or products based on their previous behavior. **Optional Flow Diagram:** If-else statement, For loop, While loop **Key Points Summary:** \n* Machine learning is a type of artificial intelligence that enables systems to learn from data.\n* This technology uses algorithms to analyze patterns in data.\n* Systems can improve their performance over time through machine learning.', 1),
(118, 28, 'markdown', 'Neural Networks', 'A neural network is an artificial intelligence model inspired by the structure and function of the human brain, used for pattern recognition and decision-making.', '**Concept Explanation:** Neural networks are a type of machine learning algorithm that mimic the way the human brain works. They are composed of layers of interconnected nodes (neurons) that process and transmit information. **Flow Explanation:** Input Data + Weights & Biases ↓ Hidden Layer 1 ↓ Activation Function ↓ Output Layer ↓ Prediction **Real-world Example:** Image recognition systems, such as facial recognition or self-driving cars, use neural networks to analyze patterns in images and make decisions based on the results. **Optional Flow Diagram:** \n* If-else statement\n* For loop\n* While loop **Key Points Summary:** \n* Neural networks are a type of machine learning algorithm.\n* They are inspired by the structure and function of the human brain.\n* Neural networks are used for pattern recognition and decision-making.', 2),
(119, 29, 'markdown', 'Python Fundamentals', 'Python is a high-level programming language that provides dynamic typing, syntax for large datasets, and clear syntax. It\'s used for web development, scientific computing, data analysis, artificial intelligence, and machine learning.', '**Concept Explanation:** Python is an interpreted language, which means it doesn\'t need to be compiled before running. This makes it easy to learn and use for beginners. Python is also known for its simplicity and readability due to its syntax. It\'s often used in web development, data analysis, and machine learning tasks.\n\n**Flow Explanation:**\nInput Data + Correct Answers\n ↓ \nTrain Model\n ↓ \nModel Learns Patterns\n ↓ \nPredict New Data\n\n**Real-world Example:** Google uses Python as a primary language for their web development. You can also use Python to automate tasks, such as sending emails or generating reports.\n\n**Optional Flow Diagram:***', 1),
(120, 29, 'markdown', 'Python Libraries and Frameworks', 'Python has numerous libraries and frameworks that facilitate various programming tasks, such as data analysis, machine learning, and web development. These tools help developers create efficient and scalable applications.', '**Concept Explanation:** Python\'s vast library ecosystem provides pre-built functions and modules for tasks like data manipulation, machine learning, and web development. This reduces the need to write custom code, allowing developers to focus on specific areas.\n\n**Flow Explanation:**\nInput Data + Correct Answers\n ↓ \nImport Libraries (e.g., Pandas, NumPy)\n ↓ \nUse Pre-built Functions or Modules\n ↓ \nIntegrate with Other Tools or Frameworks\n ↓ \nAnalyze and Visualize Results\n\n**Real-world Example:** You can use Python\'s popular libraries like Pandas for data analysis, Scikit-learn for machine learning, and Flask for web development.\n\n**Optional Flow Diagram:***', 2),
(121, 29, 'markdown', 'Machine Learning with Python', 'Python has become a leading language for machine learning due to its extensive libraries and frameworks. It\'s used for tasks like data preprocessing, model training, and prediction.', '**Concept Explanation:** Machine learning is a subset of artificial intelligence that involves training models using labeled data to make predictions. Python provides popular libraries like Scikit-learn, TensorFlow, and Keras for building machine learning models.\n\n**Flow Explanation:***\nInput Data + Correct Answers\n ↓ \nPreprocess Data (e.g., scaling, normalization)\n ↓ \nSplit Data into Training and Testing Sets\n ↓ \nTrain Model using Algorithms (e.g., Linear Regression, Decision Trees)\n ↓ \nEvaluate Model Performance and Tune Hyperparameters\n ↓ \nDeploy Trained Model for Predictions\n\n**Real-world Example:** You can use Python to train a model that recognizes handwritten digits or predicts customer churn.\n\n**Optional Flow Diagram:***', 3),
(122, 30, 'markdown', 'AI Engineer Portfolio: Project Deployment and Production Readiness', 'Production readiness is the process of preparing AI models for real-world deployment, ensuring they can handle production-level data and scale as needed.', '### Concept Explanation\n\nProduction readiness is the critical final step in the AI model development lifecycle. It ensures that AI models are deployable, maintainable, and scalable for real-world use cases.\n\nTo achieve production readiness, AI engineers must consider factors such as model interpretability, explainability, and robustness to handle unexpected data patterns. This includes strategies like data preprocessing, feature engineering, and hyperparameter tuning.\n\n### Flow Explanation\n\nInput Data + Correct Answers ↓ Train Model ↓ Model Learns Patterns ↓ Predict New Data\n\n1. **Data Preprocessing**: Clean, transform, and preprocess input data for model training.\n2. **Model Training**: Train the AI model using labeled data and tune hyperparameters for optimal performance.\n3. **Model Evaluation**: Evaluate the trained model\'s performance on a separate test dataset to ensure it generalizes well.\n4. **Deployment**: Deploy the production-ready model in a scalable infrastructure, such as cloud services or containerization.\n\n### Real-world Example\n\nImagine you\'re building an AI-powered chatbot for customer service. After training and evaluating the model, you deploy it on a cloud-based platform to handle thousands of concurrent conversations. To ensure scalability, you design the system to autoscale resources based on traffic patterns.\n\n### Optional Flow Diagram\ncreate flow diagram here (if possible)\n\n### Key Points Summary\n\n• Ensure AI models are trained and tested on diverse datasets for robustness.\n• Implement data preprocessing techniques to handle missing values, outliers, or imbalanced classes.\n• Tune hyperparameters to optimize model performance and scalability.', 1),
(123, 30, 'markdown', 'AI Engineer Portfolio: Model Interpretability', 'Model interpretability is the ability of AI models to provide insights into their decision-making processes, enabling better understanding and trust.', '### Concept Explanation\n\nModel interpretability is crucial in AI engineering, as it allows developers to understand how models make predictions and identify biases or errors. This enables better model selection, improvement, and deployment.\n\nBy providing insights into the decision-making process, interpretable AI models can:\n• Enhance trust and transparency.\n• Facilitate accountability and compliance with regulations.\n• Support domain experts in understanding AI-driven decisions.\n\n### Flow Explanation\n\nInput Data + Correct Answers ↓ Train Model ↓ Model Learns Patterns ↓ Predict New Data ↓ Interpret Results\ncreate flow diagram here (if possible)\n\n1. **Model Training**: Train the AI model using labeled data and tune hyperparameters for optimal performance.\n2. **Model Evaluation**: Evaluate the trained model\'s performance on a separate test dataset to ensure it generalizes well.\n3. **Result Interpretation**: Analyze the model\'s decision-making process, highlighting key features, relationships, or biases.\n\n### Real-world Example\n\nConsider an AI-powered medical diagnosis system that provides patients with personalized treatment recommendations. By incorporating interpretability techniques, such as feature attribution or partial dependence plots, doctors can understand how the model arrived at its conclusions and make more informed decisions.\n\n### Key Points Summary\n\n• Integrate explainable AI techniques to provide insights into model decision-making.\n• Use visualization tools to highlight key features, relationships, or biases.\n• Continuously evaluate and improve model interpretability for better decision-making.', 2),
(124, 31, 'text', 'Recommended Reading 1 for Data Analysis Fundamentals', 'Data Analysis Fundamentals is a key concept that enables scalable solutions in this domain.', '### 1. Concept Explanation\nPlease research core concepts of Data Analysis Fundamentals to build a strong foundation. It is widely used in industry to solve complex problems.\n\n### 2. Flow Explanation\nConcept -> Implementation -> Optimization -> Deployment\n\n### 3. Real-world Example\nMany companies use Data Analysis Fundamentals to improve efficiency by 50%.\n\n### 4. Key Points Summary\n- Core foundation\n- Industry standard\n- Scalable approach', 1),
(125, 31, 'text', 'Recommended Reading 2 for Data Analysis Fundamentals', 'Data Analysis Fundamentals is a key concept that enables scalable solutions in this domain.', '### 1. Concept Explanation\nPlease research core concepts of Data Analysis Fundamentals to build a strong foundation. It is widely used in industry to solve complex problems.\n\n### 2. Flow Explanation\nConcept -> Implementation -> Optimization -> Deployment\n\n### 3. Real-world Example\nMany companies use Data Analysis Fundamentals to improve efficiency by 50%.\n\n### 4. Key Points Summary\n- Core foundation\n- Industry standard\n- Scalable approach', 2);

-- --------------------------------------------------------

--
-- Table structure for table `milestone_settings`
--

CREATE TABLE `milestone_settings` (
  `id` bigint(20) NOT NULL,
  `quiz_questions_total` int(11) NOT NULL DEFAULT 40,
  `practice_questions_total` int(11) NOT NULL DEFAULT 10,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `milestone_settings`
--

INSERT INTO `milestone_settings` (`id`, `quiz_questions_total`, `practice_questions_total`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 2, 10, 1, '2026-02-25 12:47:14', '2026-02-25 13:03:42');

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
(7, 'ML Engineer', 7, 1),
(8, 'PHP', 99, 1);

-- --------------------------------------------------------

--
-- Table structure for table `system_job_logs`
--

CREATE TABLE `system_job_logs` (
  `id` bigint(20) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `started_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `processed_count` int(11) DEFAULT 0,
  `success_count` int(11) DEFAULT 0,
  `failure_count` int(11) DEFAULT 0,
  `error_message` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_job_logs`
--

INSERT INTO `system_job_logs` (`id`, `job_name`, `started_at`, `finished_at`, `status`, `processed_count`, `success_count`, `failure_count`, `error_message`, `created_at`) VALUES
(9, 'maintain_milestones', '2026-02-27 07:40:17', '2026-02-27 07:44:48', 'completed', 1, 1, 1, 'Error on milestone 29: (pymysql.err.IntegrityError) (1451, \'Cannot delete or update a parent row: a foreign key constraint fails (`careerai_db`.`user_study_material_progress`, CONSTRAINT `user_study_material_progress_ibfk_2` FOREIGN KEY (`master_study_material_id`) REFERENCES `master_study_materials` (`id`))\')\n[SQL: DELETE FROM master_study_materials WHERE master_study_materials.master_milestone_id = %(master_milestone_id_1)s]\n[parameters: {\'master_milestone_id_1\': 29}]\n(Background on this error at: https://sqlalche.me/e/20/gkpj)', '2026-02-27 13:10:17');

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
(8, 6, 1, 'AI Engineer - Fresher (0–1 year) Training Plan', 'AI-generated training plan based on your role, experience level, and skills.', 1, '2026-02-27 12:48:23'),
(9, 4, 1, 'Data Analyst - Fresher (0–1 year) Training Plan', 'AI-generated training plan based on your role, experience level, and skills.', 1, '2026-03-04 09:12:50');

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
  `created_at` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `admin_password_salt` varchar(255) DEFAULT NULL,
  `admin_password_hash` varchar(255) DEFAULT NULL,
  `admin_password_iterations` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `profile_image`, `name`, `email`, `phone`, `face_encoding`, `created_at`, `is_admin`, `admin_password_salt`, `admin_password_hash`, `admin_password_iterations`) VALUES
(1, NULL, 'Admin User', 'admin@admin.com', '9999999999', '0.12,0.03,-0.55, ... ,0.08', '2026-03-09 12:04:29.000000', 1, 'p4mjRMTzv8zP/PcfRC4heQ==', 'fficKJm14XbaW5crYxpKto6EKh6hNcxQ/tZChE16z9I=', 200000),
(4, 'profile_db4991bab7774aa2a4d55937a1ee7437.jpg', 'Molu', 'molu@gmail.com', '989899989898', '0.3921568691730499,0.3803921639919281,0.45490196347236633,0.3803921639919281,0.22745098173618317,0.4117647111415863,0.4274509847164154,0.3803921639919281,0.40392157435417175,0.3960784375667572,0.18431372940540314,0.4156862795352936,0.43921568989753723,0.3960784375667572,0.40392157435417175,0.23137255012989044,0.3843137323856354,0.3803921639919281,0.45098039507865906,0.3960784375667572,0.21176470816135406,0.20392157137393951,0.1725490242242813,0.18431372940540314,0.2235294133424759,0.4156862795352936,0.18431372940540314,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.32549020648002625,0.41960784792900085,0.3529411852359772,0.29019609093666077,0.32156863808631897,0.40392157435417175,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2666666805744171,0.18431372940540314,0.20392157137393951,0.40392157435417175,0.2823529541492462,0.3490196168422699,0.32549020648002625,0.3333333432674408,0.30588236451148987,0.2666666805744171,0.3450980484485626,0.1921568661928177,0.25882354378700256,0.32549020648002625,0.3294117748737335,0.1882352977991104,0.3529411852359772,0.29019609093666077,0.3294117748737335,0.2705882489681244,0.3333333432674408,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2823529541492462,0.2862745225429535,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.46666666865348816,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.45490196347236633,0.3843137323856354,0.4313725531101227,0.32156863808631897,0.4745098054409027,0.3333333432674408,0.41960784792900085,0.3921568691730499,0.26274511218070984,0.2862745225429535,0.27450981736183167,0.40784314274787903,0.3529411852359772,0.34117648005485535,0.4117647111415863,0.2549019753932953,0.2823529541492462,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.40784314274787903,0.3490196168422699,0.20000000298023224,0.30588236451148987,0.46666666865348816,0.2549019753932953', '2026-02-27 11:51:15.600219', 0, NULL, NULL, NULL),
(5, 'profile_d7234f20b55b461688fa6e4b6d1539de.jpg', 'manoj', 'mydatab99@gmail.com', '9760894418', '-0.056171078234910965,0.1457575559616089,0.08826415240764618,-0.023418093100190163,-0.09724277257919312,-0.00890298094600439,-0.07816978543996811,-0.06849200278520584,0.16722366213798523,-0.05034524202346802,0.2283780723810196,-0.02679971046745777,-0.23060715198516846,0.06916140019893646,-0.05039319023489952,0.0873405784368515,-0.14337590336799622,-0.11653921008110046,-0.10517404973506927,-0.055172789841890335,0.017344361171126366,0.10205333679914474,0.015083935111761093,0.002360970713198185,-0.13168978691101074,-0.4126492142677307,-0.06622444838285446,-0.17958177626132965,0.07442068308591843,-0.07360512018203735,-0.024442465975880623,0.015536808408796787,-0.0809062197804451,-0.041721444576978683,0.08234620094299316,0.06450261175632477,0.005003001540899277,-0.018396630883216858,0.22976216673851013,0.048925645649433136,-0.16318218410015106,0.036011580377817154,0.09567537158727646,0.32423272728919983,0.06453515589237213,0.11966850608587265,0.06579016894102097,-0.013034619390964508,0.09140732884407043,-0.18765762448310852,0.12323406338691711,0.13760314881801605,0.19591526687145233,0.08235174417495728,0.19065342843532562,-0.19156256318092346,0.06717603653669357,0.05688437819480896,-0.23262841999530792,0.1536213904619217,0.14996960759162903,0.043882958590984344,0.0033136175479739904,0.01242549903690815,0.26248258352279663,0.07259024679660797,-0.11658065021038055,-0.07340803742408752,0.07281193882226944,-0.1524568349123001,-0.056845277547836304,0.044720739126205444,-0.118207648396492,-0.14097973704338074,-0.20490802824497223,0.017719371244311333,0.4014319181442261,0.16303138434886932,-0.22471360862255096,-0.030491668730974197,-0.010809320956468582,-0.07163944095373154,0.0917845368385315,0.01276733260601759,-0.13550838828086853,0.026762299239635468,-0.12434573471546173,-0.012448360212147236,0.18826553225517273,0.037529606372117996,-0.0016359249129891396,0.2392706722021103,0.003700738772749901,0.005018370226025581,0.007634882349520922,0.04066671058535576,-0.1923019289970398,-0.05665211379528046,-0.08943777531385422,-0.04025809466838837,0.044739268720149994,-0.054782573133707047,-0.03153768181800842,0.08028005063533783,-0.2379750907421112,0.11053414642810822,-0.059765953570604324,-0.03115682303905487,-0.026020493358373642,0.11626619100570679,-0.1185486912727356,-0.06855736672878265,0.20522315800189972,-0.22784465551376343,0.1353682279586792,0.1772136241197586,0.016239449381828308,0.08834190666675568,0.05806797370314598,-0.020252510905265808,0.0206920076161623,0.015125260688364506,-0.16765110194683075,-0.1568397432565689,-0.011174478568136692,-0.08874781429767609,0.019741840660572052,0.04017828404903412', '2026-02-27 12:16:02.718676', 0, NULL, NULL, NULL),
(6, 'profile_7a8a840067214e6e92752d753c7bd4e0.jpg', 'kajal', 'kc@gmail.com', '6395841988', '-0.08917827159166336,0.12154177576303482,0.002962184837087989,-0.08132624626159668,-0.11741143465042114,-0.03303249552845955,0.005526676308363676,-0.12047149986028671,0.18169789016246796,-0.05126062035560608,0.17549335956573486,-0.04718748852610588,-0.26648905873298645,0.016752097755670547,-0.03785303607583046,0.15622268617153168,-0.14699968695640564,-0.12855686247348785,-0.15112094581127167,-0.04924340546131134,0.031905580312013626,0.046019297093153,0.06227424368262291,0.08543048053979874,-0.13888965547084808,-0.3729132115840912,-0.1297813206911087,-0.13652828335762024,0.05135484039783478,-0.0236402228474617,0.05420912057161331,-0.008583842776715755,-0.15292279422283173,-0.05009675770998001,0.11196935921907425,0.02096458524465561,-0.03052332252264023,-0.1206943467259407,0.205541729927063,-0.007577906362712383,-0.22799065709114075,-0.09152258187532425,0.15652450919151306,0.2335985153913498,0.09180697053670883,0.07725425809621811,0.08620242774486542,-0.10776624083518982,0.11993395537137985,-0.23520654439926147,0.1114368885755539,0.1171405091881752,0.021803544834256172,0.07818404585123062,0.11108309775590897,-0.15016178786754608,0.08285768330097198,0.22164149582386017,-0.2845926880836487,0.02997705712914467,0.10326574742794037,0.045371461659669876,-0.09353745728731155,-0.007809737231582403,0.23722170293331146,0.17311391234397888,-0.1377379596233368,-0.1568726748228073,0.1727227121591568,-0.2155461609363556,-0.014375765807926655,0.05752411112189293,-0.11400965601205826,-0.18024469912052155,-0.2583484649658203,-0.00801942590624094,0.460904061794281,0.16325786709785461,-0.10873260349035263,-0.017525408416986465,-0.07458557933568954,-0.01052215974777937,0.06801840662956238,0.035219743847846985,-0.12677700817584991,0.0013974080793559551,-0.091905876994133,0.011389319784939289,0.22510378062725067,-0.0038308328948915005,0.01871863193809986,0.2532051205635071,0.03388068079948425,-0.06901565194129944,0.010581049136817455,0.07793497294187546,-0.19692596793174744,-0.06877078115940094,-0.1538485586643219,-0.06815406680107117,0.03571634367108345,0.033359404653310776,-0.008786994963884354,0.1190827414393425,-0.23275649547576904,0.13427004218101501,-0.012272207997739315,-0.10331352800130844,-0.036668628454208374,-0.019452443346381187,-0.09141865372657776,-0.09446370601654053,0.14533579349517822,-0.17946963012218475,0.11654447019100189,0.13775530457496643,0.04589327424764633,0.12893767654895782,0.05694551020860672,0.02070682868361473,0.02796950563788414,-0.06685186177492142,-0.16843685507774353,-0.08022192865610123,0.09859646111726761,-0.07315707951784134,0.018490895628929138,-0.048496540635824203', '2026-02-27 12:24:33.354828', 0, NULL, NULL, NULL),
(7, 'profile_39f700f65aef49b38e63beabe19f96c3.jpg', 'lotr,', 'lorem@gmail.cp', '1234567890', '-0.09557967633008957,0.10122217237949371,0.10191722214221954,-0.09304684400558472,-0.12705650925636292,0.02219734713435173,-0.04029535502195358,-0.038770802319049835,0.11021555960178375,-0.07721277326345444,0.20674876868724823,-0.01567772403359413,-0.14565260708332062,-0.13672037422657013,-0.058618348091840744,0.06984852254390717,-0.12381904572248459,-0.17580923438072205,-0.04823723062872887,-0.07912570238113403,0.006843383423984051,0.02032122202217579,-0.03240188583731651,-0.06001361086964607,-0.2279214859008789,-0.3249320089817047,-0.10130023211240768,-0.10416107624769211,0.11653968691825867,-0.1365952044725418,0.005417524371296167,-0.0494963638484478,-0.1672707498073578,-0.05147966369986534,0.011404046788811684,0.09689687192440033,-0.02347388118505478,-0.004813987761735916,0.0973430797457695,0.04135425016283989,-0.1581088751554489,0.048779431730508804,0.056481726467609406,0.25942274928092957,0.18585170805454254,0.08496977388858795,0.013929912820458412,-0.0699884295463562,0.06529902666807175,-0.2693062126636505,0.15590232610702515,0.10457999259233475,0.1367267221212387,0.07088462263345718,0.1361902505159378,-0.11286626756191254,-0.0166147593408823,0.1088460236787796,-0.19867274165153503,0.06179524585604668,0.016497373580932617,0.04013437032699585,-0.07567594945430756,-0.023951051756739616,0.1760142743587494,0.12996703386306763,-0.11635890603065491,-0.08936839550733566,0.20220719277858734,-0.15825867652893066,-0.0256719458848238,0.038441311568021774,-0.001312369480729103,-0.10084615647792816,-0.25813719630241394,0.12780217826366425,0.41193702816963196,0.20377618074417114,-0.1983116716146469,-0.005317983217537403,-0.055918846279382706,0.021564412862062454,0.025178337469697,0.012129779905080795,-0.17447729408740997,0.03132355958223343,-0.049732159823179245,0.0340118408203125,0.07160578668117523,0.0069402544759213924,0.019767092540860176,0.16179710626602173,0.024756519123911858,0.06939469277858734,0.0751107856631279,0.048713162541389465,-0.15747769176959991,-0.02193550020456314,-0.0882146880030632,-0.06297704577445984,0.11092346161603928,-0.054988112300634384,0.04861263558268547,0.16235658526420593,-0.1390792429447174,0.20031043887138367,-0.010496558621525764,-0.095587357878685,0.010129076428711414,0.052297353744506836,0.026883648708462715,-0.05138549581170082,0.11925455927848816,-0.25087597966194153,0.14819300174713135,0.17725417017936707,-0.04817071929574013,0.16277919709682465,0.14669525623321533,0.02953226864337921,0.01866653561592102,-0.025215724483132362,-0.07774139940738678,-0.07718771696090698,-0.04654713347554207,-0.119941346347332,0.0191301628947258,0.030560320243239403', '2026-03-04 09:11:49.202763', 0, NULL, NULL, NULL);

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
(20, 4, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:23:53'),
(21, 5, 'face', '[-0.062277648597955704, 0.1506800651550293, 0.07578247785568237, 0.01200782973319292, -0.08592984825372696, -0.022619104012846947, -0.1048508882522583, -0.07383319735527039, 0.1402115374803543, -0.036159295588731766, 0.2284509390592575, -0.024531347677111626, -0.20445749163627625, 0.05487670376896858, -0.08066602051258087, 0.14588887989521027, -0.1547749638557434, -0.1197061836719513, -0.10897773504257202, -0.05514619126915932, -0.008947490714490414, 0.07165233045816422, 0.005742849316447973, 0.071706622838974, -0.11672931909561157, -0.35690951347351074, -0.09835255146026611, -0.1695481538772583, 0.08293502032756805, -0.0874350443482399, -0.05164075642824173, 0.0172201469540596, -0.1123649850487709, -0.03784561902284622, 0.09962493926286697, 0.08011278510093689, 0.016269832849502563, -0.024914776906371117, 0.2033366709947586, 0.04894031956791878, -0.12034174799919128, 0.042409561574459076, 0.10669239610433578, 0.3166857063770294, 0.08482211083173752, 0.12160991877317429, 0.08729301393032074, -0.008038703352212906, 0.08281166106462479, -0.20212727785110474, 0.09770266711711884, 0.13746777176856995, 0.1987321823835373, 0.10835345089435577, 0.1265084445476532, -0.18105864524841309, 0.08072905987501144, 0.09606125205755234, -0.19676423072814941, 0.15871497988700867, 0.1422106921672821, 0.02607954852283001, -0.04598010331392288, 0.025660589337348938, 0.24718844890594482, 0.06867653131484985, -0.14089101552963257, -0.08481678366661072, 0.06239484250545502, -0.1875792145729065, -0.041595909744501114, 0.06016480177640915, -0.08773449808359146, -0.15152448415756226, -0.21831826865673065, 0.02710866741836071, 0.436755508184433, 0.18915462493896484, -0.2351074069738388, -0.005444985814392567, -0.0009043729514814913, -0.06424594670534134, 0.04151428863406181, 0.025846006348729134, -0.15541838109493256, 0.040801290422677994, -0.1446302980184555, -0.009827694855630398, 0.19873516261577606, 0.06371522694826126, 0.06232134997844696, 0.24769262969493866, 0.015022674575448036, 0.00358586385846138, 0.002686981111764908, 0.054353341460227966, -0.15024824440479279, -0.10103971511125565, -0.05489160120487213, -0.049311693757772446, 0.011780962347984314, -0.04813963547348976, -0.06203989312052727, 0.03320779651403427, -0.2358449101448059, 0.13992050290107727, -0.07109856605529785, -0.030888758599758148, -0.05001772940158844, 0.1114388108253479, -0.11499817669391632, -0.04695550724864006, 0.21836167573928833, -0.22637397050857544, 0.09038152545690536, 0.19316425919532776, 0.013476734980940819, 0.08052483946084976, 0.0635157972574234, 0.03879506140947342, -0.006088030058890581, -0.017941506579518318, -0.14489787817001343, -0.17263399064540863, 0.003962999675422907, -0.14223702251911163, 0.021421369165182114, 0.00886738020926714]', NULL, 0.279348, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:46:18'),
(22, 5, 'face', '[-0.08104945719242096, 0.1752796471118927, 0.0652676522731781, -0.04796213284134865, -0.09322429448366165, -0.02425948902964592, -0.07921934872865677, -0.08032513409852982, 0.15518158674240112, 0.015644710510969162, 0.233066126704216, -0.02860269695520401, -0.24037374556064606, 0.06379983574151993, -0.07375140488147736, 0.1078386977314949, -0.17777849733829498, -0.07609827071428299, -0.11513305455446243, -0.07301663607358932, 0.030450984835624695, 0.04502362385392189, 0.03600544482469559, 0.054360248148441315, -0.12773284316062927, -0.32053864002227783, -0.09612011909484863, -0.14329299330711365, 0.03531887009739876, -0.09103062003850937, 0.008387725800275803, -0.04342121630907059, -0.127258762717247, -0.08270709961652756, 0.026710817590355873, -0.021749019622802734, -0.018742714077234268, -0.03735264390707016, 0.15322625637054443, 0.00017115847731474787, -0.10852240771055222, 0.07944837212562561, 0.08480332046747208, 0.28354546427726746, 0.14529410004615784, 0.13215325772762299, 0.09154954552650452, -0.033735573291778564, 0.040463000535964966, -0.22901420295238495, 0.10492273420095444, 0.11176355928182602, 0.18255876004695892, 0.03357680141925812, 0.13412639498710632, -0.1618812084197998, -0.01233186200261116, 0.12886206805706024, -0.19424320757389069, 0.17073313891887665, 0.1258150041103363, 0.06924910843372345, -0.05425262451171875, -0.026926768943667412, 0.21978476643562317, 0.12877944111824036, -0.15711520612239838, -0.0820903331041336, 0.06525681167840958, -0.14085185527801514, -0.05431094393134117, 0.04433668032288551, -0.09487354755401611, -0.21502262353897095, -0.20199643075466156, 0.0677560567855835, 0.39606550335884094, 0.16863593459129333, -0.24244584143161774, -0.0193489883095026, -0.015373065136373043, 0.010130749084055424, 0.03444967418909073, 0.004609747789800167, -0.1432253122329712, 0.008669951930642128, -0.13108102977275848, 0.009544070810079575, 0.14394547045230865, 0.0044372547417879105, -0.020264936611056328, 0.2631407678127289, 0.007283358369022608, -0.03544981777667999, 0.007564847823232412, 0.08930560946464539, -0.1601199358701706, -0.0405382476747036, -0.09988602995872498, -0.04458116367459297, 0.08177423477172852, -0.0021441346034407616, -0.03746157884597778, 0.03134126588702202, -0.14217433333396912, 0.13965988159179688, -0.06662172824144363, -0.025807593017816544, -0.06988248229026794, 0.05885574594140053, -0.09036917984485626, -0.02815053053200245, 0.20912425220012665, -0.2096276879310608, 0.12749716639518738, 0.16555500030517578, -0.029102588072419167, 0.10393434762954712, 0.06009913980960846, 0.020574521273374557, 0.042814187705516815, 0.0399787537753582, -0.10814385116100311, -0.14055897295475006, 0.028249939903616905, -0.10122592002153397, 0.08026623725891113, 0.019377432763576508]', NULL, 0.42503, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:51:32'),
(23, 6, 'face', '[-0.15834903717041016, 0.08857941627502441, 0.018146155402064323, -0.1028657928109169, -0.16529451310634613, -0.03655412048101425, -0.022422166541218758, -0.11851998418569565, 0.18745283782482147, -0.06607656180858612, 0.17167732119560242, -0.046230338513851166, -0.2351687252521515, -0.0009957723086699843, -0.06498446315526962, 0.1621401011943817, -0.13888195157051086, -0.07356153428554535, -0.12149041891098022, -0.1091434583067894, -0.003419010667130351, -0.01235415879637003, 0.030760809779167175, 0.10405538231134415, -0.12897223234176636, -0.32319292426109314, -0.09344703704118729, -0.15275844931602478, -0.015395239926874638, -0.06273037195205688, 0.0403272919356823, 0.029698563739657402, -0.1961759328842163, -0.07948381453752518, 0.04605559632182121, 0.03459910303354263, -0.0007899162592366338, -0.04901442304253578, 0.1667855978012085, -0.032384101301431656, -0.1822424978017807, -0.07387499511241913, 0.1310930848121643, 0.23889493942260742, 0.12359100580215454, 0.07984663546085358, 0.08884517103433609, -0.10565374791622162, 0.17822225391864777, -0.22891290485858917, 0.052956171333789825, 0.11478614062070847, 0.0612594336271286, 0.002348161768168211, 0.12936989963054657, -0.13950234651565552, 0.08098525553941727, 0.13651016354560852, -0.2554725408554077, 0.07436328381299973, 0.11167300492525101, 0.04256853833794594, -0.10127502679824829, -0.03927632421255112, 0.26443761587142944, 0.18068571388721466, -0.13202568888664246, -0.10073773562908173, 0.21657434105873108, -0.18197639286518097, 0.02370830811560154, 0.07029785960912704, -0.1260804533958435, -0.22551576793193817, -0.28351497650146484, -0.010432546027004719, 0.4303702414035797, 0.18682943284511566, -0.14730972051620483, -0.03813096135854721, -0.07988389581441879, 0.008308264426887035, 0.07718243449926376, 0.06567075103521347, -0.1122252568602562, 0.026948122307658195, -0.054211024194955826, 0.06217125803232193, 0.21299998462200165, -0.005002406891435385, 0.02035505138337612, 0.24258163571357727, 0.052253298461437225, -0.09647661447525024, -0.020819107070565224, 0.08910109847784042, -0.18336182832717896, -0.08134370297193527, -0.15644307434558868, -0.02191408909857273, 0.058309704065322876, 0.0015353382332250476, 0.019067419692873955, 0.09062141925096512, -0.22266001999378204, 0.11761743575334549, -0.055742111057043076, -0.09380267560482025, -0.13109396398067474, -0.04384933039546013, -0.07213322073221207, -0.017543138936161995, 0.16145628690719604, -0.16603627800941467, 0.14773736894130707, 0.13064827024936676, -0.02371697686612606, 0.12812550365924835, 0.014288685284554958, 0.023521415889263153, 0.009515066631138325, -0.0755523145198822, -0.0882263034582138, -0.1095259040594101, 0.06361749768257141, -0.1151801124215126, 0.07200969755649567, -0.03690971061587334]', NULL, 0.389693, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:54:50'),
(24, 5, 'face', '[-0.015630418434739113, 0.14193852245807648, 0.05151224136352539, -0.06475149095058441, -0.0765208974480629, -0.013481269590556622, -0.048184797167778015, -0.03887695074081421, 0.18072493374347687, -0.010355300270020962, 0.16845206916332245, 0.03792962804436684, -0.23204222321510315, 0.033895641565322876, -0.020249707624316216, 0.09942430257797241, -0.16557927429676056, -0.13356193900108337, -0.16613155603408813, -0.05299323797225952, -0.009013292379677296, 0.03928389400243759, 0.003754052799195051, 0.027687594294548035, -0.12600290775299072, -0.3760092854499817, -0.06939181685447693, -0.11781276017427444, 0.06011505424976349, -0.11114002764225006, 0.033104050904512405, 0.002646518172696233, -0.12972110509872437, -0.053536754101514816, 0.038987647742033005, 0.02078319899737835, -0.004331821575760841, -0.058896422386169434, 0.14213235676288605, 0.06752587854862213, -0.17515146732330322, 0.11809677630662918, 0.04048673436045647, 0.30693987011909485, 0.1413450837135315, 0.08477920293807983, 0.09083252400159836, -0.04760386049747467, 0.09161722660064697, -0.24586360156536102, 0.09563262015581131, 0.12587672472000122, 0.16962884366512299, 0.025309130549430847, 0.16546806693077087, -0.12931205332279205, 0.04817872494459152, 0.14349760115146637, -0.2505715489387512, 0.16454243659973145, 0.11472424864768982, 0.029524248093366623, -0.04397619143128395, -0.015373161993920803, 0.154399573802948, 0.07643093913793564, -0.140924870967865, -0.08799019455909729, 0.06991332769393921, -0.14407169818878174, -0.04667752608656883, 0.05615144595503807, -0.07208964228630066, -0.19647754728794098, -0.23557518422603607, 0.05579691752791405, 0.41008827090263367, 0.21172559261322021, -0.2507156729698181, -0.026903806254267693, -0.0684937983751297, -0.006941275205463171, 0.055999789386987686, 0.006739456672221422, -0.13068309426307678, -0.043288905173540115, -0.16369454562664032, 0.012550359591841698, 0.17480579018592834, 0.057819265872240067, -0.012962283566594124, 0.2456044852733612, 0.02926597185432911, -0.03472571074962616, -0.051800686866045, 0.07790230214595795, -0.2078075110912323, -0.04497876018285751, -0.11742252856492996, -0.10429096221923828, 0.066243477165699, 0.008056744933128357, -0.05233154445886612, 0.08105083554983139, -0.18849341571331024, 0.16413342952728271, -0.03000558353960514, -0.04188493639230728, -0.0005499672843143344, 0.0795825943350792, -0.06982877105474472, -0.052262332290410995, 0.1689426600933075, -0.22424806654453278, 0.11260267347097397, 0.2217746526002884, 0.025637997314333916, 0.06036650761961937, 0.054883167147636414, -0.03755419701337814, 0.015077843330800533, -0.02800092101097107, -0.1576612889766693, -0.13596682250499725, -0.004312893841415644, -0.06793872267007828, 0.026144949719309807, 0.005160126369446516]', NULL, 0.421168, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:55:02'),
(25, 6, 'face', '[-0.12176745384931564, 0.08909257501363754, 0.03754594177007675, -0.07637350261211395, -0.1357622742652893, -0.04529772698879242, -0.006079987622797489, -0.08891356736421585, 0.18621225655078888, -0.09921899437904358, 0.16447937488555908, -0.06685511022806168, -0.2555662989616394, 0.04782765358686447, -0.07683899998664856, 0.18982867896556854, -0.141697958111763, -0.10472835600376129, -0.1351470798254013, -0.044808529317379, 0.04417610540986061, 0.043094247579574585, 0.04266301169991493, 0.12349911779165268, -0.09944546222686768, -0.3626263439655304, -0.10500223189592361, -0.12049943208694458, 0.00689348578453064, -0.04297534003853798, 0.07459211349487305, 0.003915500361472368, -0.15854626893997192, -0.0667019709944725, 0.06629638373851776, 0.0464598685503006, -0.03790631145238876, -0.1009584441781044, 0.21507738530635834, -0.028643636032938957, -0.22778525948524475, -0.10342517495155334, 0.16095872223377228, 0.21319200098514557, 0.08179838955402374, 0.07318175584077835, 0.09984080493450165, -0.14146028459072113, 0.10921907424926758, -0.2318955510854721, 0.0734458714723587, 0.09914270043373108, 0.0470564030110836, 0.09190519899129868, 0.09017673134803772, -0.1775377243757248, 0.07858286798000336, 0.21096666157245636, -0.2629914879798889, 0.06940058618783951, 0.09224744141101837, 0.052946675568819046, -0.07915182411670685, -0.009164298884570599, 0.2392793446779251, 0.1542414426803589, -0.13298331201076508, -0.1636059731245041, 0.2152421772480011, -0.22125418484210968, -0.014154965057969093, 0.1117318868637085, -0.10366130620241165, -0.20923437178134918, -0.26498815417289734, -0.03274525701999664, 0.42399531602859497, 0.16406776010990143, -0.11271028965711594, -0.0639413446187973, -0.0552949532866478, -0.011503269895911217, 0.04759267345070839, 0.06888989359140396, -0.10576686263084412, 0.0018118924926966429, -0.06394054740667343, 0.035691000521183014, 0.20063336193561554, 0.024635419249534607, -0.0030581990722566843, 0.2328631579875946, 0.0701625645160675, -0.08134344965219498, 0.0040567233227193356, 0.10579216480255127, -0.18141615390777588, -0.048434361815452576, -0.1863267719745636, -0.05478745698928833, 0.034171268343925476, 0.03843037784099579, -0.0024463061708956957, 0.10306155681610107, -0.19855645298957825, 0.15424701571464539, -0.05271010473370552, -0.11092166602611542, -0.07517109811306, 0.007131969090551138, -0.1182783842086792, -0.049057669937610626, 0.18939508497714996, -0.13671338558197021, 0.11555958539247513, 0.14416398108005524, 0.037071581929922104, 0.13280731439590454, 0.05837681517004967, 0.06271464377641678, 0.016604658216238022, -0.08881191909313202, -0.17574229836463928, -0.06722690165042877, 0.08640269190073013, -0.09583888947963715, 0.06602029502391815, -0.039005979895591736]', NULL, 0.266361, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 06:55:43'),
(26, 5, 'face', '[-0.07411647588014603, 0.20109888911247253, 0.10567076504230499, -0.0025814936961978674, -0.06984664499759674, 0.020068442448973656, -0.06814035773277283, -0.0783846378326416, 0.1332370787858963, -0.013238108716905117, 0.19648534059524536, -0.011882067658007145, -0.26822391152381897, 0.04966610670089722, -0.06651657819747925, 0.15416721999645233, -0.1525799185037613, -0.10909997671842575, -0.12006618082523346, -0.0819946750998497, 0.04029858112335205, 0.0774352103471756, -0.012792794033885002, 0.02757064439356327, -0.10164020955562592, -0.36339136958122253, -0.09089311212301254, -0.11647500842809677, 0.03642904385924339, -0.05473240837454796, 0.05764522776007652, -0.03595392778515816, -0.11565986275672913, -0.044545531272888184, 0.05042900890111923, -0.014788299798965454, -0.008407620713114738, -0.004054815974086523, 0.15493245422840118, 0.005201383959501982, -0.1373661905527115, 0.0734066590666771, 0.09171080589294434, 0.2983560264110565, 0.04775207117199898, 0.12321722507476807, 0.10129611939191818, -0.04398873820900917, 0.046418074518442154, -0.2305881679058075, 0.08562243729829788, 0.12711460888385773, 0.14537949860095978, 0.05647160857915878, 0.16268043220043182, -0.16470904648303986, 0.027019072324037552, 0.13267318904399872, -0.22001118957996368, 0.20089392364025116, 0.12142110615968704, 0.02452348731458187, -0.04242147132754326, -0.005210718140006065, 0.1799645721912384, 0.08946613222360611, -0.12519828975200653, -0.13050726056098938, 0.09369447827339172, -0.14757360517978668, -0.0346226692199707, 0.07747989892959595, -0.058577340096235275, -0.18688324093818665, -0.23932690918445587, 0.05179004743695259, 0.4655463695526123, 0.18366199731826782, -0.25098124146461487, -0.044527530670166016, -0.003492852905765176, -0.010780280455946922, 0.0923452228307724, 0.015310834161937237, -0.1321457475423813, -0.006903393194079399, -0.15328431129455566, 0.005530114751309156, 0.1561552733182907, 0.04870009422302246, -0.015051474794745445, 0.2684743106365204, 0.04144640639424324, -0.01955893076956272, -0.009219670668244362, 0.09477607160806656, -0.18706782162189484, -0.06996974349021912, -0.11591695249080658, -0.08700128644704819, 0.0424652174115181, 0.01245223730802536, -0.030656563118100166, 0.06204719468951225, -0.1341913491487503, 0.1741839200258255, -0.06058894842863083, -0.018331604078412056, -0.0730658546090126, 0.13221295177936554, -0.10309679806232452, -0.028879934921860695, 0.2045537382364273, -0.17995452880859375, 0.09738726913928986, 0.17405056953430176, -0.03821031376719475, 0.06830450147390366, 0.06392611563205719, 0.03100341372191906, 0.0008566362666897476, -0.02649853564798832, -0.1492018699645996, -0.15986284613609314, 0.015460670925676823, -0.12285388261079788, 0.042330436408519745, 0.003195258090272546]', NULL, 0.408273, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-27 07:18:02'),
(27, 5, 'face', '[-0.021192900836467743, 0.17728202044963837, 0.10353431105613708, -0.0004336661077104509, -0.07128855586051941, -0.04160435497760773, -0.08270588517189026, -0.10421810299158096, 0.16283833980560303, -0.0037505938671529293, 0.16672305762767792, -0.005008184816688299, -0.1782693862915039, 0.03144695982336998, -0.06452345848083496, 0.12980498373508453, -0.15722031891345978, -0.12361329793930054, -0.09847237169742584, -0.05671401694417, 0.014594504609704018, 0.09935306012630463, 6.888365987833822e-06, 0.05243522301316261, -0.08782580494880676, -0.3525896966457367, -0.13313555717468262, -0.10235175490379333, 0.0515066422522068, -0.08945979923009872, -0.005827817600220442, -0.029661692678928375, -0.1218913123011589, -0.07182376086711884, 0.08542422205209732, 0.024012012407183647, -0.060946986079216, -0.018018821254372597, 0.13925550878047943, 0.052825238555669785, -0.12909506261348724, 0.08300758898258209, 0.0834292620420456, 0.3184853494167328, 0.06275384873151779, 0.13931117951869965, 0.0644741952419281, -0.028681499883532524, 0.0815059095621109, -0.20597371459007263, 0.0947902575135231, 0.13224294781684875, 0.19622981548309326, 0.07811552286148071, 0.14598669111728668, -0.13821621239185333, 0.027353009209036827, 0.12070779502391815, -0.21981588006019592, 0.19297349452972412, 0.1259288489818573, -0.04079563170671463, -0.03226533532142639, 0.01615910977125168, 0.2012988030910492, 0.11764588952064514, -0.11895912885665894, -0.1022353544831276, 0.08056200295686722, -0.14649030566215515, -0.05682836100459099, 0.03294831141829491, -0.032983679324388504, -0.14670692384243011, -0.22856195271015167, 0.027628956362605095, 0.43560555577278137, 0.12048257142305374, -0.25425735116004944, -0.06487960368394852, -0.01907355524599552, 0.002267989329993725, 0.031485218554735184, 0.01713559962809086, -0.16968771815299988, 0.017658138647675514, -0.17922712862491608, -0.009305685758590698, 0.16521961987018585, 0.01768394373357296, 0.019498344510793686, 0.22764480113983154, 0.02145751565694809, 0.027207227423787117, 0.00076911726500839, 0.07041390985250473, -0.19750700891017914, -0.05807633697986603, -0.10136467963457108, -0.069753497838974, 0.035452209413051605, 0.0009264110121876001, -0.045321494340896606, 0.07244855165481567, -0.14523759484291077, 0.18899698555469513, -0.021391913294792175, -0.05996476113796234, -0.06280813366174698, 0.11289811879396439, -0.10927610099315643, -0.07203388959169388, 0.17507581412792206, -0.1953028440475464, 0.13332298398017883, 0.159050852060318, -0.02047278732061386, 0.09062766283750534, 0.011226308532059193, 0.029763035476207733, -0.030231386423110962, -0.04002728685736656, -0.10517432540655136, -0.1562691181898117, 0.012195950374007225, -0.09387263655662537, 0.017150860279798508, 0.004381298087537289]', NULL, 0.40451, NULL, NULL, NULL, NULL, 'success', NULL, '2026-03-04 03:29:22'),
(28, 5, 'face', '[-0.06504213809967041, 0.11780370771884918, 0.11109469830989838, -0.027783337980508804, -0.0819144919514656, -0.009775999933481216, -0.018871227279305458, -0.024405669420957565, 0.15879958868026733, -0.04312366247177124, 0.1980419158935547, -0.03292525187134743, -0.21512626111507416, 0.035299718379974365, -0.0064774625934660435, 0.08095721155405045, -0.13286040723323822, -0.14400038123130798, -0.11928834766149521, -0.038116976618766785, 0.07431351393461227, 0.08983081579208374, 0.013698438182473183, 0.008989495225250721, -0.15726853907108307, -0.39141958951950073, -0.05388730764389038, -0.18399250507354736, 0.11046994477510452, -0.09041538834571838, -0.044521018862724304, 0.004618680104613304, -0.11002834141254425, -0.031143832951784134, 0.017390893772244453, 0.03356831893324852, 0.0015191062120720744, -0.06608029454946518, 0.22772300243377686, 0.031189467757940292, -0.25159934163093567, 0.05941364914178848, 0.07300595939159393, 0.2965072691440582, 0.09952251613140106, 0.08243948221206665, 0.06893235445022583, -0.0004306131158955395, 0.10892708599567413, -0.20492485165596008, 0.13239918649196625, 0.12324781715869904, 0.21630777418613434, 0.06468179821968079, 0.18576408922672272, -0.19696013629436493, 0.06096282973885536, 0.04813022166490555, -0.2478688359260559, 0.1488712877035141, 0.11559440940618515, 0.03743467479944229, 0.008939464576542377, -0.022868404164910316, 0.1909254789352417, 0.032950639724731445, -0.10310255736112595, -0.10956206917762756, 0.07271330803632736, -0.16176117956638336, -0.04537663608789444, 0.14125847816467285, -0.12296958267688751, -0.1599373072385788, -0.23781269788742065, 0.03831753507256508, 0.39788469672203064, 0.16183261573314667, -0.208232581615448, -0.002963416278362274, -0.01118767075240612, -0.06094759330153465, 0.0808204934000969, 0.050057943910360336, -0.12276530265808105, 0.05563120171427727, -0.1422923356294632, 0.007136039901524782, 0.17857161164283752, 0.021369533613324165, -0.025762712582945824, 0.2390202283859253, 0.026919351890683174, -0.007989542558789253, -0.027602067217230797, 0.0648481473326683, -0.1594148874282837, -0.021396160125732422, -0.056618571281433105, -0.020894542336463928, 0.09012208133935928, -0.052227556705474854, -0.05895787104964256, 0.08951300382614136, -0.24762924015522003, 0.13404767215251923, -0.06340115517377853, -0.01697811670601368, -0.0355423241853714, 0.06740699708461761, -0.10165242850780487, -0.019856035709381104, 0.16436360776424408, -0.2582186460494995, 0.0937444344162941, 0.20244230329990387, 0.017389876767992973, 0.06531591713428497, 0.048050880432128906, -0.04570542648434639, 0.024490544572472572, 0.00025042323977686465, -0.23374955356121063, -0.12480662018060684, 0.0471675805747509, -0.0958302915096283, 0.02337046153843403, 0.05997273698449135]', NULL, 0.318243, NULL, NULL, NULL, NULL, 'success', NULL, '2026-03-09 04:27:08'),
(29, 5, 'face', '[-0.050058700144290924, 0.10675586760044098, 0.08446607738733292, 0.012304484844207764, -0.0809597596526146, -0.021964946761727333, -0.07779412716627121, -0.05807574465870857, 0.13793432712554932, -0.03114638850092888, 0.23234380781650543, -0.004039695952087641, -0.21160496771335602, 0.04287993907928467, -0.07773981988430023, 0.13133588433265686, -0.13539931178092957, -0.15058256685733795, -0.13831764459609985, -0.04193944111466408, -0.008552201092243195, 0.057098474353551865, -0.011837827041745186, 0.06683460623025894, -0.11768797039985657, -0.37244418263435364, -0.07842261344194412, -0.18092094361782074, 0.03792937099933624, -0.1215960755944252, -0.02340146154165268, 0.01571030355989933, -0.11787129938602448, -0.03724772483110428, 0.07885190099477768, 0.039479561150074005, -0.004732005763798952, -0.05256807804107666, 0.20440667867660522, 0.04771982878446579, -0.1409531682729721, 0.03717951849102974, 0.1210867390036583, 0.3011717200279236, 0.05253458768129349, 0.09247054904699326, 0.08831192553043365, 0.010906711220741272, 0.09133000671863556, -0.21238265931606293, 0.08947551995515823, 0.13504435122013092, 0.2065318077802658, 0.10373761504888535, 0.14025217294692993, -0.1806468665599823, 0.08058398962020874, 0.08651301264762878, -0.2128201574087143, 0.1830020695924759, 0.11299021542072296, 0.01802058331668377, -0.06953781098127365, 0.02626025676727295, 0.2017332762479782, 0.0721631646156311, -0.12632936239242554, -0.08064965158700943, 0.0639815703034401, -0.17221643030643463, -0.0392216332256794, 0.0516500361263752, -0.09435790777206421, -0.17674492299556732, -0.20191793143749237, 0.01065907347947359, 0.41038990020751953, 0.16298052668571472, -0.23963302373886108, -0.007288967724889517, -0.015451395884156227, -0.05485280603170395, 0.0146249420940876, 0.005908092483878136, -0.14024221897125244, 0.05286606028676033, -0.15504778921604156, 0.000694948888849467, 0.1839669942855835, 0.07584002614021301, 0.05529253929853439, 0.24208156764507294, 0.013217429630458355, -0.03387594223022461, 0.01796579733490944, 0.057289693504571915, -0.1515657901763916, -0.0971812754869461, -0.07174276560544968, -0.04477139189839363, 0.012752121314406395, -0.046060316264629364, -0.07174862921237946, -0.001379969995468855, -0.21617750823497772, 0.1230335533618927, -0.04734718054533005, -0.029017910361289978, -0.04780961200594902, 0.11024055629968643, -0.12968558073043823, -0.06009162217378616, 0.1917002648115158, -0.21161627769470215, 0.09471099823713303, 0.18335571885108948, 0.033049408346414566, 0.07787449657917023, 0.05264269560575485, 0.00561120081692934, -0.013469665311276913, -0.030744781717658043, -0.15013301372528076, -0.1686074286699295, -0.0014884215779602528, -0.10542666167020798, 0.0012384852161630988, 0.00651593366637826]', 'login_a2f610de938844b4a14c1a349ed05c9f.jpg', 0.304183, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 07:01:14'),
(30, 5, 'face', '[-0.06691791862249374, 0.16303955018520355, 0.09767061471939087, -0.019878942519426346, -0.10517612844705582, -0.01930849999189377, -0.07171708345413208, -0.0582827553153038, 0.10754898190498352, -0.04059674218297005, 0.2416670173406601, -0.029435141012072563, -0.21547037363052368, 0.05625671520829201, -0.04716549068689346, 0.12510840594768524, -0.13773733377456665, -0.13017690181732178, -0.11939467489719391, -0.0747327208518982, 0.0020271064713597298, 0.054241523146629333, 0.01332004088908434, 0.058747321367263794, -0.16535645723342896, -0.367645263671875, -0.10159721225500107, -0.14720018208026886, 0.06998572498559952, -0.1036437600851059, -0.009592599235475063, 0.016545210033655167, -0.07908040285110474, -0.019927067682147026, 0.07701688259840012, 0.09205922484397888, 0.025797296315431595, -0.09656734019517899, 0.22000841796398163, 0.0496462844312191, -0.14381566643714905, 0.031564000993967056, 0.10978563129901886, 0.30911383032798767, 0.04940985515713692, 0.050718970596790314, 0.10966033488512039, 0.019585590809583664, 0.0807429850101471, -0.18579092621803284, 0.09011552482843399, 0.11724527925252914, 0.18826451897621155, 0.09294337779283524, 0.15070626139640808, -0.15387238562107086, 0.07907524704933167, 0.12113872170448303, -0.19486096501350403, 0.1332954615354538, 0.09847087413072586, 0.03361569344997406, -0.028080031275749207, -0.010078568942844868, 0.20315779745578766, 0.09277491271495819, -0.11814291030168533, -0.07920599728822708, 0.0891396552324295, -0.15264397859573364, -0.08044645935297012, 0.047943174839019775, -0.09971360117197037, -0.15244512259960175, -0.20157942175865173, 0.04522256553173065, 0.408386766910553, 0.22209885716438293, -0.24613428115844727, -0.0168019849807024, 0.020078862085938454, -0.08219777792692184, 0.024528516456484795, 0.04820352792739868, -0.17217689752578735, 0.09278560429811478, -0.14229947328567505, 0.027823958545923233, 0.20730336010456085, 0.07203511893749237, 0.025862814858555794, 0.2698134481906891, 0.03416837379336357, 0.025770528241991997, 0.03282814472913742, 0.02881108969449997, -0.1638016253709793, -0.08368097245693207, -0.08899720013141632, -0.05607355013489723, 0.06985290348529816, -0.06298172473907471, -0.059452660381793976, 0.06264238804578781, -0.23063071072101593, 0.13035672903060913, -0.05999770760536194, -0.048495013266801834, -0.06406468152999878, 0.12797969579696655, -0.10807770490646362, -0.03418484702706337, 0.21814022958278656, -0.19028547406196594, 0.04828110709786415, 0.21683195233345032, 0.021559081971645355, 0.0704244077205658, 0.12168637663125992, -0.011232187040150166, 0.037187155336141586, -0.030882539227604866, -0.14086118340492249, -0.15394572913646698, 0.019403716549277306, -0.13018500804901123, 0.02247687242925167, 0.024861712008714676]', 'login_80298157e2924fef81c4c4e768c2caaf.jpg', 0.331661, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 07:09:54'),
(31, 5, 'face', '[-0.05728249251842499, 0.13690896332263947, 0.09448971599340439, 0.030037160962820053, -0.08584014326334, -0.029982153326272964, -0.07054208964109421, -0.07100971043109894, 0.1493411362171173, -0.035021912306547165, 0.23899398744106293, 0.010777715593576431, -0.22597654163837433, 0.03017044998705387, -0.0591965913772583, 0.14115796983242035, -0.125198096036911, -0.13542883098125458, -0.14215126633644104, -0.04255896806716919, 0.008567812852561474, 0.0675887018442154, 0.008574236184358597, 0.056032877415418625, -0.12082485109567642, -0.38992685079574585, -0.09784533828496933, -0.15589940547943115, 0.034238506108522415, -0.10726233571767807, -0.005881354212760925, 0.01769435405731201, -0.11222744733095169, -0.05461918190121651, 0.07141713798046112, 0.037288859486579895, 0.024248452857136726, -0.03425242379307747, 0.2022475004196167, 0.04099558666348457, -0.1563466191291809, 0.035798028111457825, 0.12576617300510406, 0.2971619665622711, 0.06757669150829315, 0.09765730798244476, 0.09955794364213943, -0.0015714372275397182, 0.0695977509021759, -0.2211143523454666, 0.10098463296890259, 0.13647779822349548, 0.17849254608154297, 0.09835230559110641, 0.1448492705821991, -0.1550990641117096, 0.06595741212368011, 0.08417309075593948, -0.20386411249637604, 0.16443468630313873, 0.13347727060317993, 0.021486874669790268, -0.06698217988014221, 0.0279343593865633, 0.20872531831264496, 0.0636107474565506, -0.1376233696937561, -0.07585066556930542, 0.04115408658981323, -0.18898192048072815, -0.05819837749004364, 0.04296845570206642, -0.10048199445009232, -0.16684846580028534, -0.2540804445743561, 0.022231988608837128, 0.4396723210811615, 0.16657625138759613, -0.24206067621707916, 0.00637809420004487, -0.02676255814731121, -0.05967045947909355, 0.022802043706178665, 0.02773062139749527, -0.11920090764760971, 0.04999079182744026, -0.14917387068271637, 0.014707880094647408, 0.1889931857585907, 0.07651102542877197, 0.048397839069366455, 0.27540382742881775, 0.020521797239780426, -0.01049023400992155, 0.009721397422254086, 0.0836842805147171, -0.14279799163341522, -0.1151861920952797, -0.06755752116441727, -0.0448906309902668, 0.03205034136772156, -0.021657539531588554, -0.06384314596652985, 0.01160198263823986, -0.2249300479888916, 0.14224795997142792, -0.05373399704694748, -0.01430356316268444, -0.02755834348499775, 0.10506362468004227, -0.12733270227909088, -0.060456134378910065, 0.19721806049346924, -0.19962063431739807, 0.09029725193977356, 0.1826280951499939, -0.002552442252635956, 0.07079459726810455, 0.06398268789052963, 0.02366914413869381, -0.011707719415426254, -0.026658544316887856, -0.14062194526195526, -0.16522635519504547, 0.001324714976362884, -0.1261696070432663, 0.018431058153510094, 0.011795547790825367]', 'login_8ba5d60de907456ab3cfb33a7fd7df4f.jpg', 0.311064, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 07:14:06'),
(32, 5, 'face', '[-0.058849480003118515, 0.10593623667955399, 0.07111489772796631, 0.032045070081949234, -0.06653780490159988, -0.011147616431117058, -0.09501775354146957, -0.07587432116270065, 0.1535203605890274, -0.01278120931237936, 0.22300492227077484, 0.017774997279047966, -0.21764060854911804, 0.03383735194802284, -0.08533985912799835, 0.13927192986011505, -0.1291293352842331, -0.13949373364448547, -0.1368999183177948, -0.025268035009503365, -0.009683280251920223, 0.08575676381587982, 0.009869521483778954, 0.058436471968889236, -0.08731570839881897, -0.38394299149513245, -0.09025576710700989, -0.18505598604679108, 0.03022884950041771, -0.12408173084259033, -0.008821009658277035, 0.010861489921808243, -0.10168573260307312, -0.023833459243178368, 0.08002588152885437, 0.030105596408247948, -0.02641022950410843, -0.059077441692352295, 0.2102379947900772, 0.06195591390132904, -0.14766855537891388, 0.037716638296842575, 0.09024808555841446, 0.30024346709251404, 0.0646272599697113, 0.08583559840917587, 0.09482351690530777, -0.02814578264951706, 0.08448127657175064, -0.21740376949310303, 0.08305187523365021, 0.1602357178926468, 0.1764451414346695, 0.0979618951678276, 0.1500464230775833, -0.1589553952217102, 0.07694662362337112, 0.07574708014726639, -0.19911059737205505, 0.18398472666740417, 0.12776674330234528, 0.023006131872534752, -0.07040104269981384, 0.014963535591959953, 0.18057575821876526, 0.05959491431713104, -0.13628233969211578, -0.0832010805606842, 0.052702825516462326, -0.17748282849788666, -0.05656204745173454, 0.059176474809646606, -0.09571444988250732, -0.21193057298660278, -0.21710845828056335, 0.015833506360650063, 0.4270823299884796, 0.1659250408411026, -0.23650020360946655, 0.0003892439417541027, -0.012334275990724564, -0.060163192451000214, 0.011408736929297447, 0.03304619342088699, -0.1355903148651123, 0.035901617258787155, -0.15153320133686066, -0.013213055208325386, 0.18147839605808258, 0.07507766038179398, 0.057038769125938416, 0.26093217730522156, 0.00541003467515111, -0.021721748635172844, 0.011546860449016094, 0.08439061045646667, -0.12983258068561554, -0.09344331920146942, -0.05694929137825966, -0.047543786466121674, 0.024925068020820618, -0.0439242385327816, -0.05714249610900879, -0.0008285031653940678, -0.19840478897094727, 0.14383794367313385, -0.048358455300331116, -0.017162097617983818, -0.018792247399687767, 0.09573763608932495, -0.1299254596233368, -0.050328515470027924, 0.20490388572216034, -0.20702792704105377, 0.10537882149219513, 0.17525696754455566, 0.04164924472570419, 0.07618024945259094, 0.051277223974466324, 0.0410480797290802, -0.039430372416973114, -0.029652832075953484, -0.16262443363666534, -0.16485653817653656, -0.015794072300195694, -0.08299902826547623, -0.024469217285513878, 0.005811644718050957]', 'login_88622da9b6fb4b91a39cd74d209766e9.jpg', 0.344086, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', NULL, 'success', NULL, '2026-03-09 07:16:13');

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
  `progress_percentage` tinyint(4) NOT NULL DEFAULT 0,
  `practice_completed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_milestone_progress`
--

INSERT INTO `user_milestone_progress` (`id`, `user_training_plan_id`, `master_milestone_id`, `status`, `started_at`, `completed_at`, `progress_percentage`, `practice_completed`) VALUES
(28, 11, 28, 'completed', NULL, '2026-02-27 13:09:44', 100, 1),
(29, 11, 29, 'completed', '2026-02-27 13:09:44', '2026-02-27 13:16:16', 100, 1),
(30, 11, 30, 'completed', '2026-02-27 13:16:16', '2026-02-27 13:21:02', 100, 1),
(31, 12, 31, 'in_progress', NULL, NULL, 100, 1),
(32, 12, 32, 'locked', NULL, NULL, 0, 0),
(33, 12, 33, 'locked', NULL, NULL, 0, 0);

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
(5, 4, 8, 1, 'python', 'resume_eb36a6886e064326a23f7d0472b7c49a.pdf', '2026-02-27 11:51:28.504199', '2026-02-27 11:51:29.000000'),
(6, 5, 6, 1, 'php', 'resume_b4ac6725227a4a78970f58cfe6f08ca4.pdf', '2026-02-27 12:16:12.463772', '2026-02-27 12:16:13.000000'),
(7, 6, 1, 1, 'php', 'resume_2bc6afbf1250408ebb1211e1054007ac.pdf', '2026-02-27 12:24:42.217162', '2026-02-27 12:24:42.000000'),
(8, 7, 4, 1, 'PHP', 'resume_affe85edd604438a97ce6b1c39dbb00c.pdf', '2026-03-04 09:12:07.955626', '2026-03-04 09:12:09.000000');

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

--
-- Dumping data for table `user_quiz_attempts`
--

INSERT INTO `user_quiz_attempts` (`id`, `user_milestone_progress_id`, `score`, `total_questions`, `passed`, `attempted_at`) VALUES
(13, 28, 50, 2, 0, '2026-02-27 13:08:00'),
(14, 28, 50, 2, 0, '2026-02-27 13:08:19'),
(15, 28, 50, 2, 0, '2026-02-27 13:08:41'),
(16, 28, 50, 2, 0, '2026-02-27 13:09:00'),
(17, 28, 50, 2, 0, '2026-02-27 13:09:21'),
(18, 28, 100, 2, 1, '2026-02-27 13:09:44'),
(19, 29, 100, 2, 1, '2026-02-27 13:16:16'),
(20, 30, 100, 2, 1, '2026-02-27 13:21:02'),
(21, 31, 50, 2, 0, '2026-03-04 09:18:25'),
(22, 31, 50, 2, 0, '2026-03-04 09:18:44');

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

--
-- Dumping data for table `user_study_material_progress`
--

INSERT INTO `user_study_material_progress` (`id`, `user_milestone_progress_id`, `master_study_material_id`, `is_completed`, `completed_at`) VALUES
(22, 28, 117, 1, '2026-02-27 13:06:15'),
(23, 28, 118, 1, '2026-02-27 13:06:16'),
(24, 29, 121, 1, '2026-02-27 13:11:36'),
(25, 29, 119, 1, '2026-02-27 13:11:36'),
(26, 29, 120, 1, '2026-02-27 13:11:38'),
(27, 30, 123, 1, '2026-02-27 13:20:48'),
(28, 30, 122, 1, '2026-02-27 13:20:49'),
(29, 31, 124, 1, '2026-03-04 09:17:51'),
(30, 31, 125, 1, '2026-03-04 09:17:52');

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
(11, 5, 8, '2026-02-27 12:48:23', 'active', 3),
(12, 7, 9, '2026-03-04 09:12:50', 'active', 1);

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
-- Indexes for table `face_login_attempts`
--
ALTER TABLE `face_login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `matched_user_id` (`matched_user_id`),
  ADD KEY `ix_face_login_attempts_id` (`id`);

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
-- Indexes for table `milestone_settings`
--
ALTER TABLE `milestone_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_name` (`name`);

--
-- Indexes for table `system_job_logs`
--
ALTER TABLE `system_job_logs`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `face_login_attempts`
--
ALTER TABLE `face_login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_milestones`
--
ALTER TABLE `master_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=938;

--
-- AUTO_INCREMENT for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `milestone_settings`
--
ALTER TABLE `milestone_settings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `system_job_logs`
--
ALTER TABLE `system_job_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `training_plans`
--
ALTER TABLE `training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_login_details`
--
ALTER TABLE `user_login_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user_onboarding`
--
ALTER TABLE `user_onboarding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_study_material_progress`
--
ALTER TABLE `user_study_material_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `face_login_attempts`
--
ALTER TABLE `face_login_attempts`
  ADD CONSTRAINT `face_login_attempts_ibfk_1` FOREIGN KEY (`matched_user_id`) REFERENCES `users` (`id`);

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
