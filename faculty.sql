-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2023 at 12:42 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `faculty`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `ID` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `in_time` datetime DEFAULT NULL,
  `out_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`ID`, `faculty_id`, `in_time`, `out_time`) VALUES
(1, 1003, '2023-05-23 13:21:07', '2023-05-23 13:21:15'),
(2, 1003, '2023-05-23 15:29:18', '2023-05-23 15:52:59'),
(3, 1003, '2023-06-07 11:58:20', '2023-06-07 11:58:36'),
(4, 1004, '2023-06-08 01:19:13', '2023-06-08 01:19:16'),
(5, 1003, '2023-06-08 08:54:03', '2023-06-08 08:54:05'),
(6, 1004, '2023-06-08 08:56:36', '2023-06-08 08:56:38'),
(7, 1004, '2023-06-10 11:54:18', '2023-06-10 11:54:21'),
(8, 1003, '2023-06-13 02:44:14', '2023-06-13 02:44:17'),
(9, 1003, '2023-06-13 11:40:02', '2023-06-13 11:40:07'),
(10, 1003, '2023-06-13 11:48:46', '2023-06-13 11:48:49'),
(11, 1003, '2023-06-13 11:50:21', '2023-06-13 11:50:22'),
(12, 1003, '2023-06-13 14:44:06', '2023-06-13 14:44:10'),
(13, 1003, '2023-06-13 14:53:04', '2023-06-13 14:53:05');

-- --------------------------------------------------------

--
-- Table structure for table `bonafide_application`
--

CREATE TABLE `bonafide_application` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `bonafide_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bonafide_application`
--

INSERT INTO `bonafide_application` (`id`, `faculty_id`, `bonafide_reason`) VALUES
(1, 1003, 'Research'),
(2, 1004, 'Internship');

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE `details` (
  `faculty_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `blood_group` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `department` enum('CSE','EEE','ME','CE','IT','ECE','AE','CSE-AI') DEFAULT NULL,
  `designation` enum('faculty','advisor','principal','admin') NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `mobile_number` varchar(15) DEFAULT NULL,
  `marital_status` enum('married','unmarried') DEFAULT NULL,
  `address_city` varchar(50) DEFAULT NULL,
  `address_state` varchar(50) DEFAULT NULL,
  `address_pincode` varchar(10) DEFAULT NULL,
  `cv` varchar(255) NOT NULL,
  `tor` varchar(255) NOT NULL,
  `pvc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `details`
--

INSERT INTO `details` (`faculty_id`, `name`, `date_of_birth`, `blood_group`, `department`, `designation`, `email`, `mobile_number`, `marital_status`, `address_city`, `address_state`, `address_pincode`, `cv`, `tor`, `pvc`) VALUES
(1001, 'Sai Mrudhun', '2002-07-13', 'O+', 'CSE', 'faculty', 'saimrudhunp@gmail.com', '9841087972', 'unmarried', 'chennai', 'india', '600048', 'saicv.pdf', 'saitor.pdf', 'saipvc.pdf'),
(1002, 'Aswin Kumar K', '2002-10-05', 'O+', 'ME', 'advisor', 'aswinkaliraj@gmail.com', '8778731285', 'married', 'Dharapuram', 'Tamil Nadu', '600201', 'aswincv.pdf', 'aswintor.pdf', 'aswinpvc.pdf'),
(1003, 'Giri Prasath R', '2002-09-01', 'O+', 'CSE', 'faculty', 'giriganesh2000@gmail.com', '7904953380', 'married', 'Pudukkottai', 'Tamilnadu', '622001', 'giricv.pdf', 'giritor.pdf', 'giripvc.pdf'),
(1004, 'Manoj S ', '2002-11-27', 'B+', 'CSE-AI', 'advisor', 'manojsuresh2002@gmail.com', '8124433225', 'married', 'hosur', 'Tamil Nadu', '635109', 'manojcv.pdf', 'manojtor.pdf', 'manojpvc.pdf'),
(8888, 'Nishant', '2002-10-05', 'A+', NULL, 'principal', 'principal@gmail.com', '9987541475', 'unmarried', 'Namakkal', 'Tamilnadu', '637001', '', '', ''),
(9999, 'admin', '2000-01-01', 'AB+', NULL, 'admin', 'avparmita@gmail.com', '6369186514', 'married', 'Trichy\n', 'Tamilnadu', '610212', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `faculty_id` int(11) NOT NULL,
  `bachelor_degree` varchar(50) DEFAULT NULL,
  `b_institution` varchar(100) DEFAULT NULL,
  `masters_degree` varchar(50) DEFAULT NULL,
  `m_institution` varchar(100) DEFAULT NULL,
  `research` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`faculty_id`, `bachelor_degree`, `b_institution`, `masters_degree`, `m_institution`, `research`) VALUES
(1001, 'B.Tech - Computer Science', 'Amrita School of Engineering', 'M.tech - Computer VIsion', 'Massachusetts Institute of Technology', 'Railway crack detection'),
(1002, 'B.Tech - Civil Engineering', 'IIT - Madras', 'M.tech - Mechatronics', 'IIT - Pune', 'Nil'),
(1003, 'B.TECH CSE-AI', 'PSG Institute of Technology', 'M.TECH Full Stack Development', 'Amrita School of Engineering', 'nil'),
(1004, 'B.TECH CSE', 'NIT - Trichy', 'M.TECH Game Design', 'NIT - Bhopal', 'Nil'),
(8888, 'B.TECH ECE', 'PSG Institute of Technology', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exam_paper`
--

CREATE TABLE `exam_paper` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `exam_paper_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exam_paper`
--

