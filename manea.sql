-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2026 at 10:38 PM
-- Server version: 8.4.9
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manea`
--

-- --------------------------------------------------------

--
-- Table structure for table `csv_batches`
--

CREATE TABLE `csv_batches` (
  `csv_batch_id` int NOT NULL,
  `accountant_id` int NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imported_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `csv_batches`
--

INSERT INTO `csv_batches` (`csv_batch_id`, `accountant_id`, `file_name`, `file_path`, `imported_at`) VALUES
(1, 2, 'ManeaTestingD4.csv', 'uploads/csv_batches/batch_6a1c8e2d4a4133.58678170.csv', '2026-05-31 19:38:21');

-- --------------------------------------------------------

--
-- Table structure for table `employee_cards`
--

CREATE TABLE `employee_cards` (
  `card_id` int NOT NULL,
  `user_id` int NOT NULL,
  `card_suffix` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `card_status` enum('ACTIVE','INACTIVE','BLOCKED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_cards`
--

INSERT INTO `employee_cards` (`card_id`, `user_id`, `card_suffix`, `card_status`, `issued_at`) VALUES
(1, 3, '1003', 'ACTIVE', '2026-05-20 07:08:36'),
(2, 4, '1004', 'ACTIVE', '2026-05-20 07:08:36'),
(3, 5, '1005', 'ACTIVE', '2026-05-20 07:08:36'),
(4, 6, '1006', 'ACTIVE', '2026-05-20 07:08:36'),
(5, 7, '1007', 'ACTIVE', '2026-05-20 07:08:36'),
(6, 8, '1008', 'ACTIVE', '2026-05-20 07:08:36');

-- --------------------------------------------------------

--
-- Table structure for table `flags`
--

