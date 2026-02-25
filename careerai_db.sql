-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2026 at 08:19 AM
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
(4, 'Senior (5+ years) ', 4, 1),
(5, 'LazyTesterLevel', 0, 1);

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
(17, 4, 1, 'Lazy Milestone 1', 'Testing lazy loading', NULL, 0, 1),
(18, 5, 1, 'Foundations in Machine Learning', 'Understand the basics of machine learning, including supervised and unsupervised learning, regression, classification, clustering, and neural networks.', 15, 1, 1),
(19, 5, 2, 'Python Programming for ML', 'Learn the Python programming language, focusing on NumPy, Pandas, scikit-learn, and TensorFlow, to prepare for machine learning engineering.', 10, 2, 1),
(20, 5, 3, 'Hands-on Machine Learning Projects', 'Work on real-world projects applying machine learning algorithms to solve problems, building a portfolio of projects and deploying them to production environments.', 20, 3, 1);

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
(746, 17, 'Mock Q1', 'multiple_choice', 'easy', '[\"A. 1\", \"B. 2\", \"C. 3\", \"D. 4\"]', 'A', 'Because A', NULL, '2026-02-25 11:08:07'),
(747, 17, 'Medium practice question 2 for Lazy Milestone 1', 'multiple_choice', 'medium', '[\"A. Concept is partially correct\", \"B. It depends on context\", \"C. Concept is correct\", \"D. Concept is incorrect\"]', 'C', 'This is a synthetic medium question to reinforce Lazy Milestone 1. Option C reflects the correct core idea.', NULL, '2026-02-25 11:08:07'),
(748, 17, 'Medium practice question 3 for Lazy Milestone 1', 'multiple_choice', 'medium', '[\"A. Concept is partially correct\", \"B. Concept is incorrect\", \"C. It depends on context\", \"D. Concept is correct\"]', 'D', 'This is a synthetic medium question to reinforce Lazy Milestone 1. Option D reflects the correct core idea.', NULL, '2026-02-25 11:08:07'),
(749, 17, 'Medium practice question 4 for Lazy Milestone 1', 'multiple_choice', 'medium', '[\"A. Concept is incorrect\", \"B. It depends on context\", \"C. Concept is correct\", \"D. Concept is partially correct\"]', 'C', 'This is a synthetic medium question to reinforce Lazy Milestone 1. Option C reflects the correct core idea.', NULL, '2026-02-25 11:08:07'),
(750, 17, 'Medium practice question 5 for Lazy Milestone 1', 'multiple_choice', 'medium', '[\"A. Concept is correct\", \"B. Concept is incorrect\", \"C. It depends on context\", \"D. Concept is partially correct\"]', 'A', 'This is a synthetic medium question to reinforce Lazy Milestone 1. Option A reflects the correct core idea.', NULL, '2026-02-25 11:08:07'),
(751, 18, 'What type of Machine Learning trains a model using labeled data to predict correct outputs?', 'multiple_choice', 'easy', '[\"A. Supervised Learning\", \"B. Reinforcement Learning\", \"C. Unsupervised Learning\", \"D. Transfer Learning\"]', 'A', 'Supervised Learning is the type of Machine Learning that uses labeled data for training, allowing the model to learn a mapping between input data and corresponding output labels.', NULL, '2026-02-25 12:24:23'),
(752, 18, 'What is the main goal of Supervised Learning?', 'multiple_choice', 'easy', '[\"A. To discover hidden patterns in unlabeled data\", \"B. To classify new unseen data\", \"C. To learn a mapping between input data and output labels\", \"D. To identify anomalies\"]', 'C', 'The main goal of Supervised Learning is to learn a mapping between input data and corresponding output labels, allowing the model to predict correct outputs for new unseen data.', NULL, '2026-02-25 12:24:23'),
(753, 18, 'Which type of Machine Learning discovers patterns in unlabeled data by grouping similar instances together?', 'multiple_choice', 'medium', '[\"A. Unsupervised Learning\", \"B. Transfer Learning\", \"C. Supervised Learning\", \"D. Reinforcement Learning\"]', 'A', 'Unsupervised Learning is the type of Machine Learning that discovers patterns in unlabeled data by grouping similar instances together, revealing hidden structures or patterns.', NULL, '2026-02-25 12:24:23'),
(754, 18, 'What is an example of a real-world application of Supervised Learning?', 'multiple_choice', 'medium', '[\"A. Customer segmentation\", \"B. Image classification\", \"C. Facial recognition\", \"D. Sentiment analysis\"]', 'C', 'Facial recognition is a real-world application of Supervised Learning, where the model is trained on labeled data to classify new images as belonging to a specific person or group.', NULL, '2026-02-25 12:24:23'),
(755, 18, 'What type of Machine Learning is useful when you have no clear output labels?', 'multiple_choice', 'hard', '[\"A. Unsupervised Learning\", \"B. Supervised Learning\", \"C. Transfer Learning\", \"D. Reinforcement Learning\"]', 'A', 'Unsupervised Learning is the type of Machine Learning that is useful when you have no clear output labels, as it discovers patterns in unlabeled data by grouping similar instances together.', NULL, '2026-02-25 12:24:23'),
(756, 18, 'What type of machine learning trains a model using labeled data?', 'multiple_choice', 'easy', '[\"A. Supervised Learning\", \"B. Transfer Learning\", \"C. Reinforcement Learning\", \"D. Unsupervised Learning\"]', 'A', 'Supervised learning uses labeled data to train a model that can make predictions on new, unseen data.', NULL, '2026-02-25 12:25:28'),
(757, 18, 'What type of machine learning discovers patterns and relationships in unlabeled data?', 'multiple_choice', 'easy', '[\"A. Supervised Learning\", \"B. Reinforcement Learning\", \"C. Transfer Learning\", \"D. Unsupervised Learning\"]', 'D', 'Unsupervised learning uses unlabeled data to discover patterns, relationships, or groupings within the data.', NULL, '2026-02-25 12:25:28'),
(758, 18, 'What is the goal of supervised learning?', 'multiple_choice', 'medium', '[\"A. To discover patterns in data\", \"B. To predict correct outputs from labeled data\", \"C. To transfer knowledge between models\", \"D. To learn from unlabeled data\"]', 'B', 'The goal of supervised learning is to train a model that can make predictions on new, unseen data using labeled training data.', NULL, '2026-02-25 12:25:28'),
(759, 18, 'What type of machine learning is commonly used in customer segmentation?', 'multiple_choice', 'medium', '[\"A. Unsupervised Learning\", \"B. Transfer Learning\", \"C. Supervised Learning\", \"D. Reinforcement Learning\"]', 'A', 'Unsupervised learning is commonly used in customer segmentation to group customers based on their characteristics without knowing the correct labels.', NULL, '2026-02-25 12:25:28'),
(760, 18, 'What type of machine learning uses a reward signal to train a model?', 'multiple_choice', 'hard', '[\"A. Unsupervised Learning\", \"B. Supervised Learning\", \"C. Reinforcement Learning\", \"D. Transfer Learning\"]', 'C', 'Reinforcement learning uses a reward signal to train a model that can learn from trial and error by maximizing the cumulative reward.', NULL, '2026-02-25 12:25:28'),
(761, 18, 'What type of machine learning uses labeled data to train models?', 'multiple_choice', 'easy', '[\"A. Transfer Learning\", \"B. Unsupervised Learning\", \"C. Reinforcement Learning\", \"D. Supervised Learning\"]', 'D', 'Supervised learning is a type of machine learning where the algorithm is trained on labeled data to make predictions.', NULL, '2026-02-25 12:26:40'),
(762, 18, 'What is the primary goal of unsupervised learning?', 'multiple_choice', 'medium', '[\"A. To predict continuous values\", \"B. To identify patterns in unlabeled data\", \"C. To reduce dimensionality\", \"D. To classify data\"]', 'B', 'The primary goal of unsupervised learning is to identify relationships, group similar data points, or reduce dimensionality without a specific target output.', NULL, '2026-02-25 12:26:40'),
(763, 18, 'What type of regression algorithm is commonly used for classification tasks?', 'multiple_choice', 'medium', '[\"A. Logistic Regression\", \"B. Linear Regression\", \"C. Random Forest\", \"D. Decision Trees\"]', 'A', 'Logistic regression is a type of regression algorithm that\'s commonly used for classification tasks, such as predicting the probability of a yes or no answer.', NULL, '2026-02-25 12:26:40'),
(764, 18, 'What is the goal of clustering in unsupervised learning?', 'multiple_choice', 'easy', '[\"A. To classify data\", \"B. To predict continuous values\", \"C. To identify patterns and group similar data points\", \"D. To reduce dimensionality\"]', 'C', 'The primary goal of clustering is to identify patterns and group similar data points without a specific target output.', NULL, '2026-02-25 12:26:40'),
(765, 18, 'What type of machine learning uses reinforcement learning to train models?', 'multiple_choice', 'hard', '[\"A. Supervised Learning\", \"B. Unsupervised Learning\", \"C. Transfer Learning\", \"D. Reinforcement Learning\"]', 'D', 'Reinforcement learning is a type of machine learning that uses rewards or penalties to train models, often used in decision-making and control applications.', NULL, '2026-02-25 12:26:40'),
(766, 18, 'What type of machine learning uses labeled data to train a model?', 'multiple_choice', 'easy', '[\"A. Supervised Learning\", \"B. Reinforcement Learning\", \"C. Unsupervised Learning\", \"D. Self-Supervised Learning\"]', 'A', 'Supervised learning is the process of training a model using labeled data to make predictions or classify new inputs.', NULL, '2026-02-25 12:27:52'),
(767, 18, 'What is the goal of unsupervised learning?', 'multiple_choice', 'medium', '[\"A. To discover patterns and relationships in data\", \"B. To classify unlabeled data\", \"C. To optimize a reward function\", \"D. To predict continuous values\"]', 'A', 'Unsupervised learning aims to identify meaningful patterns, groupings, or correlations within the input data without labeled examples.', NULL, '2026-02-25 12:27:52'),
(768, 18, 'What is an example of supervised learning?', 'multiple_choice', 'easy', '[\"A. A chatbot\", \"B. A self-driving car\", \"C. A medical diagnosis system\", \"D. A recommendation engine\"]', 'C', 'Supervised learning is often used in applications like medical diagnosis systems, where the goal is to train a model to accurately predict diagnoses based on input features.', NULL, '2026-02-25 12:27:52'),
(769, 18, 'What type of machine learning uses unlabeled data?', 'multiple_choice', 'medium', '[\"A. Supervised Learning\", \"B. Unsupervised Learning\", \"C. Reinforcement Learning\", \"D. Self-Supervised Learning\"]', 'B', 'Unsupervised learning is the process of training a model using unlabeled data to discover patterns and relationships within the input features.', NULL, '2026-02-25 12:27:52'),
(770, 18, 'What is an example of unsupervised learning?', 'multiple_choice', 'hard', '[\"A. A predictive model\", \"B. A customer segmentation system\", \"C. A chatbot\", \"D. A recommender system\"]', 'B', 'Unsupervised learning is often used in applications like customer segmentation systems, where the goal is to group customers based on their characteristics and behavior without labeled examples.', NULL, '2026-02-25 12:27:52'),
(771, 19, 'What is the primary purpose of NumPy?', 'multiple_choice', 'easy', '[\"A. Machine learning\", \"B. Data analysis\", \"C. Text processing\", \"D. Linear algebra operations\"]', 'D', 'NumPy is designed to provide efficient numerical computations for large datasets, making it particularly useful for linear algebra operations and scientific computing.', NULL, '2026-02-25 12:37:37'),
(772, 19, 'What is the main function of scikit-learn?', 'multiple_choice', 'medium', '[\"A. Data preprocessing\", \"B. Model evaluation\", \"C. Machine learning algorithm implementation\", \"D. Visualization\"]', 'C', 'scikit-learn provides a wide range of machine learning algorithms for classification, regression, clustering, and more. Its primary function is to implement these algorithms efficiently.', NULL, '2026-02-25 12:37:37'),
(773, 19, 'What is the main advantage of using Pandas?', 'multiple_choice', 'medium', '[\"A. Easy data manipulation\", \"B. Advanced data analysis\", \"C. Fast data processing\", \"D. All of the above\"]', 'D', 'Pandas provides efficient data structures and operations for structured data, making it particularly useful for data analysis, cleaning, and manipulation. This combination of features makes Pandas an ideal choice for working with large datasets.', NULL, '2026-02-25 12:37:37'),
(774, 19, 'What is the primary function of TensorFlow?', 'multiple_choice', 'hard', '[\"A. Deep learning algorithm implementation\", \"B. Data preprocessing\", \"C. Model evaluation\", \"D. Visualization\"]', 'A', 'TensorFlow is an open-source machine learning library primarily designed for implementing deep learning models, particularly neural networks.', NULL, '2026-02-25 12:37:37'),
(775, 19, 'What is the main purpose of NumPy\'s NumArray?', 'multiple_choice', 'easy', '[\"A. Data analysis\", \"B. Linear algebra operations\", \"C. Machine learning\", \"D. Text processing\"]', 'B', 'NumPy\'s NumArray is designed for efficient linear algebra operations, making it particularly useful for scientific computing and data manipulation.', NULL, '2026-02-25 12:37:37'),
(776, 20, 'What is the primary goal of hands-on machine learning projects?', 'multiple_choice', 'easy', '[\"A. To apply algorithms to real-world problems\", \"B. To deploy models to production environments\", \"C. To evaluate model performance\", \"D. To develop and refine machine learning models\"]', 'A', 'Hands-on machine learning projects aim to apply machine learning algorithms to solve specific real-world problems, demonstrating the practical application of ML concepts.', NULL, '2026-02-25 12:38:29'),
(777, 20, 'What is the main idea behind transfer learning?', 'multiple_choice', 'medium', '[\"A. To use only labeled data for training\", \"B. To combine multiple models for better performance\", \"C. To retrain a model from scratch on each new task\", \"D. To fine-tune a pre-trained model on a new dataset\"]', 'D', 'Transfer learning involves fine-tuning a pre-trained model on a new dataset, leveraging the knowledge gained during initial training to adapt to the new problem or task.', NULL, '2026-02-25 12:38:29'),
(778, 20, 'What is an example of a real-world application of transfer learning?', 'multiple_choice', 'medium', '[\"A. Sentiment analysis for social media sentiment\", \"B. Medical image segmentation for disease diagnosis\", \"C. Image classification for self-driving cars\", \"D. Predicting customer churn for a telecommunications company\"]', 'B', 'Transfer learning can be applied to medical image segmentation, where a pre-trained model is fine-tuned on a new dataset of medical images to detect specific features.', NULL, '2026-02-25 12:38:29'),
(779, 20, 'What is the primary benefit of hands-on machine learning projects?', 'multiple_choice', 'easy', '[\"A. To evaluate model performance using only labeled data\", \"B. To combine multiple models for better performance\", \"C. To develop complex mathematical models\", \"D. To apply machine learning algorithms to real-world problems\"]', 'D', 'Hands-on machine learning projects provide the opportunity to apply machine learning algorithms to solve specific real-world problems, demonstrating the practical application of ML concepts.', NULL, '2026-02-25 12:38:29'),
(780, 20, 'What is the primary goal of deploying a model to production?', 'multiple_choice', 'hard', '[\"A. To retrain the model from scratch on each new task\", \"B. To deploy the model to production and evaluate its performance\", \"C. To evaluate the model\'s performance using only labeled data\", \"D. To fine-tune the model on a new dataset\"]', 'B', 'Deploying a model to production involves making it available for use in real-world scenarios, allowing for evaluation of its performance and potential refinement.', NULL, '2026-02-25 12:38:29');

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
(83, 17, 'markdown', 'Mock Material', 'Mock Desc', 'Mock Content', 1),
(84, 17, 'text', 'Recommended Reading 2 for Lazy Milestone 1', 'Lazy Milestone 1 is a key concept that enables scalable solutions in this domain.', '### 1. Concept Explanation\nPlease research core concepts of Lazy Milestone 1 to build a strong foundation. It is widely used in industry to solve complex problems.\n\n### 2. Flow Explanation\nConcept -> Implementation -> Optimization -> Deployment\n\n### 3. Real-world Example\nMany companies use Lazy Milestone 1 to improve efficiency by 50%.\n\n### 4. Key Points Summary\n- Core foundation\n- Industry standard\n- Scalable approach', 2),
(85, 18, 'markdown', 'Supervised Learning', 'Supervised Learning trains a model using labeled data to predict correct outputs.', '### Concept Explanation\nSupervised Learning is a type of Machine Learning where the algorithm is trained on labeled data. The goal is to learn a mapping between input data and corresponding output labels.\nThis type of learning is useful when you have a clear understanding of what the correct output should be, such as classifying images as dogs or cats.\n\n### Flow Explanation\nInput Data + Correct Answers ↓ Train Model ↓ Model Learns Patterns ↓ Predict New Data\nThe model learns to map input data to output labels by adjusting its parameters based on the labeled training data. Once trained, it can predict new unseen data.\n\n### Real-world Example\nImagine you have a dataset of images with labels (dog or cat). You train a supervised learning algorithm to classify new images as dog or cat. This is useful for applications like facial recognition or image classification.\n\n### Optional Flow Diagram\nText-based flow diagram:\n 1. Input Data + Correct Answers → Train Model → Model Learns Patterns → Predict New Data\nThis shows the step-by-step process of supervised learning, from input data to predicting new unseen data.\n\n### Key Points Summary\n* Supervised Learning is a type of Machine Learning that uses labeled data for training.\n* The goal is to learn a mapping between input data and corresponding output labels.\n* It\'s useful when you have a clear understanding of what the correct output should be.', 1),
(86, 18, 'markdown', 'Unsupervised Learning', 'Unsupervised Learning discovers patterns in unlabeled data by grouping similar instances together.', '### Concept Explanation\nUnsupervised Learning is a type of Machine Learning where the algorithm is trained on unlabeled data. The goal is to discover hidden patterns or structures in the data.\nThis type of learning is useful when you have a dataset with no clear output labels, such as clustering customers based on their purchase history.\n\n### Flow Explanation\nInput Data ↓ Cluster Similar Instances ↓ Grouped Clusters ↓ Insights Gained\nThe algorithm groups similar instances together based on their features, revealing hidden patterns or structures in the data. This can be useful for applications like customer segmentation or anomaly detection.\n\n### Real-world Example\nImagine you have a dataset of customer purchase history with no labels. You use unsupervised learning to cluster customers based on their buying behavior. This can help identify target markets and improve marketing strategies.\n\n### Optional Flow Diagram\nText-based flow diagram:\n 1. Input Data → Cluster Similar Instances → Grouped Clusters → Insights Gained\nThis shows the step-by-step process of unsupervised learning, from input data to gaining insights into hidden patterns.\n\n### Key Points Summary\n* Unsupervised Learning is a type of Machine Learning that discovers patterns in unlabeled data.\n* The goal is to group similar instances together and reveal hidden structures in the data.\n* It\'s useful when you have no clear output labels or want to identify unknown patterns.', 2),
(87, 18, 'markdown', 'Supervised Learning', 'Supervised Learning trains a model using labeled data to predict correct outputs.', '**Concept Explanation: ** Supervised learning is a type of machine learning where the algorithm learns from labeled data. This means that you have both input and output data, and the goal is to train a model that can make predictions on new, unseen data. For example, in image classification, supervised learning would use labeled images (cats or dogs) to train a model that can classify new images as either cats or dogs.\r\n\r\n**Flow Explanation:**\r\nInput Data + Correct Answers ↓ Train Model ↓ Model Learns Patterns ↓ Predict New Data\r\n\r\n**Real-world Example:** In sentiment analysis, supervised learning is used to train a model on labeled text data (positive or negative reviews) to predict the sentiment of new, unseen text.\r\n\r\n**Optional Flow Diagram: **\r\n```\r\n  +---------------+\r\n  |   Input Data  |\r\n  +---------------+\r\n  |       Correct  |\r\n  |  Answers (Labels)|\r\n  +---------------+\r\n  |      Train Model|\r\n  |      (Learn Patterns)    |\r\n  +---------------+\r\n  |  Predict New Data  |\r\n  +---------------+\r\n```\r\n**Key Points Summary:**\r\n• Supervised learning uses labeled data to train a model.\r\n• The goal is to make predictions on new, unseen data.\r\n• This type of learning is commonly used in image classification and sentiment analysis.', 1),
(88, 18, 'markdown', 'Unsupervised Learning', 'Unsupervised Learning discovers patterns and relationships in unlabeled data without a specific output.', '**Concept Explanation: ** Unsupervised learning is a type of machine learning where the algorithm learns from unlabeled data. This means that you have input data only, and the goal is to discover patterns, relationships, or groupings within the data. For example, in customer segmentation, unsupervised learning would group customers based on their characteristics (age, location, etc.) without knowing the correct labels.\r\n\r\n**Flow Explanation:**\r\nInput Data ↓ Discover Patterns ↓ Grouping/Clustering ↓ Insights\r\n\r\n**Real-world Example:** In market research, unsupervised learning is used to cluster customers based on their demographics and purchase history to create targeted marketing campaigns.\r\n\r\n**Optional Flow Diagram: **\r\n```\r\n  +---------------+\r\n  |   Input Data  |\r\n  +---------------+\r\n  |    Discover     |\r\n  |  Patterns (Clusters)  |\r\n  +---------------+\r\n  | Grouping/Clustering|\r\n  |  (Find Similarities)  |\r\n  +---------------+\r\n  |  Insights (Knowledge)|\r\n  +---------------+\r\n```\r\n**Key Points Summary:**\r\n• Unsupervised learning uses unlabeled data to discover patterns and relationships.\r\n• The goal is to group similar data points or identify clusters.\r\n• This type of learning is commonly used in customer segmentation, market research, and anomaly detection.', 2),
(89, 18, 'markdown', 'Supervised Learning', 'Supervised Learning trains a model using labeled data to predict correct outputs.', '**Concept Explanation:**\n\nSupervised learning is a type of machine learning where the algorithm is trained on labeled data to make predictions. The goal is to find a relationship between input features and output labels, which allows the model to accurately predict unknown inputs.\n\n**Flow Explanation:***\n\n+ Input Data + Correct Answers \n→ Train Model \n→ Model Learns Patterns \n→ Predict New Data\n\n**Real-world Example:**\n\nImagine you want to build a chatbot that can respond to user queries. You collect a dataset of conversations with labeled responses (correct answers). The supervised learning algorithm trains on this data, learns patterns in the conversations, and can then predict new responses for unknown inputs.\n\n**Optional Flow Diagram:***\n\n```\nInput Data + Correct Answers \n→ Train Model \n→ Model Learns Patterns \n→ Predict New Data\n```\n\n**Key Points Summary:**\n\n* Supervised learning uses labeled data to train models.\n* The goal is to make predictions on unknown inputs.\n* It\'s commonly used for classification and regression tasks.', 1),
(90, 18, 'markdown', 'Unsupervised Learning', 'Unsupervised Learning finds patterns in unlabeled data without a specific goal.', '**Concept Explanation:**\n\nUnsupervised learning is a type of machine learning where the algorithm finds patterns or structure in unlabeled data. The goal is to identify relationships, group similar data points, or reduce dimensionality.\n\n**Flow Explanation:***\n\n+ Input Data \n→ Train Model \n→ Model Learns Patterns \n→ Identify Clusters or Relationships\n\n**Real-world Example:**\n\nImagine you have a dataset of customer purchase history and want to identify clusters based on their buying behavior. Unsupervised learning algorithms, such as k-means clustering, can group similar customers together without any labeled data.\n\n**Optional Flow Diagram:***\n\n```\nInput Data \n→ Train Model \n→ Model Learns Patterns \n→ Identify Clusters or Relationships\n```\n\n**Key Points Summary:**\n\n* Unsupervised learning finds patterns in unlabeled data.\n* The goal is to identify relationships, group similar data points, or reduce dimensionality.\n* It\'s commonly used for clustering and dimensionality reduction tasks.', 2),
(91, 18, 'markdown', 'Regression', 'Regression Predicts a Continuous Value Based on Input Features.', '**Concept Explanation:**\n\nRegression is a type of supervised learning where the algorithm predicts a continuous value based on input features. The goal is to find a relationship between input variables and output values.\n\n**Flow Explanation:***\n\n+ Input Data + Output Values \n→ Train Model \n→ Model Learns Patterns \n→ Predict Continuous Value\n\n**Real-world Example:**\n\nImagine you want to predict the price of a house based on its characteristics, such as size and location. Regression algorithms can learn patterns in this data and make predictions for new houses.\n\n**Optional Flow Diagram:***\n\n```\nInput Data + Output Values \n→ Train Model \n→ Model Learns Patterns \n→ Predict Continuous Value\n```\n\n**Key Points Summary:**\n\n* Regression predicts a continuous value based on input features.\n* The goal is to find a relationship between input variables and output values.\n* It\'s commonly used for predicting continuous outcomes, such as stock prices or temperatures.', 3),
(92, 18, 'markdown', 'Supervised Learning', 'Supervised Learning trains a model using labeled data to predict correct outputs.', '### Concept Explanation\nSupervised learning is a type of machine learning where the algorithm learns from labeled data. The goal is to train a model that can accurately predict the output based on the input features.\n\nIn supervised learning, you provide both the input and the corresponding expected output. This allows the model to learn the relationship between the input features and the desired output.\n\n### Flow Explanation\nInput Data + Correct Answers\ndown\ntagging Model\ndown\nto Model Learns Patterns from Labeled Data\ndown	predict New Unseen Data\n\n### Real-world Example\nImagine a medical diagnosis system that uses X-rays to classify patients as having either pneumonia or not. The system would be trained on a dataset of labeled X-ray images and the corresponding diagnoses. Once trained, it could accurately diagnose new patients based on their X-rays.\n\n### Optional Flow Diagram\n```\n  +---------------+\n  |  Input Data  |\n  +---------------+\n  |  Tagging Model |\n  +---------------+\n  v\n  +---------------+\n  |  Model Learns  |\n  |  Patterns from  |\n  |  Labeled Data   |\n  +---------------+\n  v\n  +---------------+\n  |  Predict New  |\n  |  Unseen Data   |\n  +---------------+\n```\n### Key Points Summary\n* Supervised learning uses labeled data to train a model.\n* The goal is to predict the correct output based on the input features.\n* This type of learning is commonly used in image and speech recognition, natural language processing, and more.', 1),
(93, 18, 'markdown', 'Unsupervised Learning', 'Unsupervised Learning discovers patterns and relationships in data without labeled examples.', '### Concept Explanation\nUnsupervised learning is a type of machine learning where the algorithm learns from unlabeled data. The goal is to discover hidden patterns, relationships, or structures within the data.\n\nIn unsupervised learning, you provide only the input features, and the model must find meaningful clusters, groupings, or correlations on its own.\n\n### Flow Explanation\nInput Data\ndown\ntagging Model (Optional)\ndown\nto Model Learns Patterns and Relationships from Unlabeled Data\ndown	predict New Clusters or Categories\n\n### Real-world Example\nImagine a customer segmentation system that groups customers based on their shopping habits, demographics, and other characteristics. The system would be trained on a dataset of unlabeled customer data and could identify meaningful clusters, such as \'frequent shoppers\' or \'high-value customers\'.\n\n### Optional Flow Diagram\n```\n  +---------------+\n  |  Input Data  |\n  +---------------+\n  |  Tagging Model |\n  (Optional)\n  +---------------+\n  v\n  +---------------+\n  |  Model Learns  |\n  |  Patterns and   |\n  |  Relationships  |\n  |  from Unlabeled |\n  |  Data           |\n  +---------------+\n  v\n  +---------------+\n  |  Predict New  |\n  |  Clusters or    |\n  |  Categories    |\n  +---------------+\n```\n### Key Points Summary\n* Unsupervised learning discovers patterns and relationships in data without labeled examples.\n* The goal is to identify meaningful groupings, clusters, or correlations within the data.\n* This type of learning is commonly used in clustering, dimensionality reduction, and density estimation.', 2),
(94, 19, 'markdown', 'NumPy Basics', 'NumPy (Numerical Python) is a library for efficient numerical computation in Python. It provides support for large, multi-dimensional arrays and matrices, along with high-performance mathematical functions to operate on these arrays.', '## Concept Explanation\nNumPy is designed to provide an easy-to-use interface for numerical operations. It allows you to manipulate and analyze data efficiently.\n\n## Flow Explanation\nInput Data + Correct Answers\ndownarrow\nTrain Model\n→\nModel Learns Patterns\n→\nPredict New Data\n\n## Real-world Example\nImagine you\'re working with a dataset containing patient information, such as age, blood pressure, and cholesterol levels. You want to use this data to train a model that can predict the likelihood of developing heart disease.\n\n## Optional Flow Diagram\n```\nInput Data → Train Model → Predict New Data → Analyze Results\n```\n## Key Points Summary\n* NumPy provides efficient numerical operations for large datasets.\n* It\'s designed for high-performance computation.\n* You can use NumPy to manipulate and analyze data in Python.', 1),
(95, 19, 'markdown', 'Pandas Fundamentals', 'Pandas is a powerful library for working with structured data in Python. It provides efficient data structures and operations for manipulating and analyzing data.', '## Concept Explanation\nPandas is designed to provide easy-to-use data structures for efficiently handling structured data. It\'s particularly useful for data analysis, cleaning, and manipulation.\n\n## Flow Explanation\nInput Data + Correct Answers\ndownarrow\nLoad Data into Pandas DataFrame\n→\nManipulate and Clean Data\n→\nAnalyze and Visualize Data\n→\nMake Predictions or Insights\n\n## Real-world Example\nImagine you\'re working with a dataset containing customer information, such as demographics, purchase history, and product ratings. You want to use this data to identify patterns and make predictions about future purchases.\n\n## Optional Flow Diagram\n```\nInput Data → Load into DataFrame → Manipulate & Clean → Analyze & Visualize → Make Predictions\n```\n## Key Points Summary\n* Pandas provides efficient data structures for structured data.\n* It\'s designed for data analysis, cleaning, and manipulation.\n* You can use Pandas to load, manipulate, and analyze data in Python.', 2),
(96, 19, 'markdown', 'scikit-learn Introduction', 'scikit-learn is a machine learning library for Python. It provides a wide range of algorithms for classification, regression, clustering, and more.', '## Concept Explanation\nscikit-learn is designed to provide easy-to-use interfaces for implementing various machine learning algorithms. It\'s particularly useful for data preprocessing, feature selection, and model evaluation.\n\n## Flow Explanation\nInput Data + Correct Answers\ndownarrow\nPreprocess Data\n→\nSplit Data into Training & Testing Sets\n→\nTrain Model\n→\nEvaluate Model Performance\n→\nMake Predictions or Insights\n\n## Real-world Example\nImagine you\'re working with a dataset containing customer information, such as demographics and purchase history. You want to use this data to train a model that can predict future purchases.\n\n## Optional Flow Diagram\n```\nInput Data → Preprocess → Split into Training & Testing → Train Model → Evaluate Performance → Make Predictions\n```\n## Key Points Summary\n* scikit-learn provides easy-to-use interfaces for machine learning algorithms.\n* It\'s designed for data preprocessing, feature selection, and model evaluation.\n* You can use scikit-learn to implement various machine learning models in Python.', 3),
(97, 20, 'markdown', 'Hands-on Machine Learning: Project-Based Learning', 'Hands-on machine learning projects involve applying algorithms to real-world problems, building a portfolio of projects and deploying them to production environments.', '**Concept Explanation:** In hands-on machine learning, you work on real-world projects that apply machine learning algorithms to solve specific problems. This approach helps you build a portfolio of projects that demonstrate your skills and deploy them to production environments. By working on practical projects, you gain hands-on experience in developing and refining your machine learning models. This is an essential step in becoming a proficient ML engineer.\n\n**Flow Explanation:**\nInput Data + Correct Answers\n↓\nTrain Model\n↓\nModel Learns Patterns\n↓\nPredict New Data\n\n**Real-world Example:** For instance, you might work on a project to predict customer churn for a telecommunications company. You would collect data on customer behavior, usage patterns, and demographics, then train a model using machine learning algorithms. Finally, you would deploy the model to production and evaluate its performance.\n\n**Optional Flow Diagram:*\nInput Data → Correct Answers → Train Model → Model Learns Patterns → Predict New Data\ndeployed_model → evaluate_performance\n\n**Key Points Summary:**\n• Apply machine learning algorithms to real-world problems.\n• Build a portfolio of projects that demonstrate your skills.\n• Deploy models to production environments for evaluation.', 1),
(98, 20, 'markdown', 'Transfer Learning', 'Transfer learning is a technique where a pre-trained model is fine-tuned on a new dataset, leveraging the knowledge learned from the initial training process.', '**Concept Explanation:** Transfer learning is an approach in machine learning that involves fine-tuning a pre-trained model on a new dataset. This technique leverages the knowledge gained during the initial training process and adapts it to fit the new problem or dataset. In essence, transfer learning allows you to reuse the learned patterns and relationships from one domain or task and apply them to another related domain or task.\n\n**Flow Explanation:**\nPre-trained Model + New Dataset\n↓\nFine-tune Model\n↓\nModel Learns Domain-Specific Patterns\n↓\nPredict New Data\n\n**Real-world Example:** For instance, you might use a pre-trained model for object detection and fine-tune it on a new dataset of medical images to detect specific features. The initial training process helps the model learn general patterns related to objects, which are then adapted to fit the specific domain of medical imaging.\n\n**Optional Flow Diagram:*\nPre-trained Model → New Dataset → Fine-tune Model → Model Learns Domain-Specific Patterns → Predict New Data\ndeployed_model → evaluate_performance\n\n**Key Points Summary:**\n• Fine-tune a pre-trained model on a new dataset.\n• Leverage knowledge learned during initial training process.\n• Adapt the model to fit a new problem or dataset.', 2);

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
(1, 5, 10, 1, '2026-02-25 12:47:14', '2026-02-25 12:49:00');

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
(8, 'LazyTesterRole', 99, 1);

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
(1, 'maintain_milestones', '2026-02-25 06:56:08', '2026-02-25 06:56:08', 'completed', 0, 0, 0, NULL, '2026-02-25 12:26:08'),
(2, 'maintain_milestones', '2026-02-25 06:57:25', '2026-02-25 06:57:25', 'completed', 0, 0, 0, NULL, '2026-02-25 12:27:25'),
(3, 'maintain_milestones', '2026-02-25 06:57:28', '2026-02-25 06:57:28', 'completed', 0, 0, 0, NULL, '2026-02-25 12:27:28'),
(4, 'maintain_milestones', '2026-02-25 06:57:46', '2026-02-25 06:57:46', 'completed', 0, 0, 0, NULL, '2026-02-25 12:27:46'),
(5, 'maintain_milestones', '2026-02-25 07:06:40', '2026-02-25 07:08:29', 'completed', 2, 2, 0, NULL, '2026-02-25 12:36:40');

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
(4, 8, 5, 'Lazy Test Plan', NULL, 1, '2026-02-25 11:08:07'),
(5, 7, 1, 'ML Engineer - Fresher (0–1 year) Training Plan', 'AI-generated training plan based on your role, experience level, and skills.', 1, '2026-02-25 12:22:56');

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
(1, NULL, 'Test User', 'test@example.com', '1234567890', 'dummy_encoding', '2026-02-25 10:27:21.742397'),
(2, 'profile_c295ab85897f433aa7c6073a4bda8ac4.jpg', 'Manoj', 'mydatab99@gmail.com', '9760894418', '0.3921568691730499,0.3803921639919281,0.45490196347236633,0.3803921639919281,0.22745098173618317,0.4117647111415863,0.4274509847164154,0.3803921639919281,0.40392157435417175,0.3960784375667572,0.18431372940540314,0.4156862795352936,0.43921568989753723,0.3960784375667572,0.40392157435417175,0.23137255012989044,0.3843137323856354,0.3803921639919281,0.45098039507865906,0.3960784375667572,0.21176470816135406,0.20392157137393951,0.1725490242242813,0.18431372940540314,0.2235294133424759,0.4156862795352936,0.18431372940540314,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.32549020648002625,0.41960784792900085,0.3529411852359772,0.29019609093666077,0.32156863808631897,0.40392157435417175,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2666666805744171,0.18431372940540314,0.20392157137393951,0.40392157435417175,0.2823529541492462,0.3490196168422699,0.32549020648002625,0.3333333432674408,0.30588236451148987,0.2666666805744171,0.3450980484485626,0.1921568661928177,0.25882354378700256,0.32549020648002625,0.3294117748737335,0.1882352977991104,0.3529411852359772,0.29019609093666077,0.3294117748737335,0.2705882489681244,0.3333333432674408,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2823529541492462,0.2862745225429535,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.3176470696926117,0.46666666865348816,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.45490196347236633,0.3843137323856354,0.4313725531101227,0.32156863808631897,0.4745098054409027,0.3333333432674408,0.41960784792900085,0.3921568691730499,0.26274511218070984,0.2862745225429535,0.27450981736183167,0.40784314274787903,0.3529411852359772,0.34117648005485535,0.4117647111415863,0.2549019753932953,0.2823529541492462,0.20392157137393951,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.2549019753932953,0.2549019753932953,0.2705882489681244,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.2549019753932953,0.25882354378700256,0.40784314274787903,0.3490196168422699,0.20000000298023224,0.30588236451148987,0.46666666865348816,0.2549019753932953', '2026-02-22 22:22:20.416900'),
(3, NULL, 'Lazy User', 'lazy@test.com', '123', '[]', '2026-02-25 11:08:07.201910');

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
(7, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 11:25:22'),
(8, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 12:33:38'),
(9, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 13:49:03'),
(10, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 15:00:01'),
(11, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 16:16:40'),
(12, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-24 17:20:49'),
(13, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-25 04:35:29'),
(14, 2, 'face', '[0.39215686274509803, 0.3803921568627451, 0.4549019607843137, 0.3803921568627451, 0.22745098039215686, 0.4117647058823529, 0.42745098039215684, 0.3803921568627451, 0.403921568627451, 0.396078431372549, 0.1843137254901961, 0.41568627450980394, 0.4392156862745098, 0.396078431372549, 0.403921568627451, 0.23137254901960785, 0.3843137254901961, 0.3803921568627451, 0.45098039215686275, 0.396078431372549, 0.21176470588235294, 0.20392156862745098, 0.17254901960784313, 0.1843137254901961, 0.2235294117647059, 0.41568627450980394, 0.1843137254901961, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.3254901960784314, 0.4196078431372549, 0.35294117647058826, 0.2901960784313726, 0.3215686274509804, 0.403921568627451, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.26666666666666666, 0.1843137254901961, 0.20392156862745098, 0.403921568627451, 0.2823529411764706, 0.34901960784313724, 0.3254901960784314, 0.3333333333333333, 0.3058823529411765, 0.26666666666666666, 0.34509803921568627, 0.19215686274509805, 0.25882352941176473, 0.3254901960784314, 0.32941176470588235, 0.18823529411764706, 0.35294117647058826, 0.2901960784313726, 0.32941176470588235, 0.27058823529411763, 0.3333333333333333, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2823529411764706, 0.28627450980392155, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.3176470588235294, 0.4666666666666667, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.4549019607843137, 0.3843137254901961, 0.43137254901960786, 0.3215686274509804, 0.4745098039215686, 0.3333333333333333, 0.4196078431372549, 0.39215686274509803, 0.2627450980392157, 0.28627450980392155, 0.27450980392156865, 0.40784313725490196, 0.35294117647058826, 0.3411764705882353, 0.4117647058823529, 0.2549019607843137, 0.2823529411764706, 0.20392156862745098, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.2549019607843137, 0.2549019607843137, 0.27058823529411763, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.2549019607843137, 0.25882352941176473, 0.40784313725490196, 0.34901960784313724, 0.2, 0.3058823529411765, 0.4666666666666667, 0.2549019607843137]', NULL, 0, NULL, NULL, NULL, NULL, 'success', NULL, '2026-02-25 06:19:40');

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
(17, 7, 17, 'in_progress', NULL, NULL, 0, 0),
(18, 8, 18, 'in_progress', NULL, NULL, 100, 1),
(19, 8, 19, 'locked', NULL, NULL, 0, 0),
(20, 8, 20, 'locked', NULL, NULL, 0, 0);

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

--
-- Dumping data for table `user_quiz_attempts`
--

INSERT INTO `user_quiz_attempts` (`id`, `user_milestone_progress_id`, `score`, `total_questions`, `passed`, `attempted_at`) VALUES
(2, 18, 52, 19, 0, '2026-02-25 12:34:54'),
(3, 18, 40, 20, 0, '2026-02-25 12:35:40'),
(4, 18, 30, 20, 0, '2026-02-25 12:39:20');

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
(6, 18, 85, 1, '2026-02-25 12:30:53'),
(7, 18, 87, 1, '2026-02-25 12:30:56'),
(8, 18, 89, 1, '2026-02-25 12:30:59'),
(9, 18, 92, 1, '2026-02-25 12:31:01'),
(10, 18, 91, 1, '2026-02-25 12:31:07'),
(11, 18, 93, 1, '2026-02-25 12:31:10'),
(12, 18, 90, 1, '2026-02-25 12:31:12'),
(13, 18, 86, 1, '2026-02-25 12:31:14'),
(14, 18, 88, 1, '2026-02-25 12:31:16');

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
(7, 3, 4, '2026-02-25 11:08:07', 'active', 1),
(8, 2, 5, '2026-02-25 12:22:56', 'active', 1);

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
-- AUTO_INCREMENT for table `master_milestones`
--
ALTER TABLE `master_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `master_quiz_questions`
--
ALTER TABLE `master_quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=781;

--
-- AUTO_INCREMENT for table `master_study_materials`
--
ALTER TABLE `master_study_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `training_plans`
--
ALTER TABLE `training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_login_details`
--
ALTER TABLE `user_login_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user_milestone_progress`
--
ALTER TABLE `user_milestone_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_quiz_submitted_answers`
--
ALTER TABLE `user_quiz_submitted_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_study_material_progress`
--
ALTER TABLE `user_study_material_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user_study_progress`
--
ALTER TABLE `user_study_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_training_plans`
--
ALTER TABLE `user_training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