INSERT INTO `exam_paper` (`id`, `faculty_id`, `exam_paper_name`) VALUES
(1, 1003, 'exam_paper1.pdf'),
(2, 1004, 'exam_paper2.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `leave_application`
--

CREATE TABLE `leave_application` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `leave_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `leave_application`
--

INSERT INTO `leave_application` (`id`, `faculty_id`, `start_date`, `end_date`, `leave_reason`, `created_at`) VALUES
(1, 1003, '2023-06-13', '2023-06-15', 'Sick', '2023-06-12 09:05:58'),
(2, 1004, '2023-06-13', '2023-06-16', 'Personal', '2023-06-13 10:21:59');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `faculty_id` int(11) NOT NULL,
  `designation` enum('faculty','advisor','principal','admin') DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `passcode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`faculty_id`, `designation`, `email`, `passcode`) VALUES
(1001, 'faculty', 'saimrudhunp@gmail.com', 'sai@123'),
(1002, 'advisor', 'aswinkaliraj@gmail.com', 'aswin'),
(1003, 'faculty', 'giriganesh2000@gmail.com', 'giri@123'),
(1004, 'advisor', 'manojsuresh2002@gmail.com', 'manoj@123'),
(8888, 'principal', 'principal@gmail.com', 'principal@123'),
(9999, 'admin', 'avparmita@gmail.com', 'Admin@123');

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `file_data` longblob DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `faculty_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `file_data`, `file_name`, `file_size`, `faculty_id`) VALUES
(14, NULL, 'CB.EN.U4CSE20122_Paper.pdf', 1770, 1003),
(15, NULL, 'CB.EN.U4CSE20122_PPT.pptx', 3691, 1003),
(21, NULL, 'Stress_Summary__http___localhost_3000__Load_Test_1_1.pdf', 118, 1003);

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `faculty_id` int(11) NOT NULL,
  `designation` enum('faculty','advisor','principal','admin') DEFAULT NULL,
  `basic_salary` decimal(15,2) DEFAULT NULL,
  `taxes` decimal(10,2) GENERATED ALWAYS AS (case when `basic_salary` between 600000 and 900000 then `basic_salary` * 0.1 when `basic_salary` between 900001 and 1200000 then `basic_salary` * 0.15 when `basic_salary` between 1200001 and 1500000 then `basic_salary` * 0.2 when `basic_salary` > 1500000 then `basic_salary` * 0.3 else 0 end) STORED,
  `total_salary` decimal(10,2) GENERATED ALWAYS AS (`basic_salary` - `taxes`) STORED,
  `monthly_salary` decimal(10,2) GENERATED ALWAYS AS (`total_salary` / 12) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`faculty_id`, `designation`, `basic_salary`) VALUES
(1001, 'faculty', '2000000.00'),
(1002, 'advisor', '2500000.00'),
(1003, 'faculty', '1400000.00'),
(1004, 'advisor', '2200000.00'),
(8888, 'principal', '800000.00');

-- --------------------------------------------------------

--
-- Table structure for table `sample_paper`
--

CREATE TABLE `sample_paper` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `sample_paper_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sample_paper`
--

INSERT INTO `sample_paper` (`id`, `faculty_id`, `sample_paper_name`) VALUES
(1, 1002, 'sample_paper1.pdf'),
(2, 1004, 'sample_paper2.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `task_id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `task_description` text DEFAULT NULL,
  `task_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`task_id`, `faculty_id`, `task_description`, `task_date`) VALUES
(1, 1001, 'To attend the conference on computer vision on 23/07', '2023-05-20 18:55:13'),
(2, 1003, 'To upload the quiz marks for cse-b\r\n', '2023-05-19 18:55:17'),
(3, 1002, 'Approve all the passes of cseb on coming thursday', '2023-05-15 12:55:54'),
(4, 1004, 'Meeting with CRs of cseb on coming monday', '2023-05-20 18:56:59'),
(5, 1003, 'Quiz on Bootcamp for cseb on 24th', '2023-05-19 10:58:31'),
(6, 1001, 'Correct all the papers of computer vision by 25th', '2023-05-16 08:59:39'),
(929, 1003, 'cir', '2023-06-13 14:45:09'),
(930, 1003, 'cir', '2023-06-13 14:45:09'),
(931, 1003, 'cir', '2023-06-13 14:45:09'),
(932, 1003, 'cir', '2023-06-13 14:45:09'),
(933, 1003, 'cir', '2023-06-13 14:45:09'),
(934, 1003, 'cir', '2023-06-13 14:53:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `bonafide_application`
--
ALTER TABLE `bonafide_application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `details`
--
ALTER TABLE `details`
  ADD PRIMARY KEY (`faculty_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `exam_paper`
--
ALTER TABLE `exam_paper`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `leave_application`
--
ALTER TABLE `leave_application`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`faculty_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `sample_paper`
--
ALTER TABLE `sample_paper`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`task_id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `bonafide_application`
--
ALTER TABLE `bonafide_application`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `exam_paper`
--
ALTER TABLE `exam_paper`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `leave_application`
--
ALTER TABLE `leave_application`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `sample_paper`
--
ALTER TABLE `sample_paper`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `task_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=935;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `bonafide_application`
--
ALTER TABLE `bonafide_application`
  ADD CONSTRAINT `bonafide_application_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `education_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `exam_paper`
--
ALTER TABLE `exam_paper`
  ADD CONSTRAINT `exam_paper_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `leave_application`
--
ALTER TABLE `leave_application`
  ADD CONSTRAINT `leave_application_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`),
  ADD CONSTRAINT `login_ibfk_2` FOREIGN KEY (`email`) REFERENCES `details` (`email`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `salary`
--
ALTER TABLE `salary`
  ADD CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `sample_paper`
--
ALTER TABLE `sample_paper`
  ADD CONSTRAINT `sample_paper_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `details` (`faculty_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