CREATE TABLE `flags` (
  `flag_id` int NOT NULL,
  `flag_ref` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fund_request_id` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  `invoice_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `flag_reason` enum('AI_AMOUNT_MISMATCH','OVERDUE_TRANSACTION','DUPLICATE_INVOICE','MANUAL_REVIEW') COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` enum('LOW','MEDIUM','HIGH') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'HIGH',
  `status` enum('OPEN','REVIEWED','RESOLVED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPEN',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flags`
--

INSERT INTO `flags` (`flag_id`, `flag_ref`, `fund_request_id`, `transaction_id`, `invoice_id`, `employee_id`, `flag_reason`, `priority`, `status`, `details`, `created_at`, `resolved_at`) VALUES
(1, 'FLG-001', 1, 1, 1, 3, 'AI_AMOUNT_MISMATCH', 'HIGH', 'RESOLVED', 'Invoice amount (SAR 1,160.00) does not match transaction amount (SAR 3,200.00). Difference: SAR 2,040.00.', '2026-05-31 19:45:07', '2026-05-31 20:15:40'),
(2, 'FLG-002', 2, 3, 2, 4, 'AI_AMOUNT_MISMATCH', 'MEDIUM', 'OPEN', 'Invoice amount (SAR 2,900.30) does not match transaction amount (SAR 3,000.00). Difference: SAR 99.70.', '2026-05-31 19:47:29', NULL),
(3, 'FLG-003', 3, 5, 4, 5, 'AI_AMOUNT_MISMATCH', 'HIGH', 'OPEN', 'Invoice amount (SAR 65.00) does not match transaction amount (SAR 1,850.00). Difference: SAR 1,785.00.', '2026-05-31 19:48:52', NULL),
(4, 'FLG-004', 4, 8, 5, 6, 'DUPLICATE_INVOICE', 'HIGH', 'REVIEWED', 'Invoice 0003-6316 submitted again. Original upload: 2026-05-31 22:48:52.', '2026-05-31 19:49:29', NULL),
(5, 'FLG-005', 1, 2, NULL, 3, 'OVERDUE_TRANSACTION', 'HIGH', 'OPEN', 'Invoice not uploaded within 7 days. Transaction: 2026-05-10. 14 days overdue.', '2026-05-31 20:13:41', NULL),
(6, 'FLG-006', 3, 6, NULL, 5, 'OVERDUE_TRANSACTION', 'HIGH', 'RESOLVED', 'Invoice not uploaded within 7 days. Transaction: 2026-05-10. 14 days overdue.', '2026-05-31 20:13:41', '2026-05-31 20:16:06'),
(7, 'FLG-007', 5, 9, NULL, 7, 'OVERDUE_TRANSACTION', 'HIGH', 'OPEN', 'Invoice not uploaded within 7 days. Transaction: 2026-05-10. 14 days overdue.', '2026-05-31 20:13:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fund_recoveries`
--

CREATE TABLE `fund_recoveries` (
  `recovery_id` int NOT NULL,
  `fund_request_id` int NOT NULL,
  `amount` decimal(12,2) DEFAULT '0.00',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `recovered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accountant_id` int DEFAULT NULL,
  `amount_recovered` decimal(12,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fund_recoveries`
--

INSERT INTO `fund_recoveries` (`recovery_id`, `fund_request_id`, `amount`, `reason`, `recovered_at`, `accountant_id`, `amount_recovered`) VALUES
(1, 5, 0.00, NULL, '2026-05-31 20:11:26', 2, 0.00),
(2, 5, 0.00, NULL, '2026-05-31 20:12:52', 2, 21600.00),
(3, 4, 0.00, NULL, '2026-05-31 20:13:03', 2, 37448.00);

-- --------------------------------------------------------

--
-- Table structure for table `fund_requests`
--

CREATE TABLE `fund_requests` (
  `fund_request_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `accountant_id` int DEFAULT NULL,
  `request_title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` enum('LOW','MEDIUM','HIGH') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MEDIUM',
  `status` enum('PENDING','APPROVED','REJECTED','CANCELED','ACTIVE','READY_TO_CLOSE','CLOSED','FLAGGED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `amount_requested` decimal(12,2) NOT NULL DEFAULT '0.00',
  `amount_spent` decimal(12,2) NOT NULL DEFAULT '0.00',
  `purpose` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `project_due_date` date DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remaining_amount` decimal(12,2) DEFAULT '0.00',
  `request_date` date DEFAULT (curdate()),
  `rejection_reason` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fund_requests`
--

INSERT INTO `fund_requests` (`fund_request_id`, `employee_id`, `accountant_id`, `request_title`, `request_type`, `priority`, `status`, `amount_requested`, `amount_spent`, `purpose`, `description`, `project_due_date`, `approved_at`, `closed_at`, `created_at`, `remaining_amount`, `request_date`, `rejection_reason`) VALUES
(1, 3, NULL, 'Digital Marketing Campaign', 'Marketing', 'HIGH', 'FLAGGED', 25000.00, 8000.00, 'Fund campaign expenses across digital channels', 'Covers social media ads, content creation, and influencer partnerships for Q2 campaign', '2026-07-30', '2026-05-31 19:24:57', NULL, '2026-05-31 19:14:06', 17000.00, '2026-05-31', NULL),
(2, 4, NULL, 'HR Training & Development', 'HR', 'MEDIUM', 'FLAGGED', 35000.00, 5400.00, 'Annual staff training program', 'Covers training sessions, materials, and external trainer fees for HR department', '2026-07-30', '2026-05-31 19:31:05', NULL, '2026-05-31 19:16:07', 29600.00, '2026-05-31', NULL),
(3, 5, NULL, 'IT Infrastructure Upgrade', 'Technology', 'HIGH', 'FLAGGED', 50000.00, 9150.00, 'Upgrade network switches and servers', 'Replace outdated network equipment across all floors', '2026-07-30', '2026-05-31 19:31:17', NULL, '2026-05-31 19:17:26', 40850.00, '2026-05-31', NULL),
(4, 6, NULL, 'Marketing Campaigns Q2', 'Marketing', 'HIGH', 'CLOSED', 40000.00, 40000.00, 'Q2 marketing and brand awareness campaigns', 'Covers print, digital, and event marketing activities for Q2', '2026-07-30', '2026-05-31 19:31:23', NULL, '2026-05-31 19:19:26', 0.00, '2026-05-31', NULL),
(5, 7, NULL, 'Logistics Vendor Support', 'Operations', 'MEDIUM', 'CLOSED', 30000.00, 30000.00, 'Vendor payments and logistics coordination', 'Covers third-party vendor payments and delivery coordination costs', '2026-05-01', '2026-05-31 19:31:27', NULL, '2026-05-31 19:21:10', 0.00, '2026-05-31', NULL),
(6, 8, NULL, 'Office Supplies & Equipment', 'IT', 'LOW', 'REJECTED', 15000.00, 0.00, 'Purchase office supplies and equipment', 'Covers stationery, printing equipment, and office furniture for IT department', '2026-07-30', NULL, NULL, '2026-05-31 19:22:33', 15000.00, '2026-05-31', 'Budget allocation exceeded for this quarter'),
(7, 8, NULL, 'Office Supplies & Equipment', 'IT', 'LOW', 'PENDING', 3666.00, 0.00, 'jihugyf', 'ouiyut', '2026-07-30', NULL, NULL, '2026-05-31 19:50:57', 0.00, '2026-05-31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL,
  `fund_request_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `invoice_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `invoice_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `invoice_currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SAR',
  `converted_amount_base` decimal(12,2) DEFAULT NULL,
  `base_currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SAR',
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ocr_raw_text` text COLLATE utf8mb4_unicode_ci,
  `ocr_vendor_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ocr_confidence` decimal(5,2) DEFAULT NULL,
  `verification_status` enum('PENDING','VERIFIED','REJECTED','FLAGGED','MATCHED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `fund_request_id`, `employee_id`, `invoice_number`, `invoice_date`, `invoice_amount`, `invoice_currency`, `converted_amount_base`, `base_currency`, `file_path`, `file_name`, `ocr_raw_text`, `ocr_vendor_name`, `ocr_confidence`, `verification_status`, `uploaded_at`, `upload_date`) VALUES
(1, 1, 3, '191', '2023-06-22', 1160.00, 'SAR', NULL, 'SAR', 'uploads\\invoices\\20260531_224507_1_in.JPG', '20260531_224507_1_in.JPG', NULL, 'مؤسسة فخامة المنزل للديكور', NULL, 'FLAGGED', '2026-05-31 19:45:07', '2026-05-31 19:45:07'),
(2, 2, 4, '17303', '2021-05-19', 2900.30, 'SAR', NULL, 'SAR', 'uploads\\invoices\\20260531_224729_2_in55.jpg', '20260531_224729_2_in55.jpg', NULL, 'SALEM ALSOLU EST', NULL, 'FLAGGED', '2026-05-31 19:47:29', '2026-05-31 19:47:29'),
(3, 2, 4, '3235', '2025-03-09', 2400.00, 'SAR', NULL, 'SAR', 'uploads\\invoices\\20260531_224759_2_in2.JPG', '20260531_224759_2_in2.JPG', NULL, 'مؤسسة تقنية الأسد', NULL, 'VERIFIED', '2026-05-31 19:47:59', '2026-05-31 19:47:59'),
(4, 3, 5, '0003-6316', '2024-11-17', 65.00, 'SAR', NULL, 'SAR', 'uploads\\invoices\\20260531_224852_3_in66.jpg', '20260531_224852_3_in66.jpg', NULL, 'مؤسسة جوهره الانارة التجارية', NULL, 'FLAGGED', '2026-05-31 19:48:52', '2026-05-31 19:48:52'),
(5, 4, 6, '0003-6316', '2024-11-17', 65.00, 'SAR', NULL, 'SAR', 'uploads\\invoices\\20260531_224929_4_in66.jpg', '20260531_224929_4_in66.jpg', NULL, 'مؤسسة جوهره الانارة التجارية', NULL, 'FLAGGED', '2026-05-31 19:49:29', '2026-05-31 19:49:29');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_transactions`
--

CREATE TABLE `invoice_transactions` (
  `id` int NOT NULL,
  `invoice_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `match_score` decimal(5,3) DEFAULT NULL,
  `match_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_transactions`
--

INSERT INTO `invoice_transactions` (`id`, `invoice_id`, `transaction_id`, `match_score`, `match_method`, `is_confirmed`, `created_at`) VALUES
(1, 1, 1, 0.700, 'direct_link', 1, '2026-05-31 19:45:07'),
(3, 2, 3, 0.700, 'direct_link', 1, '2026-05-31 19:47:29'),
(5, 3, 4, 1.000, 'direct_link', 1, '2026-05-31 19:47:59'),
(7, 4, 5, 0.700, 'direct_link', 1, '2026-05-31 19:48:52'),
(9, 5, 8, 0.700, 'direct_link', 1, '2026-05-31 19:49:29');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int NOT NULL,
  `user_id` int NOT NULL,
  `type` enum('REQUEST_APPROVED','REQUEST_REJECTED','FLAGGED_TRANSACTION','ACCOUNT_CLEARED','INVOICE_OVERDUE','REQUEST_CLOSED','') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `type`, `message`, `is_read`, `created_at`) VALUES
(1, 3, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:14:06'),
(2, 4, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:16:07'),
(3, 5, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:17:26'),
(4, 6, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:19:26'),
(5, 7, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:21:10'),
(6, 8, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:22:33'),
(7, 2, '', 'Fund request #2 is pending approval.', 0, '2026-05-31 19:24:57'),
(8, 2, '', 'Fund request #3 is pending approval.', 0, '2026-05-31 19:24:57'),
(9, 2, '', 'Fund request #4 is pending approval.', 0, '2026-05-31 19:24:57'),
(10, 2, '', 'Fund request #5 is pending approval.', 0, '2026-05-31 19:24:57'),
(11, 2, '', 'Fund request #6 is pending approval.', 0, '2026-05-31 19:24:57'),
(12, 8, 'REQUEST_REJECTED', 'Your fund request has been rejected. Reason: Budget allocation exceeded for this quarter', 0, '2026-05-31 19:30:55'),
(13, 1, 'FLAGGED_TRANSACTION', 'FLG-001: Amount mismatch — invoice SAR 1,160.00 vs transaction SAR 3,200.00', 1, '2026-05-31 19:45:07'),
(14, 9, 'FLAGGED_TRANSACTION', 'FLG-001: Amount mismatch — invoice SAR 1,160.00 vs transaction SAR 3,200.00', 0, '2026-05-31 19:45:07'),
(16, 3, 'FLAGGED_TRANSACTION', 'Invoice amount does not match the transaction amount. The auditor has been notified.', 0, '2026-05-31 19:45:07'),
(17, 1, 'FLAGGED_TRANSACTION', 'FLG-002: Amount mismatch — invoice SAR 2,900.30 vs transaction SAR 3,000.00', 1, '2026-05-31 19:47:29'),
(18, 9, 'FLAGGED_TRANSACTION', 'FLG-002: Amount mismatch — invoice SAR 2,900.30 vs transaction SAR 3,000.00', 0, '2026-05-31 19:47:29'),
(20, 4, 'FLAGGED_TRANSACTION', 'Invoice amount does not match the transaction amount. The auditor has been notified.', 0, '2026-05-31 19:47:29'),
(21, 4, 'REQUEST_APPROVED', 'Invoice uploaded successfully and sent for OCR verification.', 0, '2026-05-31 19:47:59'),
(22, 1, 'FLAGGED_TRANSACTION', 'FLG-003: Amount mismatch — invoice SAR 65.00 vs transaction SAR 1,850.00', 1, '2026-05-31 19:48:52'),
(23, 9, 'FLAGGED_TRANSACTION', 'FLG-003: Amount mismatch — invoice SAR 65.00 vs transaction SAR 1,850.00', 0, '2026-05-31 19:48:52'),
(25, 5, 'FLAGGED_TRANSACTION', 'Invoice amount does not match the transaction amount. The auditor has been notified.', 0, '2026-05-31 19:48:52'),
(26, 1, 'FLAGGED_TRANSACTION', 'FLG-004: Duplicate invoice 0003-6316 detected', 1, '2026-05-31 19:49:29'),
(27, 9, 'FLAGGED_TRANSACTION', 'FLG-004: Duplicate invoice 0003-6316 detected', 0, '2026-05-31 19:49:29'),
(29, 6, 'FLAGGED_TRANSACTION', 'Invoice flagged as duplicate. The same invoice was already submitted. Please re-upload the correct invoice.', 0, '2026-05-31 19:49:29'),
(30, 8, 'REQUEST_APPROVED', 'Request submitted successfully. Submission status: Sent for review.', 0, '2026-05-31 19:50:57'),
(32, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:11:26'),
(33, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:11:26'),
(34, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:12:52'),
(35, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:12:52'),
(36, 6, 'REQUEST_CLOSED', 'Fund request #4 has been closed.', 0, '2026-05-31 20:13:03'),
(37, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:13:03'),
(38, 6, 'REQUEST_CLOSED', 'Fund request #4 has been closed.', 0, '2026-05-31 20:13:03'),
(39, 7, 'REQUEST_CLOSED', 'Fund request #5 has been closed.', 0, '2026-05-31 20:13:03'),
(40, 1, 'INVOICE_OVERDUE', 'FLG-005: Overdue invoice — Digital Marketing Campaign', 1, '2026-05-31 20:13:41'),
(41, 9, 'INVOICE_OVERDUE', 'FLG-005: Overdue invoice — Digital Marketing Campaign', 0, '2026-05-31 20:13:41'),
(43, 1, 'INVOICE_OVERDUE', 'FLG-006: Overdue invoice — IT Infrastructure Upgrade', 1, '2026-05-31 20:13:41'),
(44, 9, 'INVOICE_OVERDUE', 'FLG-006: Overdue invoice — IT Infrastructure Upgrade', 0, '2026-05-31 20:13:41'),
(46, 1, 'INVOICE_OVERDUE', 'FLG-007: Overdue invoice — Logistics Vendor Support', 1, '2026-05-31 20:13:41'),
(47, 9, 'INVOICE_OVERDUE', 'FLG-007: Overdue invoice — Logistics Vendor Support', 0, '2026-05-31 20:13:41');

-- --------------------------------------------------------

--
-- Table structure for table `pending_invoice_uploads`
--

CREATE TABLE `pending_invoice_uploads` (
  `upload_id` int NOT NULL,
  `fund_request_id` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  `employee_id` int NOT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('PENDING','PROCESSING','DONE','FAILED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `invoice_id` int DEFAULT NULL,
  `error_message` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `csv_batch_id` int DEFAULT NULL,
  `card_id` int NOT NULL,
  `fund_request_id` int DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency_code` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SAR',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'POS',
  `due_date` date DEFAULT NULL,
  `verification_status` enum('UNMATCHED','MATCHED','FLAGGED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNMATCHED',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `csv_batch_id`, `card_id`, `fund_request_id`, `transaction_date`, `amount`, `currency_code`, `description`, `transaction_type`, `due_date`, `verification_status`, `created_at`) VALUES
(1, 1, 1, 1, '2026-05-28', 3200.00, 'SAR', 'POS PURCHASE RIYADH', 'POS', '2026-06-04', 'FLAGGED', '2026-05-31 19:38:21'),
(2, 1, 1, 1, '2026-05-10', 4800.00, 'SAR', 'ONLINE PURCHASE', 'ONLINE', '2026-05-17', 'FLAGGED', '2026-05-31 19:38:21'),
(3, 1, 2, 2, '2026-05-28', 3000.00, 'SAR', 'POS PURCHASE JEDDAH', 'POS', '2026-06-04', 'FLAGGED', '2026-05-31 19:38:21'),
(4, 1, 2, 2, '2026-05-28', 2400.00, 'SAR', 'DEBIT TRANSFER', 'DEBIT_TRANSFER', '2026-06-04', 'MATCHED', '2026-05-31 19:38:21'),
(5, 1, 3, 3, '2026-05-28', 1850.00, 'SAR', 'POINT OF SALE RIYADH', 'POS', '2026-06-04', 'FLAGGED', '2026-05-31 19:38:21'),
(6, 1, 3, 3, '2026-05-10', 7300.00, 'SAR', 'POS PURCHASE DAMMAM', 'POS', '2026-05-17', 'FLAGGED', '2026-05-31 19:38:21'),
(7, 1, 4, 4, '2026-05-28', 1160.00, 'SAR', 'MADA PURCHASE DAMMAM', 'POS', '2026-06-04', 'UNMATCHED', '2026-05-31 19:38:21'),
(8, 1, 4, 4, '2026-05-28', 1392.00, 'SAR', 'MADA PURCHASE DAMMAM', 'POS', '2026-06-04', 'FLAGGED', '2026-05-31 19:38:21'),
(9, 1, 5, 5, '2026-05-10', 8400.00, 'SAR', 'DEBIT TRANSFER VENDOR', 'DEBIT_TRANSFER', '2026-05-17', 'FLAGGED', '2026-05-31 19:38:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('EMPLOYEE','ACCOUNTANT','AUDITOR') COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password_hash`, `role`, `department`, `is_active`, `created_at`) VALUES
(1, 'Ahmed Al-Rashidi', 'ahmed.rashidi@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'AUDITOR', 'Internal Audit', 1, '2026-05-20 07:08:36'),
(2, 'Sara Al-Otaibi', 'sara.otaibi@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'ACCOUNTANT', 'Finance', 1, '2026-05-20 07:08:36'),
(3, 'Mohammed Al-Zahrani', 'mohammed.zahrani@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'Operations', 1, '2026-05-20 07:08:36'),
(4, 'Fatima Al-Dosari', 'fatima.dosari@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'HR', 1, '2026-05-20 07:08:36'),
(5, 'Khalid Al-Shehri', 'khalid.shehri@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'IT', 1, '2026-05-20 07:08:36'),
(6, 'Noura Al-Ghamdi', 'noura.ghamdi@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'Marketing', 1, '2026-05-20 07:08:36'),
(7, 'Omar Al-Harbi', 'omar.harbi@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'Logistics', 1, '2026-05-20 07:08:36'),
(8, 'Lina Al-Qahtani', 'lina.qahtani@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'EMPLOYEE', 'IT', 1, '2026-05-20 07:08:36'),
(9, 'Nora Al-Rashidi', 'nora.rashidi@manea.com', '$2y$10$YcFBnNrdY2hJaPnX./FsFuWJqe/UwueQdiNE76sjsNev61AhiBG76', 'AUDITOR', 'Internal Audit', 1, '2026-05-20 07:08:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `csv_batches`
--
ALTER TABLE `csv_batches`
  ADD PRIMARY KEY (`csv_batch_id`),
  ADD KEY `fk_batch_accountant` (`accountant_id`);

--
-- Indexes for table `employee_cards`
--
ALTER TABLE `employee_cards`
  ADD PRIMARY KEY (`card_id`),
  ADD KEY `fk_card_user` (`user_id`);

--
-- Indexes for table `flags`
--
ALTER TABLE `flags`
  ADD PRIMARY KEY (`flag_id`),
  ADD KEY `fk_flag_request` (`fund_request_id`),
  ADD KEY `fk_flag_transaction` (`transaction_id`),
  ADD KEY `fk_flag_invoice` (`invoice_id`),
  ADD KEY `fk_flag_employee` (`employee_id`);

--
-- Indexes for table `fund_recoveries`
--
ALTER TABLE `fund_recoveries`
  ADD PRIMARY KEY (`recovery_id`),
  ADD KEY `fk_rec_request` (`fund_request_id`);

--
-- Indexes for table `fund_requests`
--
ALTER TABLE `fund_requests`
  ADD PRIMARY KEY (`fund_request_id`),
  ADD KEY `fk_fr_employee` (`employee_id`),
  ADD KEY `fk_fr_accountant` (`accountant_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `fk_inv_request` (`fund_request_id`),
  ADD KEY `fk_inv_employee` (`employee_id`);

--
-- Indexes for table `invoice_transactions`
--
ALTER TABLE `invoice_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_inv_tx` (`invoice_id`,`transaction_id`),
  ADD KEY `fk_it_transaction` (`transaction_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `fk_notif_user` (`user_id`);

--
-- Indexes for table `pending_invoice_uploads`
--
ALTER TABLE `pending_invoice_uploads`
  ADD PRIMARY KEY (`upload_id`),
  ADD KEY `fk_piu_request` (`fund_request_id`),
  ADD KEY `fk_piu_employee` (`employee_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `uq_transaction` (`card_id`,`transaction_date`,`amount`,`description`(50)),
  ADD KEY `fk_tx_request` (`fund_request_id`),
  ADD KEY `fk_tx_batch` (`csv_batch_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `csv_batches`
--
ALTER TABLE `csv_batches`
  MODIFY `csv_batch_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_cards`
--
ALTER TABLE `employee_cards`
  MODIFY `card_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `flags`
--
ALTER TABLE `flags`
  MODIFY `flag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `fund_recoveries`
--
ALTER TABLE `fund_recoveries`
  MODIFY `recovery_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fund_requests`
--
ALTER TABLE `fund_requests`
  MODIFY `fund_request_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `invoice_transactions`
--
ALTER TABLE `invoice_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `pending_invoice_uploads`
--
ALTER TABLE `pending_invoice_uploads`
  MODIFY `upload_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `csv_batches`
--
ALTER TABLE `csv_batches`
  ADD CONSTRAINT `fk_batch_accountant` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `employee_cards`
--
ALTER TABLE `employee_cards`
  ADD CONSTRAINT `fk_card_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `flags`
--
ALTER TABLE `flags`
  ADD CONSTRAINT `fk_flag_employee` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_flag_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`),
  ADD CONSTRAINT `fk_flag_request` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`fund_request_id`);

--
-- Constraints for table `fund_recoveries`
--
ALTER TABLE `fund_recoveries`
  ADD CONSTRAINT `fk_rec_request` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`fund_request_id`);

--
-- Constraints for table `fund_requests`
--
ALTER TABLE `fund_requests`
  ADD CONSTRAINT `fk_fr_accountant` FOREIGN KEY (`accountant_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_fr_employee` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_inv_employee` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_inv_request` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`fund_request_id`);

--
-- Constraints for table `invoice_transactions`
--
ALTER TABLE `invoice_transactions`
  ADD CONSTRAINT `fk_it_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `pending_invoice_uploads`
--
ALTER TABLE `pending_invoice_uploads`
  ADD CONSTRAINT `fk_piu_employee` FOREIGN KEY (`employee_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_piu_request` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`fund_request_id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_tx_batch` FOREIGN KEY (`csv_batch_id`) REFERENCES `csv_batches` (`csv_batch_id`),
  ADD CONSTRAINT `fk_tx_card` FOREIGN KEY (`card_id`) REFERENCES `employee_cards` (`card_id`),
  ADD CONSTRAINT `fk_tx_request` FOREIGN KEY (`fund_request_id`) REFERENCES `fund_requests` (`fund_request_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
