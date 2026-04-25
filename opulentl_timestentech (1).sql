-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 25, 2026 at 11:01 AM
-- Server version: 10.11.16-MariaDB-cll-lve
-- PHP Version: 8.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `opulentl_timestentech`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `last_login`) VALUES
(1, 'timestentechnologies@gmail.com', '$2y$10$6pvYF7az3ikhidLlXOaos.hZmiEH1PGsBU9LwtQrw0HKoibO3z7Bi', '2024-08-21 10:22:13');

-- --------------------------------------------------------

--
-- Table structure for table `backup_logs`
--

CREATE TABLE `backup_logs` (
  `id` int(11) NOT NULL,
  `backup_name` varchar(255) NOT NULL,
  `backup_file` varchar(500) NOT NULL,
  `backup_size` bigint(20) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(100) NOT NULL,
  `backup_type` enum('manual','auto') NOT NULL DEFAULT 'manual',
  `status` enum('success','failed','in_progress') NOT NULL DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_logs`
--

INSERT INTO `backup_logs` (`id`, `backup_name`, `backup_file`, `backup_size`, `created_at`, `created_by`, `backup_type`, `status`) VALUES
(4, 'backup_2026-04-09_12-10-10.sql', '/home3/opulentl/timestentechnologies.co.ke/dashboard/backups/backup_2026-04-09_12-10-10.sql', 654084, '2026-04-09 12:10:10', 'timestentechnologies@gmail.com', 'manual', 'success');

-- --------------------------------------------------------

--
-- Table structure for table `backup_schedule`
--

CREATE TABLE `backup_schedule` (
  `id` int(11) NOT NULL,
  `schedule_name` varchar(100) NOT NULL DEFAULT 'Every 2 Days',
  `frequency_days` int(11) NOT NULL DEFAULT 2,
  `last_run` timestamp NULL DEFAULT NULL,
  `next_run` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_schedule`
--

INSERT INTO `backup_schedule` (`id`, `schedule_name`, `frequency_days`, `last_run`, `next_run`, `is_active`, `created_at`) VALUES
(1, 'Every 2 Days', 2, NULL, '2026-03-20 07:00:36', 1, '2026-03-18 07:00:36');

-- --------------------------------------------------------

--
-- Table structure for table `blog`
--

CREATE TABLE `blog` (
  `id` int(11) NOT NULL,
  `blog_title` varchar(255) NOT NULL,
  `blog_desc` text NOT NULL,
  `blog_detail` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ufile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blog`
--

INSERT INTO `blog` (`id`, `blog_title`, `blog_desc`, `blog_detail`, `created_at`, `ufile`) VALUES
(2, 'Unlocking Business Potential with Custom Software Development', 'Discover how custom software development can provide tailored solutions for your business', 'Introduction:\r\nOff-the-shelf software often falls short in addressing unique business needs. Custom software development provides tailored solutions that align with your specific requirements and goals.\r\n\r\nTailored Solutions:\r\nCustom software is designed to meet the unique challenges of your business, offering features and functionalities that off-the-shelf products cannot match.\r\n\r\nScalability:\r\nCustom software solutions are built to scale with your business. As your company grows, the software can be adjusted to accommodate new needs and demands.\r\n\r\nIntegration:\r\nSeamless integration with existing systems enhances operational efficiency by ensuring that all tools and platforms work together smoothly.\r\n\r\nEnhanced Security:\r\nCustom solutions provide better security by addressing specific vulnerabilities and implementing robust protection measures tailored to your business.\r\n\r\nCost Efficiency:\r\nWhile custom software may require a higher initial investment, it offers long-term savings by reducing the need for expensive upgrades and minimizing disruptions.\r\n\r\nConclusion:\r\nCustom software development offers significant benefits for businesses seeking tailored solutions. Partner with Timesten Kenya to create software that meets your unique needs and drives growth.\r\n\r\n', '2024-08-18 12:49:59', '9082default.png'),
(3, 'The Future of Web Development: Trends and Innovations to Watch', 'Explore the latest trends and innovations in web development that are shaping the future of digital experiences. ', 'Introduction:\r\nThe web development landscape is continuously evolving, with new trends and technologies emerging at a rapid pace. Staying updated with these changes is essential for creating modern, engaging websites.\r\n\r\nResponsive Design:\r\nResponsive design ensures that websites function seamlessly across various devices and screen sizes. With the increasing use of mobile devices, this approach is now a standard practice.\r\n\r\nProgressive Web Apps (PWAs):\r\nPWAs combine the best features of web and mobile apps, offering offline capabilities, faster loading times, and a more app-like experience. They are becoming increasingly popular for enhancing user engagement.\r\n\r\nArtificial Intelligence:\r\nAI is transforming web development by enabling personalized experiences, automation, and intelligent analytics. From chatbots to recommendation engines, AI enhances the functionality and user experience of websites.\r\n\r\nCybersecurity:\r\nAs cyber threats grow, robust security measures are critical for protecting online assets. Implementing the latest security protocols ensures that your website is safe from potential breaches.\r\n\r\nFuture Trends:\r\nEmerging technologies such as 5G are set to further impact web development by enabling faster connections and new possibilities for interactive experiences.\r\n\r\nConclusion:\r\nKeeping pace with web development trends allows businesses to remain competitive and relevant. At Timesten Kenya, we integrate these innovations into our web solutions to ensure that our clients benefit from the latest advancements.', '2024-08-18 13:38:08', '3693img-5.gif'),
(4, 'Leveraging Data Analytics to Drive Informed Business Decisions', 'Learn how data analytics provides insights, predictive models, and visualization tools to enhance decision-making and business performance.', 'Introduction:\r\nData analytics plays a crucial role in today’s business landscape, offering insights that help companies make informed decisions and optimize their strategies.\r\n\r\nData Collection:\r\nEffective data collection involves gathering relevant and accurate information from various sources. Proper management ensures that the data is reliable and useful for analysis.\r\n\r\nData Analysis:\r\nAnalyzing data involves examining patterns and trends to uncover valuable insights. Techniques such as statistical analysis and data mining help businesses understand their data better.\r\n\r\nPredictive Analytics:\r\nPredictive analytics uses historical data to forecast future trends and behaviors. This helps businesses anticipate changes and make proactive decisions.\r\n\r\nVisualization:\r\nData visualization tools present complex data in an easy-to-understand format. Visualizations such as charts and graphs help stakeholders grasp insights quickly and make informed decisions.\r\n\r\nReal-World Examples:\r\nExplore case studies of businesses that have successfully used data analytics to drive their strategies and achieve their goals.\r\n\r\nConclusion:\r\nHarnessing the power of data analytics enables businesses to make strategic, data-driven decisions. Timesten Kenya offers expert analytics services to help you unlock the full potential of your data.', '2024-08-18 13:39:23', '1376interactive.png'),
(5, 'Top 7 Reasons to Choose a Kenyan Website Development Company in 2025', 'Discover why Kenyan web development companies like TimesTen Technologies offer affordable, expert, and localized solutions for your business in 2025.', 'In todayâ€™s digitally-driven economy, having a professionally developed website is critical to the success of any business. If you\\\'re based in Kenya or targeting the East African market, hiring a local website development company offers several advantages. This article highlights seven key reasons why choosing a Kenyan website development company like TimesTen Technologies in 2025 is a smart move.\\r\\n\\r\\n1. Local Market Understanding Kenyan developers understand the cultural, economic, and consumer behavior patterns in the region. This enables them to create locally relevant websites that appeal to your target audience. Image suggestion: Nairobi skyline with tech startups overlay\\r\\n\\r\\n2. Seamless Communication & Time Zone Alignment Working with a local team means easier coordination, faster response times, and in-person meetings when needed. No more late-night Zoom calls or translation issues. Image suggestion: TimesTen team in a client strategy meeting\\r\\n\\r\\n3. Cost-Effective Yet High-Quality Services Compared to international firms, Kenyan companies offer competitive pricing while delivering global-standard solutions. You get value for money without compromising on quality.\\r\\n\\r\\n4. Knowledge of Regional Regulations Local developers understand Kenyan ICT laws, data protection regulations, and can integrate M-Pesa and local payment systems seamlessly. Image suggestion: Screenshot of a mobile payment checkout page\\r\\n\\r\\n5. Strong After-Sales Support Need updates or fixes? A Kenyan firm like TimesTen offers timely, reliable after-sales support and ongoing maintenance packages.\\r\\n\\r\\n6. Better Local SEO Performance Developers with local knowledge optimize your site for Kenyan search terms, helping your business appear in results for queries like \\\"website development Nairobi\\\" or \\\"tech companies in Kenya.\\\"\\r\\n\\r\\n7. Empowering the Local Economy By hiring a local company, you\\\'re also supporting job creation and digital innovation in Kenya.\\r\\n\\r\\nA website is more than just a digital presence; it\\\'s your 24/7 sales tool. Choosing a Kenyan developer ensures you get a site tailored to your market, with local support and expert guidance.\\r\\n\\r\\nLooking for a trusted web development partner in Kenya? Contact TimesTen Technologies today. https://timestentechnologies.co.ke\\r\\n', '2025-06-08 07:08:15', '7225550_5waysseowebdesigngotogether5e2945dd5df37.webp'),
(6, 'How to Choose the Best Website Development Company Near You in Kenya', 'Learn how to choose the right web developer near you in Kenya. From portfolio review to SEO experience, hereâ€™s your 2025 checklist.', 'With dozens of web development companies in Kenya, how do you choose the right one? Whether you need a new website or a redesign, selecting the right partner is critical. Hereâ€™s your comprehensive guide to making an informed choice.\r\n\r\n1. Evaluate Their Portfolio\r\nCheck the companyâ€™s previous work. A solid portfolio shows creativity, industry experience, and technical skills.\r\nImage suggestion: Collage of project screenshots with client logos\r\n\r\n2. Look at Their Technology Stack\r\nDo they use modern tools and frameworks like WordPress, Laravel, React, or Shopify? This ensures scalability and future-proofing.\r\n\r\n3. Check SEO & Performance Optimization Expertise\r\nA good developer will not only build your site but also optimize it for speed, search rankings, and mobile responsiveness.\r\nImage suggestion: Lighthouse performance and SEO score screenshot\r\n\r\n4. Ask for References & Testimonials\r\nSpeak with past clients to verify the companyâ€™s claims. Check Google reviews, LinkedIn, or testimonials on the website.\r\n\r\n5. Consider Their Communication Style\r\nYou want a responsive and transparent partner. Look for firms that offer clear timelines, documentation, and regular updates.\r\n\r\n6. Assess Pricing & Contracts\r\nAvoid vague quotes. Ask for itemized pricing, scope of work, and post-launch support terms.\r\n\r\n7. Look for Local Presence\r\nA team based in Nairobi or Mombasa can offer face-to-face meetings, local market insights, and faster support.\r\n\r\nChoosing the best website development company involves more than comparing prices. Use this checklist to find a reliable, results-driven partner.\r\n\r\nReady to work with a top-rated Kenyan web developer? Request a free consultation.', '2025-06-08 09:08:35', '4884welcome[1].jpg'),
(7, '10 Most In-Demand Tech Services for Kenyan Businesses in 2025', 'Discover the essential tech services driving growth for Kenyan businesses in 2025, from cybersecurity to mobile apps and cloud solutions.', 'In Kenya\'s rapidly evolving digital economy, businesses are realizing that technology isn\'t just a support functionâ€”it\'s the backbone of growth and competitive advantage. From streamlining operations to reaching new markets, tech services are now at the heart of business strategy. Whether you\'re a startup, SME, or large enterprise, here are the top 10 in-demand tech services Kenyan businesses are investing in for 2025.\r\n\r\n1. Custom Website & Web App DevelopmentA professional website is often the first impression your business makes. In 2025, web platforms are becoming more interactive, mobile-responsive, and SEO-optimized. Businesses are also leveraging custom web apps for internal operations like inventory, HR, and CRM systems.ðŸ“Š Stat: Over 65% of Kenyan consumers visit a companyâ€™s website before making a purchase decision.\r\n\r\n2. Mobile App DevelopmentWith Kenyaâ€™s mobile penetration at 91% (CAK, 2024), mobile apps are essential. Whether itâ€™s for e-commerce, fintech, healthcare, or education, mobile applications help businesses stay close to their customers.\r\n\r\nðŸ“Š Stat: 80% of urban Kenyan users spend more than 3 hours daily on mobile apps.\r\n\r\n3. Cybersecurity & Data ProtectionWith increased digitalization comes increased risk. Kenyan firms face growing threats such as phishing, ransomware, and data breaches. Companies are now investing in firewalls, two-factor authentication, encryption, and regular audits.ðŸ“Š Stat: Kenya recorded over 700 million cyber threat events in the first half of 2024 (CAK Report).\r\n\r\n4. Digital Marketing & SEOSearch engine optimization, Google Ads, social media marketing, and email automation are helping businesses reach local and global audiences. Content-rich strategies are especially effective in Kenyaâ€™s service-based economy.\r\n\r\nðŸ“Š Stat: 90% of purchases start with an online search (Think with Google, 2024).\r\n\r\n5. IT Consulting & Digital StrategyFrom setting up digital infrastructure to advising on compliance and automation, IT consulting helps businesses scale efficiently. Consultants also assist in vendor selection and software procurement.\r\n\r\n6. Cloud Migration & Hosting SolutionsMore Kenyan companies are moving to cloud platforms like AWS, Microsoft Azure, and Google Cloud. Cloud services enable scalability, security, and cost savings.ðŸ“Š Stat: 54% of medium-to-large Kenyan businesses adopted cloud in some form by 2024.\r\n\r\n7. E-commerce Store DevelopmentRetailers, wholesalers, and service providers are launching online stores with secure checkout, M-Pesa integration, inventory sync, and delivery APIs. Shopify, WooCommerce, and custom platforms are leading tools.\r\n\r\nðŸ“Š Stat: Kenyaâ€™s e-commerce market is projected to grow to KES 500 billion by 2027.\r\n\r\n8. Software Integration (ERP, CRM, APIs)Disparate systems are being replaced with integrated solutions. TimesTen helps businesses connect accounting, HR, CRM, POS, and inventory using ERP systems like Odoo or SAP.\r\n\r\n9. Managed IT Services & Remote SupportInstead of hiring full-time tech teams, many Kenyan companies outsource IT support. Services include system updates, network monitoring, data backups, and endpoint management.\r\n\r\n10. Tech Training & Employee OnboardingDigital literacy among staff is critical. TimesTen offers customized staff training on tools like Microsoft 365, Google Workspace, cybersecurity hygiene, and CRM platforms.\r\n\r\nKenyan businesses are entering a golden age of digital transformation. From mobile-first platforms to secure cloud environments, adopting these technologies is no longer optionalâ€”itâ€™s a business imperative. By working with a tech-forward partner like TimesTen Technologies, your company is positioned to thrive in a competitive landscape.\r\n\r\nReady to future-proof your operations? Explore our full suite of services or book a free consultation today.', '2025-06-08 09:23:29', '1058WhatsApp Image 2025-06-08 at 12.12.28 PM.jpeg'),
(8, 'IT Consulting in Kenya â€“ Why Strategic Tech Advice Matters in 2025', 'Learn how IT consulting can help Kenyan businesses scale, reduce costs, automate operations, and plan tech strategies for long-term growth.', 'In Kenyaâ€™s fast-paced tech environment, many businesses struggle to keep up with rapid advancements, cybersecurity risks, and digital compliance. IT consulting bridges this gap by offering expert insights, tailored technology strategies, and seamless implementations. Hereâ€™s why IT consulting is critical for businesses in 2025 and how TimesTen Technologies is leading the way.\r\n\r\n1. Customized Digital Transformation PlansA good IT consultant doesnâ€™t just recommend softwareâ€”they understand your business model. TimesTen begins by assessing your operations, then tailors a digital transformation roadmap that addresses inefficiencies, improves processes, and integrates the right technologies.\r\n\r\n2. Vendor and Infrastructure SelectionWith so many tech vendors and platforms available, it\'s easy to make costly mistakes. Our consultants guide you in choosing scalable hosting, ERPs, CRMs, and payment solutions suited for your goals and budget.\r\n\r\n3. Cloud, Networking, and Security ArchitectureWe help you transition from outdated servers to secure, cloud-based systems. Whether AWS, Azure, or Google Cloud, our team ensures robust architecture and failover mechanisms.\r\n\r\n4. Risk and Compliance AuditsAvoid legal penalties and downtime by ensuring your systems meet GDPR, Data Protection Act (Kenya), and cybersecurity compliance standards. We conduct IT audits, policy reviews, and data handling workshops.\r\n\r\n5. Automation and Cost ReductionAutomate repetitive processes like payroll, HR approvals, invoicing, and reporting. Our tech stack helps reduce operational costs while increasing output and reliability.\r\n\r\n6. Project Oversight and Change ManagementFrom software rollout to company-wide digital adoption, we offer project management tools, onboarding sessions, and support frameworks for change resistance.\r\n\r\nIn 2025, technology is no longer optionalâ€”itâ€™s foundational. IT consulting helps Kenyan businesses stay agile, avoid pitfalls, and invest wisely. Partner with TimesTen Technologies to receive strategic, actionable advice that drives success.\r\n\r\nLet our experts audit your digital systems. Book a free consultation today.', '2025-06-08 09:25:40', '5722WhatsApp Image 2025-06-08 at 12.12.29 PM.jpeg'),
(9, 'Cybersecurity in Kenya â€“ Staying Ahead of Threats in 2025', 'Discover how Kenyan businesses can protect data, avoid breaches, and meet compliance using TimesTenâ€™s tailored cybersecurity solutions.', 'Kenya recorded over 700 million cyber threat incidents in just six months of 2024 (CAK Report). As the countryâ€™s digital economy grows, so does its vulnerability. Whether you\'re a financial institution, retail chain, healthcare provider, or startupâ€”cybersecurity is no longer negotiable. Hereâ€™s how to prepare for 2025.\r\n\r\n1. Identify & Mitigate Risks EarlyOur cybersecurity team runs vulnerability scans, penetration testing, and asset discovery to find your weak points before attackers do.\r\n\r\n2. Install Multi-Layered ProtectionFrom firewalls and endpoint security to anti-malware, email filtering, and DNS protectionâ€”TimesTen provides enterprise-grade layers of defense.\r\n\r\n3. Empower Staff with Security TrainingA major entry point for attackers is human error. We offer awareness programs covering phishing, social engineering, password hygiene, and secure file sharing.\r\n\r\n4. Enforce Backup & Disaster RecoveryRansomware can paralyze a business overnight. Our backup and recovery solutions help you restore critical systems within hours, not days.\r\n\r\n5. Stay Compliant with Data LawsWhether youâ€™re handling personal medical data, financial transactions, or customer records, we ensure your company is compliant with the Kenyan Data Protection Act and international standards.\r\n\r\n6. Monitor & Respond in Real-TimeWe set up SOC dashboards, alerts, and response protocols that detect and stop threats as they emerge.\r\n\r\nConclusionCybersecurity in Kenya is now a boardroom issue. Donâ€™t wait until an incident forces change. Work with TimesTen Technologies to create a security-first culture and safeguard your future.\r\n\r\nGet a free security assessment. Contact us today.', '2025-06-08 09:31:52', '1324WhatsApp Image 2025-06-08 at 12.12.43 PM.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `chat_responses`
--

CREATE TABLE `chat_responses` (
  `id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `keywords` text NOT NULL,
  `response_text` text NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_responses`
--

INSERT INTO `chat_responses` (`id`, `category`, `keywords`, `response_text`, `active`, `created_at`, `updated_at`) VALUES
(1, 'general', 'help,support,assist,question', 'How can I assist you today?', 1, '2025-05-19 17:33:56', '2025-05-19 17:33:56'),
(2, 'pricing', 'cost,price,package,quote', 'Our pricing varies based on your needs. Would you like to see our packages?', 1, '2025-05-19 17:33:56', '2025-05-19 17:33:56');

-- --------------------------------------------------------

--
-- Table structure for table `contact_info`
--

CREATE TABLE `contact_info` (
  `id` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_info`
--

INSERT INTO `contact_info` (`id`, `phone`, `email`) VALUES
(1, '123-456-7890', 'contact@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `ref_code` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `phone`, `message`, `ref_code`, `created_at`) VALUES
(5, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'chombaalex2019@gmail.com', 'ALEX3D0D', '2026-04-11 17:37:07'),
(6, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'chombaalex2019@gmail.com 50K', '', '2026-04-11 18:01:52'),
(7, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'chombaalex2019@gmail.com', '', '2026-04-11 18:07:49'),
(8, 'Mogire John Anunda', 'Mogirejohn2006@gmail.com', '0114885488', 'I would like to apply for an online marketing job.', '', '2026-04-23 06:15:22');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `doc_type` varchar(20) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `link_url` text DEFAULT NULL,
  `uploaded_by` varchar(120) DEFAULT NULL,
  `related_employee_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `category_id`, `title`, `doc_type`, `file_name`, `original_name`, `link_url`, `uploaded_by`, `related_employee_id`, `created_at`) VALUES
(5, 1, 'Rentsmart Document', 'file', '2273_RentSmartCompletePlatformGuide.docx.pdf', 'RentSmart Complete Platform Guide.docx.pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-04 11:38:21'),
(6, 4, 'Rentsmart link landlords demo', 'link', NULL, NULL, 'https://rentsmart.timestentechnologies.co.ke/demo/start?role=landlord', 'timestentechnologies@gmail.com', NULL, '2026-03-04 11:42:00'),
(7, 4, 'manager link', 'link', NULL, NULL, 'https://rentsmart.timestentechnologies.co.ke/demo/start?role=manager', 'timestentechnologies@gmail.com', NULL, '2026-03-04 11:42:47'),
(8, 4, 'realtors link', 'link', NULL, NULL, 'https://rentsmart.timestentechnologies.co.ke/demo/start?role=realtor', 'timestentechnologies@gmail.com', NULL, '2026-03-04 11:43:21'),
(9, 4, 'Agent link', 'link', NULL, NULL, 'https://rentsmart.timestentechnologies.co.ke/demo/start?role=agent', 'timestentechnologies@gmail.com', NULL, '2026-03-04 11:43:56'),
(10, 1, 'Strategy document', 'file', '5245_TimestenTechnologiesStrategicGrowthPlan202620291.pdf', 'Timesten Technologies â€“ Strategic Growth Plan (2026â€“2029) (1).pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-10 16:04:45'),
(32, 5, '1', 'file', 'Company_Assets/Logos/8986_1.png', '1.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(33, 5, '2', 'file', 'Company_Assets/Logos/7376_2.png', '2.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(34, 5, '3', 'file', 'Company_Assets/Logos/7223_3.png', '3.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(35, 5, 'Dark Blue And White Modern We Are Hiring Instagram Post', 'file', 'Company_Assets/Logos/7364_DarkBlueAndWhiteModernWeAreHiringInstagramPost.png', 'Dark Blue And White Modern We Are Hiring Instagram Post.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(36, 5, 'favidarknobg', 'file', 'Company_Assets/Logos/7339_favidarknobg.png', 'favidarknobg.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(37, 5, 'faviwhitenobg', 'file', 'Company_Assets/Logos/8966_faviwhitenobg.png', 'faviwhitenobg.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(38, 5, 'LaundryLogo', 'file', 'Company_Assets/Logos/3353_LaundryLogo.png', 'LaundryLogo.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(39, 5, 'logo (1)', 'file', 'Company_Assets/Logos/9523_logo1.png', 'logo (1).png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(40, 5, 'logo', 'file', 'Company_Assets/Logos/5952_logo.png', 'logo.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(41, 5, 'logodarknobg', 'file', 'Company_Assets/Logos/1158_logodarknobg.png', 'logodarknobg.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(42, 5, 'logowhitenobg - Copy', 'file', 'Company_Assets/Logos/5245_logowhitenobg-Copy.png', 'logowhitenobg - Copy.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(43, 5, 'logowhitenobg', 'file', 'Company_Assets/Logos/6057_logowhitenobg.png', 'logowhitenobg.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(44, 5, 'Navy Gradient Modern Creative Service Price List Instagram Post', 'file', 'Company_Assets/Logos/9619_NavyGradientModernCreativeServicePriceListInstagramPost.png', 'Navy Gradient Modern Creative Service Price List Instagram Post.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(45, 5, 'Timesten Technology Logo  (1)', 'file', 'Company_Assets/Logos/1168_TimestenTechnologyLogo1.png', 'Timesten Technology Logo  (1).png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(46, 5, 'Timesten Technology Logo  (2)', 'file', 'Company_Assets/Logos/7843_TimestenTechnologyLogo2.png', 'Timesten Technology Logo  (2).png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(47, 5, 'Timesten Technology Logo  (3)', 'file', 'Company_Assets/Logos/7953_TimestenTechnologyLogo3.png', 'Timesten Technology Logo  (3).png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(48, 5, 'Timesten Technology Logo  (4)', 'file', 'Company_Assets/Logos/9491_TimestenTechnologyLogo4.png', 'Timesten Technology Logo  (4).png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(49, 5, 'Timesten Technology Logo ', 'file', 'Company_Assets/Logos/7661_TimestenTechnologyLogo.pdf', 'Timesten Technology Logo .pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(50, 5, 'Timesten Technology Logo ', 'file', 'Company_Assets/Logos/4444_TimestenTechnologyLogo.png', 'Timesten Technology Logo .png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(51, 5, 'Timesten_Technology_Logo___1_-removebg-preview', 'file', 'Company_Assets/Logos/6972_Timesten_Technology_Logo___1_-removebg-preview.png', 'Timesten_Technology_Logo___1_-removebg-preview.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 12:37:23'),
(52, 1, 'BN-RRSK56Y3-Name Reservation Certificate', 'file', 'Company_Documents/Company Files/4923_BN-RRSK56Y3-NameReservationCertificate.pdf', 'BN-RRSK56Y3-Name Reservation Certificate.pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:48:41'),
(53, 1, 'BN-RRSK56Y3-Business Name Registration Certificate', 'file', 'Company_Documents/Company Files/9638_BN-RRSK56Y3-BusinessNameRegistrationCertificate.pdf', 'BN-RRSK56Y3-Business Name Registration Certificate.pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:48:41'),
(54, 1, 'BN-RRSK56Y3-RECEIPT', 'file', 'Company_Documents/Company Files/4181_BN-RRSK56Y3-RECEIPT.pdf', 'BN-RRSK56Y3-RECEIPT.pdf', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:48:41'),
(55, 5, '1', 'file', '1902_1.png', '1.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(56, 5, '2', 'file', '8429_2.png', '2.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(57, 5, '3', 'file', '1909_3.png', '3.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(58, 5, '4', 'file', '9469_4.png', '4.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(59, 5, '5', 'file', '5092_5.png', '5.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(60, 5, '6', 'file', '6360_6.png', '6.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(61, 5, '7', 'file', '6471_7.png', '7.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(62, 5, '8', 'file', '2452_8.png', '8.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(63, 5, '9', 'file', '4527_9.png', '9.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(64, 5, '10', 'file', '1488_10.png', '10.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(65, 5, '11', 'file', '2347_11.png', '11.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38'),
(66, 5, '12', 'file', '3951_12.png', '12.png', NULL, 'timestentechnologies@gmail.com', NULL, '2026-03-23 16:49:38');

-- --------------------------------------------------------

--
-- Table structure for table `document_categories`
--

CREATE TABLE `document_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `document_categories`
--

INSERT INTO `document_categories` (`id`, `name`, `created_at`) VALUES
(1, 'Company Documents', '2026-02-23 16:12:57'),
(2, 'Employee', '2026-02-23 20:02:58'),
(3, 'Legal', '2026-02-23 20:03:11'),
(4, 'Links', '2026-03-04 11:40:53'),
(5, 'Company Assets', '2026-03-20 23:26:09');

-- --------------------------------------------------------

--
-- Table structure for table `doc_access_tokens`
--

CREATE TABLE `doc_access_tokens` (
  `id` int(11) NOT NULL,
  `doc_kind` varchar(30) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doc_access_tokens`
--

INSERT INTO `doc_access_tokens` (`id`, `doc_kind`, `doc_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 'payslip', 2, '94d7be054a9a4d8fdea31f4aa5eb86c98c081163a4112f78', '2026-03-04 08:35:21', '2026-02-25 08:35:21'),
(2, 'payslip', 2, '0285ac25c56290753347d172b97ec479cf25b894c98f5e16', '2026-03-04 08:46:21', '2026-02-25 08:46:21'),
(3, 'payslip', 2, '543d30af5a4e45fa1f7a31e458acab4ead4907381a960ac7', '2026-03-04 09:02:28', '2026-02-25 09:02:28'),
(4, 'payslip', 2, '75eeda7cdd3b808456c48d7a7fa0c6b4b69aa71df6896107', '2026-03-04 09:02:33', '2026-02-25 09:02:33'),
(5, 'payslip', 2, '019ee8f4646fc3001ae5c7db15029d5b1765523b3bb161fb', '2026-03-04 09:02:58', '2026-02-25 09:02:58'),
(6, 'invoice', 2, '252357922bb55f3079f73545d6718b57a10248b518435c87', '2026-03-04 09:15:12', '2026-02-25 09:15:12'),
(7, 'invoice', 3, 'b3b1703d584d0f6156f0bc1311275dc269986d4e1acaea84', '2026-04-18 11:10:05', '2026-04-11 11:10:05');

-- --------------------------------------------------------

--
-- Table structure for table `email_settings`
--

CREATE TABLE `email_settings` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(255) DEFAULT NULL,
  `smtp_port` int(11) DEFAULT NULL,
  `smtp_user` varchar(255) DEFAULT NULL,
  `smtp_pass` varchar(255) DEFAULT NULL,
  `smtp_secure` varchar(20) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `logo_url` text DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `email_settings`
--

INSERT INTO `email_settings` (`id`, `smtp_host`, `smtp_port`, `smtp_user`, `smtp_pass`, `smtp_secure`, `from_email`, `from_name`, `logo_url`, `updated_at`) VALUES
(1, 'smtp.gmail.com', 587, 'timestentechnologies@gmail.com', 'agwc ifvm nbhs mffs', 'tls', 'info@timestentechnologies.co.ke', 'TimesTen Technologies', '', '2026-02-24 08:42:00');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `full_name` varchar(160) NOT NULL,
  `email` varchar(160) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `comp_type` varchar(30) DEFAULT NULL,
  `comp_amount` decimal(12,2) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `hired_from_application_id` int(11) DEFAULT NULL,
  `cv_document_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `full_name`, `email`, `phone`, `job_title`, `comp_type`, `comp_amount`, `photo`, `hired_from_application_id`, `cv_document_id`, `created_at`) VALUES
(2, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'Business Development Lead', 'salary', 100000.00, NULL, NULL, NULL, '2026-04-25 10:36:22'),
(3, 'Mercy Wanjiru', 'mercyshii002@gmail.com', '0110089303', 'System Admin Lead', 'salary', 100000.00, NULL, NULL, NULL, '2026-04-25 10:37:19');

-- --------------------------------------------------------

--
-- Table structure for table `employee_payments`
--

CREATE TABLE `employee_payments` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `deductions` decimal(12,2) DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` varchar(120) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `employee_payments`
--

INSERT INTO `employee_payments` (`id`, `employee_id`, `amount`, `deductions`, `pay_date`, `payment_method`, `reference`, `notes`, `created_by`, `created_at`) VALUES
(1, 1, 20000.00, NULL, '2026-02-24', 'Cash', 'Test payment', '', 'timestentechnologies@gmail.com', '2026-02-24 16:00:18'),
(2, 1, 20000.00, 0.00, '2026-02-24', 'cash', 'test2', '', 'timestentechnologies@gmail.com', '2026-02-24 20:04:22');

-- --------------------------------------------------------

--
-- Table structure for table `employee_payment_deductions`
--

CREATE TABLE `employee_payment_deductions` (
  `id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `title` varchar(120) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enquiry_text`
--

CREATE TABLE `enquiry_text` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enquiry_text`
--

INSERT INTO `enquiry_text` (`id`, `title`, `text`) VALUES
(1, 'Enquiry Text Title', 'Enquiry text content here...');

-- --------------------------------------------------------

--
-- Table structure for table `finance_customers`
--

CREATE TABLE `finance_customers` (
  `id` int(11) NOT NULL,
  `name` varchar(160) NOT NULL,
  `email` varchar(160) DEFAULT NULL,
  `phone` varchar(80) DEFAULT NULL,
  `service` varchar(160) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_customers`
--

INSERT INTO `finance_customers` (`id`, `name`, `email`, `phone`, `service`, `address`, `created_at`) VALUES
(3, 'SwimG\'s Academy', '', '0791539635', 'Web Development', 'Nairobi, Kenya', '2026-03-26 11:57:43'),
(4, 'Domia Ventures Limited', 'homeview.rem@gmail.com', '0717911589', 'RentSmart Software', 'Nairobi, Kenya', '2026-04-14 15:36:53');

-- --------------------------------------------------------

--
-- Table structure for table `finance_expenses`
--

CREATE TABLE `finance_expenses` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `vendor` varchar(160) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `expense_date` date DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `receipt_file` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_expenses`
--

INSERT INTO `finance_expenses` (`id`, `category_id`, `vendor`, `description`, `amount`, `expense_date`, `employee_id`, `payment_id`, `payment_method`, `reference`, `receipt_file`, `created_at`) VALUES
(4, 6, 'Sam', 'Paid to Sam for the connection', 500.00, '2026-03-26', NULL, NULL, 'Mpesa', '', NULL, '2026-03-26 12:10:05'),
(5, 5, '', 'Charges on till', 62.00, '2026-03-26', NULL, NULL, 'Mpesa', '', NULL, '2026-03-26 12:11:38');

-- --------------------------------------------------------

--
-- Table structure for table `finance_expense_categories`
--

CREATE TABLE `finance_expense_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_expense_categories`
--

INSERT INTO `finance_expense_categories` (`id`, `name`, `created_at`) VALUES
(1, 'General', '2026-02-24 12:51:16'),
(2, 'Office', '2026-02-24 12:51:16'),
(3, 'Transport', '2026-02-24 12:51:16'),
(4, 'Salary', '2026-02-24 12:51:16'),
(5, 'Transaction Charges', '2026-03-26 12:08:54'),
(6, 'Taxes', '2026-03-26 12:09:03');

-- --------------------------------------------------------

--
-- Table structure for table `finance_invoices`
--

CREATE TABLE `finance_invoices` (
  `id` int(11) NOT NULL,
  `invoice_no` varchar(50) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `issue_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL,
  `tax_rate` decimal(6,2) DEFAULT NULL,
  `tax_exempt` tinyint(1) DEFAULT NULL,
  `discount_type` varchar(10) DEFAULT NULL,
  `discount_value` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `amount_paid` decimal(12,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_invoices`
--

INSERT INTO `finance_invoices` (`id`, `invoice_no`, `customer_id`, `issue_date`, `due_date`, `status`, `notes`, `subtotal`, `tax_rate`, `tax_exempt`, `discount_type`, `discount_value`, `total`, `amount_paid`, `created_at`) VALUES
(3, 'INV-20260326-9635', 3, '2026-03-26', '2026-03-26', 'partial', 'Web Development \r\nDeployment and Hosting', 30700.00, NULL, NULL, NULL, NULL, 30700.00, 27200.00, '2026-03-26 12:03:24'),
(4, 'INV-20260414-6667', 4, '2026-04-14', '2026-05-01', 'draft', '', 5000.00, NULL, NULL, NULL, NULL, 5000.00, 0.00, '2026-04-14 15:37:20'),
(5, 'INV-20260421-8337', 4, '2026-04-21', '2026-04-30', 'draft', '', 192200.00, NULL, NULL, 'fixed', 0.00, 192200.00, 0.00, '2026-04-21 11:03:30');

-- --------------------------------------------------------

--
-- Table structure for table `finance_invoice_items`
--

CREATE TABLE `finance_invoice_items` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `qty` decimal(12,2) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `line_total` decimal(12,2) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_invoice_items`
--

INSERT INTO `finance_invoice_items` (`id`, `invoice_id`, `product_id`, `description`, `qty`, `unit_price`, `line_total`, `created_at`) VALUES
(4, 3, 1, 'Website development', 1.00, 22000.00, 22000.00, '2026-03-26 12:04:02'),
(5, 3, 3, 'Hostpinnacle Hosting Space', 1.00, 4200.00, 4200.00, '2026-03-26 12:05:04'),
(8, 3, 6, 'Additional features on expenses and dashboard', 1.00, 3500.00, 3500.00, '2026-04-11 11:08:24'),
(11, 4, 8, 'RentSmart Software (Property Management System)', 1.00, 5000.00, 5000.00, '2026-04-14 15:50:20'),
(12, 5, 9, '.co.ke or .com domain registration annually renewed', 1.00, 2000.00, 2000.00, '2026-04-21 11:04:09'),
(13, 5, 10, 'Hostpinnacle Shared Hosting Infrastructure Renewed Year', 1.00, 5200.00, 5200.00, '2026-04-21 11:07:44'),
(14, 5, 11, 'Software Development and deployment onetime fee', 1.00, 180000.00, 180000.00, '2026-04-21 11:09:20'),
(15, 5, 12, 'Retainer and Maintainace fee Paid yearly', 1.00, 5000.00, 5000.00, '2026-04-21 11:11:08'),
(16, 3, 5, 'Design Work Poster Design', 1.00, 1000.00, 1000.00, '2026-04-24 16:15:42');

-- --------------------------------------------------------

--
-- Table structure for table `finance_payments`
--

CREATE TABLE `finance_payments` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `paid_at` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_payments`
--

INSERT INTO `finance_payments` (`id`, `invoice_id`, `customer_id`, `amount`, `method`, `reference`, `paid_at`, `notes`, `created_at`) VALUES
(3, 3, 3, 10000.00, 'Mpesa Till', 'UCQCTAO0TU', '2026-03-26', 'First Installment Payments', '2026-03-26 12:08:12'),
(4, 3, 3, 13000.00, 'Mpesa', 'UD7CT069XX', '2026-04-07', 'Payment Made for the balance coding and video generation', '2026-04-09 12:20:34'),
(5, 3, 3, 4200.00, 'Mpesa', 'UCUCTB5984', '2026-04-09', 'Hosting payment', '2026-04-09 12:21:44');

-- --------------------------------------------------------

--
-- Table structure for table `finance_products`
--

CREATE TABLE `finance_products` (
  `id` int(11) NOT NULL,
  `name` varchar(160) NOT NULL,
  `description` text DEFAULT NULL,
  `qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit_price` decimal(12,2) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `finance_products`
--

INSERT INTO `finance_products` (`id`, `name`, `description`, `qty`, `unit_price`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Website Development', 'Professional website design and development services.', 0.00, 20000.00, 1, '2026-02-24 12:28:24', NULL),
(2, 'Software Installation & Setup', 'Installation, configuration, and initial setup of software solutions.', 0.00, 20000.00, 1, '2026-02-24 20:06:28', NULL),
(3, 'Hosting & Deployment', 'Web hosting provision and application deployment (HostPinnacle hosting space).', 0.00, 4200.00, 1, '2026-03-26 12:05:04', NULL),
(4, 'Domain Registration', 'Domain name registration and DNS configuration.', 0.00, 1500.00, 1, '2026-03-26 12:06:17', NULL),
(5, 'Graphic Design Services', 'Design services including poster and marketing artwork.', 0.00, 1000.00, 1, '2026-04-09 12:18:11', NULL),
(6, 'Additional Features (Enhancements)', 'Implementation of additional features and enhancements (expenses module and dashboard).', 0.00, 3500.00, 1, '2026-04-11 11:08:24', NULL),
(7, 'RentSmart Software', 'RentSmart software licence and setup.', 0.00, 5000.00, 1, '2026-04-14 15:38:32', NULL),
(8, 'RentSmart (Property Management System)', 'Property management system (RentSmart) licence and setup.', 0.00, 5000.00, 1, '2026-04-14 15:50:20', NULL),
(9, 'Domain Registration (.co.ke / .com)', 'Domain registration with annual renewal for .co.ke or .com domains.', 0.00, 2000.00, 1, '2026-04-21 11:04:09', NULL),
(10, 'Shared Hosting (Annual Renewal)', 'HostPinnacle shared hosting subscription renewal (annual).', 0.00, 5200.00, 1, '2026-04-21 11:07:44', NULL),
(11, 'Software Development & Deployment', 'One-time fee for software development and production deployment.', 0.00, 180000.00, 1, '2026-04-21 11:09:20', NULL),
(12, 'Retainer & Maintenance (Annual)', 'Annual retainer and maintenance support fee.', 0.00, 5000.00, 1, '2026-04-21 11:11:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_settings`
--

CREATE TABLE `invoice_settings` (
  `id` int(11) NOT NULL,
  `invoice_logo` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `invoice_settings`
--

INSERT INTO `invoice_settings` (`id`, `invoice_logo`, `updated_at`) VALUES
(1, '1013logodarknobg.png', '2026-02-24 13:11:44');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `job_title` varchar(255) NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `job_desc` text NOT NULL,
  `requirements` text NOT NULL,
  `location` varchar(150) NOT NULL,
  `job_type` varchar(50) NOT NULL,
  `deadline` date DEFAULT NULL,
  `status` enum('open','closed') NOT NULL DEFAULT 'open',
  `cover_image` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `salary` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `job_title`, `short_desc`, `job_desc`, `requirements`, `location`, `job_type`, `deadline`, `status`, `cover_image`, `created_at`, `salary`, `views`) VALUES
(1, 'Commision Based Sales executive', 'We are looking for a motivated and results-driven Commission-Based Sales Executive to join our growing team. The ideal candidate will be responsible for generating leads, closing sales, and promoting our products and services through online channels and d', 'We are looking for a motivated and results-driven Commission-Based Sales Executive to join our growing team. The ideal candidate will be responsible for generating leads, closing sales, and promoting our products and services through online channels and direct client engagement.\r\n\r\nYou will play a key role in driving revenue growth by identifying potential clients, presenting product solutions, and maintaining strong customer relationships.\r\n\r\nðŸŽ¯ Key Responsibilities\r\n\r\nGenerate and qualify sales leads through online platforms and networking\r\n\r\nPromote company products and services to potential clients\r\n\r\nClose sales and achieve agreed sales targets\r\n\r\nMaintain communication with prospects and customers\r\n\r\nProvide feedback on market trends and customer needs\r\n\r\nSupport marketing campaigns to drive conversions', 'Strong communication and negotiation skills\r\n\r\nSelf-motivated and target-driven personality\r\n\r\nExperience in sales or customer engagement is an added advantage\r\n\r\nAbility to work independently in a remote environment\r\n\r\nBasic knowledge of digital marketing or online sales is a plus', 'Online / Remote', 'Commission-Based Contract', '2026-04-30', 'open', '8865_content_thumb.png', '2026-02-22 09:47:20', 'Commission', 48);

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `cover_letter` text DEFAULT NULL,
  `cv_file` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_applications`
--

INSERT INTO `job_applications` (`id`, `job_id`, `full_name`, `email`, `phone`, `cover_letter`, `cv_file`, `created_at`) VALUES
(1, 1, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', '', '6025_Invoice-INV-20260326-9635.pdf', '2026-04-25 09:06:24');

-- --------------------------------------------------------

--
-- Table structure for table `job_application_answers`
--

CREATE TABLE `job_application_answers` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_application_answers`
--

INSERT INTO `job_application_answers` (`id`, `application_id`, `question_id`, `answer_text`) VALUES
(1, 1, 1, 'I am who I am'),
(2, 1, 2, 'Intereste'),
(3, 1, 3, 'yes'),
(4, 1, 4, 'Focused'),
(5, 1, 5, 'Good Strategy'),
(6, 1, 6, 'Carefully'),
(7, 1, 7, 'Crm'),
(8, 1, 8, 'Money'),
(9, 1, 9, '38'),
(10, 1, 10, 'yes i do'),
(11, 1, 11, 'Convincing'),
(12, 1, 12, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `job_questions`
--

CREATE TABLE `job_questions` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_questions`
--

INSERT INTO `job_questions` (`id`, `job_id`, `question_text`, `is_required`) VALUES
(1, 1, 'Tell us about yourself and your experience in sales.', 1),
(2, 1, 'Why are you interested in a commission-based sales role?', 1),
(3, 1, 'Have you worked in sales before? If yes, what products or services have you sold?', 1),
(4, 1, 'How do you usually find and approach potential customers?', 1),
(5, 1, 'Describe a time when you successfully closed a sale. What was your strategy?', 1),
(6, 1, 'How do you handle customer rejection or objections during sales conversations?', 1),
(7, 1, 'What online platforms or tools do you use to generate leads?', 0),
(8, 1, 'What motivates you to achieve your sales targets?', 0),
(9, 1, 'How many hours per day/week are you able to dedicate to this role?', 0),
(10, 1, 'What do you understand about commission-based work?', 0),
(11, 1, 'How would you convince a customer to choose our product/service over competitors?', 0),
(12, 1, 'Do you have any experience with digital marketing, social media selling, or CRM tools?', 0);

-- --------------------------------------------------------

--
-- Table structure for table `logo`
--

CREATE TABLE `logo` (
  `id` int(11) NOT NULL,
  `xfile` varchar(255) DEFAULT NULL,
  `ufile` varchar(255) DEFAULT NULL,
  `sticky_ufile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logo`
--

INSERT INTO `logo` (`id`, `xfile`, `ufile`, `sticky_ufile`) VALUES
(1, '699c07607ef9b-favidarknobg.png', '699c095714edd-logowhitenobg - Copy.png', '699c0935cdbe0-logodarknobg.png');

-- --------------------------------------------------------

--
-- Table structure for table `page_visits`
--

CREATE TABLE `page_visits` (
  `id` int(11) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `device_type` varchar(20) DEFAULT NULL,
  `location` varchar(120) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `page_visits`
--

INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(34, '/dashboard/index.php?jv_page=1&rv_page=1&rv_limit=5', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 15:52:22'),
(35, '/portfolio', '111.119.255.47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-23 16:01:03'),
(36, '/dashboard/index.php?jv_page=1&rv_page=1&rv_limit=5', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:10:21'),
(37, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:10:24'),
(38, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:12:40'),
(39, '/dashboard/document-categories.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:12:44'),
(40, '/dashboard/document-categories.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:12:57'),
(41, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:13:06'),
(42, '/dashboard/documents.php?cat=1&view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:13:09'),
(43, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:13:32'),
(44, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:15:07'),
(45, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:27:45'),
(46, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:27:58'),
(47, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:34:05'),
(48, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:34:12'),
(49, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:34:14'),
(50, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:34:36'),
(51, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:22'),
(52, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:22'),
(53, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:24'),
(54, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:25'),
(55, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:26'),
(56, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:29'),
(57, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:29'),
(58, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:34'),
(59, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:34'),
(60, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:36'),
(61, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:36:49'),
(62, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:37:37'),
(63, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:23'),
(64, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:25'),
(65, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:27'),
(66, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:28'),
(67, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:29'),
(68, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:30'),
(69, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:31'),
(70, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:32'),
(71, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:33'),
(72, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:34'),
(73, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:47'),
(74, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:38:55'),
(75, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:05'),
(76, '/dashboard/document-categories.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:13'),
(77, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:16'),
(78, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:19'),
(79, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:21'),
(80, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:22'),
(81, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:27'),
(82, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:57'),
(83, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:41:59'),
(84, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:42:01'),
(85, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:42:42'),
(86, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:44:30'),
(87, '/', '34.121.66.25', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-02-23 16:47:59'),
(88, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:48:24'),
(89, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:48:27'),
(90, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:48:33'),
(91, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:48:37'),
(92, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 16:55:19'),
(93, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:00:38'),
(94, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:00:52'),
(95, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:01:29'),
(96, '/dashboard/documents.php?view=list', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:01:31'),
(97, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:01:32'),
(98, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:02:20'),
(99, '/', '5.133.192.140', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-02-23 17:02:24'),
(100, '/dashboard/documents.php?view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 17:05:00'),
(101, '/', '185.247.137.12', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Manchester, England, United Kingdom', '2026-02-23 17:25:23'),
(102, '/', '3.151.194.164', 'visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'Desktop', 'Hilliard, Ohio, United States', '2026-02-23 17:47:47'),
(103, '/', '139.59.191.181', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-02-23 17:48:14'),
(104, '/blogdetail.php?id=4', '94.74.91.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-23 19:04:05'),
(105, '/', '34.172.100.190', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-02-23 19:13:03'),
(106, '/', '34.172.100.190', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-02-23 19:13:03'),
(107, '/contact', '116.204.72.2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-23 19:41:22'),
(108, '/portdetail.php?id=8', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:50:32'),
(109, '/portdetail.php?id=8', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:51:29'),
(110, '/portdetail.php?id=9', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:54:00'),
(111, '/dashboard/editport.php?id=9', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:54:26'),
(112, '/careers', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:54:44'),
(113, '/jobdetail.php?id=1', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:55:23'),
(114, '/jobdetail.php?id=1', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:55:42'),
(115, '/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:55:59'),
(116, '/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:58:33'),
(117, '/dashboard/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:58:45'),
(118, '/dashboard/index.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 19:58:50'),
(119, '/dashboard/portfolio.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:00:10'),
(120, '/dashboard/editport.php?id=9', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:00:26'),
(121, '/blog', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:00:49'),
(122, '/dashboard/jobs', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:01:08'),
(123, '/dashboard/jobapplications/1', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:01:20'),
(124, '/dashboard/documents.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:01:47'),
(125, '/', '192.71.12.156', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-02-23 20:01:55'),
(126, '/dashboard/documents.php?view=list', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:02:04'),
(127, '/dashboard/documents.php?view=grid', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:02:07'),
(128, '/dashboard/document-categories.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:02:43'),
(129, '/dashboard/document-categories.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:02:58'),
(130, '/dashboard/document-categories.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:03:11'),
(131, '/dashboard/documents.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:03:18'),
(132, '/dashboard/employees.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:03:27'),
(133, '/dashboard/employees.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:03:50'),
(134, '/dashboard/employees.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:03:51'),
(135, '/dashboard/employees.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:04:19'),
(136, '/dashboard/slider', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:04:28'),
(137, '/dashboard/edit-slider.php?id=5', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:04:35'),
(138, '/dashboard/edit-slider.php?id=5', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:04:41'),
(139, '/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:04:46'),
(140, '/dashboard/edit-slider.php?id=5', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:05:07'),
(141, '/dashboard/static', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:05:36'),
(142, '/dashboard/static', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:05:43'),
(143, '/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:05:47'),
(144, '/dashboard/static', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:06:11'),
(145, '/', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:06:15'),
(146, '/dashboard/slider', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:06:46'),
(147, '/dashboard/social', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:07:03'),
(148, '/dashboard/testimony', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:07:11'),
(149, '/dashboard/social', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:07:26'),
(150, '/dashboard/why', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:07:40'),
(151, '/dashboard/settings', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:08:21'),
(152, '/dashboard/sections', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:08:54'),
(153, '/dashboard/logo', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:09:05'),
(154, '/dashboard/contact', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:09:10'),
(155, '/about', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:09:19'),
(156, '/careers', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:12:09'),
(157, '/jobdetail.php?id=1', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:12:20'),
(158, '/dashboard/documents.php', '102.209.18.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-23 20:15:15'),
(159, '/servicedetail.php?id=10', '121.37.110.82', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-23 20:22:32'),
(160, '/services', '111.119.245.184', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-23 21:03:43'),
(161, '/', '52.30.28.69', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-23 21:16:45'),
(162, '/servicedetail.php?id=9', '192.144.171.111', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-23 21:44:53'),
(163, '/', '106.8.138.156', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-02-23 21:46:06'),
(164, '/servicedetail.php?id=8', '120.53.16.204', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-23 23:07:12'),
(165, '/portdetail.php?id=3', '62.234.192.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-23 23:49:04'),
(166, '/portdetail.php?id=6', '82.156.176.252', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 00:29:23'),
(167, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-24 01:16:45'),
(168, '/servicedetail.php?id=4', '49.233.43.214', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 01:51:54'),
(169, '/blogdetail.php?id=7', '111.119.217.127', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 02:32:54'),
(170, '/servicedetail.php?id=4', '17.246.23.192', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-02-24 03:38:38'),
(171, '/', '35.204.44.196', 'Scrapy/2.13.4 (+https://scrapy.org)', 'Desktop', 'Groningen, Groningen, The Netherlands', '2026-02-24 03:52:02'),
(172, '/servicedetail.php?id=5', '159.138.109.53', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 03:55:03'),
(173, '/about', '66.249.79.168', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-24 04:33:41'),
(174, '/', '116.204.78.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 04:37:16'),
(175, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-24 05:16:42'),
(176, '/about', '116.204.105.213', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 05:17:52'),
(177, '/', '93.158.90.33', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-02-24 05:49:22'),
(178, '/servicedetail.php?id=3', '81.70.218.241', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 05:58:31'),
(179, '/blogdetail.php?id=2', '81.70.223.132', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 06:39:40'),
(180, '/blogdetail.php?id=3', '124.243.179.14', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 07:20:41'),
(181, '/', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 07:52:49'),
(182, '/dashboard/', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 07:53:01'),
(183, '/dashboard/index.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 07:53:04'),
(184, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 07:53:31'),
(185, '/dashboard/why', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 07:53:39'),
(186, '/servicedetail.php?id=7', '111.119.200.167', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 08:02:00'),
(187, '/dashboard/why', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:02:52'),
(188, '/dashboard/edit-why.php?id=6', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:02:55'),
(189, '/dashboard/edit-why.php?id=6', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:08'),
(190, '/dashboard/why-us.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:14'),
(191, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:20'),
(192, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:47'),
(193, '/dashboard/social', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:57'),
(194, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:03:59'),
(195, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:12'),
(196, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:14'),
(197, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:15'),
(198, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:17'),
(199, '/dashboard/social', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:26'),
(200, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:11:28'),
(201, '/', '66.249.79.168', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-24 08:14:30'),
(202, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:17:07'),
(203, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:17:09'),
(204, '/dashboard/edit-social.php?id=1', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:17:10'),
(205, '/dashboard/social', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:17:13'),
(206, '/dashboard/edit-social.php?id=4', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:17:17'),
(207, '/dashboard/edit-social.php?id=4', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:20:19'),
(208, '/dashboard/blog', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:20:32'),
(209, '/dashboard/editblog.php?id=7', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:20:35'),
(210, '/dashboard/editblog.php?id=7', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:06'),
(211, '/dashboard/services', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:10'),
(212, '/dashboard/editservice.php?id=8', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:12'),
(213, '/dashboard/', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:16'),
(214, '/dashboard/services', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:23'),
(215, '/dashboard/editservice.php?id=8', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:28'),
(216, '/dashboard/', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:31'),
(217, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:37'),
(218, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:22:46'),
(219, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:28:37'),
(220, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:28:37'),
(221, '/dashboard/documents.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:29:58'),
(222, '/dashboard/documents.php?cat=1&view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:30:06'),
(223, '/dashboard/documents.php?cat=1&view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:30:07'),
(224, '/dashboard/documents.php?cat=2&view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:30:09'),
(225, '/dashboard/documents.php?cat=1&view=grid', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:30:10'),
(226, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:33:35'),
(227, '/dashboard/sections', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:33:44'),
(228, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:33:46'),
(229, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:33:54'),
(230, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:39:33'),
(231, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:39:40'),
(232, '/dashboard/settings', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:42:00'),
(233, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:42:15'),
(234, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:42:48'),
(235, '/dashboard/employees.php', '41.90.181.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 08:42:49'),
(236, '/blogdetail.php?id=8', '116.204.83.159', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 08:43:21'),
(237, '/', '188.239.41.144', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 09:24:33'),
(238, '/blogdetail.php?id=6', '188.239.60.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Singapore, Singapore', '2026-02-24 10:05:21'),
(239, '/', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:20:04'),
(240, '/careers', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:20:38'),
(241, '/jobdetail.php?id=1', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:20:52'),
(242, '/', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:21:17'),
(243, '/portfolio', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:21:22'),
(244, '/portdetail.php?id=8', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:21:31'),
(245, '/portdetail.php?id=8', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:23:26'),
(246, '/servicedetail.php?id=11', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:23:45'),
(247, '/', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:24:12'),
(248, '/servicedetail.php?id=11', '102.0.15.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 10:24:19');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(249, '/servicedetail.php?id=11', '62.234.188.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 10:46:31'),
(250, '/contact', '82.157.115.208', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 11:27:35'),
(251, '/', '162.120.187.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-02-24 11:48:45'),
(252, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:02:23'),
(253, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:02:26'),
(254, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:02:31'),
(255, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:02:43'),
(256, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:07:35'),
(257, '/blogdetail.php?id=5', '116.204.120.253', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 12:09:01'),
(258, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:18:57'),
(259, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:19:00'),
(260, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:19:17'),
(261, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:19:20'),
(262, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:19:22'),
(263, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:21:41'),
(264, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:21:52'),
(265, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:25:50'),
(266, '/dashboard/customers.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:25:50'),
(267, '/dashboard/customers.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:25:58'),
(268, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:26:55'),
(269, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:27:08'),
(270, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:27:08'),
(271, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:28:24'),
(272, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:28:24'),
(273, '/dashboard/payments.php?invoice_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:28:42'),
(274, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:28:58'),
(275, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:29:00'),
(276, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:30:08'),
(277, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:30:11'),
(278, '/dashboard/customers.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:30:12'),
(279, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:30:29'),
(280, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:30:31'),
(281, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:38:38'),
(282, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:38:40'),
(283, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:40:13'),
(284, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:45:48'),
(285, '/portdetail.php?id=5', '116.204.108.179', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 12:49:52'),
(286, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:50:41'),
(287, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:51:16'),
(288, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:04'),
(289, '/dashboard/expenses.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:04'),
(290, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:16'),
(291, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:27'),
(292, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:32'),
(293, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:33'),
(294, '/dashboard/payments.php?invoice_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:52:37'),
(295, '/dashboard/payments.php?invoice_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:53:15'),
(296, '/dashboard/payments.php?invoice_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:53:15'),
(297, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:53:32'),
(298, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:57:13'),
(299, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:57:15'),
(300, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:57:18'),
(301, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:57:42'),
(302, '/dashboard/logo', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 12:57:44'),
(303, '/dashboard/logo', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:11:21'),
(304, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:11:25'),
(305, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:11:44'),
(306, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:11:55'),
(307, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:11:57'),
(308, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-24 13:16:44'),
(309, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:18:04'),
(310, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:18:07'),
(311, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 13:21:55'),
(312, '/blogdetail.php?id=9', '82.157.205.196', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 13:31:01'),
(313, '/portdetail.php?id=9', '62.234.78.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 14:13:32'),
(314, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:35:08'),
(315, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:35:10'),
(316, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:35:35'),
(317, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:35:37'),
(318, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:35:39'),
(319, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:47:14'),
(320, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:50:03'),
(321, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:55:12'),
(322, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 14:55:16'),
(323, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:08:09'),
(324, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:08:11'),
(325, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:17:48'),
(326, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:17:51'),
(327, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:21:00'),
(328, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:25:12'),
(329, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:25:14'),
(330, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:27:58'),
(331, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:30:44'),
(332, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:30:46'),
(333, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:31:59'),
(334, '/dashboard/contact', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:32:04'),
(335, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:35:03'),
(336, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:35:14'),
(337, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:35:31'),
(338, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:35:38'),
(339, '/dashboard/contact', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:35:59'),
(340, '/dashboard/logo', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:36:02'),
(341, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:36:04'),
(342, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:36:56'),
(343, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:37:58'),
(344, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:37:59'),
(345, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:42:32'),
(346, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:42:34'),
(347, '/dashboard/contact', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:42:52'),
(348, '/dashboard/contact', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:43:29'),
(349, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:43:35'),
(350, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:43:36'),
(351, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:58:42'),
(352, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:59:03'),
(353, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:59:07'),
(354, '/dashboard/expense-receipt-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:59:11'),
(355, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:59:51'),
(356, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 15:59:59'),
(357, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:02'),
(358, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:06'),
(359, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:09'),
(360, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:18'),
(361, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:18'),
(362, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:32'),
(363, '/dashboard/expense-receipt-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:00:36'),
(364, '/dashboard/payments', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:03:51'),
(365, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:03:55'),
(366, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:05:49'),
(367, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:06:03'),
(368, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:06:06'),
(369, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:06:17'),
(370, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:06:17'),
(371, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:06:56'),
(372, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:16'),
(373, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:18'),
(374, '/dashboard/employees.php?ajax=latest_payslip&employee_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:21'),
(375, '/dashboard/employees.php?ajax=latest_payslip&employee_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:30'),
(376, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:45'),
(377, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:47'),
(378, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:11:53'),
(379, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:14:14'),
(380, '/dashboard/employees.php?ajax=latest_payslip&employee_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:14:16'),
(381, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:18:31'),
(382, '/dashboard/payslip-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:18:35'),
(383, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:21:38'),
(384, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:21:54'),
(385, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:24:22'),
(386, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:27:04'),
(387, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:36:51'),
(388, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:36:59'),
(389, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:37:10'),
(390, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:08'),
(391, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:10'),
(392, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:23'),
(393, '/dashboard/customers', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:37'),
(394, '/dashboard/customers.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:37'),
(395, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:41'),
(396, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:38:42'),
(397, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:40:31'),
(398, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:44:13'),
(399, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:44:23'),
(400, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:44:52'),
(401, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:46:02'),
(402, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:46:04'),
(403, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:46:13'),
(404, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:46:27'),
(405, '/dashboard/expenses', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:47:03'),
(406, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:49:29'),
(407, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:49:32'),
(408, '/dashboard/payments.php?invoice_id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:49:56'),
(409, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:50:06'),
(410, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:50:08'),
(411, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:52:07'),
(412, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:52:09'),
(413, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:53:32'),
(414, '/dashboard/jobs', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:53:36'),
(415, '/dashboard/jobapplications/1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:53:46'),
(416, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:55:52'),
(417, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 16:55:54'),
(418, '/dashboard/invoice-view.php?id=1', '41.90.177.98', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 17:02:36'),
(419, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-02-24 17:02:36'),
(420, '/careers', '188.239.11.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 19:11:32'),
(421, '/privacy', '1.92.192.13', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 19:37:13'),
(422, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:01:56'),
(423, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:02:01'),
(424, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:02:12'),
(425, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:02:26'),
(426, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:02:32'),
(427, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:02:54'),
(428, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:04:22'),
(429, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:04:22'),
(430, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:05:24'),
(431, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:05:33'),
(432, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:05:53'),
(433, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:05:53'),
(434, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:06:28'),
(435, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:06:29'),
(436, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:06:36'),
(437, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:06:36'),
(438, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:07:26'),
(439, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:07:26'),
(440, '/dashboard/payments.php?invoice_id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:08:25'),
(441, '/dashboard/payments.php?invoice_id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:08:57'),
(442, '/dashboard/payments.php?invoice_id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:08:57'),
(443, '/dashboard/payments', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:09:05'),
(444, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:09:20'),
(445, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:09:25'),
(446, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:10:02'),
(447, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:10:10'),
(448, '/dashboard/statement', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:10:51'),
(449, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:11:40'),
(450, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:11:43'),
(451, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:13:24'),
(452, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:13:25'),
(453, '/terms', '188.239.9.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Singapore, Singapore', '2026-02-24 20:14:03'),
(454, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:14:08'),
(455, '/dashboard/invoice-view.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:14:09'),
(456, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:15:04'),
(457, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:15:14'),
(458, '/dashboard/edit-social.php?id=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:15:19'),
(459, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:15:27'),
(460, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:15:33'),
(461, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:16:04');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(462, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:17:45'),
(463, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:17:50'),
(464, '/dashboard/jobs', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:18:03'),
(465, '/dashboard/jobapplications/1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:18:09'),
(466, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:19:56'),
(467, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:20:01'),
(468, '/portdetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-24 20:20:43'),
(469, '/cookie', '49.232.159.109', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 20:51:13'),
(470, '/servicedetail.php?id=7', '124.243.149.250', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 22:04:43'),
(471, '/servicedetail.php?id=10', '116.204.98.53', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-24 22:41:54'),
(472, '/blogdetail.php?id=7', '124.243.173.199', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 23:18:52'),
(473, '/blogdetail.php?id=8', '119.13.100.183', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-24 23:55:53'),
(474, '/servicedetail.php?id=5', '116.204.75.197', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 00:32:43'),
(475, '/servicedetail.php?id=8', '113.44.107.150', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 01:09:34'),
(476, '/portdetail.php?id=3', '49.0.204.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Singapore, Singapore', '2026-02-25 01:46:44'),
(477, '/portdetail.php?id=6', '188.239.48.80', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-25 02:23:24'),
(478, '/cookie', '57.141.20.40', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-25 02:24:02'),
(479, '/portdetail.php?id=9', '111.119.252.139', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-25 03:01:53'),
(480, '/blogdetail.php?id=3', '188.239.56.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Singapore, Singapore', '2026-02-25 03:37:14'),
(481, '/', '42.232.7.130', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhengzhou, Henan, China', '2026-02-25 04:04:27'),
(482, '/blogdetail.php?id=6', '116.204.123.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 04:14:04'),
(483, '/portdetail.php?id=5', '152.136.255.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 04:51:04'),
(484, '/careers', '57.141.20.30', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-25 05:04:47'),
(485, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-25 05:16:42'),
(486, '/privacy', '57.141.20.2', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-25 05:20:32'),
(487, '/blogdetail.php?id=9', '82.156.228.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 05:28:09'),
(488, '/terms', '57.141.20.14', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-25 05:48:05'),
(489, '/blogdetail.php?id=4', '1.92.203.161', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 06:04:47'),
(490, '/servicedetail.php?id=11', '121.37.89.118', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 06:41:56'),
(491, '/', '157.173.122.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'Desktop', 'Lauterbourg, Grand Est, France', '2026-02-25 06:53:02'),
(492, '/portdetail.php?id=8', '49.232.132.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 07:18:48'),
(493, '/dashboard/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:17:23'),
(494, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:17:26'),
(495, '/dashboard/documents.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:21:33'),
(496, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:22:37'),
(497, '/blogdetail.php?id=2', '81.70.252.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 08:32:26'),
(498, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:34:05'),
(499, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:34:07'),
(500, '/dashboard/documents.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:34:13'),
(501, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:35:14'),
(502, '/dashboard/documents.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:43:35'),
(503, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:43:59'),
(504, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:44:03'),
(505, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 08:46:11'),
(506, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:02:22'),
(507, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:02:45'),
(508, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:02:51'),
(509, '/servicedetail.php?id=3', '111.119.210.192', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-25 09:09:28'),
(510, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:11:49'),
(511, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:11:53'),
(512, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:11:55'),
(513, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:15:09'),
(514, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:16:12'),
(515, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:16:15'),
(516, '/servicedetail.php?id=11', '17.241.227.204', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-02-25 09:22:35'),
(517, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:40:35'),
(518, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:40:37'),
(519, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:40:38'),
(520, '/dashboard/employees.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:41:52'),
(521, '/dashboard/documents.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:42:03'),
(522, '/dashboard/dashboard', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:42:11'),
(523, '/dashboard/blog', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:42:30'),
(524, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:42:41'),
(525, '/dashboard/settings', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:45:12'),
(526, '/servicedetail.php?id=4', '116.204.109.58', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 09:46:29'),
(527, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:38'),
(528, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:44'),
(529, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:46'),
(530, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:50'),
(531, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:52'),
(532, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:49:53'),
(533, '/dashboard/statement', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 09:55:57'),
(534, '/', '162.120.188.135', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-02-25 11:13:06'),
(535, '/', '41.139.193.11', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 11:13:24'),
(536, '/', '116.204.67.254', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 11:37:19'),
(537, '/', '107.22.248.10', 'Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-25 11:47:54'),
(538, '/', '107.22.248.10', 'Mozilla/5.0 (X11; Linux x86_64; rv:138.0) Gecko/20100101 Firefox/138.0', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-25 11:47:55'),
(539, '/', '66.249.79.169', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-25 12:45:21'),
(540, '/portfolio', '121.37.85.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 12:50:57'),
(541, '/cookie', '66.249.79.169', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; GoogleOther)', 'Mobile', 'Mountain View, California, United States', '2026-02-25 13:03:39'),
(542, '/about', '188.239.13.17', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-02-25 13:27:47'),
(543, '/', '62.234.161.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 14:04:50'),
(544, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-02-25 14:20:29'),
(545, '/', '31.13.127.9', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Clonee, Leinster, Ireland', '2026-02-25 14:21:18'),
(546, '/dashboard/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 14:21:56'),
(547, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 14:21:59'),
(548, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 14:22:06'),
(549, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 14:22:08'),
(550, '/contact', '1.92.210.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 14:41:52'),
(551, '/contact', '81.70.210.253', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 15:18:49'),
(552, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebyEfNwCKBrftYdPwajF0_6liDpXLVzx49_lcsjhN0E0G1T398F4RqlZoRSk_aem_NPNbeipZY3F3s447O9seBQ', '31.13.127.32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Desktop', 'Clonee, Leinster, Ireland', '2026-02-25 16:09:00'),
(553, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebyEfNwCKBrftYdPwajF0_6liDpXLVzx49_lcsjhN0E0G1T398F4RqlZoRSk_aem_NPNbeipZY3F3s447O9seBQ', '173.252.69.116', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'DeKalb, Illinois, United States', '2026-02-25 16:09:40'),
(554, '/', '173.252.70.21', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Gallatin, Tennessee, United States', '2026-02-25 16:09:48'),
(555, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe8RQFXqN6Delps4rt6D5dqJIKXax0JS2O6aHlxECSa1gdjW7_npfcHwmciTc_aem_OhqVrozmJhfWdPhKLrZEUw', '173.252.127.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Desktop', 'Forest City, North Carolina, United States', '2026-02-25 16:10:48'),
(556, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe8RQFXqN6Delps4rt6D5dqJIKXax0JS2O6aHlxECSa1gdjW7_npfcHwmciTc_aem_OhqVrozmJhfWdPhKLrZEUw', '173.252.127.18', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Forest City, North Carolina, United States', '2026-02-25 16:11:25'),
(557, '/dashboard/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:15:11'),
(558, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:15:14'),
(559, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:15:17'),
(560, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:15:19'),
(561, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-02-25 16:22:18'),
(562, '/dashboard/index.php', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:23:13'),
(563, '/dashboard/invoices', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:23:15'),
(564, '/dashboard/invoice-view.php?id=2', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-25 16:23:16'),
(565, '/services', '1.92.209.185', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-02-25 16:32:29'),
(566, '/', '185.130.246.22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Viewer/99.9.8853.8', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-02-25 16:38:12'),
(567, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe85tLd3R5_nzfpLTSqQsbhPHgv3Ox0r_KOOtmyflwjAFcGsdWgMaX6DfpsW4_aem_Lwg3TFR1EvMA1OCeZXl4Qg', '173.252.95.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Altoona, Iowa, United States', '2026-02-25 16:54:51'),
(568, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe85tLd3R5_nzfpLTSqQsbhPHgv3Ox0r_KOOtmyflwjAFcGsdWgMaX6DfpsW4_aem_Lwg3TFR1EvMA1OCeZXl4Qg', '173.252.83.9', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Springfield, Nebraska, United States', '2026-02-25 16:55:27'),
(569, '/', '69.171.230.8', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-02-25 16:55:35'),
(570, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeLwD2RCNtBxPBEW_8yYJKeuk-_uYbBpuVTFWygfaYFEKlEljT9KaRTbQLBcw_aem_uR2eJkVbpE3qbtwgHuIPyg', '66.220.149.38', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Prineville, Oregon, United States', '2026-02-25 16:58:13'),
(571, '/', '173.252.95.114', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Altoona, Iowa, United States', '2026-02-25 16:58:56'),
(572, '/servicedetail.php?id=5', '52.167.144.149', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-02-25 17:04:18'),
(573, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeobzxxUzZ-X0t7LeQ9FRZlntidhmYb2WFdHPpj1Oghzu6Cl8z0rxUASRT170_aem_z_CI4ESSkysBwVSayvY0Sg', '173.252.87.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Fort Worth, Texas, United States', '2026-02-25 17:11:02'),
(574, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeobzxxUzZ-X0t7LeQ9FRZlntidhmYb2WFdHPpj1Oghzu6Cl8z0rxUASRT170_aem_z_CI4ESSkysBwVSayvY0Sg', '173.252.127.59', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Forest City, North Carolina, United States', '2026-02-25 17:11:41'),
(575, '/', '31.13.127.10', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Clonee, Leinster, Ireland', '2026-02-25 17:11:49'),
(576, '/', '198.235.24.106', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-02-25 19:37:17'),
(577, '/', '66.249.79.168', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-25 21:01:32'),
(578, '/', '66.249.79.167', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-25 21:01:42'),
(579, '/', '82.25.247.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Belgrade, Central Serbia, Serbia', '2026-02-25 22:08:27'),
(580, '/', '123.174.10.240', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Yuncheng, Shanxi, China', '2026-02-25 23:59:40'),
(581, '/', '93.158.90.168', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-02-26 00:27:38'),
(582, '/servicedetail.php?id=9', '17.246.15.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-02-26 02:56:05'),
(583, '/', '222.242.171.93', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Changsha, Hunan, China', '2026-02-26 03:46:46'),
(584, '/', '192.71.142.232', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', 'Mobile', 'Lookup failed', '2026-02-26 04:15:20'),
(585, '/', '205.210.31.93', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Lookup failed', '2026-02-26 04:30:20'),
(586, '/', '159.65.172.119', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Lookup failed', '2026-02-26 04:51:49'),
(587, '/', '52.30.28.69', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-26 06:16:42'),
(588, '/careers', '57.141.20.4', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 06:35:42'),
(589, '/blogdetail.php?id=2', '52.167.144.184', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-02-26 06:39:26'),
(590, '/privacy', '57.141.20.37', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 07:25:11'),
(591, '/cookie', '57.141.20.55', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 07:38:17'),
(592, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-26 08:03:52'),
(593, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEePfgZDe_y-jZCy0i3qQOqPeuaN8jbKHL6X5CukjJA1Fufx2qmGDr8yUIntWg_aem_1LugGYxWZO2GwR345QdRAg', '31.13.115.37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'LuleÃ¥, Norrbotten County, Sweden', '2026-02-26 08:48:15'),
(594, '/', '173.252.79.4', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Los Lunas, New Mexico, United States', '2026-02-26 08:49:01'),
(595, '/dashboard/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-26 09:03:32'),
(596, '/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-26 09:03:42'),
(597, '/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-26 09:11:02'),
(598, '/', '180.153.236.153', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-02-26 11:06:49'),
(599, '/', '66.249.79.168', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-26 11:10:26'),
(600, '/about', '207.32.143.88', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'New York, New York, United States', '2026-02-26 12:50:11'),
(601, '/', '52.30.28.69', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-26 13:16:43'),
(602, '/servicedetail.php?id=11', '57.141.20.20', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 13:36:14'),
(603, '/servicedetail.php?id=10', '57.141.20.42', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 13:54:56'),
(604, '/jobdetail.php?id=1', '57.141.20.35', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-26 14:02:28'),
(605, '/', '180.153.236.135', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-02-26 14:44:52'),
(606, '/', '180.153.236.32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-02-26 14:45:31'),
(607, '/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-26 15:07:58'),
(608, '/', '41.90.177.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-26 15:08:42'),
(609, '/', '106.8.131.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Qinhuangdao, Hebei, China', '2026-02-26 23:44:06'),
(610, '/', '66.249.76.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-02-26 23:47:05'),
(611, '/about', '104.253.247.52', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-02-27 01:14:25'),
(612, '/', '185.247.137.2', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Manchester, England, United Kingdom', '2026-02-27 01:25:18'),
(613, '/', '147.185.132.159', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-02-27 02:51:48'),
(614, '/', '39.185.113.6', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Cixi, Zhejiang, China', '2026-02-27 03:14:48'),
(615, '/', '113.137.186.221', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Xi\'an, Shaanxi, China', '2026-02-27 03:34:47'),
(616, '/', '116.132.236.30', 'YisouSpider', 'Desktop', 'Beijing, Beijing, China', '2026-02-27 04:17:36'),
(617, '/terms', '57.141.20.13', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-27 06:14:09'),
(618, '/privacy', '57.141.20.41', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-27 07:58:11'),
(619, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-27 08:03:56'),
(620, '/careers', '57.141.20.20', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-27 08:14:26'),
(621, '/cookie', '57.141.20.52', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-02-27 09:23:12'),
(622, '/', '137.184.148.29', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'North Bergen, New Jersey, United States', '2026-02-27 09:47:47'),
(623, '/', '199.244.88.222', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Bartlett, Illinois, United States', '2026-02-27 09:51:04'),
(624, '/', '54.236.168.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-27 11:11:44'),
(625, '/', '54.236.168.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4093.0 Safari/537.36 Edg/83.0.470.0', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-27 11:11:44'),
(626, '/', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:36:37'),
(627, '/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:36:44'),
(628, '/portdetail.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:36:47'),
(629, '/dashboard/editport.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:36:49'),
(630, '/dashboard/editport.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:36:54'),
(631, '/dashboard/index.php', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:37:03'),
(632, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 14:37:18'),
(633, '/dashboard/editport.php?id=8', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:16'),
(634, '/dashboard/editport.php?id=8', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:23'),
(635, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:30'),
(636, '/dashboard/editport.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:33'),
(637, '/dashboard/editport.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:49'),
(638, '/dashboard/editport.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:53'),
(639, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:17:59'),
(640, '/dashboard/editport.php?id=6', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:09'),
(641, '/dashboard/editport.php?id=6', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:26'),
(642, '/dashboard/editport.php?id=6', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:36'),
(643, '/dashboard/editport.php?id=6', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:38'),
(644, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:43'),
(645, '/dashboard/services', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:50'),
(646, '/dashboard/editservice.php?id=11', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:18:58'),
(647, '/dashboard/editservice.php?id=11', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:19:05'),
(648, '/dashboard/services', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:19:09'),
(649, '/dashboard/editservice.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:19:14'),
(650, '/dashboard/editservice.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:19:25'),
(651, '/dashboard/services', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:19:29'),
(652, '/dashboard/createportfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:20:42'),
(653, '/dashboard/createportfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:21:45'),
(654, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:21:47'),
(655, '/dashboard/editport.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:21:56'),
(656, '/dashboard/editport.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:25:10'),
(657, '/dashboard/portfolio', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:25:16'),
(658, '/dashboard/editport.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:25:20'),
(659, '/portdetail.php?id=9', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:25:27'),
(660, '/portdetail.php?id=10', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:25:32'),
(661, '/services', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 15:26:45'),
(662, '/', '41.90.36.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-02-27 16:06:58'),
(663, '/', '23.162.40.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-02-27 16:09:51'),
(664, '/about', '45.41.146.131', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-27 19:52:52'),
(665, '/', '95.217.145.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 Edg/144.0.0.0', 'Desktop', 'Helsinki, Uusimaa, Finland', '2026-02-28 01:57:30'),
(666, '/', '95.217.145.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Helsinki, Uusimaa, Finland', '2026-02-28 01:57:30'),
(667, '/', '95.217.145.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Helsinki, Uusimaa, Finland', '2026-02-28 01:57:30'),
(668, '/', '95.217.145.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Helsinki, Uusimaa, Finland', '2026-02-28 01:57:30'),
(669, '/about', '198.145.140.60', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Boston, Massachusetts, United States', '2026-02-28 02:31:24'),
(670, '/', '115.63.125.223', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhengzhou, Henan, China', '2026-02-28 05:30:04'),
(671, '/', '112.51.225.156', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Guangzhou, Guangdong, China', '2026-02-28 06:23:30'),
(672, '/careers', '103.176.57.234', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'New Delhi, National Capital Territory of Delhi, India', '2026-02-28 07:36:24'),
(673, '/jobdetail.php?id=1', '103.176.57.234', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'New Delhi, National Capital Territory of Delhi, India', '2026-02-28 07:36:40'),
(674, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-28 08:04:09'),
(675, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-02-28 08:07:32'),
(676, '/', '54.174.62.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 (compatible; HubSpot DataHub; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-02-28 12:48:32');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(677, '/', '77.104.167.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Rochdale, England, United Kingdom', '2026-02-28 12:59:56'),
(678, '/', '116.132.255.65', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Lookup failed', '2026-02-28 13:33:04'),
(679, '/portfolio', '193.186.4.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-02-28 20:04:35'),
(680, '/', '66.249.76.230', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-02-28 23:04:13'),
(681, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-01 01:52:26'),
(682, '/', '66.249.64.104', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-01 01:53:36'),
(683, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-01 01:53:37'),
(684, '/', '198.235.24.44', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-01 02:36:49'),
(685, '/privacy', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-01 03:43:09'),
(686, '/cookie', '57.141.20.28', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-01 03:54:03'),
(687, '/careers', '57.141.20.2', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-01 04:14:00'),
(688, '/terms', '57.141.20.50', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-01 06:36:59'),
(689, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-01 08:04:02'),
(690, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-01 08:06:30'),
(691, '/portfolio', '40.77.167.20', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-03-01 08:11:27'),
(692, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-01 11:23:05'),
(693, '/', '100.26.154.21', 'Mozilla/5.0 (Linux; Android 9; ZTE Blade A7 2020) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Mobile Safari/537.36', 'Mobile', 'Ashburn, Virginia, United States', '2026-03-01 16:34:27'),
(694, '/', '192.36.109.115', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-02 00:21:39'),
(695, '/', '106.8.76.57', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-02 03:44:55'),
(696, '/', '42.234.197.145', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhengzhou, Henan, China', '2026-03-02 03:45:08'),
(697, '/', '64.23.244.30', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Santa Clara, California, United States', '2026-03-02 04:17:53'),
(698, '/', '39.154.12.102', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Hohhot, Inner Mongolia, China', '2026-03-02 05:09:07'),
(699, '/privacy', '57.141.20.54', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-02 05:44:44'),
(700, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-02 08:04:42'),
(701, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-02 08:07:49'),
(702, '/', '185.253.162.20', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Strovolos, Nicosia, Cyprus', '2026-03-02 08:59:54'),
(703, '/', '185.253.162.20', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Strovolos, Nicosia, Cyprus', '2026-03-02 08:59:54'),
(704, '/', '185.253.162.20', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Strovolos, Nicosia, Cyprus', '2026-03-02 08:59:54'),
(705, '/', '185.253.162.20', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Strovolos, Nicosia, Cyprus', '2026-03-02 08:59:54'),
(706, '/', '167.94.138.170', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'Ann Arbor, Michigan, United States', '2026-03-02 09:10:48'),
(707, '/', '167.94.138.170', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'Ann Arbor, Michigan, United States', '2026-03-02 09:11:58'),
(708, '/', '41.90.37.135', 'WhatsApp/2.2607.102 W', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-02 09:23:33'),
(709, '/portfolio', '41.90.37.135', 'WhatsApp/2.2607.102 W', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-02 09:23:38'),
(710, '/', '41.90.37.135', 'WhatsApp/2.2607.102 W', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-02 09:23:47'),
(711, '/', '164.92.163.179', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-02 09:54:30'),
(712, '/', '69.171.249.116', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-02 11:23:28'),
(713, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeVON_U6wamacBgDKgevSb6R_T5QyOHnyS9dwdB0d-pGwaD6tmvMws0J_hbjM_aem__g8R3ByIc1a2Fi17eGxuEQ', '173.252.82.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Springfield, Nebraska, United States', '2026-03-02 11:23:29'),
(714, '/', '69.171.249.10', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-02 11:23:31'),
(715, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeyZWNFtlRLUvuMHLUUuf3q7SzuWngqwNzs7qOircZqWYaDCOhFgVAkHddU-8_aem_1ViG4FzfaWYnZZgn8O0igA', '173.252.127.29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Forest City, North Carolina, United States', '2026-03-02 11:23:32'),
(716, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeDOU_kvHDaDzCt8Twp-olYAYdpYCQRa37O6Z3sS1QimAd0Pu4ueFvCCVyQ0Y_aem_fUkZiBy2vqcUBAmQS0TbIg', '66.220.149.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Prineville, Oregon, United States', '2026-03-02 11:23:32'),
(717, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeurLu05KQXSs4TYog-6uf9_dm50IkGJ3af0QS8iifrD1CJ2-Y-lFL_E60D-A_aem_JEoGNlo20kWPTRdyM130UA', '66.220.149.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-03-02 11:23:32'),
(718, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeb9FoR5uwdLu4bYLRN_PXlpON-KOeRxXif-apbajfdNlucJEgBgttpm0qgPs_aem_96hkJCZc_yq7h1W6xSnkww', '173.252.87.115', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-02 11:23:34'),
(719, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeVON_U6wamacBgDKgevSb6R_T5QyOHnyS9dwdB0d-pGwaD6tmvMws0J_hbjM_aem__g8R3ByIc1a2Fi17eGxuEQ', '69.171.230.18', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-02 11:24:05'),
(720, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeDOU_kvHDaDzCt8Twp-olYAYdpYCQRa37O6Z3sS1QimAd0Pu4ueFvCCVyQ0Y_aem_fUkZiBy2vqcUBAmQS0TbIg', '173.252.79.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-02 11:24:10'),
(721, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeurLu05KQXSs4TYog-6uf9_dm50IkGJ3af0QS8iifrD1CJ2-Y-lFL_E60D-A_aem_JEoGNlo20kWPTRdyM130UA', '69.171.231.19', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-02 11:24:11'),
(722, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-02 11:36:18'),
(723, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-02 11:53:41'),
(724, '/', '38.226.202.48', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', 'Mobile', 'Imara Daima Estate, Nairobi County, Kenya', '2026-03-02 13:02:49'),
(725, '/about', '74.7.36.73', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Desktop', 'Richmond, Virginia, United States', '2026-03-02 13:30:47'),
(726, '/', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-02 15:23:53'),
(727, '/portdetail.php?id=10', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-02 15:24:14'),
(728, '/', '54.174.58.233', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-02 16:30:02'),
(729, '/careers', '17.22.253.18', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-02 20:24:55'),
(730, '/', '185.151.16.182', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Viewer/99.9.8853.8', 'Desktop', 'Moscow, Moscow, Russia', '2026-03-02 21:15:40'),
(731, '/', '198.235.24.148', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-02 22:09:39'),
(732, '/', '3.18.186.238', 'visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'Desktop', 'Hilliard, Ohio, United States', '2026-03-02 22:32:03'),
(733, '/', '198.235.24.16', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-02 22:54:59'),
(734, '/terms', '57.141.20.43', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-03 03:14:08'),
(735, '/careers', '57.141.20.54', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-03 04:24:40'),
(736, '/', '66.249.76.232', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-03 04:27:56'),
(737, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-03 04:28:48'),
(738, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-03 05:25:27'),
(739, '/cookie', '57.141.20.8', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-03 06:33:04'),
(740, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-03 08:04:16'),
(741, '/', '205.210.31.153', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-03 08:44:04'),
(742, '/', '198.235.24.142', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-03 10:41:21'),
(743, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-03 10:57:26'),
(744, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:10:39'),
(745, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:11:30'),
(746, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:11:46'),
(747, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:11:51'),
(748, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:12:00'),
(749, '/dashboard/edit-social.php?id=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:12:06'),
(750, '/dashboard/edit-social.php?id=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:17:45'),
(751, '/dashboard/edit-social.php?id=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:17:49'),
(752, '/dashboard/edit-social.php?id=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:17:54'),
(753, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:18:01'),
(754, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:18:45'),
(755, '/dashboard/edit-social.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:19:15'),
(756, '/dashboard/edit-social.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:21:49'),
(757, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:21:57'),
(758, '/dashboard/edit-social.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:23:40'),
(759, '/dashboard/edit-social.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:30:18'),
(760, '/dashboard/social', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:30:22'),
(761, '/', '87.236.176.185', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Leeds, England, United Kingdom', '2026-03-03 11:52:23'),
(762, '/', '41.90.172.249', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 11:58:19'),
(763, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-03 13:14:32'),
(764, '/', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:14:34'),
(765, '/', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:14:59'),
(766, '/about', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:14:59'),
(767, '/services', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:15:38'),
(768, '/portfolio', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:15:41'),
(769, '/terms', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:16:21'),
(770, '/privacy', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:16:41'),
(771, '/contact', '3.82.24.209', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:16:41'),
(772, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:01'),
(773, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:06'),
(774, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:11'),
(775, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:38'),
(776, '/dashboard/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:47'),
(777, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:56:55'),
(778, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 13:57:16'),
(779, '/', '54.224.223.231', 'Iframely/1.3.1 (+https://iframely.com/docs/about) Canva', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 13:58:51'),
(780, '/', '104.143.84.54', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-03 15:39:50'),
(781, '/', '104.143.84.54', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-03 15:39:50'),
(782, '/', '104.143.84.54', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-03 15:39:51'),
(783, '/', '104.143.84.54', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-03 15:39:51'),
(784, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-03 15:42:51'),
(785, '/', '192.36.166.94', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1.2 Mobile/15E148 Safari/604', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-03 16:42:20'),
(786, '/', '69.171.234.23', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Hillsboro, Oregon, United States', '2026-03-03 16:53:10'),
(787, '/', '69.171.249.1', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-03 16:53:54'),
(788, '/', '78.109.75.245', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Yerevan, Yerevan, Armenia', '2026-03-03 16:54:44'),
(789, '/services', '78.109.75.245', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Yerevan, Yerevan, Armenia', '2026-03-03 16:54:47'),
(790, '/', '185.247.137.239', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Manchester, England, United Kingdom', '2026-03-03 17:42:23'),
(791, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-03 20:02:09'),
(792, '/', '69.171.230.38', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-03 23:10:18'),
(793, '/', '66.249.76.232', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-04 06:34:28'),
(794, '/', '66.249.76.233', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-04 06:34:34'),
(795, '/', '216.157.41.88', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-04 10:43:21'),
(796, '/', '192.36.109.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Viewer/99.9.8853.8', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-04 11:03:51'),
(797, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:36:16'),
(798, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:36:25'),
(799, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:36:33'),
(800, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:37:19'),
(801, '/dashboard/documents.php?view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:37:19'),
(802, '/dashboard/documents.php?view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:38:21'),
(803, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:38:21'),
(804, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:39:37'),
(805, '/dashboard/document-categories.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:40:42'),
(806, '/dashboard/document-categories.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:40:53'),
(807, '/dashboard/document-categories.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:41:12'),
(808, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:41:18'),
(809, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:42:00'),
(810, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:42:00'),
(811, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:42:47'),
(812, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:42:48'),
(813, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:43:21'),
(814, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:43:21'),
(815, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:43:56'),
(816, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:43:57'),
(817, '/dashboard/jobs', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:44:07'),
(818, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:44:21'),
(819, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:53:45'),
(820, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:54:11'),
(821, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:55:07'),
(822, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 11:59:14'),
(823, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:04:55'),
(824, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:04:56'),
(825, '/', '72.14.201.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Mountain View, California, United States', '2026-03-04 12:05:18'),
(826, '/about', '162.120.188.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-04 12:05:20'),
(827, '/blog', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-04 12:05:45'),
(828, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:06:14'),
(829, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:06:40'),
(830, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:06:58'),
(831, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:07:05'),
(832, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:07:27'),
(833, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:07:55'),
(834, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:12:58'),
(835, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:17:31'),
(836, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:17:51'),
(837, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:17:59'),
(838, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:18:06'),
(839, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:18:18'),
(840, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:18:24'),
(841, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:18:29'),
(842, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:18:37'),
(843, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:19:19'),
(844, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:22:20'),
(845, '/dashboard/editservice.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:22:33'),
(846, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:24:24'),
(847, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:24:46'),
(848, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:24:54'),
(849, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:25:05'),
(850, '/dashboard/editservice.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:29:46'),
(851, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:29:56'),
(852, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:30:51'),
(853, '/', '216.157.40.79', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-04 12:46:31'),
(854, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 12:50:00'),
(855, '/', '3.125.100.85', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-04 12:50:20'),
(856, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:10:00'),
(857, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:10:27'),
(858, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:10:34'),
(859, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:10:41'),
(860, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:10:46'),
(861, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:14:02'),
(862, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:14:10'),
(863, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:14:16'),
(864, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:14:22'),
(865, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:19:36'),
(866, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:19:48'),
(867, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:19:52'),
(868, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:24:33'),
(869, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:24:39'),
(870, '/dashboard/?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:24:56'),
(871, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:28:39'),
(872, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:28:44'),
(873, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:28:49'),
(874, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:28:53'),
(875, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:28:55'),
(876, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:30:36'),
(877, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:30:45'),
(878, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:30:47'),
(879, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:31:07'),
(880, '/dashboard/editport.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:31:16'),
(881, '/dashboard/editport.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:34:05'),
(882, '/dashboard/remove_portfolio_media.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:34:24'),
(883, '/dashboard/editport.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:34:28'),
(884, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 13:34:32'),
(885, '/', '124.239.12.123', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-03-04 13:53:08'),
(886, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:28:23'),
(887, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:28:27'),
(888, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:28:36'),
(889, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:28:44'),
(890, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:29:06'),
(891, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:29:14'),
(892, '/dashboard/editservice.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:29:22');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(893, '/dashboard/editservice.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:04'),
(894, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:13'),
(895, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:18'),
(896, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:26'),
(897, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:29'),
(898, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:34'),
(899, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:38'),
(900, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:40'),
(901, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:42'),
(902, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:44'),
(903, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:48'),
(904, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:51'),
(905, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:54'),
(906, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:57'),
(907, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:30:59'),
(908, '/dashboard/remove_service_media.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:31:05'),
(909, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:31:47'),
(910, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:31:56'),
(911, '/dashboard/editservice.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:32:09'),
(912, '/dashboard/remove_service_media.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:32:23'),
(913, '/dashboard/editservice.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:32:25'),
(914, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:32:29'),
(915, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:32:36'),
(916, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:33:10'),
(917, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:33:48'),
(918, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:03'),
(919, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:24'),
(920, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:28'),
(921, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:44'),
(922, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:47'),
(923, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:34:59'),
(924, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:35:09'),
(925, '/blogdetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:35:25'),
(926, '/blogdetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:35:26'),
(927, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:35:53'),
(928, '/blogdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:35:58'),
(929, '/careers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:36:06'),
(930, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:36:18'),
(931, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:39:25'),
(932, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-04 14:39:30'),
(933, '/', '16.147.187.82', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-03-04 15:30:44'),
(934, '/', '54.146.94.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.136 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-04 15:47:17'),
(935, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-04 16:56:35'),
(936, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-04 18:51:41'),
(937, '/', '66.249.76.230', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-04 18:51:42'),
(938, '/', '197.237.148.116', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-04 20:33:20'),
(939, '/careers', '197.237.148.116', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-04 20:33:38'),
(940, '/jobdetail.php?id=1', '197.237.148.116', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-04 20:33:54'),
(941, '/', '198.235.24.243', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-05 00:41:29'),
(942, '/', '192.71.126.249', 'Mozilla/5.0 (Linux; U; Android 13; sk-sk; Xiaomi 11T Pro Build/TKQ1.220829.002) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.4.0-g', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-05 01:23:01'),
(943, '/blogdetail.php?id=9', '17.22.237.206', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-05 02:11:11'),
(944, '/cookie', '57.141.20.40', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-05 02:20:00'),
(945, '/privacy', '57.141.20.11', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-05 03:08:01'),
(946, '/terms', '57.141.20.19', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-05 03:34:08'),
(947, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 08:59:57'),
(948, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:03:14'),
(949, '/dashboard/index.php', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-05 09:03:28'),
(950, '/dashboard/index.php', '66.249.64.103', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-05 09:03:29'),
(951, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:04:11'),
(952, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:04:24'),
(953, '/dashboard/index.php?rv_page=1&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:04:45'),
(954, '/dashboard/index.php?rv_page=2&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:04:53'),
(955, '/dashboard/index.php?rv_page=3&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:04:58'),
(956, '/dashboard/index.php?rv_page=4&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:02'),
(957, '/dashboard/index.php?rv_page=5&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:12'),
(958, '/dashboard/index.php?rv_page=6&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:22'),
(959, '/dashboard/index.php?rv_page=7&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:30'),
(960, '/dashboard/index.php?rv_page=8&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:38'),
(961, '/dashboard/index.php?rv_page=9&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:05:54'),
(962, '/dashboard/index.php?rv_page=10&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:06:03'),
(963, '/dashboard/index.php?rv_page=11&jv_page=1&rv_limit=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:06:28'),
(964, '/dashboard/index.php?rv_page=11&jv_page=1&rv_limit=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:06:43'),
(965, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:07:43'),
(966, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:07:55'),
(967, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:08:12'),
(968, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:08:14'),
(969, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:08:17'),
(970, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:08:19'),
(971, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:09:37'),
(972, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:09:51'),
(973, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:09:55'),
(974, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:09:58'),
(975, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:01'),
(976, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:05'),
(977, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:12'),
(978, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:13'),
(979, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:18'),
(980, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:23'),
(981, '/dashboard/editservice.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:30'),
(982, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:33'),
(983, '/dashboard/editservice.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:39'),
(984, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:10:52'),
(985, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-05 09:14:02'),
(986, '/portdetail.php?id=10', '41.90.37.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:15:01'),
(987, '/dashboard/editservice.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:16:33'),
(988, '/dashboard/editservice.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:16:48'),
(989, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:17:00'),
(990, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:17:17'),
(991, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:17:24'),
(992, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:17:42'),
(993, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:17:43'),
(994, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:03'),
(995, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:13'),
(996, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:19'),
(997, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:23'),
(998, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:31'),
(999, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:18:48'),
(1000, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:19:01'),
(1001, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:19:20'),
(1002, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:19:26'),
(1003, '/dashboard/remove_service_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:19:32'),
(1004, '/dashboard/editservice.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:19:42'),
(1005, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:04'),
(1006, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:14'),
(1007, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:25'),
(1008, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:29'),
(1009, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:50'),
(1010, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:20:58'),
(1011, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:21:59'),
(1012, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:22:34'),
(1013, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:22:42'),
(1014, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:22:46'),
(1015, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:22:53'),
(1016, '/dashboard/remove_service_media.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:24:21'),
(1017, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:24:27'),
(1018, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:24:37'),
(1019, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:24:47'),
(1020, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:25:31'),
(1021, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:25:38'),
(1022, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:25:41'),
(1023, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:25:46'),
(1024, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:47:25'),
(1025, '/dashboard/remove_service_media.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:47:44'),
(1026, '/dashboard/remove_service_media.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:47:49'),
(1027, '/dashboard/remove_service_media.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:47:52'),
(1028, '/dashboard/remove_service_media.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:47:54'),
(1029, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:48:25'),
(1030, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:48:32'),
(1031, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:48:44'),
(1032, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:48:55'),
(1033, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:02'),
(1034, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:05'),
(1035, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:09'),
(1036, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:11'),
(1037, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:14'),
(1038, '/dashboard/remove_portfolio_media.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:16'),
(1039, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:48'),
(1040, '/dashboard/editport.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:53'),
(1041, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:49:59'),
(1042, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:05'),
(1043, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:31'),
(1044, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:34'),
(1045, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:41'),
(1046, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:47'),
(1047, '/dashboard/editservice.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:50:53'),
(1048, '/dashboard/editservice.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:51:35'),
(1049, '/dashboard/editservice.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:51:46'),
(1050, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:51:52'),
(1051, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:52:03'),
(1052, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:52:15'),
(1053, '/dashboard/editservice.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:52:31'),
(1054, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:52:42'),
(1055, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:52:56'),
(1056, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:53:01'),
(1057, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:53:07'),
(1058, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:53:16'),
(1059, '/dashboard/editport.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:53:26'),
(1060, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:53:45'),
(1061, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:54:05'),
(1062, '/dashboard/editport.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:54:13'),
(1063, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:54:34'),
(1064, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:54:42'),
(1065, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:54:59'),
(1066, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:06'),
(1067, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:11'),
(1068, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:17'),
(1069, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:25'),
(1070, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:33'),
(1071, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:55:52'),
(1072, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:56:08'),
(1073, '/blogdetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 09:56:22'),
(1074, '/', '52.205.228.45', 'Iframely/1.3.1 (+https://iframely.com/docs/about) Canva', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-05 10:01:19'),
(1075, '/', '180.153.236.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-05 11:58:28'),
(1076, '/', '180.153.236.106', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-05 11:58:32'),
(1077, '/', '180.153.236.224', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-05 11:58:34'),
(1078, '/', '69.63.184.114', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Social Circle, Georgia, United States', '2026-03-05 12:37:59'),
(1079, '/', '69.171.249.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-05 12:38:02'),
(1080, '/', '69.171.249.116', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-05 12:38:02'),
(1081, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe3uB58no48k9T9QtIS0R1tM-qpl-SJyLBex_-ilUBotmHI8u7nXgYRIw70hw_aem_-Y-jmDbXtHaQD3mA2YZuwA', '66.220.149.10', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Prineville, Oregon, United States', '2026-03-05 12:38:04'),
(1082, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe_1jAjAxgSg-SeuerzPqRrhAjxpYeK13d1xpiyzF5WFgV2c0t055qFVWsCQw_aem_ynLMy_-2UFoSWblrd7knqg', '66.220.149.28', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Prineville, Oregon, United States', '2026-03-05 12:38:04'),
(1083, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe_1jAjAxgSg-SeuerzPqRrhAjxpYeK13d1xpiyzF5WFgV2c0t055qFVWsCQw_aem_ynLMy_-2UFoSWblrd7knqg', '69.171.234.112', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Hillsboro, Oregon, United States', '2026-03-05 12:38:40'),
(1084, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe3uB58no48k9T9QtIS0R1tM-qpl-SJyLBex_-ilUBotmHI8u7nXgYRIw70hw_aem_-Y-jmDbXtHaQD3mA2YZuwA', '69.171.249.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-05 12:38:41'),
(1085, '/', '173.252.87.59', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Fort Worth, Texas, United States', '2026-03-05 12:38:46'),
(1086, '/', '173.252.107.2', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-05 12:38:46'),
(1087, '/', '69.171.234.114', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Hillsboro, Oregon, United States', '2026-03-05 12:51:42'),
(1088, '/', '69.171.231.4', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Eagle Mountain, Utah, United States', '2026-03-05 12:52:25'),
(1089, '/', '69.171.230.18', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-05 12:52:45'),
(1090, '/', '180.153.236.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-05 13:26:16'),
(1091, '/careers', '57.141.20.39', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-05 13:42:15'),
(1092, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-05 14:00:44'),
(1093, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-05 14:00:57'),
(1094, '/', '193.186.4.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-03-05 14:01:14'),
(1095, '/', '216.157.42.70', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-05 15:49:38'),
(1096, '/dashboard/', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 16:47:07'),
(1097, '/dashboard/', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 16:47:09'),
(1098, '/dashboard/index.php', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 16:47:13'),
(1099, '/dashboard/index.php?rv_page=1&jv_page=1&rv_limit=50', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 16:47:36'),
(1100, '/dashboard/dashboard', '41.90.37.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 16:48:00'),
(1101, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:21:38');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(1102, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:22:06'),
(1103, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:22:18'),
(1104, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:22:38'),
(1105, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:22:48'),
(1106, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:23:11'),
(1107, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:23:26'),
(1108, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:23:39'),
(1109, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:24:03'),
(1110, '/?utm_source=ig&utm_medium=social&utm_content=link_in_bio&fbclid=PAZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQPNTY3MDY3MzQzMzUyNDI3AAGnxHT43QxQ5sn8YpXiheBwsUIEfyeyArX6EYWfgQ8nm-Sf9Nkl32i4w82czjg_aem_ttnFcUjtIjUWcb8gIfd0GQ', '102.209.18.34', 'Mozilla/5.0 (Linux; Android 16; SM-A165F Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.113 Mobile Safari/537.36 Instagram 418.0.0.51.77 Android (36/16; 420dpi; 1080x2340; samsung; SM-A165F; a16; mt6789; en_ZA; 891072599; IABMV/1)', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:33:02'),
(1111, '/services', '102.209.18.34', 'Mozilla/5.0 (Linux; Android 16; SM-A165F Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.113 Mobile Safari/537.36 Instagram 418.0.0.51.77 Android (36/16; 420dpi; 1080x2340; samsung; SM-A165F; a16; mt6789; en_ZA; 891072599; IABMV/1)', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:33:31'),
(1112, '/servicedetail.php?id=11', '102.209.18.34', 'Mozilla/5.0 (Linux; Android 16; SM-A165F Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.113 Mobile Safari/537.36 Instagram 418.0.0.51.77 Android (36/16; 420dpi; 1080x2340; samsung; SM-A165F; a16; mt6789; en_ZA; 891072599; IABMV/1)', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-05 19:33:36'),
(1113, '/privacy', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-06 04:13:11'),
(1114, '/terms', '57.141.20.33', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-06 05:01:39'),
(1115, '/cookie', '57.141.20.17', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-06 06:16:15'),
(1116, '/dashboard/editservice.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:26:12'),
(1117, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:26:22'),
(1118, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:28:25'),
(1119, '/dashboard/createservice', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:28:33'),
(1120, '/dashboard/createservice', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:41:19'),
(1121, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:41:33'),
(1122, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:42:43'),
(1123, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:20'),
(1124, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:31'),
(1125, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:40'),
(1126, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:45'),
(1127, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:50'),
(1128, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:43:56'),
(1129, '/servicedetail.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:44:02'),
(1130, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:44:08'),
(1131, '/dashboard/createservice', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:45:02'),
(1132, '/dashboard/createservice', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:46:41'),
(1133, '/dashboard/createservice', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:48:22'),
(1134, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:48:47'),
(1135, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:49:08'),
(1136, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:50:12'),
(1137, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:50:38'),
(1138, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:51:19'),
(1139, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:51:49'),
(1140, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:52:10'),
(1141, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:52:17'),
(1142, '/servicedetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:54:02'),
(1143, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:54:53'),
(1144, '/dashboard/editservice.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:55:25'),
(1145, '/servicedetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-06 14:55:58'),
(1146, '/', '134.199.84.144', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-03-06 17:20:33'),
(1147, '/', '173.252.107.115', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-06 17:43:55'),
(1148, '/', '31.13.127.60', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Clonee, Leinster, Ireland', '2026-03-06 17:46:32'),
(1149, '/', '66.249.89.168', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-06 19:18:35'),
(1150, '/careers', '57.141.20.25', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-06 22:35:55'),
(1151, '/servicedetail.php?id=12', '57.141.20.17', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-06 22:53:18'),
(1152, '/careers', '17.241.219.99', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-06 23:35:34'),
(1153, '/contact', '17.246.19.73', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-07 00:04:58'),
(1154, '/', '91.98.176.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-03-07 02:44:09'),
(1155, '/', '3.139.242.79', 'visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'Desktop', 'Hilliard, Ohio, United States', '2026-03-07 05:54:53'),
(1156, '/', '192.71.126.53', 'Mozilla/5.0 (Linux; Android 12; SAMSUNG SM-A415F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/23.0 Chrome/115.0.0.0 Mobile Safari/537.3', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-07 06:19:14'),
(1157, '/', '159.69.136.106', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Mobile/15E148 Safari/604.1', 'Mobile', 'Falkenstein, Saxony, Germany', '2026-03-07 13:58:18'),
(1158, '/', '162.120.188.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-03-07 15:03:18'),
(1159, '/portfolio', '162.120.188.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-03-07 15:03:19'),
(1160, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-07 15:22:25'),
(1161, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-07 15:22:49'),
(1162, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-07 15:22:55'),
(1163, '/', '18.207.225.24', 'Mozilla/5.0 (X11; U; FreeBSD; i386; en-US; rv:1.7) Gecko', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-07 15:43:12'),
(1164, '/', '197.248.186.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-07 16:56:15'),
(1165, '/portfolio', '102.0.11.107', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-07 17:00:05'),
(1166, '/services', '102.0.11.107', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-07 17:01:38'),
(1167, '/services', '102.0.11.107', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-07 17:01:39'),
(1168, '/', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:16'),
(1169, '/servicedetail.php?id=10', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:24'),
(1170, '/contact', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:29'),
(1171, '/portdetail.php?id=3', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:32'),
(1172, '/portdetail.php?id=10', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:35'),
(1173, '/terms', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:37'),
(1174, '/privacy', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:38'),
(1175, '/portfolio', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:39'),
(1176, '/portdetail.php?id=6', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:42'),
(1177, '/portdetail.php?id=5', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:43'),
(1178, '/portdetail.php?id=8', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:47'),
(1179, '/portdetail.php?id=9', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:47'),
(1180, '/careers', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:48'),
(1181, '/servicedetail.php?id=11', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:50'),
(1182, '/servicedetail.php?id=12', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:50'),
(1183, '/cookie', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:34:51'),
(1184, '/jobdetail.php?id=1', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:35:05'),
(1185, '/careers', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-07 17:35:17'),
(1186, '/servicedetail.php?id=11', '43.143.181.57', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-07 19:11:50'),
(1187, '/servicedetail.php?id=9', '111.119.202.108', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-07 20:51:02'),
(1188, '/contact', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; GoogleOther)', 'Mobile', 'Mountain View, California, United States', '2026-03-07 21:20:19'),
(1189, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-07 22:02:54'),
(1190, '/portdetail.php?id=8', '121.37.108.38', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-07 22:42:12'),
(1191, '/privacy', '57.141.20.22', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-07 23:38:20'),
(1192, '/servicedetail.php?id=10', '82.156.80.149', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 00:33:07'),
(1193, '/terms', '57.141.20.3', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-08 00:41:37'),
(1194, '/careers', '57.141.20.24', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-08 00:53:22'),
(1195, '/', '54.193.126.42', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-03-08 01:01:36'),
(1196, '/', '54.193.126.42', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-03-08 01:01:36'),
(1197, '/', '54.46.46.58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Hong Kong, Hong Kong', '2026-03-08 01:26:58'),
(1198, '/blogdetail.php?id=6', '113.44.98.181', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 02:23:42'),
(1199, '/cookie', '57.141.20.52', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-08 04:08:24'),
(1200, '/blogdetail.php?id=4', '121.37.109.59', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 04:14:43'),
(1201, '/', '198.235.24.58', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-08 05:24:04'),
(1202, '/blogdetail.php?id=2', '152.136.149.155', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 06:05:20'),
(1203, '/servicedetail.php?id=5', '113.44.112.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 07:56:01'),
(1204, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-08 08:01:39'),
(1205, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-08 08:03:52'),
(1206, '/services', '66.249.76.233', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-08 09:46:06'),
(1207, '/services', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-08 09:46:06'),
(1208, '/servicedetail.php?id=4', '188.239.12.225', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-08 09:46:31'),
(1209, '/', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:04'),
(1210, '/', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:05'),
(1211, '/contact', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:06'),
(1212, '/privacy', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:08'),
(1213, '/terms', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:09'),
(1214, '/about', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:10'),
(1215, '/services', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:11'),
(1216, '/careers', '149.56.160.237', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:12'),
(1217, '/', '149.56.160.237', 'Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36', 'Mobile', 'Montreal, Quebec, Canada', '2026-03-08 10:18:15'),
(1218, '/', '149.56.150.25', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:23'),
(1219, '/', '149.56.150.25', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:29'),
(1220, '/', '149.56.150.25', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-08 10:18:31'),
(1221, '/', '192.36.109.131', 'Mozilla/5.0 (Android 14; Mobile; rv:123.0) Gecko/123.0 Firefox/123', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-08 10:32:36'),
(1222, '/', '193.186.4.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-03-08 10:57:40'),
(1223, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 10:59:23'),
(1224, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 11:06:23'),
(1225, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 11:06:28'),
(1226, '/', '34.162.230.222', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Claude-User/1.0; +Claude-User@anthropic.com)', 'Desktop', 'Columbus, Ohio, United States', '2026-03-08 11:24:54'),
(1227, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 11:35:30'),
(1228, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 11:35:33'),
(1229, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 11:35:45'),
(1230, '/servicedetail.php?id=7', '43.143.179.53', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 11:37:40'),
(1231, '/', '180.153.236.24', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-08 11:37:54'),
(1232, '/', '180.153.236.19', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-08 11:37:58'),
(1233, '/', '192.36.172.171', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-08 11:42:49'),
(1234, '/blogdetail.php?id=8', '188.239.58.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-08 13:27:50'),
(1235, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:21:07'),
(1236, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:21:32'),
(1237, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:14'),
(1238, '/dashboard/payments', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:21'),
(1239, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:29'),
(1240, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:35'),
(1241, '/dashboard/invoices.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:35'),
(1242, '/dashboard/invoices.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:40'),
(1243, '/dashboard/invoices.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:40'),
(1244, '/dashboard/payments', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:45'),
(1245, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:48'),
(1246, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:22:57'),
(1247, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:04'),
(1248, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:11'),
(1249, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:11'),
(1250, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:16'),
(1251, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:23'),
(1252, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:28'),
(1253, '/dashboard/customers.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:29'),
(1254, '/dashboard/statement', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:38'),
(1255, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:23:41'),
(1256, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:25:22'),
(1257, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-08 14:26:26'),
(1258, '/servicedetail.php?id=3', '154.8.168.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 15:19:02'),
(1259, '/portdetail.php?id=9', '121.37.99.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-08 17:09:35'),
(1260, '/', '91.231.89.123', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-08 17:19:09'),
(1261, '/', '91.231.89.22', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-08 17:26:42'),
(1262, '/', '91.231.89.124', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-08 17:28:54'),
(1263, '/', '51.254.49.100', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Roubaix, Hauts-de-France, France', '2026-03-08 18:41:46'),
(1264, '/', '159.69.136.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-03-08 20:41:58'),
(1265, '/blogdetail.php?id=2', '188.239.61.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-08 22:26:03'),
(1266, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 00:05:23'),
(1267, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 00:06:58'),
(1268, '/careers', '57.141.20.1', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-09 01:29:16'),
(1269, '/privacy', '57.141.20.6', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-09 01:44:12'),
(1270, '/blogdetail.php?id=6', '124.243.177.75', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-09 01:52:34'),
(1271, '/terms', '57.141.20.50', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-09 02:43:06'),
(1272, '/', '91.98.178.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-03-09 05:05:10'),
(1273, '/portdetail.php?id=8', '124.243.150.3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-09 05:17:50'),
(1274, '/', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:09'),
(1275, '/terms', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:11'),
(1276, '/portfolio', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:19'),
(1277, '/blog', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:21'),
(1278, '/portdetail.php?id=9', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:25'),
(1279, '/careers', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:26'),
(1280, '/portdetail.php?id=10', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:28'),
(1281, '/cookie', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:29'),
(1282, '/services', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:30'),
(1283, '/portfolio', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:34'),
(1284, '/', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:35'),
(1285, '/', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:35'),
(1286, '/about', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:40'),
(1287, '/privacy', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:40'),
(1288, '/servicedetail.php?id=10', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:43'),
(1289, '/servicedetail.php?id=12', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:43'),
(1290, '/servicedetail.php?id=11', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:44'),
(1291, '/blogdetail.php?id=7', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:46'),
(1292, '/blogdetail.php?id=5', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:47'),
(1293, '/blogdetail.php?id=8', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:47'),
(1294, '/portdetail.php?id=6', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:48'),
(1295, '/blogdetail.php?id=9', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:56'),
(1296, '/blogdetail.php?id=2', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:56'),
(1297, '/portdetail.php?id=3', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:57'),
(1298, '/blogdetail.php?id=4', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:57'),
(1299, '/jobdetail.php?id=1', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:58'),
(1300, '/portdetail.php?id=8', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:58'),
(1301, '/blogdetail.php?id=6', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:59'),
(1302, '/portdetail.php?id=5', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:52:59'),
(1303, '/blogdetail.php?id=3', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:00'),
(1304, '/careers', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:04'),
(1305, '/servicedetail.php?id=7', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:08'),
(1306, '/servicedetail.php?id=3', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:08'),
(1307, '/servicedetail.php?id=8', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:09'),
(1308, '/servicedetail.php?id=4', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:09'),
(1309, '/servicedetail.php?id=9', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:10'),
(1310, '/servicedetail.php?id=5', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:10'),
(1311, '/contact', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:48'),
(1312, '/contact', '74.7.242.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-09 06:53:52'),
(1313, '/servicedetail.php?id=10', '17.241.227.189', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-09 07:41:03'),
(1314, '/', '199.244.88.226', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Bartlett, Illinois, United States', '2026-03-09 07:46:27'),
(1315, '/servicedetail.php?id=8', '43.143.231.169', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-09 08:43:33'),
(1316, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:24:56'),
(1317, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:20'),
(1318, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:23'),
(1319, '/about', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:28'),
(1320, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:31'),
(1321, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:36'),
(1322, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:40'),
(1323, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:31:58');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(1324, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 09:44:33'),
(1325, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:48:25'),
(1326, '/dashboard/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:48:40'),
(1327, '/dashboard/index.php', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:48:44'),
(1328, '/dashboard/settings', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:48:50'),
(1329, '/dashboard/settings', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:48:58'),
(1330, '/dashboard/sections', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:49:14'),
(1331, '/dashboard/sections', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:50:02'),
(1332, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:50:11'),
(1333, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:50:14'),
(1334, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:50:18'),
(1335, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:50:19'),
(1336, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:37'),
(1337, '/dashboard/settings', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:42'),
(1338, '/dashboard/settings', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:45'),
(1339, '/dashboard/settings', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:48'),
(1340, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:51'),
(1341, '/', '41.90.41.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 09:55:52'),
(1342, '/', '173.252.69.1', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'DeKalb, Illinois, United States', '2026-03-09 10:12:00'),
(1343, '/', '69.171.230.2', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-09 10:12:00'),
(1344, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeTi5QkJopOgEoJ4ZpGCprI8VnnUSFiqaYKkdn2TX8zNC3DQI7f1x0MmXJ04A_aem_1XUd2SsHmGsS_HUC1fBapg', '173.252.127.35', 'Instagram 418.0.0.51.77 Android (36/16; 420dpi; 1080x2340; samsung; SM-A165F; a16; mt6789; en_ZA; 891072599)', 'Mobile', 'Forest City, North Carolina, United States', '2026-03-09 10:12:01'),
(1345, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeTi5QkJopOgEoJ4ZpGCprI8VnnUSFiqaYKkdn2TX8zNC3DQI7f1x0MmXJ04A_aem_1XUd2SsHmGsS_HUC1fBapg', '69.171.231.22', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Eagle Mountain, Utah, United States', '2026-03-09 10:12:41'),
(1346, '/', '205.210.31.54', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-09 10:29:27'),
(1347, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-09 10:41:21'),
(1348, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 10:41:41'),
(1349, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 10:41:48'),
(1350, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 10:42:14'),
(1351, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 10:42:24'),
(1352, '/terms', '1.92.205.90', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-09 12:09:51'),
(1353, '/', '154.30.105.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-09 12:44:27'),
(1354, '/', '91.231.89.37', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-09 14:28:54'),
(1355, '/', '116.203.103.191', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Nuremberg, Bavaria, Germany', '2026-03-09 14:53:12'),
(1356, '/', '167.94.138.204', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'Ann Arbor, Michigan, United States', '2026-03-09 15:07:01'),
(1357, '/about', '101.44.163.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Singapore, Singapore', '2026-03-09 15:34:43'),
(1358, '/', '162.120.188.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-09 15:49:20'),
(1359, '/servicedetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:03'),
(1360, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:11'),
(1361, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:19'),
(1362, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:27'),
(1363, '/portdetail.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:35'),
(1364, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:50:43'),
(1365, '/contact', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:51:10'),
(1366, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:51:15'),
(1367, '/careers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:51:24'),
(1368, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:52:52'),
(1369, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-09 15:52:59'),
(1370, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 16:34:26'),
(1371, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 16:36:46'),
(1372, '/contact', '82.157.39.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47', 'Desktop', 'Beijing, Beijing, China', '2026-03-09 19:07:24'),
(1373, '/', '184.32.87.144', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Desktop', 'Boardman, Oregon, United States', '2026-03-09 22:13:55'),
(1374, '/', '54.174.58.249', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-09 22:28:12'),
(1375, '/', '66.249.76.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-09 23:29:32'),
(1376, '/cookie', '57.141.20.32', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-09 23:29:32'),
(1377, '/about', '17.22.253.245', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-09 23:31:57'),
(1378, '/', '66.249.76.232', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 02:10:38'),
(1379, '/', '216.157.41.68', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-10 03:07:22'),
(1380, '/', '18.193.15.23', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-10 03:13:25'),
(1381, '/', '216.157.40.84', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-10 04:32:22'),
(1382, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-10 08:04:24'),
(1383, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-10 08:07:02'),
(1384, '/', '198.235.24.151', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-10 09:59:58'),
(1385, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 10:09:04'),
(1386, '/', '34.162.230.222', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Claude-User/1.0; +Claude-User@anthropic.com)', 'Desktop', 'Columbus, Ohio, United States', '2026-03-10 10:37:41'),
(1387, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:01:05'),
(1388, '/', '162.120.187.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-03-10 11:15:37'),
(1389, '/services', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:17:07'),
(1390, '/about', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:17:11'),
(1391, '/careers', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:17:32'),
(1392, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:17:42'),
(1393, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:22:31'),
(1394, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:09'),
(1395, '/services', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:15'),
(1396, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:27'),
(1397, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:35'),
(1398, '/servicedetail.php?id=8', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:30:37'),
(1399, '/servicedetail.php?id=8', '66.249.83.103', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:30:38'),
(1400, '/servicedetail.php?id=8', '66.249.83.130', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:30:38'),
(1401, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:39'),
(1402, '/servicedetail.php?id=9', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:30:41'),
(1403, '/servicedetail.php?id=9', '66.249.83.104', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:30:42'),
(1404, '/servicedetail.php?id=9', '66.249.83.129', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:30:42'),
(1405, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:45'),
(1406, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:49'),
(1407, '/servicedetail.php?id=11', '66.249.93.167', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:30:51'),
(1408, '/servicedetail.php?id=11', '66.249.83.129', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:30:52'),
(1409, '/servicedetail.php?id=11', '66.249.83.131', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:30:52'),
(1410, '/servicedetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:52'),
(1411, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:55'),
(1412, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:30:58'),
(1413, '/servicedetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:31:00'),
(1414, '/servicedetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:31:02'),
(1415, '/servicedetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:31:05'),
(1416, '/servicedetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-10 11:31:07'),
(1417, '/servicedetail.php?id=5', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:31:09'),
(1418, '/servicedetail.php?id=5', '66.249.83.129', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-10 11:31:10'),
(1419, '/servicedetail.php?id=5', '66.249.83.130', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 11:31:10'),
(1420, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 13:31:09'),
(1421, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-10 14:01:00'),
(1422, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 14:12:51'),
(1423, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 14:12:57'),
(1424, '/portdetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 14:31:08'),
(1425, '/', '216.157.42.78', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-10 14:45:24'),
(1426, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 16:03:06'),
(1427, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 16:03:12'),
(1428, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 16:03:47'),
(1429, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 16:04:45'),
(1430, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-10 16:04:45'),
(1431, '/servicedetail.php?id=12', '116.204.15.52', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-10 20:13:41'),
(1432, '/', '74.7.243.210', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:45:52'),
(1433, '/', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:45:53'),
(1434, '/portfolio', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:45:58'),
(1435, '/servicedetail.php?id=12', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:03'),
(1436, '/', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:09'),
(1437, '/contact', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:11'),
(1438, '/blog', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:14'),
(1439, '/portfolio', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:17'),
(1440, '/', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:18'),
(1441, '/services', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:19'),
(1442, '/terms', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:19'),
(1443, '/careers', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:20'),
(1444, '/cookie', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:20'),
(1445, '/privacy', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:21'),
(1446, '/servicedetail.php?id=11', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:24'),
(1447, '/servicedetail.php?id=10', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:25'),
(1448, '/portdetail.php?id=10', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:27'),
(1449, '/portdetail.php?id=9', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:28'),
(1450, '/blogdetail.php?id=2', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:29'),
(1451, '/jobdetail.php?id=1', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:29'),
(1452, '/blogdetail.php?id=9', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:32'),
(1453, '/careers', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:36'),
(1454, '/blogdetail.php?id=4', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:36'),
(1455, '/portdetail.php?id=6', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:37'),
(1456, '/blogdetail.php?id=5', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:37'),
(1457, '/blogdetail.php?id=8', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:38'),
(1458, '/blogdetail.php?id=7', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:39'),
(1459, '/portdetail.php?id=3', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:39'),
(1460, '/blogdetail.php?id=3', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:40'),
(1461, '/portdetail.php?id=5', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:40'),
(1462, '/blogdetail.php?id=6', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:41'),
(1463, '/portdetail.php?id=8', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:41'),
(1464, '/servicedetail.php?id=5', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:48'),
(1465, '/servicedetail.php?id=8', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:49'),
(1466, '/servicedetail.php?id=9', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:49'),
(1467, '/servicedetail.php?id=7', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:50'),
(1468, '/servicedetail.php?id=4', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:50'),
(1469, '/servicedetail.php?id=3', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:46:51'),
(1470, '/contact', '74.7.227.148', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-03-11 02:47:25'),
(1471, '/portdetail.php?id=10', '43.143.174.140', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-11 03:03:02'),
(1472, '/privacy', '57.141.20.19', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-11 03:19:24'),
(1473, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-11 04:40:06'),
(1474, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.116 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-11 04:40:36'),
(1475, '/careers', '57.141.20.46', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-11 05:07:51'),
(1476, '/', '93.158.90.71', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-11 05:36:52'),
(1477, '/', '15.204.182.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-03-11 06:20:57'),
(1478, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:17:31'),
(1479, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:30:09'),
(1480, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:30:17'),
(1481, '/servicedetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:30:28'),
(1482, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:30:47'),
(1483, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:30:58'),
(1484, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:31:07'),
(1485, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:31:39'),
(1486, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:31:48'),
(1487, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:32:26'),
(1488, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:32:44'),
(1489, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:32:49'),
(1490, '/dashboard/jobs', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:33:40'),
(1491, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 20:33:55'),
(1492, '/', '123.182.48.158', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-03-17 20:47:03'),
(1493, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:01:13'),
(1494, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:01:27'),
(1495, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:01:38'),
(1496, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:01:48'),
(1497, '/dashboard/static', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:01:51'),
(1498, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:00'),
(1499, '/dashboard/edit-slider.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:05'),
(1500, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:09'),
(1501, '/dashboard/edit-slider.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:13'),
(1502, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:17'),
(1503, '/dashboard/edit-slider.php?id=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:21'),
(1504, '/dashboard/slider', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:23'),
(1505, '/dashboard/static', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:02:28'),
(1506, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:03:26'),
(1507, '/careers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:03:59'),
(1508, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 21:04:18'),
(1509, '/', '54.174.58.249', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-17 21:19:04'),
(1510, '/', '192.36.173.21', 'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.6099.280 Mobile Safari/537.36 OPR/80.4.4244.7786', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-17 21:34:45'),
(1511, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 23:07:40'),
(1512, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-17 23:07:50'),
(1513, '/', '34.70.107.246', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-17 23:34:14'),
(1514, '/', '34.70.107.246', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-17 23:34:14'),
(1515, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-17 23:58:53'),
(1516, '/', '140.250.147.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'Desktop', 'Shenzhen, Guangdong, China', '2026-03-18 01:10:05'),
(1517, '/', '18.158.189.225', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-18 02:37:07'),
(1518, '/', '35.209.68.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-18 03:59:29'),
(1519, '/', '216.157.41.78', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 04:20:09'),
(1520, '/', '216.157.40.95', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 04:26:08'),
(1521, '/', '3.127.31.193', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-18 06:18:17'),
(1522, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-18 07:28:36'),
(1523, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-18 07:30:13'),
(1524, '/', '216.157.40.85', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 07:38:11'),
(1525, '/', '216.157.41.67', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 07:48:45'),
(1526, '/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:19:45'),
(1527, '/dashboard/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:20:09'),
(1528, '/dashboard/index.php', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:20:29'),
(1529, '/dashboard/backup.php', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:20:36'),
(1530, '/dashboard/backup.php', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:20:49'),
(1531, '/dashboard/settings', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:21:32'),
(1532, '/dashboard/settings', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:21:44'),
(1533, '/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:21:54'),
(1534, '/services', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:21:59'),
(1535, '/services', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:22:08'),
(1536, '/about', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:22:13'),
(1537, '/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:22:16'),
(1538, '/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 10:22:30'),
(1539, '/', '216.157.42.70', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 11:18:55');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(1540, '/', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 12:31:32'),
(1541, '/careers', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 12:31:45'),
(1542, '/services', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 12:32:02'),
(1543, '/blog', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 12:32:15'),
(1544, '/dashboard/backup.php', '41.90.179.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 12:32:35'),
(1545, '/', '216.157.42.88', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-18 16:03:21'),
(1546, '/blog', '193.36.225.237', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-03-18 16:37:21'),
(1547, '/blog', '37.140.223.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-03-18 16:39:30'),
(1548, '/blogdetail.php?id=8', '37.140.223.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-03-18 16:39:51'),
(1549, '/', '41.90.177.53', 'WhatsApp/2.23.20.0', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-18 16:44:15'),
(1550, '/', '41.90.177.53', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-18 16:44:23'),
(1551, '/portfolio', '41.90.177.53', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-18 16:44:27'),
(1552, '/portdetail.php?id=10', '41.90.177.53', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-18 16:44:30'),
(1553, '/', '68.221.75.19', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Desktop', 'Madrid, Madrid, Spain', '2026-03-18 18:20:57'),
(1554, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 04:09:57'),
(1555, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 04:11:12'),
(1556, '/', '91.99.178.58', 'Go-http-client/1.1', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-03-19 05:37:56'),
(1557, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-19 08:41:31'),
(1558, '/portfolio', '162.120.188.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-19 08:41:32'),
(1559, '/', '193.186.4.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-03-19 08:41:38'),
(1560, '/portfolio', '162.120.188.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-19 08:41:40'),
(1561, '/', '173.252.107.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-19 09:48:34'),
(1562, '/', '173.252.127.5', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Forest City, North Carolina, United States', '2026-03-19 09:48:34'),
(1563, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEektSNqkKaefc2fp3ev8akAa89uMLIWjWB9q_KsJQrVdwVCTl0XrRdz6_WMzs_aem_nXQjPa0E_heopKW_QMg_lA', '31.13.127.12', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', 'Mobile', 'Clonee, Leinster, Ireland', '2026-03-19 09:48:35'),
(1564, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEektSNqkKaefc2fp3ev8akAa89uMLIWjWB9q_KsJQrVdwVCTl0XrRdz6_WMzs_aem_nXQjPa0E_heopKW_QMg_lA', '173.252.107.9', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-19 09:49:11'),
(1565, '/', '69.171.230.116', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-19 09:49:20'),
(1566, '/', '31.13.127.66', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Clonee, Leinster, Ireland', '2026-03-19 09:49:24'),
(1567, '/', '180.153.236.180', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-19 11:23:28'),
(1568, '/', '180.153.236.6', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-19 11:23:51'),
(1569, '/', '162.120.187.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-03-19 12:04:05'),
(1570, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-19 12:05:03'),
(1571, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-19 12:05:18'),
(1572, '/portdetail.php?id=9', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 12:05:20'),
(1573, '/portdetail.php?id=9', '66.249.83.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 12:05:21'),
(1574, '/portdetail.php?id=9', '66.249.83.72', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 12:05:21'),
(1575, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-19 12:05:27'),
(1576, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-19 12:05:30'),
(1577, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-19 12:05:43'),
(1578, '/', '180.153.236.95', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-19 12:20:43'),
(1579, '/', '180.153.236.155', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-19 12:21:02'),
(1580, '/servicedetail.php?id=10', '17.246.19.212', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-19 13:58:00'),
(1581, '/servicedetail.php?id=7', '1.92.218.131', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-19 14:25:12'),
(1582, '/', '100.25.162.41', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1', 'Mobile', 'Ashburn, Virginia, United States', '2026-03-19 15:22:46'),
(1583, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 17:29:07'),
(1584, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-19 17:33:32'),
(1585, '/portfolio', '72.14.201.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Mountain View, California, United States', '2026-03-19 19:40:31'),
(1586, '/', '192.71.2.56', 'Mozilla/5.0 (Linux; Android 12; SAMSUNG SM-A415F) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/23.0 Chrome/115.0.0.0 Mobile Safari/537.3', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-03-19 21:23:16'),
(1587, '/', '198.235.24.80', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-19 22:24:27'),
(1588, '/', '78.175.45.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/145.0.7632.6 Safari/537.36', 'Desktop', 'EyÃ¼psultan, Istanbul, TÃ¼rkiye', '2026-03-20 00:16:17'),
(1589, '/', '78.175.45.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/145.0.7632.6 Safari/537.36', 'Desktop', 'EyÃ¼psultan, Istanbul, TÃ¼rkiye', '2026-03-20 00:16:23'),
(1590, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-20 08:07:10'),
(1591, '/', '199.244.88.219', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Chicago, Illinois, United States', '2026-03-20 12:27:18'),
(1592, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-20 17:05:42'),
(1593, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-20 17:05:42'),
(1594, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-20 17:05:42'),
(1595, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-20 17:05:42'),
(1596, '/', '104.143.84.58', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-20 17:06:01'),
(1597, '/terms', '17.246.15.65', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-20 20:51:05'),
(1598, '/', '205.210.31.140', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-20 20:56:23'),
(1599, '/', '205.210.31.159', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-20 21:39:45'),
(1600, '/servicedetail.php?id=12', '17.22.245.70', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-20 22:49:16'),
(1601, '/dashboard/backup.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:25:26'),
(1602, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:25:34'),
(1603, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:25:41'),
(1604, '/dashboard/document-categories.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:25:51'),
(1605, '/dashboard/document-categories.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:26:09'),
(1606, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:26:13'),
(1607, '/', '105.164.105.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:19'),
(1608, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:25'),
(1609, '/dashboard/documents.php?cat=5&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:26'),
(1610, '/dashboard/documents.php?cat=1&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:36'),
(1611, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:43'),
(1612, '/dashboard/documents.php?cat=5&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:28:48'),
(1613, '/blog', '105.164.105.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:29:59'),
(1614, '/services', '105.164.105.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:30:32'),
(1615, '/services', '105.164.105.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-20 23:30:42'),
(1616, '/servicedetail.php?id=7', '17.246.19.111', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-20 23:36:33'),
(1617, '/', '106.8.137.202', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-21 01:36:06'),
(1618, '/', '183.155.32.10', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36', 'Desktop', 'Jinhua, Zhejiang, China', '2026-03-21 04:12:15'),
(1619, '/', '106.8.131.251', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Qinhuangdao, Hebei, China', '2026-03-21 05:12:05'),
(1620, '/', '192.71.2.57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-21 10:11:29'),
(1621, '/', '205.210.31.10', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-21 14:06:29'),
(1622, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-21 14:34:04'),
(1623, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-21 14:37:35'),
(1624, '/', '198.235.24.121', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-21 15:21:04'),
(1625, '/', '198.235.24.152', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-21 15:56:23'),
(1626, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-21 22:25:04'),
(1627, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-21 22:25:23'),
(1628, '/', '205.210.31.15', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-22 00:43:23'),
(1629, '/', '124.239.12.83', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-03-22 02:14:04'),
(1630, '/', '106.8.138.164', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-22 02:56:05'),
(1631, '/', '114.231.72.27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'Desktop', 'Nantong, Jiangsu, China', '2026-03-22 02:57:05'),
(1632, '/', '117.92.209.215', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.5359.95 Safari/537.36 QIHU 360SE', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-22 02:58:14'),
(1633, '/', '116.16.206.207', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Guangzhou, Guangdong, China', '2026-03-22 03:07:53'),
(1634, '/', '205.210.31.43', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-22 08:02:14'),
(1635, '/', '192.36.24.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Agency/93.8.2357.5', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-22 10:50:33'),
(1636, '/', '180.153.236.142', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-22 12:01:44'),
(1637, '/', '180.153.236.45', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-22 12:01:45'),
(1638, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-22 12:13:43'),
(1639, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-22 12:35:07'),
(1640, '/', '8.219.10.165', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-22 13:02:53'),
(1641, '/', '217.199.148.246', 'WhatsApp/2.23.20.0', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-22 13:05:02'),
(1642, '/', '154.159.246.2', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-22 13:31:02'),
(1643, '/portdetail.php?id=5', '154.159.246.2', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-22 13:32:24'),
(1644, '/', '162.120.188.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-22 13:46:56'),
(1645, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-22 13:46:57'),
(1646, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-22 13:47:22'),
(1647, '/', '180.153.236.158', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-22 14:11:49'),
(1648, '/', '180.153.236.51', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-22 14:12:17'),
(1649, '/', '198.235.24.50', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-22 15:50:42'),
(1650, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 19:06:42'),
(1651, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 19:06:42'),
(1652, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 19:06:42'),
(1653, '/', '104.143.84.56', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 19:06:42'),
(1654, '/', '82.165.74.190', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-22 19:22:16'),
(1655, '/', '104.143.84.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 20:29:46'),
(1656, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-22 22:18:22'),
(1657, '/', '104.143.84.58', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 22:52:11'),
(1658, '/', '104.143.84.58', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 22:52:11'),
(1659, '/', '104.143.84.58', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 22:52:11'),
(1660, '/', '104.143.84.58', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 22:52:12'),
(1661, '/', '104.143.84.8', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-22 22:52:28'),
(1662, '/', '42.239.182.93', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhengzhou, Henan, China', '2026-03-23 00:29:27'),
(1663, '/', '198.235.24.12', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-23 04:31:51'),
(1664, '/', '34.215.124.43', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'Desktop', 'Boardman, Oregon, United States', '2026-03-23 07:13:50'),
(1665, '/', '159.203.34.151', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Toronto, Ontario, Canada', '2026-03-23 09:54:23'),
(1666, '/', '162.120.188.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-23 10:14:54'),
(1667, '/dashboard/', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:15:04'),
(1668, '/dashboard/index.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:15:07'),
(1669, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:15:10'),
(1670, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:18:38'),
(1671, '/', '198.235.24.16', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-23 10:29:55'),
(1672, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:44:22'),
(1673, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:45:47'),
(1674, '/dashboard/document-categories.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:46:09'),
(1675, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:46:14'),
(1676, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:47:35'),
(1677, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:47:45'),
(1678, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:54:06'),
(1679, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:54:06'),
(1680, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 10:54:23'),
(1681, '/', '54.174.58.242', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-23 10:56:24'),
(1682, '/', '54.174.58.252', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-23 10:56:24'),
(1683, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 11:12:22'),
(1684, '/', '41.90.172.254', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/146.0.7680.151 Mobile/15E148 Safari/604.1', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-23 11:41:56'),
(1685, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-23 12:10:56'),
(1686, '/dashboard/', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:02'),
(1687, '/dashboard/index.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:05'),
(1688, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:07'),
(1689, '/dashboard/documents.php?view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:10'),
(1690, '/dashboard/documents.php?view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:12'),
(1691, '/dashboard/documents.php?view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:11:14'),
(1692, '/dashboard/documents.php?view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:22:52'),
(1693, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:23:06'),
(1694, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:23:12'),
(1695, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:23:12'),
(1696, '/', '173.252.107.115', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-23 12:23:36'),
(1697, '/', '69.171.249.1', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-23 12:23:37'),
(1698, '/', '69.171.249.3', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-23 12:23:37'),
(1699, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEepQp23Bx-ZByLYp_O6LHzEjAHscFsPY5AVLpFgJmaRH0p3sgKFh8BM6_s1XY_aem_SC5toURS-M7eTEEU1zhgDg', '31.13.127.39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'Clonee, Leinster, Ireland', '2026-03-23 12:23:43'),
(1700, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeIvuUkFhLjnsDn_wB7eSGK0aC9GBudFKOUiIaukqLARrU7d9HhUpKnc3oqnY_aem_bZdqi3wE_JrNV0q0EDPEfw', '173.252.87.59', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101 Firefox/59.0', 'Desktop', 'Fort Worth, Texas, United States', '2026-03-23 12:23:43'),
(1701, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebcrd-7jasi7NUjg9LtHeW6ZSuR8wmmOLySBvjMSAm7ZzlP0jWw221byToWs_aem_CSLyKQcb7mse-2T9WiJpbQ', '66.220.149.36', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101 Firefox/59.0', 'Desktop', 'Prineville, Oregon, United States', '2026-03-23 12:23:43'),
(1702, '/', '173.252.69.17', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'DeKalb, Illinois, United States', '2026-03-23 12:23:45'),
(1703, '/', '69.171.230.115', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:23:47'),
(1704, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEei535wkM64AJ3a56G_NJTluv6san8tKzvykdxbPPnuiVNM_ZEgRyFDQMOPvw_aem_yk3ClH2kzp7DXDNHTNDdDg', '66.220.149.17', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:53'),
(1705, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEezN4c0qfHYU0mr2b5QMi9Y3E4X9is78BlojczIKfG9pwS_u1-ODcUbKa9JNg_aem_DOJ9gZTg04GdZdJ1FATTJQ', '66.220.149.13', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:53'),
(1706, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeheDRK-On90UEeRv9C3LJcpJvL-5HapXKNLdEbWa7XTfSvd849KdYsLl5O7A_aem_ilvbGeNJuFXgRUPibkeXJw', '173.252.127.27', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:53'),
(1707, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe-lpogQMHhuVHtEcl2qzfTgxoB80UkVxq0_D9AT_FWIcF2_U-Y5h6Jyei9QI_aem_cey-8Izu9lCiZKAxwPRmpQ', '66.220.149.30', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:53'),
(1708, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebfwWLJCuBnFQ9A0aLx1lqojf8X5kMgySxMdNiyHg2h6OkL51-E0h97HR0Lo_aem_85KP9r-cMGm9PuSbVzrKyA', '173.252.95.10', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:53'),
(1709, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEetej7XCee8LfzM3Qh6hF567E5QyJXLg3q90WaSKHTm7VK_hrgI61BrIjFRP0_aem_bY3SiPxM_mtPp0ywnA9fSg', '173.252.87.10', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Lookup failed', '2026-03-23 12:23:57'),
(1710, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEepQp23Bx-ZByLYp_O6LHzEjAHscFsPY5AVLpFgJmaRH0p3sgKFh8BM6_s1XY_aem_SC5toURS-M7eTEEU1zhgDg', '173.252.69.112', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:18'),
(1711, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebcrd-7jasi7NUjg9LtHeW6ZSuR8wmmOLySBvjMSAm7ZzlP0jWw221byToWs_aem_CSLyKQcb7mse-2T9WiJpbQ', '173.252.95.19', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:20'),
(1712, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEebfwWLJCuBnFQ9A0aLx1lqojf8X5kMgySxMdNiyHg2h6OkL51-E0h97HR0Lo_aem_85KP9r-cMGm9PuSbVzrKyA', '173.252.83.9', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Springfield, Nebraska, United States', '2026-03-23 12:24:28'),
(1713, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeheDRK-On90UEeRv9C3LJcpJvL-5HapXKNLdEbWa7XTfSvd849KdYsLl5O7A_aem_ilvbGeNJuFXgRUPibkeXJw', '69.63.184.14', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:31'),
(1714, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEei535wkM64AJ3a56G_NJTluv6san8tKzvykdxbPPnuiVNM_ZEgRyFDQMOPvw_aem_yk3ClH2kzp7DXDNHTNDdDg', '69.171.234.40', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:31'),
(1715, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEe-lpogQMHhuVHtEcl2qzfTgxoB80UkVxq0_D9AT_FWIcF2_U-Y5h6Jyei9QI_aem_cey-8Izu9lCiZKAxwPRmpQ', '69.63.184.43', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:31'),
(1716, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEezN4c0qfHYU0mr2b5QMi9Y3E4X9is78BlojczIKfG9pwS_u1-ODcUbKa9JNg_aem_DOJ9gZTg04GdZdJ1FATTJQ', '173.252.95.115', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:31'),
(1717, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEetej7XCee8LfzM3Qh6hF567E5QyJXLg3q90WaSKHTm7VK_hrgI61BrIjFRP0_aem_bY3SiPxM_mtPp0ywnA9fSg', '173.252.83.7', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-23 12:24:35'),
(1718, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:36:27'),
(1719, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:36:29'),
(1720, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:36:37'),
(1721, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:36:37'),
(1722, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:36:46'),
(1723, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:37:23'),
(1724, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:37:23'),
(1725, '/dashboard/documents.php?cat=5&view=list', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:37:37'),
(1726, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:38:37'),
(1727, '/dashboard/documents.php?cat=1&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:38:52'),
(1728, '/dashboard/documents.php?cat=1&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:38:52'),
(1729, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:38:57'),
(1730, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:39:10'),
(1731, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 12:39:10'),
(1732, '/', '98.84.1.175', 'RecordedFuture Global Inventory Crawler', 'Desktop', 'Lookup failed', '2026-03-23 12:48:38'),
(1733, '/', '5.133.192.133', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-03-23 13:20:52'),
(1734, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-23 13:28:19'),
(1735, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 13:28:58'),
(1736, '/', '31.13.103.112', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Odense, South Denmark, Denmark', '2026-03-23 13:55:28'),
(1737, '/', '31.13.115.115', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'LuleÃ¥, Norrbotten County, Sweden', '2026-03-23 13:55:29'),
(1738, '/', '69.63.184.5', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Social Circle, Georgia, United States', '2026-03-23 13:55:56'),
(1739, '/', '198.235.24.34', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-23 16:21:09'),
(1740, '/dashboard/', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:47:52'),
(1741, '/dashboard/index.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:47:54'),
(1742, '/dashboard/documents.php', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:47:57'),
(1743, '/dashboard/documents.php?cat=1&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:47:59'),
(1744, '/dashboard/documents.php?cat=1&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:48:41'),
(1745, '/dashboard/documents.php?cat=1&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:48:42'),
(1746, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:48:55'),
(1747, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:49:38'),
(1748, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 16:49:38');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(1749, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 17:01:01'),
(1750, '/dashboard/documents.php?cat=5&view=grid', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 17:04:27'),
(1751, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-23 19:48:05'),
(1752, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.7632.159 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-23 19:50:51'),
(1753, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 22:36:39'),
(1754, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 22:36:49'),
(1755, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 22:36:54'),
(1756, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 22:36:57'),
(1757, '/', '147.185.132.195', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-23 22:54:16'),
(1758, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 22:59:46'),
(1759, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 23:00:04'),
(1760, '/', '162.120.188.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-03-23 23:01:05'),
(1761, '/servicedetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 23:01:21'),
(1762, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-23 23:03:08'),
(1763, '/services', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 00:35:39'),
(1764, '/', '52.230.163.43', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Desktop', 'Des Moines, Iowa, United States', '2026-03-24 00:36:28'),
(1765, '/careers', '57.141.20.8', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-24 02:16:14'),
(1766, '/cookie', '57.141.20.42', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-24 03:47:39'),
(1767, '/', '198.235.24.37', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-24 07:42:34'),
(1768, '/', '162.120.188.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-03-24 08:23:14'),
(1769, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-24 08:23:30'),
(1770, '/', '72.14.201.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Mountain View, California, United States', '2026-03-24 08:23:53'),
(1771, '/', '193.186.4.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'London, England, United Kingdom', '2026-03-24 08:24:40'),
(1772, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 08:35:51'),
(1773, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 08:35:56'),
(1774, '/dashboard/index.php?rv_page=2&jv_page=1&rv_limit=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 08:36:09'),
(1775, '/', '197.232.68.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 08:42:52'),
(1776, '/dashboard/index.php?rv_page=2&jv_page=1&rv_limit=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 09:47:08'),
(1777, '/', '69.171.249.113', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-24 11:11:44'),
(1778, '/', '66.220.149.34', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-24 11:11:44'),
(1779, '/', '173.252.107.116', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-03-24 11:11:44'),
(1780, '/', '69.171.231.7', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-24 11:11:44'),
(1781, '/', '69.171.234.2', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-24 11:11:45'),
(1782, '/', '173.252.70.50', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-24 11:11:45'),
(1783, '/', '31.13.115.1', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-24 11:11:45'),
(1784, '/', '31.13.103.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-24 11:11:46'),
(1785, '/', '192.36.109.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Desktop', 'Lookup failed', '2026-03-24 11:17:14'),
(1786, '/', '197.232.68.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:15:24'),
(1787, '/', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:43:51'),
(1788, '/portdetail.php?id=10', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:44:53'),
(1789, '/portfolio', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:47:31'),
(1790, '/portdetail.php?id=5', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:47:35'),
(1791, '/portdetail.php?id=6', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:47:45'),
(1792, '/', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:47:49'),
(1793, '/portdetail.php?id=9', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:47:56'),
(1794, '/dashboard/editport.php?id=9', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:48:17'),
(1795, '/portfolio', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:48:44'),
(1796, '/portdetail.php?id=8', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 12:48:49'),
(1797, '/', '198.235.24.183', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-24 13:11:06'),
(1798, '/', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 15:07:53'),
(1799, '/portdetail.php?id=6', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 15:08:30'),
(1800, '/', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-24 15:08:45'),
(1801, '/', '161.115.235.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30', 'Desktop', 'Los Angeles, California, United States', '2026-03-24 15:45:30'),
(1802, '/about', '161.115.234.161', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30', 'Desktop', 'Los Angeles, California, United States', '2026-03-24 15:45:41'),
(1803, '/contact', '161.115.234.219', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30', 'Desktop', 'Los Angeles, California, United States', '2026-03-24 15:46:10'),
(1804, '/', '54.174.58.226', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-24 15:47:10'),
(1805, '/', '205.210.31.41', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-24 16:15:30'),
(1806, '/jobdetail.php?id=1', '17.22.237.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-24 17:10:01'),
(1807, '/', '54.174.58.252', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-24 21:03:51'),
(1808, '/', '45.94.31.99', '', 'Desktop', 'Lelystad, Flevoland, The Netherlands', '2026-03-25 01:35:32'),
(1809, '/privacy', '57.141.0.66', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-25 05:18:44'),
(1810, '/terms', '57.141.0.10', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-25 06:01:00'),
(1811, '/cookie', '57.141.0.67', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-25 06:38:58'),
(1812, '/careers', '57.141.0.66', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-25 06:57:58'),
(1813, '/', '216.157.40.81', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-25 07:40:24'),
(1814, '/', '34.207.230.175', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-25 07:59:46'),
(1815, '/cookie', '116.204.117.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-25 08:23:08'),
(1816, '/contact', '101.42.26.150', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-25 08:33:29'),
(1817, '/', '62.141.44.236', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'Desktop', 'Dusseldorf, North Rhine-Westphalia, Germany', '2026-03-25 08:43:47'),
(1818, '/', '196.97.0.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-25 08:56:30'),
(1819, '/', '196.97.0.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-25 08:59:26'),
(1820, '/portfolio', '196.97.0.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-25 08:59:33'),
(1821, '/portdetail.php?id=10', '196.97.0.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-25 08:59:36'),
(1822, '/', '72.14.201.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Mountain View, California, United States', '2026-03-25 09:40:01'),
(1823, '/services', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-25 09:41:00'),
(1824, '/servicedetail.php?id=10', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-25 09:41:11'),
(1825, '/portfolio', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-25 09:41:27'),
(1826, '/portdetail.php?id=3', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-25 09:42:56'),
(1827, '/portdetail.php?id=5', '41.90.186.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-25 09:43:01'),
(1828, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-25 09:50:25'),
(1829, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-25 09:55:58'),
(1830, '/', '18.193.15.23', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-25 12:13:56'),
(1831, '/', '216.157.41.87', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-25 12:16:58'),
(1832, '/', '87.236.176.230', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Leeds, England, United Kingdom', '2026-03-25 13:46:04'),
(1833, '/', '123.183.235.222', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Chengde, Hebei, China', '2026-03-25 15:20:04'),
(1834, '/terms', '17.241.219.81', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-25 15:44:13'),
(1835, '/', '104.143.84.8', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-25 18:29:18'),
(1836, '/', '104.143.84.8', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-25 18:29:18'),
(1837, '/', '104.143.84.8', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-25 18:29:18'),
(1838, '/', '104.143.84.8', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Salt Lake City, Utah, United States', '2026-03-25 18:29:18'),
(1839, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-25 18:51:49'),
(1840, '/', '66.249.64.102', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-25 18:52:39'),
(1841, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-25 18:52:39'),
(1842, '/', '3.127.31.193', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-25 19:40:06'),
(1843, '/', '216.157.41.68', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-25 19:56:37'),
(1844, '/', '216.157.40.95', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-25 23:14:35'),
(1845, '/cookie', '166.108.235.125', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-26 01:06:28'),
(1846, '/', '114.218.58.23', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.5359.95 Safari/537.36 QIHU 360SE', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-26 02:50:08'),
(1847, '/blogdetail.php?id=8', '17.22.253.45', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-26 02:51:09'),
(1848, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 02:55:35'),
(1849, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 02:55:35'),
(1850, '/', '114.106.134.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'Desktop', 'Hefei, Anhui, China', '2026-03-26 03:27:06'),
(1851, '/', '216.157.42.86', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-03-26 05:27:46'),
(1852, '/cookie', '57.141.20.46', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-26 06:43:46'),
(1853, '/about', '166.108.230.57', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-26 07:04:05'),
(1854, '/privacy', '57.141.20.16', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-26 07:20:43'),
(1855, '/careers', '57.141.20.26', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-26 07:45:01'),
(1856, '/terms', '57.141.20.28', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-26 08:04:46'),
(1857, '/', '66.249.64.103', 'GoogleOther', 'Desktop', 'Mountain View, California, United States', '2026-03-26 08:37:05'),
(1858, '/', '66.249.64.102', 'GoogleOther', 'Desktop', 'Mountain View, California, United States', '2026-03-26 10:19:07'),
(1859, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 11:15:34'),
(1860, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 11:38:58'),
(1861, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:49:31'),
(1862, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:50:13'),
(1863, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:54:44'),
(1864, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:54:53'),
(1865, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:55:10'),
(1866, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:57:43'),
(1867, '/dashboard/customers.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 11:57:43'),
(1868, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:02:24'),
(1869, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:03:24'),
(1870, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:03:24'),
(1871, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:04:02'),
(1872, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:04:03'),
(1873, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:05:04'),
(1874, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:05:04'),
(1875, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:05:44'),
(1876, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:05:44'),
(1877, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:06:17'),
(1878, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:06:18'),
(1879, '/', '34.90.199.112', 'Scrapy/2.13.4 (+https://scrapy.org)', 'Desktop', 'Groningen, Groningen, The Netherlands', '2026-03-26 12:06:18'),
(1880, '/dashboard/payments.php?invoice_id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:06:51'),
(1881, '/dashboard/payments.php?invoice_id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:12'),
(1882, '/dashboard/payments.php?invoice_id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:13'),
(1883, '/dashboard/payments', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:31'),
(1884, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:35'),
(1885, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:54'),
(1886, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:08:54'),
(1887, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:09:03'),
(1888, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:09:03'),
(1889, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:10:05'),
(1890, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:10:06'),
(1891, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:11:38'),
(1892, '/dashboard/expenses.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:11:38'),
(1893, '/dashboard/statement', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:11:50'),
(1894, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:12:08'),
(1895, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:12:11'),
(1896, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:12:52'),
(1897, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:12:52'),
(1898, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:15:15'),
(1899, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:15:19'),
(1900, '/dashboard/index.php', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 12:15:21'),
(1901, '/dashboard/index.php', '66.249.83.72', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 12:15:22'),
(1902, '/dashboard/index.php', '66.249.83.71', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 12:15:22'),
(1903, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:15:28'),
(1904, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 12:15:31'),
(1905, '/dashboard/invoice-view.php?id=3', '66.249.93.167', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-26 12:15:33'),
(1906, '/dashboard/invoice-view.php?id=3', '66.249.83.71', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 12:15:34'),
(1907, '/dashboard/invoice-view.php?id=3', '66.249.83.72', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 12:15:34'),
(1908, '/contact', '101.46.1.99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-26 13:07:47'),
(1909, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:34'),
(1910, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:38'),
(1911, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:44'),
(1912, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:54'),
(1913, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:57'),
(1914, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:07:58'),
(1915, '/', '106.8.138.218', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-26 14:08:03'),
(1916, '/', '124.239.12.248', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-03-26 14:08:16'),
(1917, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:08:36'),
(1918, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:08:40'),
(1919, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:08:44'),
(1920, '/dashboard/invoices', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-03-26 14:08:46'),
(1921, '/dashboard/invoices', '66.249.83.131', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-26 14:08:46'),
(1922, '/dashboard/invoices', '66.249.83.104', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-03-26 14:08:47'),
(1923, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:08:49'),
(1924, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:18:31'),
(1925, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:19:02'),
(1926, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:19:25'),
(1927, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:19:25'),
(1928, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:20:22'),
(1929, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:20:26'),
(1930, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 14:20:28'),
(1931, '/', '216.157.42.72', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-03-26 15:22:48'),
(1932, '/', '167.71.52.60', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-26 18:06:42'),
(1933, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 18:17:06'),
(1934, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 18:17:12'),
(1935, '/dashboard/backup.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 18:17:27'),
(1936, '/dashboard/backup.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 18:17:40'),
(1937, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 18:18:08'),
(1938, '/dashboard/documents.php?cat=2&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-26 19:11:36'),
(1939, '/blogdetail.php?id=4', '17.22.245.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-26 20:09:56'),
(1940, '/', '124.239.12.4', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-03-26 20:22:05'),
(1941, '/', '100.25.180.254', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-26 20:26:04'),
(1942, '/blogdetail.php?id=9', '17.22.237.76', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-26 23:38:04'),
(1943, '/', '91.231.89.17', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-27 03:11:23'),
(1944, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-27 03:45:07'),
(1945, '/', '116.132.236.213', 'YisouSpider', 'Desktop', 'Beijing, Beijing, China', '2026-03-27 04:03:05'),
(1946, '/', '34.107.89.180', 'node', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-27 04:06:56'),
(1947, '/', '125.125.229.122', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.5359.95 Safari/537.36 QIHU 360SE', 'Desktop', 'Shenzhencun, Shanghai, China', '2026-03-27 09:19:04'),
(1948, '/', '185.13.96.91', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Safari/605.1.1', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-27 11:46:55'),
(1949, '/', '106.8.137.32', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-27 14:00:03'),
(1950, '/', '150.255.102.122', 'Mozilla/4.049897920 Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)', 'Desktop', 'Haikou, Hainan, China', '2026-03-27 14:03:35'),
(1951, '/', '40.77.167.123', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-03-27 18:23:23'),
(1952, '/', '209.97.129.234', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-03-27 18:49:48'),
(1953, '/blogdetail.php?id=6', '111.119.216.84', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-27 19:19:11'),
(1954, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:27:53'),
(1955, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:28:22'),
(1956, '/dashboard/index.php?rv_page=1&jv_page=1&rv_limit=15', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:29:02'),
(1957, '/dashboard/index.php?rv_page=1&jv_page=1&rv_limit=25', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:29:59'),
(1958, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:30:43'),
(1959, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:31:12'),
(1960, '/blogdetail.php?id=7', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:31:25'),
(1961, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:31:48'),
(1962, '/dashboard/contact', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:40:53'),
(1963, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:40:59'),
(1964, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:41:08'),
(1965, '/dashboard/documents.php?view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:41:08'),
(1966, '/dashboard/documents.php?view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-27 19:41:18');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(1967, '/', '123.182.48.52', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-03-27 20:36:04'),
(1968, '/blog', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-27 21:28:22'),
(1969, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-27 21:36:28'),
(1970, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-27 21:38:12'),
(1971, '/', '140.250.151.167', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'Desktop', 'Shenzhen, Guangdong, China', '2026-03-28 00:21:13'),
(1972, '/', '66.249.64.108', 'GoogleBot/2.1', 'Desktop', 'Mountain View, California, United States', '2026-03-28 00:50:12'),
(1973, '/', '192.36.109.115', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-28 03:38:32'),
(1974, '/', '137.184.134.216', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'North Bergen, New Jersey, United States', '2026-03-28 04:02:07'),
(1975, '/', '123.182.51.122', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-03-28 05:03:02'),
(1976, '/', '54.174.58.241', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 05:24:05'),
(1977, '/', '18.159.199.77', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-28 05:26:03'),
(1978, '/', '216.157.41.67', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-03-28 05:26:04'),
(1979, '/', '216.157.40.69', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Portland, Oregon, United States', '2026-03-28 05:26:06'),
(1980, '/', '216.157.42.74', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-03-28 05:26:08'),
(1981, '/', '13.219.121.241', 'RecordedFuture Global Inventory Crawler', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 08:24:40'),
(1982, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-28 09:37:50'),
(1983, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-28 09:38:47'),
(1984, '/', '205.210.31.20', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-28 11:46:47'),
(1985, '/', '91.231.89.19', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-03-28 12:24:52'),
(1986, '/', '91.196.152.166', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Roubaix, Hauts-de-France, France', '2026-03-28 12:31:34'),
(1987, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-28 12:47:04'),
(1988, '/', '49.87.198.86', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-28 14:11:03'),
(1989, '/', '121.226.176.66', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-28 14:17:03'),
(1990, '/', '106.8.139.230', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-28 14:20:03'),
(1991, '/', '58.243.47.174', 'Mozilla/5.077692140 Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko', 'Desktop', 'Hefei, Anhui, China', '2026-03-28 14:21:40'),
(1992, '/', '121.237.36.31', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.27 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/601.1.27', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-28 14:30:38'),
(1993, '/servicedetail.php?id=7', '82.156.98.113', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-28 19:11:30'),
(1994, '/portfolio', '17.22.253.34', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-28 19:16:20'),
(1995, '/careers', '57.141.20.58', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-28 20:55:27'),
(1996, '/contact', '54.174.58.226', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 20:59:52'),
(1997, '/contact', '54.174.58.241', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 20:59:53'),
(1998, '/', '104.198.198.236', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-28 21:08:13'),
(1999, '/blog', '54.174.58.252', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:08:27'),
(2000, '/blog', '54.174.58.246', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:08:28'),
(2001, '/services', '54.174.58.246', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:35:47'),
(2002, '/services', '54.174.58.239', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:35:47'),
(2003, '/about', '54.174.58.226', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:35:49'),
(2004, '/about', '54.174.58.246', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:35:49'),
(2005, '/', '106.8.138.30', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-28 21:45:23'),
(2006, '/portfolio', '54.174.58.226', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:54:55'),
(2007, '/portfolio', '54.174.58.239', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; HubSpot Crawler; +https://www.hubspot.com) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 21:54:55'),
(2008, '/terms', '57.141.0.34', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-28 23:33:04'),
(2009, '/', '223.215.181.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'Desktop', 'Hefei, Anhui, China', '2026-03-29 01:44:08'),
(2010, '/', '61.143.230.254', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Guangzhou, Guangdong, China', '2026-03-29 02:28:04'),
(2011, '/', '106.8.131.121', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Qinhuangdao, Hebei, China', '2026-03-29 07:16:02'),
(2012, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-29 08:05:56'),
(2013, '/', '110.19.145.161', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhangzhou, Fujian, China', '2026-03-29 08:25:12'),
(2014, '/portdetail.php?id=10', '40.77.167.18', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-03-29 11:55:28'),
(2015, '/', '23.27.145.198', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-03-29 14:15:26'),
(2016, '/', '180.153.236.37', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 14:59:03'),
(2017, '/', '180.153.236.159', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 14:59:22'),
(2018, '/', '180.153.236.130', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 14:59:24'),
(2019, '/', '162.120.187.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-03-29 15:06:06'),
(2020, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-29 15:06:27'),
(2021, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-29 15:07:15'),
(2022, '/blog', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-03-29 15:07:21'),
(2023, '/', '124.239.12.145', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-03-29 15:51:04'),
(2024, '/', '180.153.236.173', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 18:08:18'),
(2025, '/', '180.153.236.152', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 18:08:18'),
(2026, '/', '180.153.236.62', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-03-29 18:08:25'),
(2027, '/contact', '1.92.219.56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-29 19:15:59'),
(2028, '/', '116.132.254.132', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Beijing, Beijing, China', '2026-03-29 20:31:08'),
(2029, '/contact', '62.234.21.152', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-29 21:40:15'),
(2030, '/', '54.174.58.252', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-29 22:18:16'),
(2031, '/', '18.193.15.23', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-29 22:20:15'),
(2032, '/', '216.157.41.73', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-03-29 22:20:18'),
(2033, '/', '216.157.40.76', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Portland, Oregon, United States', '2026-03-29 22:20:18'),
(2034, '/', '216.157.42.74', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-03-29 22:20:20'),
(2035, '/', '158.173.153.155', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Seattle, Washington, United States', '2026-03-29 23:13:55'),
(2036, '/', '158.173.153.155', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Seattle, Washington, United States', '2026-03-29 23:13:55'),
(2037, '/', '158.173.153.155', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Seattle, Washington, United States', '2026-03-29 23:13:55'),
(2038, '/', '158.173.153.155', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Seattle, Washington, United States', '2026-03-29 23:13:55'),
(2039, '/about', '111.119.246.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-30 00:20:59'),
(2040, '/', '198.235.24.23', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-03-30 01:11:29'),
(2041, '/servicedetail.php?id=8', '116.204.94.165', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-30 03:37:07'),
(2042, '/servicedetail.php?id=8', '116.204.28.189', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-30 03:37:45'),
(2043, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-30 04:49:28'),
(2044, '/', '66.249.76.230', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-03-30 04:49:30'),
(2045, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-30 08:06:21'),
(2046, '/servicedetail.php?id=12', '101.46.0.185', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-30 08:30:56'),
(2047, '/', '87.236.176.252', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Desktop', 'Leeds, England, United Kingdom', '2026-03-30 09:10:43'),
(2048, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-30 09:31:01'),
(2049, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-30 09:31:09'),
(2050, '/', '123.182.48.181', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-03-30 10:13:02'),
(2051, '/careers', '57.141.20.52', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-30 10:41:14'),
(2052, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 10:59:26'),
(2053, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 10:59:35'),
(2054, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:05:37'),
(2055, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:05:43'),
(2056, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:07:50'),
(2057, '/blogdetail.php?id=8', '113.44.99.134', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-30 11:09:43'),
(2058, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:27:38'),
(2059, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:27:45'),
(2060, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:28:00'),
(2061, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:33:57'),
(2062, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:34:45'),
(2063, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:35:00'),
(2064, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:36:28'),
(2065, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:36:32'),
(2066, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:36:57'),
(2067, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:39:06'),
(2068, '/', '143.110.218.144', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Toronto, Ontario, Canada', '2026-03-30 11:42:35'),
(2069, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:47:16'),
(2070, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:47:31'),
(2071, '/dashboard/createportfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:51:49'),
(2072, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:51:54'),
(2073, '/dashboard/editport.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:52:06'),
(2074, '/dashboard/editport.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:52:27'),
(2075, '/dashboard/editport.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:53:26'),
(2076, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-30 11:54:02'),
(2077, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:54:56'),
(2078, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:55:40'),
(2079, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:55:51'),
(2080, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:57:40'),
(2081, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:57:53'),
(2082, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:58:34'),
(2083, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:58:45'),
(2084, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:59:18'),
(2085, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:59:25'),
(2086, '/portdetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 11:59:41'),
(2087, '/portdetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:00:05'),
(2088, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:00:57'),
(2089, '/portdetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:01:15'),
(2090, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:01:38'),
(2091, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:02:12'),
(2092, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:02:24'),
(2093, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:02:37'),
(2094, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:03:22'),
(2095, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:03:48'),
(2096, '/dashboard/editport.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:03:59'),
(2097, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:04:19'),
(2098, '/portdetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:04:46'),
(2099, '/portdetail.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:05:15'),
(2100, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:05:30'),
(2101, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:05:53'),
(2102, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:06:03'),
(2103, '/dashboard/editport.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:06:26'),
(2104, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:06:36'),
(2105, '/portdetail.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:06:42'),
(2106, '/portdetail.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:07:06'),
(2107, '/portdetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:07:18'),
(2108, '/cookie', '57.141.20.55', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-30 12:07:42'),
(2109, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:07:48'),
(2110, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:08:01'),
(2111, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:08:41'),
(2112, '/servicedetail.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:09:07'),
(2113, '/servicedetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:09:25'),
(2114, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 12:25:26'),
(2115, '/terms', '57.141.20.27', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-30 12:41:14'),
(2116, '/', '69.171.249.6', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-30 12:45:21'),
(2117, '/', '69.63.184.10', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Social Circle, Georgia, United States', '2026-03-30 12:45:22'),
(2118, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeHRhMyHLDjMrfnBwUBmxBmuFpdjU--izge7s_eXk1HAiGY6x7paxfkzNcgXM_aem_NrUCRPVQZlx-YbpTJXL3jQ', '31.13.115.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Desktop', 'LuleÃ¥, Norrbotten County, Sweden', '2026-03-30 12:45:25'),
(2119, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeHRhMyHLDjMrfnBwUBmxBmuFpdjU--izge7s_eXk1HAiGY6x7paxfkzNcgXM_aem_NrUCRPVQZlx-YbpTJXL3jQ', '173.252.87.114', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Fort Worth, Texas, United States', '2026-03-30 12:46:19'),
(2120, '/', '69.171.230.7', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-30 13:06:13'),
(2121, '/', '69.63.189.27', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Huntsville, Alabama, United States', '2026-03-30 13:06:39'),
(2122, '/privacy', '57.141.20.23', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-30 13:16:21'),
(2123, '/servicedetail.php?id=9', '111.119.216.107', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-30 13:43:37'),
(2124, '/', '35.231.70.247', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'North Charleston, South Carolina, United States', '2026-03-30 14:16:48'),
(2125, '/', '64.227.180.111', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Bengaluru, Karnataka, India', '2026-03-30 14:22:51'),
(2126, '/', '41.90.177.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 14:38:53'),
(2127, '/portfolio', '41.90.177.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 14:39:15'),
(2128, '/portdetail.php?id=11', '41.90.177.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 14:39:22'),
(2129, '/', '23.27.145.200', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-03-30 14:50:04'),
(2130, '/', '34.23.128.235', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'North Charleston, South Carolina, United States', '2026-03-30 15:55:47'),
(2131, '/servicedetail.php?id=11', '82.157.83.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-30 16:20:42'),
(2132, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-03-30 16:35:44'),
(2133, '/', '35.202.177.57', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-30 16:40:19'),
(2134, '/', '35.202.177.57', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-03-30 16:40:19'),
(2135, '/', '41.90.177.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-30 16:42:33'),
(2136, '/', '78.159.110.69', '', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-03-30 16:49:00'),
(2137, '/', '52.76.30.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'Desktop', 'Singapore, Singapore', '2026-03-30 17:39:33'),
(2138, '/services', '49.232.169.81', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 00:05:50'),
(2139, '/contact', '116.204.90.175', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 00:08:18'),
(2140, '/', '66.249.76.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-31 00:49:52'),
(2141, '/portdetail.php?id=11', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; GoogleOther)', 'Mobile', 'Mountain View, California, United States', '2026-03-31 00:54:43'),
(2142, '/about', '121.37.105.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 01:04:04'),
(2143, '/', '116.132.236.9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Beijing, Beijing, China', '2026-03-31 02:44:07'),
(2144, '/cookie', '111.119.212.161', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-31 04:04:48'),
(2145, '/', '106.8.131.93', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-31 06:32:07'),
(2146, '/', '3.233.59.216', 'RecordedFuture Global Inventory Crawler', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-31 06:49:46'),
(2147, '/servicedetail.php?id=5', '152.136.135.48', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 07:03:50'),
(2148, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-03-31 08:06:08'),
(2149, '/', '121.225.25.139', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SE 2.X MetaSr 1.0; SE 2.X MetaSr 1.0; .NET CLR 2.0.50727; SE 2.X MetaSr 1.0)', 'Desktop', 'Nanjing, Jiangsu, China', '2026-03-31 08:14:06'),
(2150, '/portdetail.php?id=6', '82.157.1.71', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 10:06:22'),
(2151, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeX1DgmAHhfCfmg2vq8cZim6SlST0NTwwE4PnGMP0MZd15P_oS2s-ibLEXPSI_aem_rzhqGm_knGq1DYlwoz42qg', '173.252.82.11', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Springfield, Nebraska, United States', '2026-03-31 12:05:55'),
(2152, '/?fbclid=IwZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQMMjU2MjgxMDQwNTU4AAEeX1DgmAHhfCfmg2vq8cZim6SlST0NTwwE4PnGMP0MZd15P_oS2s-ibLEXPSI_aem_rzhqGm_knGq1DYlwoz42qg', '69.171.234.21', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Hillsboro, Oregon, United States', '2026-03-31 12:06:32'),
(2153, '/', '45.154.98.148', '', 'Desktop', 'Lelystad, Flevoland, The Netherlands', '2026-03-31 12:27:26'),
(2154, '/portdetail.php?id=9', '188.239.40.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-03-31 13:06:02'),
(2155, '/', '31.13.115.1', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Lookup failed', '2026-03-31 14:06:00'),
(2156, '/', '173.252.95.9', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Altoona, Iowa, United States', '2026-03-31 14:06:13'),
(2157, '/', '69.63.184.24', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Social Circle, Georgia, United States', '2026-03-31 14:32:48'),
(2158, '/', '69.171.230.112', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Prineville, Oregon, United States', '2026-03-31 14:32:56'),
(2159, '/', '23.27.145.138', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-03-31 14:51:36'),
(2160, '/servicedetail.php?id=8', '116.204.43.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-03-31 16:03:24'),
(2161, '/careers', '57.141.20.36', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-03-31 16:48:55'),
(2162, '/', '129.222.187.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-03-31 17:53:31'),
(2163, '/', '135.196.204.199', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'Desktop', 'New York, New York, United States', '2026-03-31 17:58:20'),
(2164, '/', '195.172.109.78', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-03-31 17:59:03'),
(2165, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-31 18:24:03'),
(2166, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-03-31 18:24:30'),
(2167, '/blog', '17.241.75.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-03-31 20:45:17'),
(2168, '/', '106.8.138.55', 'YisouSpider', 'Desktop', 'Qinhuangdao, Hebei, China', '2026-03-31 21:15:07'),
(2169, '/', '192.36.109.94', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-03-31 21:24:37'),
(2170, '/cookie', '101.42.49.108', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 00:17:37'),
(2171, '/servicedetail.php?id=12', '82.157.148.63', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 00:18:13'),
(2172, '/portdetail.php?id=6', '116.204.114.204', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 02:12:11'),
(2173, '/', '123.182.48.192', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-04-01 04:38:20'),
(2174, '/servicedetail.php?id=5', '1.92.213.79', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 05:22:44'),
(2175, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.164 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-01 05:38:04'),
(2176, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.164 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-01 05:39:24'),
(2177, '/', '123.182.51.91', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e YisouSpider/5.0 Safari/602.1', 'Mobile', 'Shijiazhuang, Hebei, China', '2026-04-01 05:51:02'),
(2178, '/', '171.213.191.183', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Desktop', 'Chengdu, Sichuan, China', '2026-04-01 07:30:40'),
(2179, '/', '171.213.191.183', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Desktop', 'Chengdu, Sichuan, China', '2026-04-01 07:30:40'),
(2180, '/', '171.213.191.183', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', 'Desktop', 'Chengdu, Sichuan, China', '2026-04-01 07:30:41'),
(2181, '/', '72.14.201.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Mountain View, California, United States', '2026-04-01 07:57:59'),
(2182, '/blog', '162.120.187.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-04-01 07:58:00'),
(2183, '/', '162.120.187.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-04-01 07:58:34'),
(2184, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-01 07:59:18'),
(2185, '/portdetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-01 07:59:33'),
(2186, '/', '193.186.4.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'London, England, United Kingdom', '2026-04-01 08:01:13'),
(2187, '/', '162.120.187.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-04-01 08:01:29'),
(2188, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-01 08:05:57'),
(2189, '/servicedetail.php?id=10', '116.204.125.147', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 08:44:52'),
(2190, '/portfolio', '193.23.206.166', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Orem, Utah, United States', '2026-04-01 11:22:12'),
(2191, '/portfolio', '84.37.224.190', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-01 11:23:07');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(2192, '/portfolio', '142.147.186.85', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Dallas, Texas, United States', '2026-04-01 11:29:45'),
(2193, '/', '114.106.147.171', 'Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20100101 Firefox/5.0', 'Desktop', 'Hefei, Anhui, China', '2026-04-01 11:50:22'),
(2194, '/jobdetail.php?id=1', '17.22.245.183', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-01 11:56:42'),
(2195, '/', '149.57.180.125', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'New York City, New York, United States', '2026-04-01 14:14:44'),
(2196, '/', '23.27.145.128', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-01 14:41:57'),
(2197, '/careers', '142.147.163.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Dallas, Texas, United States', '2026-04-01 15:28:45'),
(2198, '/?utm_source=ig&utm_medium=social&utm_content=link_in_bio&fbclid=PAZXh0bgNhZW0CMTEAc3J0YwZhcHBfaWQPNTY3MDY3MzQzMzUyNDI3AAGnh9YTPjW9uwb1xUSq_3tWKZuJZhYz8At4LtnvaRqCHwE-VWe6Bk3B-y89yyM_aem_IP_0WXyJnzBjfql8tGP-tw', '105.161.16.216', 'Mozilla/5.0 (Linux; Android 10; SM-G965F Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.103 Mobile Safari/537.36 Instagram 417.0.0.54.77 Android (29/10; 420dpi; 1080x2220; samsung; SM-G965F; star2lte; samsungexynos9810; en_US; 884780529; IABMV/1)', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-01 18:49:00'),
(2199, '/portdetail.php?id=11', '105.161.16.216', 'Mozilla/5.0 (Linux; Android 10; SM-G965F Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.103 Mobile Safari/537.36 Instagram 417.0.0.54.77 Android (29/10; 420dpi; 1080x2220; samsung; SM-G965F; star2lte; samsungexynos9810; en_US; 884780529; IABMV/1)', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-01 18:49:49'),
(2200, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-01 18:51:03'),
(2201, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-01 18:51:04'),
(2202, '/cookie', '101.43.135.128', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-01 19:38:38'),
(2203, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.164 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-01 21:42:16'),
(2204, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.164 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-01 21:42:52'),
(2205, '/', '116.203.103.191', 'Mozilla/5.0 (compatible; DomainAnalyzer/1.0)', 'Desktop', 'Nuremberg, Bavaria, Germany', '2026-04-01 22:06:03'),
(2206, '/portdetail.php?id=12', '142.147.218.153', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-01 22:16:21'),
(2207, '/cookie', '103.74.179.36', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'New York, New York, United States', '2026-04-01 22:16:26'),
(2208, '/portdetail.php?id=9', '68.167.134.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-01 22:16:30'),
(2209, '/terms', '45.138.249.163', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-04-01 22:18:26'),
(2210, '/', '192.36.109.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-01 23:04:17'),
(2211, '/services', '166.108.193.227', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-02 01:06:34'),
(2212, '/', '35.92.179.30', 'Mozilla/5.0 (Android 2.2; Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Mobile', 'Boardman, Oregon, United States', '2026-04-02 07:13:57'),
(2213, '/servicedetail.php?id=10', '49.233.219.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-02 07:48:34'),
(2214, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-02 09:00:00'),
(2215, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-02 09:00:27'),
(2216, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-02 09:01:38'),
(2217, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-02 09:01:41'),
(2218, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-04-02 10:37:28'),
(2219, '/', '45.38.16.204', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Desktop', 'New York City, New York, United States', '2026-04-02 11:01:24'),
(2220, '/servicedetail.php?id=9', '119.13.108.88', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-02 13:01:46'),
(2221, '/', '102.129.232.49', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-02 14:32:50'),
(2222, '/', '180.153.236.155', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-02 20:21:00'),
(2223, '/', '180.153.236.145', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-02 20:21:22'),
(2224, '/blogdetail.php?id=7', '192.144.205.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-02 21:06:44'),
(2225, '/blogdetail.php?id=3', '94.74.91.123', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-02 21:51:56'),
(2226, '/', '205.169.39.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-02 22:01:56'),
(2227, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-02 22:02:02'),
(2228, '/', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:04'),
(2229, '/terms', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:15'),
(2230, '/privacy', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:25'),
(2231, '/contact', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:34'),
(2232, '/', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:44'),
(2233, '/about', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:02:54'),
(2234, '/services', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:03:03'),
(2235, '/portfolio', '100.54.18.12', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-02 22:03:12'),
(2236, '/', '205.169.39.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-02 22:05:32'),
(2237, '/', '205.169.39.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-02 22:05:35'),
(2238, '/', '205.169.39.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-02 22:08:19'),
(2239, '/portdetail.php?id=9', '188.239.34.61', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-03 00:22:08'),
(2240, '/', '35.153.180.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-03 00:42:33'),
(2241, '/blogdetail.php?id=6', '113.44.96.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 03:07:55'),
(2242, '/blogdetail.php?id=4', '116.204.32.186', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 05:46:51'),
(2243, '/blogdetail.php?id=5', '43.138.43.162', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 08:22:50'),
(2244, '/servicedetail.php?id=7', '166.108.206.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-03 11:02:43'),
(2245, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-03 12:55:30'),
(2246, '/', '5.133.192.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-03 13:37:20'),
(2247, '/', '1.92.207.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 13:42:08'),
(2248, '/', '66.249.70.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-03 15:40:08'),
(2249, '/contact', '113.44.114.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 16:20:42'),
(2250, '/contact', '1.92.218.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-03 16:21:30'),
(2251, '/', '51.107.70.202', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Desktop', 'Zurich, Zurich, Switzerland', '2026-04-03 18:17:30'),
(2252, '/', '82.165.74.190', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-03 18:27:01'),
(2253, '/', '74.7.229.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:04'),
(2254, '/contact', '74.7.242.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:07'),
(2255, '/portdetail.php?id=6', '74.7.243.43', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:30'),
(2256, '/blog', '74.7.243.6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:31'),
(2257, '/about', '74.7.243.43', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:32'),
(2258, '/portfolio', '74.7.229.9', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:41'),
(2259, '/', '74.7.242.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:41'),
(2260, '/', '74.7.229.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:42'),
(2261, '/terms', '74.7.242.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:44'),
(2262, '/careers', '74.7.229.9', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:45'),
(2263, '/cookie', '74.7.243.43', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:45'),
(2264, '/privacy', '74.7.229.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:46'),
(2265, '/servicedetail.php?id=10', '74.7.229.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:48'),
(2266, '/servicedetail.php?id=11', '74.7.229.9', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:48'),
(2267, '/portdetail.php?id=9', '74.7.242.151', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:50'),
(2268, '/servicedetail.php?id=7', '74.7.229.9', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-03 18:28:52'),
(2269, '/', '196.96.235.205', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-03 19:04:46'),
(2270, '/', '138.246.253.7', 'quic-go-HTTP/3', 'Desktop', 'Munich, Bavaria, Germany', '2026-04-03 19:22:03'),
(2271, '/', '108.131.72.157', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-03 22:59:07'),
(2272, '/', '185.12.150.17', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/122.0.6261.89 Mobile/15E148 Safari/604', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-04-04 00:47:13'),
(2273, '/', '109.199.118.129', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.54', 'Desktop', 'Lauterbourg, Grand Est, France', '2026-04-04 01:32:48'),
(2274, '/portfolio', '52.167.144.191', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-04 01:50:31'),
(2275, '/careers', '17.22.237.74', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 02:40:29'),
(2276, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-04 04:07:38'),
(2277, '/', '34.223.82.40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-04 06:14:39'),
(2278, '/portdetail.php?id=9', '1.92.222.126', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-04 07:03:34'),
(2279, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-04 08:06:14'),
(2280, '/', '199.244.88.229', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Streamwood, Illinois, United States', '2026-04-04 09:24:04'),
(2281, '/portdetail.php?id=3', '62.234.49.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-04 13:05:34'),
(2282, '/', '102.219.208.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-04 17:22:06'),
(2283, '/servicedetail.php?id=10', '102.219.208.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-04 17:22:21'),
(2284, '/blogdetail.php?id=4', '17.22.237.16', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 17:57:37'),
(2285, '/blogdetail.php?id=5', '17.241.75.145', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 18:23:15'),
(2286, '/blogdetail.php?id=8', '17.241.219.18', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 19:12:29'),
(2287, '/', '198.235.24.56', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-04 19:22:18'),
(2288, '/terms', '40.77.167.76', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-04 19:33:08'),
(2289, '/blogdetail.php?id=6', '17.246.23.61', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 19:54:36'),
(2290, '/blogdetail.php?id=7', '17.22.253.207', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-04 20:00:43'),
(2291, '/about', '178.156.239.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-04 21:00:21'),
(2292, '/about', '121.37.99.69', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-04 23:51:26'),
(2293, '/', '192.36.109.84', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-05 00:23:32'),
(2294, '/services', '42.193.105.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-05 04:40:55'),
(2295, '/', '180.153.236.50', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-05 09:08:53'),
(2296, '/', '82.156.29.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-05 09:27:01'),
(2297, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-05 10:53:47'),
(2298, '/', '66.249.70.194', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-05 10:53:48'),
(2299, '/', '180.153.236.183', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-05 11:14:05'),
(2300, '/', '198.235.24.173', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-05 12:41:44'),
(2301, '/about', '216.73.216.167', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Desktop', 'Columbus, Ohio, United States', '2026-04-05 13:25:49'),
(2302, '/', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 13:42:28'),
(2303, '/blog', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 13:42:42'),
(2304, '/privacy', '43.143.217.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-05 14:14:05'),
(2305, '/dashboard/', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:25:55'),
(2306, '/careers', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:28:52'),
(2307, '/jobdetail.php?id=1', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:28:55'),
(2308, '/blog', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:30:33'),
(2309, '/blogdetail.php?id=9', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:30:36'),
(2310, '/', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:31:52'),
(2311, '/careers', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:31:57'),
(2312, '/jobdetail.php?id=1', '114.124.247.193', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Jakarta, Jakarta, Indonesia', '2026-04-05 16:31:59'),
(2313, '/portdetail.php?id=12', '111.119.193.235', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-05 19:30:14'),
(2314, '/', '74.7.227.136', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-05 19:45:18'),
(2315, '/servicedetail.php?id=12', '116.204.77.87', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-05 20:32:11'),
(2316, '/servicedetail.php?id=4', '58.87.87.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-05 22:01:14'),
(2317, '/portdetail.php?id=10', '124.243.172.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-05 23:31:11'),
(2318, '/blogdetail.php?id=9', '116.204.13.94', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 01:02:59'),
(2319, '/', '54.174.58.233', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-06 01:22:50'),
(2320, '/', '18.159.199.77', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-06 01:35:49'),
(2321, '/', '216.157.41.80', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-04-06 01:35:51'),
(2322, '/', '216.157.40.81', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-04-06 01:35:52'),
(2323, '/', '216.157.42.88', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Miami, Florida, United States', '2026-04-06 01:35:58'),
(2324, '/', '104.199.53.158', 'Mozilla/5.0 (compatible; VelenPublicWebCrawler/1.0; +https://velen.io)', 'Desktop', 'Brussels, Brussels Capital, Belgium', '2026-04-06 02:28:02'),
(2325, '/blogdetail.php?id=2', '113.44.119.202', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 02:31:16'),
(2326, '/', '112.20.2.180', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Nanjing, Jiangsu, China', '2026-04-06 02:52:29'),
(2327, '/', '183.0.179.129', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Guangzhou, Guangdong, China', '2026-04-06 02:52:45'),
(2328, '/', '183.253.105.81', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Putian, Fujian, China', '2026-04-06 02:53:06'),
(2329, '/portdetail.php?id=8', '116.204.32.51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 04:01:25'),
(2330, '/portdetail.php?id=6', '121.37.99.96', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 05:30:59'),
(2331, '/', '120.235.167.172', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Guangzhou, Guangdong, China', '2026-04-06 06:35:13'),
(2332, '/blogdetail.php?id=4', '116.204.44.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 07:01:02'),
(2333, '/servicedetail.php?id=4', '207.46.13.116', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Redmond, Washington, United States', '2026-04-06 07:58:29'),
(2334, '/servicedetail.php?id=11', '81.70.210.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 08:30:58'),
(2335, '/servicedetail.php?id=9', '188.239.34.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-06 10:00:36'),
(2336, '/', '198.235.24.49', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-06 10:27:49'),
(2337, '/blogdetail.php?id=7', '62.234.144.59', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 11:30:53'),
(2338, '/', '142.93.156.163', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Toronto, Ontario, Canada', '2026-04-06 12:56:41'),
(2339, '/servicedetail.php?id=10', '116.204.78.105', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 13:01:39'),
(2340, '/servicedetail.php?id=10', '188.239.59.29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-06 13:02:04'),
(2341, '/', '124.243.173.58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-06 14:30:50'),
(2342, '/', '54.86.221.44', 'Mozilla/5.0 (X11; Linux i686; rv:43.0) Gecko/20100101 Firefox/43.0', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-06 14:42:12'),
(2343, '/blogdetail.php?id=8', '116.204.46.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 19:14:17'),
(2344, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-06 19:43:55'),
(2345, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-06 19:43:55'),
(2346, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-06 19:43:56'),
(2347, '/', '173.244.56.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Phoenix, Arizona, United States', '2026-04-06 19:43:56'),
(2348, '/', '184.33.141.154', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Desktop', 'Boardman, Oregon, United States', '2026-04-06 21:20:39'),
(2349, '/portdetail.php?id=8', '121.37.96.207', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-06 23:01:18'),
(2350, '/', '27.188.160.155', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-04-06 23:39:01'),
(2351, '/', '121.237.36.27', 'Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.20) Gecko/20081217 Firefox/2.0.0.20', 'Desktop', 'Nanjing, Jiangsu, China', '2026-04-06 23:45:25'),
(2352, '/', '66.249.70.194', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-07 00:17:35'),
(2353, '/portdetail.php?id=3', '82.156.137.195', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 00:21:10'),
(2354, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-07 00:26:54'),
(2355, '/servicedetail.php?id=12', '111.119.192.29', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 01:41:05'),
(2356, '/servicedetail.php?id=11', '111.119.196.79', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 03:04:36'),
(2357, '/servicedetail.php?id=8', '188.239.8.116', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 04:20:40'),
(2358, '/', '1.198.22.122', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Zhengzhou, Henan, China', '2026-04-07 05:44:13'),
(2359, '/', '223.151.179.60', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Changsha, Hunan, China', '2026-04-07 05:44:45'),
(2360, '/', '121.29.51.28', 'Dalvik/2.1.0 (Linux; U; Android 9.0; ZTE BA520 Build/MRA58K)', 'Mobile', 'Beijing, Beijing, China', '2026-04-07 05:56:01'),
(2361, '/', '121.29.51.28', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; ja-jp) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 05:57:12'),
(2362, '/', '121.29.51.28', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.27 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/601.1.27', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 05:57:28'),
(2363, '/', '121.29.51.28', 'Dalvik/2.1.0 (Linux; U; Android 9.0; ZTE BA520 Build/MRA58K)', 'Mobile', 'Beijing, Beijing, China', '2026-04-07 06:04:38'),
(2364, '/blogdetail.php?id=5', '113.44.116.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 07:04:11'),
(2365, '/blogdetail.php?id=6', '166.108.239.58', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 08:20:51'),
(2366, '/', '104.36.50.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Desktop', 'New York, New York, United States', '2026-04-07 08:57:02'),
(2367, '/portdetail.php?id=10', '17.22.253.31', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-07 09:08:18'),
(2368, '/', '91.231.89.37', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-04-07 09:35:30'),
(2369, '/', '91.196.152.66', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Roubaix, Hauts-de-France, France', '2026-04-07 09:39:28'),
(2370, '/', '43.138.54.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 09:40:45'),
(2371, '/', '91.231.89.123', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-04-07 09:43:57'),
(2372, '/portfolio', '1.92.196.187', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 11:01:30'),
(2373, '/', '51.254.49.98', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Roubaix, Hauts-de-France, France', '2026-04-07 11:12:56'),
(2374, '/', '223.80.80.46', 'User-Agent:Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36', 'Desktop', 'Qingdao, Shandong, China', '2026-04-07 11:22:42'),
(2375, '/', '66.249.70.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-07 12:11:17'),
(2376, '/', '111.119.248.44', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 12:20:35'),
(2377, '/', '3.72.68.72', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-07 12:45:33'),
(2378, '/', '3.72.68.72', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-07 12:45:33'),
(2379, '/', '41.90.184.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-07 13:02:23'),
(2380, '/portfolio', '41.90.184.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-07 13:02:29'),
(2381, '/portdetail.php?id=11', '41.90.184.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-07 13:02:33'),
(2382, '/portfolio', '41.90.184.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-07 13:06:02'),
(2383, '/careers', '1.92.192.240', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 15:01:32'),
(2384, '/blogdetail.php?id=9', '17.22.237.240', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-07 15:19:23'),
(2385, '/blogdetail.php?id=2', '17.241.227.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-07 15:43:02'),
(2386, '/', '162.250.121.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'Desktop', 'Secaucus, New Jersey, United States', '2026-04-07 16:00:12'),
(2387, '/', '92.71.98.153', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-07 16:07:58'),
(2388, '/cookie', '124.243.174.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 16:20:39'),
(2389, '/contact', '116.204.46.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-07 17:40:27'),
(2390, '/portdetail.php?id=11', '188.239.11.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-07 19:32:20'),
(2391, '/about', '43.143.178.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 01:03:19'),
(2392, '/about', '43.143.178.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 01:03:49'),
(2393, '/', '180.153.236.51', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-08 02:20:08'),
(2394, '/', '116.204.77.223', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 04:01:34'),
(2395, '/', '35.93.254.152', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Desktop', 'Boardman, Oregon, United States', '2026-04-08 06:54:13'),
(2396, '/portdetail.php?id=6', '116.204.32.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 07:03:59'),
(2397, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-08 08:05:58'),
(2398, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-08 08:08:55'),
(2399, '/', '173.252.107.113', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Desktop', 'Sandston, Virginia, United States', '2026-04-08 10:47:06'),
(2400, '/servicedetail.php?id=9', '116.204.8.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 10:55:10'),
(2401, '/', '184.72.173.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-08 10:58:40'),
(2402, '/', '184.72.173.149', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Safari/605.1.15', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-08 10:58:40'),
(2403, '/blogdetail.php?id=6', '49.233.44.57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-08 13:13:06'),
(2404, '/', '66.249.70.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-08 13:31:30'),
(2405, '/', '91.231.89.98', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-04-08 13:40:58'),
(2406, '/', '91.196.152.155', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Roubaix, Hauts-de-France, France', '2026-04-08 13:42:22'),
(2407, '/', '66.249.70.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-08 14:00:06'),
(2408, '/portdetail.php?id=9', '17.246.23.10', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-08 14:09:55');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(2409, '/', '44.250.145.58', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Desktop', 'Boardman, Oregon, United States', '2026-04-08 14:30:57'),
(2410, '/', '198.235.24.123', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-08 15:47:18'),
(2411, '/portdetail.php?id=6', '124.243.174.116', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-08 19:19:49'),
(2412, '/', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:50'),
(2413, '/', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:52'),
(2414, '/contact', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:52'),
(2415, '/privacy', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:54'),
(2416, '/terms', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:55'),
(2417, '/about', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:56'),
(2418, '/services', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:57'),
(2419, '/careers', '144.217.135.217', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:40:58'),
(2420, '/', '144.217.135.217', 'Mozilla/5.0 (Linux; Android 10; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.162 Mobile Safari/537.36', 'Mobile', 'Beauharnois, Quebec, Canada', '2026-04-08 19:41:01'),
(2421, '/', '144.217.135.220', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:41:11'),
(2422, '/', '144.217.135.220', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:41:17'),
(2423, '/', '144.217.135.220', 'Mozilla/5.0 (compatible; Dataprovider.com)', 'Desktop', 'Beauharnois, Quebec, Canada', '2026-04-08 19:41:19'),
(2424, '/blogdetail.php?id=2', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; GoogleOther)', 'Mobile', 'Mountain View, California, United States', '2026-04-08 21:45:11'),
(2425, '/portdetail.php?id=10', '116.204.104.72', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-09 01:00:50'),
(2426, '/', '106.8.131.200', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-04-09 01:34:29'),
(2427, '/portdetail.php?id=8', '17.241.227.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-09 01:52:09'),
(2428, '/careers', '17.246.15.153', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-09 04:19:10'),
(2429, '/', '104.233.38.178', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-09 05:16:54'),
(2430, '/portdetail.php?id=12', '166.108.202.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-09 07:01:47'),
(2431, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-09 08:05:50'),
(2432, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-09 08:08:57'),
(2433, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 11:28:42'),
(2434, '/', '162.120.187.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-04-09 12:16:11'),
(2435, '/dashboard/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:22'),
(2436, '/dashboard/index.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:25'),
(2437, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:33'),
(2438, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:37'),
(2439, '/dashboard/documents.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:40'),
(2440, '/', '180.153.236.43', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-09 12:16:47'),
(2441, '/dashboard/customers', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:48'),
(2442, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:16:58'),
(2443, '/', '180.153.236.165', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-09 12:17:05'),
(2444, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:17:20'),
(2445, '/dashboard/invoices.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:17:20'),
(2446, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:17:22'),
(2447, '/', '180.153.236.239', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-09 12:17:27'),
(2448, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:18:11'),
(2449, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:18:11'),
(2450, '/dashboard/payments.php?invoice_id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:18:29'),
(2451, '/dashboard/payments.php?invoice_id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:20:34'),
(2452, '/dashboard/payments.php?invoice_id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:20:34'),
(2453, '/dashboard/payments.php?invoice_id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:21:44'),
(2454, '/dashboard/payments.php?invoice_id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:21:44'),
(2455, '/dashboard/payments', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:21:55'),
(2456, '/dashboard/statement', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:21:59'),
(2457, '/dashboard/statement?from=2026-01-01&to=2026-04-09', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:22:17'),
(2458, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:22:34'),
(2459, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 12:22:37'),
(2460, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-09 12:28:23'),
(2461, '/', '205.210.31.178', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-09 13:12:30'),
(2462, '/', '23.27.145.186', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-09 14:16:41'),
(2463, '/', '23.27.145.110', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-09 14:43:24'),
(2464, '/dashboard/dashboard', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:03:05'),
(2465, '/dashboard/index.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:03:07'),
(2466, '/dashboard/index.php?rv_page=1&jv_page=1&rv_limit=25', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:03:12'),
(2467, '/dashboard/services.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:06:41'),
(2468, '/dashboard/dashboard', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:07:09'),
(2469, '/dashboard/dashboard?rv_page=1&jv_page=1&rv_limit=50', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:08:33'),
(2470, '/dashboard/dashboard?rv_page=1&jv_page=1&rv_limit=50', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:08:50'),
(2471, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:08:55'),
(2472, '/careers', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:09:05'),
(2473, '/jobdetail.php?id=1', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:09:16'),
(2474, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:09:51'),
(2475, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:10'),
(2476, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:25'),
(2477, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:27'),
(2478, '/dashboard/backup.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:31'),
(2479, '/dashboard/customers', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:35'),
(2480, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:43'),
(2481, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:10:47'),
(2482, '/dashboard/statement', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:11:13'),
(2483, '/dashboard/statement?from=2026-01-01&to=2026-04-09', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:11:23'),
(2484, '/dashboard/payments', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:11:39'),
(2485, '/dashboard/expenses', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:11:47'),
(2486, '/dashboard/employees.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:12:09'),
(2487, '/dashboard/employees.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:12:10'),
(2488, '/dashboard/blog', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-09 15:12:25'),
(2489, '/', '31.59.20.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-04-09 16:07:13'),
(2490, '/portfolio', '31.59.20.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-04-09 16:07:53'),
(2491, '/portdetail.php?id=11', '31.59.20.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'Desktop', 'London, England, United Kingdom', '2026-04-09 16:08:51'),
(2492, '/', '180.153.236.50', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-09 17:33:43'),
(2493, '/', '72.14.201.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Mountain View, California, United States', '2026-04-09 17:35:54'),
(2494, '/', '172.215.218.110', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Desktop', 'Cheyenne, Wyoming, United States', '2026-04-09 17:36:24'),
(2495, '/', '174.138.33.142', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'North Bergen, New Jersey, United States', '2026-04-09 19:06:52'),
(2496, '/', '192.71.142.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-09 22:45:50'),
(2497, '/', '136.114.11.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-10 02:35:26'),
(2498, '/', '136.114.11.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-10 02:35:26'),
(2499, '/', '136.114.11.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-10 02:35:27'),
(2500, '/', '136.114.11.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-10 02:35:27'),
(2501, '/', '15.204.182.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-10 07:27:10'),
(2502, '/', '191.96.106.199', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 08:04:37'),
(2503, '/', '191.96.106.199', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 08:05:05'),
(2504, '/', '34.253.155.187', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-10 08:25:16'),
(2505, '/', '15.204.182.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-10 08:45:25'),
(2506, '/', '35.215.76.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BuiltWith/1.4; rb.gy/xprgqj) Chrome/124.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 11:23:53'),
(2507, '/', '35.215.76.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BuiltWith/1.4; rb.gy/xprgqj) Chrome/124.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 11:23:54'),
(2508, '/servicedetail.php?id=10', '35.215.76.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BuiltWith/1.4; rb.gy/xprgqj) Chrome/124.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 11:23:59'),
(2509, '/cookie', '35.215.76.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko; compatible; BuiltWith/1.4; rb.gy/xprgqj) Chrome/124.0.0.0 Safari/537.36', 'Desktop', 'Los Angeles, California, United States', '2026-04-10 11:24:03'),
(2510, '/', '98.90.210.252', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-10 12:27:13'),
(2511, '/', '98.90.210.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/138.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-10 12:27:14'),
(2512, '/', '66.249.70.193', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-10 12:50:31'),
(2513, '/', '66.249.70.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-10 13:23:27'),
(2514, '/', '137.184.189.89', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-10 13:29:42'),
(2515, '/', '198.235.24.119', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-10 13:37:23'),
(2516, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-10 16:16:35'),
(2517, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-04-10 16:16:36'),
(2518, '/', '54.174.58.227', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-11 05:41:10'),
(2519, '/', '216.157.41.66', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-04-11 05:57:27'),
(2520, '/', '216.157.40.66', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Portland, Oregon, United States', '2026-04-11 05:57:28'),
(2521, '/', '18.159.93.15', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-11 05:57:35'),
(2522, '/', '216.157.42.71', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-04-11 05:58:10'),
(2523, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:02:06'),
(2524, '/portfolio', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:02:26'),
(2525, '/portdetail.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:02:46'),
(2526, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:04'),
(2527, '/portdetail.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:12'),
(2528, '/dashboard/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:37'),
(2529, '/dashboard/index.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:40'),
(2530, '/dashboard/blog', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:49'),
(2531, '/dashboard/portfolio', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:03:58'),
(2532, '/dashboard/editport.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:04:02'),
(2533, '/dashboard/editport.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:05:18'),
(2534, '/dashboard/portfolio', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:05:30'),
(2535, '/dashboard/editport.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:05:37'),
(2536, '/dashboard/editport.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:05:43'),
(2537, '/dashboard/services', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:05:52'),
(2538, '/dashboard/services', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:17'),
(2539, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:22'),
(2540, '/services', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:26'),
(2541, '/portfolio', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:28'),
(2542, '/portdetail.php?id=11', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:31'),
(2543, '/', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:06:58'),
(2544, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:12'),
(2545, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:22'),
(2546, '/dashboard/invoices.php', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:23'),
(2547, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:25'),
(2548, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:28'),
(2549, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:07:28'),
(2550, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:08:24'),
(2551, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:08:24'),
(2552, '/dashboard/payments', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:08:43'),
(2553, '/dashboard/invoices', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:08:51'),
(2554, '/dashboard/invoice-view.php?id=3', '105.164.128.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:08:53'),
(2555, '/', '102.219.208.90', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-11 11:12:23'),
(2556, '/', '134.209.40.111', 'python-requests/2.32.3', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-11 11:32:33'),
(2557, '/', '134.209.40.111', 'python-requests/2.32.3', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-11 11:32:35'),
(2558, '/', '134.209.40.111', 'python-requests/2.32.3', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-11 11:32:36'),
(2559, '/', '134.209.40.111', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/116.0.0.0 Safari/537.36', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-11 11:32:37'),
(2560, '/', '78.159.110.69', '', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-11 11:38:01'),
(2561, '/', '44.242.194.57', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-11 16:47:52'),
(2562, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 17:43:04'),
(2563, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:02:08'),
(2564, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:06:23'),
(2565, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:06:30'),
(2566, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:06:35'),
(2567, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:06:44'),
(2568, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:07:40'),
(2569, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:07:46'),
(2570, '/refer?token=939501820c536579&msg=Registration+successful%21+Start+referring+and+earning.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:07:57'),
(2571, '/?ref=939501820c536579', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:08:11'),
(2572, '/contact', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:08:31'),
(2573, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:10:43'),
(2574, '/about', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:12:16'),
(2575, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:16:19'),
(2576, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:21:59'),
(2577, '/refer?token=939501820c536579&msg=You+are+already+registered%21+Use+your+existing+link.&status=info', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:22:07'),
(2578, '/about', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-11 18:22:29'),
(2579, '/about', '66.249.76.230', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-11 18:22:34'),
(2580, '/contact', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-11 18:22:39'),
(2581, '/contact', '66.249.64.102', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-11 18:22:48'),
(2582, '/refer?token=939501820c536579&msg=Registration+successful%21+Start+referring+and+earning.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:22:48'),
(2583, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:23:10'),
(2584, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:23:16'),
(2585, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:12'),
(2586, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:21'),
(2587, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:25'),
(2588, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:29'),
(2589, '/refer?token=939501820c536579&msg=You+are+already+registered%21+Use+your+existing+link.&status=info', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:35'),
(2590, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:45'),
(2591, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:32:55'),
(2592, '/refer?token=2093806323e18593&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:33:05'),
(2593, '/?ref=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:33:47'),
(2594, '/?ref=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:34:08'),
(2595, '/refer?token=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:34:20'),
(2596, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:36:00'),
(2597, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:36:06'),
(2598, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:36:14'),
(2599, '/refer?token=2093806323e18593&msg=You+are+already+registered%21+Use+your+existing+link.&status=info', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:36:26'),
(2600, '/refer?token=2093806323e18593&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:40:12'),
(2601, '/?ref=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 18:41:04'),
(2602, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:27:29'),
(2603, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:27:35'),
(2604, '/refer?token=2093806323e18593&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:27:37'),
(2605, '/refer?token=ALEX23FC&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:27:57'),
(2606, '/refer?token=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:28:28'),
(2607, '/?ref=2093806323e18593', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:28:33'),
(2608, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:28:51'),
(2609, '/refer?token=ALEX23FC&msg=You+are+already+registered%21+Use+your+existing+link.&status=info', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:29:01'),
(2610, '/?ref=ALEX23FC', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:30:38'),
(2611, '/contact', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:30:56'),
(2612, '/blog', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:31:54'),
(2613, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:32:17'),
(2614, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:32:23'),
(2615, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:32:26'),
(2616, '/refer?token=ALEX23FC&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:34:15'),
(2617, '/refer?token=ALEX23FC&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:34:18'),
(2618, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:34:47'),
(2619, '/refer?token=ALEX23FC&msg=You+are+already+registered%21+Use+your+existing+link.&status=info', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:35:16'),
(2620, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:35:20'),
(2621, '/services', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:35:36'),
(2622, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:35:39'),
(2623, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:41:03'),
(2624, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:41:21'),
(2625, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:41:24'),
(2626, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:45:17'),
(2627, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:46:45');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(2628, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:46:49'),
(2629, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 19:49:48'),
(2630, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:31'),
(2631, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:35'),
(2632, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:45'),
(2633, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:50'),
(2634, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:52'),
(2635, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:05:55'),
(2636, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:06:03'),
(2637, '/refer', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:06:31'),
(2638, '/refer?token=ALEX3D0D&msg=Registration+successful%21+Check+your+email+for+your+referral+link.&status=success', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:06:40'),
(2639, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:07:39'),
(2640, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:08:40'),
(2641, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:08:43'),
(2642, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:08:49'),
(2643, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:14:42'),
(2644, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:14:51'),
(2645, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:15:13'),
(2646, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:17:12'),
(2647, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:17:16'),
(2648, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:17:19'),
(2649, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:18:57'),
(2650, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:19:36'),
(2651, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:19:45'),
(2652, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:25:33'),
(2653, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:26:24'),
(2654, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:26:27'),
(2655, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:26:30'),
(2656, '/dashboard/?delete=2', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:26:38'),
(2657, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:26:42'),
(2658, '/?ref=ALEX3D0D', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:09'),
(2659, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:35'),
(2660, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:37'),
(2661, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:42'),
(2662, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:49'),
(2663, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:32:52'),
(2664, '/contact', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:36:55'),
(2665, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:37:13'),
(2666, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:42:39'),
(2667, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:42:44'),
(2668, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:43:00'),
(2669, '/dashboard/?delete=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:47:25'),
(2670, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:47:49'),
(2671, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:57:36'),
(2672, '/dashboard/referred_clients', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:57:41'),
(2673, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:59:53'),
(2674, '/dashboard/inquiries', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:59:59'),
(2675, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 20:59:59'),
(2676, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:05'),
(2677, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:05'),
(2678, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:11'),
(2679, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:11'),
(2680, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:15'),
(2681, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:16'),
(2682, '/dashboard/inquiries?deleted=1', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:00:37'),
(2683, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:01:18'),
(2684, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:07:36'),
(2685, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:12:12'),
(2686, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:15:44'),
(2687, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:16:32'),
(2688, '/', '205.210.31.41', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-11 21:22:56'),
(2689, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:23:06'),
(2690, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:23:15'),
(2691, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:23:28'),
(2692, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:26:51'),
(2693, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:27:20'),
(2694, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:27:34'),
(2695, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:27:38'),
(2696, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:27:57'),
(2697, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-11 21:28:30'),
(2698, '/', '66.249.76.232', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 01:15:28'),
(2699, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 01:32:05'),
(2700, '/blogdetail.php?id=6', '17.246.19.223', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-12 01:51:51'),
(2701, '/', '104.253.174.133', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Santa Clara, California, United States', '2026-04-12 05:32:48'),
(2702, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 08:48:56'),
(2703, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 09:20:46'),
(2704, '/about', '66.249.76.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 09:33:14'),
(2705, '/', '91.231.89.34', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Desktop', 'Gravelines, Hauts-de-France, France', '2026-04-12 10:24:17'),
(2706, '/', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-12 10:40:04'),
(2707, '/contact', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-12 10:40:12'),
(2708, '/about', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-12 10:40:15'),
(2709, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:13:59'),
(2710, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:14:33'),
(2711, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:14:44'),
(2712, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:15:45'),
(2713, '/dashboard/', '41.198.150.100', 'Mozilla/5.0 (Linux; Android 16; SM-A165F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Johannesburg, Gauteng, South Africa', '2026-04-12 11:15:50'),
(2714, '/dashboard/', '41.198.150.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Johannesburg, Gauteng, South Africa', '2026-04-12 11:15:50'),
(2715, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:17:07'),
(2716, '/dashboard/index.php', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:10'),
(2717, '/dashboard/index.php', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:11'),
(2718, '/dashboard/index.php', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:11'),
(2719, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:17:24'),
(2720, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:17:37'),
(2721, '/dashboard/services', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:38'),
(2722, '/dashboard/services', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:38'),
(2723, '/dashboard/services', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:17:38'),
(2724, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:17:51'),
(2725, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:17:58'),
(2726, '/dashboard/editport.php?id=11', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:18:00'),
(2727, '/dashboard/editport.php?id=11', '66.249.83.131', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-04-12 11:18:00'),
(2728, '/dashboard/editport.php?id=11', '66.102.8.231', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:18:00'),
(2729, '/dashboard/editport.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:18:53'),
(2730, '/dashboard/services', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:19:08'),
(2731, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:19:23'),
(2732, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:19:30'),
(2733, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:20:33'),
(2734, '/dashboard/', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:20:35'),
(2735, '/dashboard/', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:20:36'),
(2736, '/dashboard/', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:20:36'),
(2737, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:20:38'),
(2738, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:20:49'),
(2739, '/dashboard/invoices', '66.249.93.167', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-04-12 11:20:50'),
(2740, '/dashboard/invoices', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:20:51'),
(2741, '/dashboard/invoices', '66.249.83.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:20:51'),
(2742, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:20:57'),
(2743, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:02'),
(2744, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:09'),
(2745, '/dashboard/expenses', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:21:10'),
(2746, '/dashboard/expenses', '66.249.83.71', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:21:11'),
(2747, '/dashboard/expenses', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:21:11'),
(2748, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:12'),
(2749, '/dashboard/expenses', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:24'),
(2750, '/dashboard/blog', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:32'),
(2751, '/dashboard/blog', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:39'),
(2752, '/dashboard/portfolio', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:52'),
(2753, '/dashboard/editport.php?id=12', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:21:57'),
(2754, '/dashboard/editport.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:22:01'),
(2755, '/dashboard/editport.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:22:35'),
(2756, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:22:49'),
(2757, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:23:00'),
(2758, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:23:14'),
(2759, '/portdetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:23:39'),
(2760, '/portdetail.php?id=12', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:23:41'),
(2761, '/portdetail.php?id=12', '66.249.83.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:23:41'),
(2762, '/portdetail.php?id=12', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:23:41'),
(2763, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:23:45'),
(2764, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:23:56'),
(2765, '/', '217.199.148.246', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:44:41'),
(2766, '/', '72.14.201.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:52:03'),
(2767, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-12 11:52:26'),
(2768, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 11:58:37'),
(2769, '/', '66.249.76.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 12:01:38'),
(2770, '/', '180.153.236.248', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-12 13:06:53'),
(2771, '/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 13:33:11'),
(2772, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 13:33:17'),
(2773, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 13:33:28'),
(2774, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 13:33:34'),
(2775, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 13:33:44'),
(2776, '/dashboard/documents.php?cat=4&view=grid', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-12 16:49:22'),
(2777, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-12 17:47:32'),
(2778, '/', '198.235.24.154', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-12 19:19:50'),
(2779, '/', '102.129.234.142', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Dallas, Texas, United States', '2026-04-12 20:23:56'),
(2780, '/', '102.129.234.142', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Dallas, Texas, United States', '2026-04-12 20:23:56'),
(2781, '/', '102.129.234.142', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Dallas, Texas, United States', '2026-04-12 20:23:57'),
(2782, '/', '102.129.234.142', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0', 'Desktop', 'Dallas, Texas, United States', '2026-04-12 20:23:57'),
(2783, '/', '74.7.227.29', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-13 00:27:26'),
(2784, '/', '180.153.236.182', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-13 02:22:00'),
(2785, '/', '180.153.236.48', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-13 02:22:00'),
(2786, '/portdetail.php?id=8', '40.77.167.6', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-13 03:02:42'),
(2787, '/about', '15.204.161.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:19:50'),
(2788, '/services', '40.160.21.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:20:37'),
(2789, '/servicedetail.php?id=8', '40.160.21.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:20:37'),
(2790, '/portfolio', '40.160.21.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:20:37'),
(2791, '/contact', '15.204.183.221', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:21:07'),
(2792, '/contact', '15.204.183.221', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:21:07'),
(2793, '/privacy', '15.204.161.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:34:25'),
(2794, '/cookie', '15.204.161.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:34:27'),
(2795, '/terms', '15.204.161.7', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:34:27'),
(2796, '/careers', '15.204.161.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Reston, Virginia, United States', '2026-04-13 05:40:45'),
(2797, '/', '18.237.203.228', 'Opera/9.80 (Windows NT 5.1; U; MRA 5.5 (build 02842); ru) Presto/2.7.62 Version/11.00', 'Desktop', 'Boardman, Oregon, United States', '2026-04-13 07:13:31'),
(2798, '/', '159.203.45.139', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Toronto, Ontario, Canada', '2026-04-13 07:35:58'),
(2799, '/', '159.65.197.122', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Amsterdam, North Holland, The Netherlands', '2026-04-13 08:02:45'),
(2800, '/refer?token=ALEX3D0D', '105.164.128.79', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-13 09:26:42'),
(2801, '/blogdetail.php?id=3', '17.246.19.204', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-13 13:27:58'),
(2802, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-13 13:31:48'),
(2803, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-13 13:46:20'),
(2804, '/', '23.27.145.217', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-13 14:10:11'),
(2805, '/', '23.27.145.21', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-13 14:36:40'),
(2806, '/cookie', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-13 16:16:06'),
(2807, '/refer', '57.141.20.23', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-13 16:16:30'),
(2808, '/portdetail.php?id=9', '17.241.227.196', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-13 22:04:15'),
(2809, '/', '5.133.192.99', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-14 01:08:13'),
(2810, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:39:47'),
(2811, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:39:57'),
(2812, '/portdetail.php?id=12', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:40:03'),
(2813, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:40:54'),
(2814, '/portdetail.php?id=11', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:40:58'),
(2815, '/portdetail.php?id=11', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:41:00'),
(2816, '/portdetail.php?id=11', '66.102.9.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:41:00'),
(2817, '/portdetail.php?id=11', '66.102.9.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:41:00'),
(2818, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:15'),
(2819, '/portdetail.php?id=8', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:17'),
(2820, '/portdetail.php?id=8', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:42:19'),
(2821, '/portdetail.php?id=8', '66.102.9.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:42:20'),
(2822, '/portdetail.php?id=8', '66.102.9.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:42:20'),
(2823, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:33'),
(2824, '/portdetail.php?id=9', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:36'),
(2825, '/portdetail.php?id=9', '66.249.93.167', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-04-14 06:42:38'),
(2826, '/portdetail.php?id=9', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:42:38'),
(2827, '/portdetail.php?id=9', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:42:38'),
(2828, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:57'),
(2829, '/portdetail.php?id=10', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:42:59'),
(2830, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:43:27'),
(2831, '/portdetail.php?id=6', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:43:31');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(2832, '/portdetail.php?id=6', '66.249.93.167', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Lookup failed', '2026-04-14 06:43:32'),
(2833, '/portdetail.php?id=6', '66.102.9.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 06:43:33'),
(2834, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:44:02'),
(2835, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:44:05'),
(2836, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:44:09'),
(2837, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:45:18'),
(2838, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:47:26'),
(2839, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:47:57'),
(2840, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:48:06'),
(2841, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:48:09'),
(2842, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:48:30'),
(2843, '/careers', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:53:47'),
(2844, '/blog', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:53:58'),
(2845, '/about', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:54:06'),
(2846, '/portfolio', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 06:54:18'),
(2847, '/', '57.141.20.46', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-14 07:00:52'),
(2848, '/', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:30:12'),
(2849, '/blog', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:34:03'),
(2850, '/blogdetail.php?id=9', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:35:26'),
(2851, '/blogdetail.php?id=8', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:38:17'),
(2852, '/blogdetail.php?id=7', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:42:37'),
(2853, '/blogdetail.php?id=6', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:45:09'),
(2854, '/blogdetail.php?id=5', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:46:29'),
(2855, '/blogdetail.php?id=4', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:48:53'),
(2856, '/blogdetail.php?id=3', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:51:47'),
(2857, '/blogdetail.php?id=2', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 07:53:11'),
(2858, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-14 08:06:02'),
(2859, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-14 08:09:22'),
(2860, '/portdetail.php?id=12', '57.141.20.9', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-14 11:10:24'),
(2861, '/portdetail.php?id=11', '57.141.20.32', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-14 11:13:19'),
(2862, '/', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 12:55:51'),
(2863, '/blog', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 12:57:07'),
(2864, '/blogdetail.php?id=9', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 12:59:51'),
(2865, '/blogdetail.php?id=8', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:03:36'),
(2866, '/blogdetail.php?id=7', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:06:46'),
(2867, '/blogdetail.php?id=6', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:09:50'),
(2868, '/blogdetail.php?id=5', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:10:34'),
(2869, '/blogdetail.php?id=4', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:13:50'),
(2870, '/blogdetail.php?id=3', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:15:56'),
(2871, '/blogdetail.php?id=2', '35.163.99.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.35 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36', 'Desktop', 'Boardman, Oregon, United States', '2026-04-14 13:16:58'),
(2872, '/blogdetail.php?id=7', '52.167.144.17', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-14 13:53:18'),
(2873, '/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 14:52:16'),
(2874, '/', '102.213.48.6', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 14:55:10'),
(2875, '/', '23.27.145.138', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-14 14:56:25'),
(2876, '/portdetail.php?id=10', '102.213.48.6', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 14:56:57'),
(2877, '/', '162.120.188.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-04-14 15:31:35'),
(2878, '/', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:31:35'),
(2879, '/dashboard/', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:32:06'),
(2880, '/dashboard/index.php', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:32:09'),
(2881, '/dashboard/customers', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:32:14'),
(2882, '/dashboard/customers', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:36:53'),
(2883, '/dashboard/customers.php', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:36:53'),
(2884, '/dashboard/invoices', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:37:01'),
(2885, '/dashboard/invoices', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:37:19'),
(2886, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:37:20'),
(2887, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:38:32'),
(2888, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:38:32'),
(2889, '/', '205.210.31.238', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-14 15:48:33'),
(2890, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:48:33'),
(2891, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:48:33'),
(2892, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:48:40'),
(2893, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:48:40'),
(2894, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:50:20'),
(2895, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:50:20'),
(2896, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:50:25'),
(2897, '/dashboard/invoice-view.php?id=4', '105.164.128.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 15:50:25'),
(2898, '/', '101.47.4.254', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1', 'Mobile', 'Singapore, Singapore', '2026-04-14 17:47:46'),
(2899, '/', '104.232.221.55', 'Mozilla/5.0 (Linux; Android 13; SM-A225F Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/118.0.0.0 Mobile Safari/537.36 musical_ly_2022604050 JsSdk/1.0 NetType/WIFI Channel/googleplay AppName/musical_ly app_version/26.4.5 ByteLocale/en ByteFullLocale/en Region/GB Spark/1.1.9.4-bugfix AppVersion/26.4.5 PIA/1.4.3 BytedanceWebview/d8a21c6', 'Mobile', 'Antwerp, Flanders, Belgium', '2026-04-14 17:47:49'),
(2900, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:04'),
(2901, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:08'),
(2902, '/dashboard/index.php', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:09'),
(2903, '/dashboard/index.php', '66.249.88.165', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:10'),
(2904, '/dashboard/index.php', '66.249.88.164', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:10'),
(2905, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:34'),
(2906, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:42'),
(2907, '/dashboard/employees.php', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:53'),
(2908, '/dashboard/employees.php', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:55'),
(2909, '/dashboard/employees.php', '66.249.88.165', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:56'),
(2910, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:49:56'),
(2911, '/dashboard/employees.php', '66.249.88.165', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 17:49:56'),
(2912, '/dashboard/jobs', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:50:03'),
(2913, '/dashboard/editjob/1', '217.199.148.246', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 17:50:09'),
(2914, '/', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 18:52:08'),
(2915, '/', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 18:52:23'),
(2916, '/careers', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 18:52:44'),
(2917, '/jobdetail.php?id=1', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 18:53:04'),
(2918, '/jobdetail.php?id=1', '66.249.93.168', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 18:53:07'),
(2919, '/jobdetail.php?id=1', '66.102.8.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 18:53:07'),
(2920, '/jobdetail.php?id=1', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 18:53:08'),
(2921, '/privacy', '57.141.20.67', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-14 18:55:15'),
(2922, '/careers', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 18:59:44'),
(2923, '/', '41.90.193.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 19:00:31'),
(2924, '/', '105.164.73.239', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-14 19:37:50'),
(2925, '/servicedetail.php?id=8', '52.167.144.176', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-14 19:59:19'),
(2926, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-14 21:00:12'),
(2927, '/', '162.120.188.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Rome, Lazio, Italy', '2026-04-14 21:14:58'),
(2928, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:15:40'),
(2929, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:15:58'),
(2930, '/dashboard/customers', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:16:18'),
(2931, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:16:34'),
(2932, '/dashboard/invoice-view.php?id=3', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:16:41'),
(2933, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:17:25'),
(2934, '/dashboard/invoice-view.php?id=4', '217.199.148.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-14 21:17:29'),
(2935, '/servicedetail.php?id=12', '207.46.13.168', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Quincy, Washington, United States', '2026-04-15 07:14:20'),
(2936, '/', '196.207.23.2', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-15 09:40:54'),
(2937, '/', '196.207.23.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 09:42:28'),
(2938, '/', '54.225.40.171', 'Mozilla/5.0 (compatible; SurdotlyBot/1.0; +http://sur.ly/bot.html)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-15 09:42:32'),
(2939, '/', '54.209.213.78', 'Mozilla/5.0 (Linux; Android 4.3; Galaxy Nexus Build/JWR67B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.117 Mobile Safari/537.36', 'Mobile', 'Ashburn, Virginia, United States', '2026-04-15 09:42:33'),
(2940, '/', '54.209.213.78', 'Mozilla/5.0 (compatible; SurdotlyBot/1.0; +http://sur.ly/bot.html)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-15 09:42:45'),
(2941, '/', '54.209.213.78', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/120.0.6099.224 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-15 09:42:46'),
(2942, '/', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:54:29'),
(2943, '/portfolio', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:55:15'),
(2944, '/portdetail.php?id=12', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:55:20'),
(2945, '/portfolio', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:56:37'),
(2946, '/portdetail.php?id=11', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:56:44'),
(2947, '/portfolio', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:56:50'),
(2948, '/portdetail.php?id=8', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-15 10:57:02'),
(2949, '/', '192.121.146.24', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Mobile/15E148 Safari/604', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-04-15 11:05:37'),
(2950, '/terms', '57.141.20.3', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-15 11:10:56'),
(2951, '/', '23.27.145.207', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-15 14:50:59'),
(2952, '/', '79.127.132.140', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-15 15:17:52'),
(2953, '/', '79.127.132.140', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-15 15:18:22'),
(2954, '/', '54.227.171.135', 'Mozilla/5.0 (Linux; Android 10; M2010J19SI) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.74 Mobile Safari/537.36', 'Mobile', 'Ashburn, Virginia, United States', '2026-04-15 15:27:42'),
(2955, '/', '34.90.222.110', 'Scrapy/2.13.4 (+https://scrapy.org)', 'Desktop', 'Groningen, Groningen, The Netherlands', '2026-04-15 15:42:31'),
(2956, '/', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-15 19:30:44'),
(2957, '/contact', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-15 19:30:46'),
(2958, '/about', '145.241.99.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', 'Desktop', 'Johannesburg, Gauteng, South Africa', '2026-04-15 19:30:56'),
(2959, '/blog', '17.241.75.53', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-16 02:00:06'),
(2960, '/', '130.89.144.167', 'OI-Crawler/Nutch (https://openintel.nl/webcrawl/)', 'Desktop', 'Enschede, Overijssel, The Netherlands', '2026-04-16 03:06:12'),
(2961, '/careers', '52.167.144.190', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-16 05:18:09'),
(2962, '/', '5.133.192.193', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-16 05:23:40'),
(2963, '/', '44.211.75.250', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-16 08:41:02'),
(2964, '/portfolio', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-16 09:12:48'),
(2965, '/', '37.19.210.5', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Denver, Colorado, United States', '2026-04-16 10:05:40'),
(2966, '/', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-16 10:45:38'),
(2967, '/', '72.14.201.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Mountain View, California, United States', '2026-04-16 11:43:06'),
(2968, '/servicedetail.php?id=8', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:44:17'),
(2969, '/', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:44:26'),
(2970, '/refer', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:49:55'),
(2971, '/careers', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:50:16'),
(2972, '/jobdetail.php?id=1', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:50:30'),
(2973, '/blog', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:51:08'),
(2974, '/blogdetail.php?id=2', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:51:33'),
(2975, '/blog', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:51:46'),
(2976, '/blogdetail.php?id=9', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:51:51'),
(2977, '/blog', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:52:04'),
(2978, '/services', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:52:10'),
(2979, '/servicedetail.php?id=7', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:52:19'),
(2980, '/services', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:52:34'),
(2981, '/servicedetail.php?id=8', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:52:43'),
(2982, '/privacy', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:53:54'),
(2983, '/terms', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:53:59'),
(2984, '/servicedetail.php?id=10', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 11:54:08'),
(2985, '/servicedetail.php?id=9', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 12:27:14'),
(2986, '/portfolio', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 12:27:19'),
(2987, '/portdetail.php?id=8', '105.164.128.92', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-16 12:27:27'),
(2988, '/', '57.141.20.37', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-16 12:56:46'),
(2989, '/', '44.197.109.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-16 13:12:24'),
(2990, '/', '44.197.109.186', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/132.0.0.0 Safari/537.36', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-16 13:12:24'),
(2991, '/', '52.167.144.24', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-16 15:56:04'),
(2992, '/', '23.234.71.27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'Desktop', 'Denver, Colorado, United States', '2026-04-16 16:23:06'),
(2993, '/', '80.64.24.158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.37 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36', 'Desktop', 'St Petersburg, St.-Petersburg, Russia', '2026-04-16 16:45:55'),
(2994, '/', '66.249.64.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-16 23:27:30'),
(2995, '/', '35.233.57.217', 'Mozilla/5.0 (compatible; VelenPublicWebCrawler/1.0; +https://velen.io)', 'Desktop', 'Brussels, Brussels Capital, Belgium', '2026-04-17 03:26:18'),
(2996, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-17 04:09:58'),
(2997, '/', '122.8.89.58', 'Mozilla/5.0 (X12; Linux x86_64) AppleWebKit/537.96 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 05:58:06'),
(2998, '/', '162.120.188.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-04-17 10:34:27'),
(2999, '/careers', '41.90.42.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-17 10:51:18'),
(3000, '/', '199.45.154.151', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'New York City, New York, United States', '2026-04-17 14:18:40'),
(3001, '/', '199.45.154.151', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'New York City, New York, United States', '2026-04-17 14:19:17'),
(3002, '/terms', '57.141.20.34', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-17 16:19:15'),
(3003, '/blogdetail.php?id=2', '188.239.12.188', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-17 18:57:55'),
(3004, '/portdetail.php?id=12', '121.37.106.181', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 18:58:04'),
(3005, '/portdetail.php?id=5', '116.204.20.42', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 19:03:24'),
(3006, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-17 19:38:52'),
(3007, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-17 19:39:53'),
(3008, '/servicedetail.php?id=8', '188.239.34.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-17 19:53:05'),
(3009, '/blogdetail.php?id=9', '121.37.108.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 19:53:14'),
(3010, '/servicedetail.php?id=11', '188.239.45.68', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-17 19:55:44'),
(3011, '/blogdetail.php?id=5', '116.204.76.126', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 19:55:47'),
(3012, '/blogdetail.php?id=3', '49.232.200.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 19:56:01'),
(3013, '/portdetail.php?id=3', '1.92.207.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 20:03:20'),
(3014, '/blogdetail.php?id=8', '124.243.174.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-17 20:35:00'),
(3015, '/', '198.235.24.179', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-17 20:49:04'),
(3016, '/portdetail.php?id=10', '111.119.212.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Singapore, Singapore', '2026-04-17 20:52:37'),
(3017, '/terms', '116.204.42.162', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-17 20:52:39'),
(3018, '/portdetail.php?id=11', '17.22.245.45', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-17 21:17:39'),
(3019, '/portdetail.php?id=10', '17.241.219.236', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-17 21:37:39'),
(3020, '/blog', '162.120.188.240', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-04-18 00:55:38'),
(3021, '/blog', '162.120.187.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Paris, Ile-de-France, France', '2026-04-18 00:56:18'),
(3022, '/blog', '193.186.4.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'London, England, United Kingdom', '2026-04-18 01:14:32'),
(3023, '/', '199.244.88.222', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Bartlett, Illinois, United States', '2026-04-18 04:49:21'),
(3024, '/', '35.226.112.116', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/29.0', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-18 04:56:53'),
(3025, '/', '162.120.188.112', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Rome, Lazio, Italy', '2026-04-18 05:56:36'),
(3026, '/', '105.164.116.25', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-18 05:58:12'),
(3027, '/', '34.41.192.221', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-18 06:49:48'),
(3028, '/', '205.210.31.11', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-18 07:50:47'),
(3029, '/careers', '57.141.20.17', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-18 09:43:35'),
(3030, '/', '162.120.187.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-04-18 11:06:46'),
(3031, '/', '44.214.178.232', 'node', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-18 11:07:54'),
(3032, '/', '44.214.178.232', 'node', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-18 11:07:55'),
(3033, '/', '5.183.91.105', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Balikesir, Balikesir, Turkey', '2026-04-18 11:07:55'),
(3034, '/', '195.64.119.32', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Oslo, Oslo County, Norway', '2026-04-18 11:07:56'),
(3035, '/', '195.64.115.132', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Oslo, Oslo County, Norway', '2026-04-18 11:10:21'),
(3036, '/', '5.183.90.231', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Balikesir, Balikesir, Turkey', '2026-04-18 11:10:44'),
(3037, '/', '185.5.147.51', 'undici', 'Desktop', 'Alexandria, Virginia, United States', '2026-04-18 11:10:47'),
(3038, '/about', '194.26.202.120', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Virginia Beach, Virginia, United States', '2026-04-18 11:10:49'),
(3039, '/portfolio', '195.64.115.93', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Oslo, Oslo County, Norway', '2026-04-18 11:10:49'),
(3040, '/careers', '195.64.119.24', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Oslo, Oslo County, Norway', '2026-04-18 11:10:49'),
(3041, '/contact', '5.183.91.11', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:49'),
(3042, '/portfolio', '195.64.115.113', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:49'),
(3043, '/services', '5.183.89.33', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:49'),
(3044, '/blog', '5.183.91.113', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:49'),
(3045, '/', '194.26.202.205', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:49'),
(3046, '/refer', '113.30.193.164', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Virginia Beach, Virginia, United States', '2026-04-18 11:10:50'),
(3047, '/', '35.245.194.175', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3048, '/blog', '34.21.13.193', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3049, '/', '5.183.90.123', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3050, '/', '113.30.194.51', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3051, '/about', '195.64.119.141', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3052, '/portfolio', '195.96.134.158', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(3053, '/contact', '5.183.91.160', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3054, '/blog', '5.183.91.98', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3055, '/', '195.64.119.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3056, '/about', '5.183.90.211', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3057, '/careers', '195.64.119.68', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3058, '/services', '195.64.115.165', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3059, '/portfolio', '5.183.89.39', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3060, '/services', '5.183.88.35', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3061, '/careers', '113.30.193.172', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3062, '/', '113.30.194.34', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:52'),
(3063, '/portfolio', '195.64.124.249', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3064, '/portfolio', '195.64.119.31', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3065, '/careers', '172.58.131.120', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3066, '/services', '172.58.128.70', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3067, '/blog', '195.64.115.155', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3068, '/', '172.58.131.120', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3069, '/portfolio', '172.58.131.74', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3070, '/about', '172.58.134.240', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3071, '/contact', '77.247.117.201', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3072, '/portfolio', '174.218.242.168', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3073, '/', '172.58.128.70', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3074, '/portfolio', '172.58.128.196', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3075, '/', '172.58.131.251', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3076, '/contact', '172.58.129.93', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3077, '/', '172.58.128.196', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3078, '/portfolio', '172.58.134.144', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3079, '/blog', '172.58.134.255', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3080, '/contact', '172.58.130.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3081, '/careers', '172.58.130.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3082, '/services', '172.58.130.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3083, '/about', '172.58.134.255', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3084, '/blog', '172.58.134.255', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 11:10:53'),
(3085, '/', '185.5.147.51', 'undici', 'Desktop', 'Alexandria, Virginia, United States', '2026-04-18 11:11:00'),
(3086, '/', '23.27.145.102', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-18 14:29:12'),
(3087, '/', '122.8.89.165', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edg/144.0.0.0 Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-18 15:29:07'),
(3088, '/terms', '142.111.165.73', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.3635.0', 'Desktop', 'Dallas, Texas, United States', '2026-04-18 15:35:32'),
(3089, '/', '119.13.220.72', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0 Teams/25212.2404.3875.1360/50', 'Desktop', 'Newark, New York, United States', '2026-04-18 15:35:32'),
(3090, '/about', '122.8.7.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5; rv:146.442.914) Gecko/20100101 Firefox/146.442.914', 'Desktop', 'Beijing, Beijing, China', '2026-04-18 15:35:32'),
(3091, '/blog', '122.8.7.22', 'Mozilla/144.0; Compatible; U; en-US; x86_64; Mobile; Gecko/20100101 Mobile/A2251 Firefox/144.0', 'Mobile', 'Beijing, Beijing, China', '2026-04-18 15:35:32'),
(3092, '/privacy', '122.8.85.138', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', 'Desktop', 'Lookup failed', '2026-04-18 15:35:33'),
(3093, '/services', '122.8.85.20', 'Mozilla/144.0; Compatible; U; en-US; x86_64; Mobile; Gecko/20100101 Mobile/A2251 Firefox/144.0 (x86_64)', 'Mobile', 'Lookup failed', '2026-04-18 15:35:33'),
(3094, '/contact', '122.8.85.214', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4; rv:146.204.198) Gecko/20100101 Firefox/146.204.198', 'Desktop', 'Lookup failed', '2026-04-18 15:35:35'),
(3095, '/', '198.235.24.10', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-18 20:38:56'),
(3096, '/', '105.164.4.223', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-18 23:17:39'),
(3097, '/', '106.8.137.54', 'YisouSpider', 'Desktop', 'Shijiazhuang, Hebei, China', '2026-04-19 06:55:26'),
(3098, '/', '122.8.7.119', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36 psi-exam-extension/3.5.0.0', 'Desktop', 'Beijing, Beijing, China', '2026-04-19 07:05:53'),
(3099, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-19 08:05:29'),
(3100, '/careers', '41.90.4.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-19 13:53:00'),
(3101, '/jobdetail.php?id=1', '41.90.4.85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-19 13:53:05'),
(3102, '/jobdetail.php?id=1', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-19 13:53:10'),
(3103, '/jobdetail.php?id=1', '66.102.8.231', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-19 13:53:11'),
(3104, '/jobdetail.php?id=1', '66.102.8.231', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-19 13:53:11'),
(3105, '/', '205.210.31.156', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-19 14:18:25'),
(3106, '/', '149.57.180.37', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'New York City, New York, United States', '2026-04-19 14:20:28'),
(3107, '/', '180.153.236.19', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-19 15:31:11'),
(3108, '/', '180.153.236.123', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-19 15:31:31'),
(3109, '/', '180.153.236.183', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-19 15:31:31'),
(3110, '/', '198.235.24.9', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Desktop', 'Santa Clara, California, United States', '2026-04-19 15:35:32'),
(3111, '/', '180.153.236.2', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-19 23:18:14'),
(3112, '/', '180.153.236.59', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-19 23:18:16'),
(3113, '/services', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-20 00:04:10'),
(3114, '/services', '119.12.167.149', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Hong Kong, Hong Kong', '2026-04-20 00:04:23'),
(3115, '/services', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-20 00:04:57'),
(3116, '/servicedetail.php?id=11', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-20 00:16:56'),
(3117, '/', '3.139.242.79', 'visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'Desktop', 'Hilliard, Ohio, United States', '2026-04-20 05:22:12'),
(3118, '/refer', '17.241.227.140', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-20 06:54:01'),
(3119, '/', '99.80.127.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-20 08:06:09'),
(3120, '/servicedetail.php?id=11', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-20 12:13:23'),
(3121, '/', '101.36.108.133', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/589.44 (KHTML, like Gecko) Chrome/61.0.2777 Safari/537.36', 'Desktop', 'Hong Kong, Hong Kong', '2026-04-20 12:48:36'),
(3122, '/', '118.194.250.22', 'Mozilla/5.0 (Windows NT 7_0_1; Win64; x64) AppleWebKit/534.39 (KHTML, like Gecko) Chrome/96.0.115 Safari/537.36', 'Desktop', 'Bangkok, Bangkok, Thailand', '2026-04-20 12:48:46'),
(3123, '/', '165.227.234.2', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'London, England, United Kingdom', '2026-04-20 13:18:37'),
(3124, '/privacy', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-20 13:44:45'),
(3125, '/cookie', '57.141.20.45', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-20 16:16:38'),
(3126, '/servicedetail.php?id=11', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-20 17:20:36'),
(3127, '/', '122.8.90.148', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/532.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Beijing, Beijing, China', '2026-04-21 05:40:56'),
(3128, '/', '3.233.59.216', 'RecordedFuture Global Inventory Crawler', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-21 06:33:17'),
(3129, '/', '49.12.151.216', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-04-21 07:40:51'),
(3130, '/', '91.98.178.17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Desktop', 'Falkenstein, Saxony, Germany', '2026-04-21 07:40:57'),
(3131, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-21 08:05:32'),
(3132, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-21 08:09:07'),
(3133, '/dashboard/', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:03:11'),
(3134, '/dashboard/index.php', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:03:13'),
(3135, '/dashboard/invoices', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:03:19'),
(3136, '/dashboard/invoices', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:03:30'),
(3137, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:03:30'),
(3138, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:04:09'),
(3139, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:04:09'),
(3140, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:07:44'),
(3141, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:07:44'),
(3142, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:09:20'),
(3143, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:09:20'),
(3144, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:11:08'),
(3145, '/dashboard/invoice-view.php?id=5', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:11:08'),
(3146, '/dashboard/dashboard', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:16:47'),
(3147, '/dashboard/invoices', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:16:52'),
(3148, '/dashboard/invoices', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:17:14'),
(3149, '/dashboard/invoices.php', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:17:14'),
(3150, '/dashboard/invoice-view.php?id=3', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:17:26'),
(3151, '/dashboard/dashboard', '105.164.128.168', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-21 11:17:34'),
(3152, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-21 13:51:18'),
(3153, '/', '149.57.180.81', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'New York City, New York, United States', '2026-04-21 14:26:14'),
(3154, '/', '54.84.18.201', 'Mozilla/5.0 (Linux; Android 9; ASUS_X00TD) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Mobile Safari/537.36', 'Mobile', 'Ashburn, Virginia, United States', '2026-04-21 15:28:13'),
(3155, '/', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:36:18'),
(3156, '/services', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:37'),
(3157, '/services', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:44'),
(3158, '/services', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:47'),
(3159, '/services', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:48'),
(3160, '/about', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:48'),
(3161, '/services', '41.139.184.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-21 15:37:49'),
(3162, '/privacy', '57.141.20.32', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-21 16:07:49'),
(3163, '/', '34.10.96.26', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-21 18:05:56'),
(3164, '/', '34.10.96.26', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Desktop', 'Council Bluffs, Iowa, United States', '2026-04-21 18:05:56'),
(3165, '/careers', '57.141.20.21', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-21 19:48:28'),
(3166, '/', '8.217.191.14', 'Go-http-client/1.1', 'Desktop', 'Hong Kong, Hong Kong', '2026-04-21 23:23:35'),
(3167, '/terms', '57.141.20.59', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-22 00:48:45'),
(3168, '/', '93.158.92.11', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115', 'Desktop', 'NÃ¤ttraby, Blekinge County, Sweden', '2026-04-22 07:26:27'),
(3169, '/', '54.220.82.239', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.80 Safari/537.36', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-22 08:05:04'),
(3170, '/', '54.174.58.254', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-22 09:38:57'),
(3171, '/', '18.158.189.225', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-22 10:03:33'),
(3172, '/', '216.157.41.86', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-04-22 10:03:36'),
(3173, '/', '216.157.40.72', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Portland, Oregon, United States', '2026-04-22 10:04:00'),
(3174, '/', '216.157.42.80', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-04-22 10:04:44'),
(3175, '/dashboard/', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:04:56'),
(3176, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:05:02'),
(3177, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:05:13'),
(3178, '/dashboard/jobs.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:05:13'),
(3179, '/dashboard/referrers', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:05:51'),
(3180, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:06:02'),
(3181, '/dashboard/dashboard', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:06:22'),
(3182, '/dashboard/documents.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:06:46'),
(3183, '/dashboard/invoices', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:06:52'),
(3184, '/dashboard/invoice-view.php?id=5', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:07:11'),
(3185, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 11:07:54'),
(3186, '/', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:00:26'),
(3187, '/', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:00:30'),
(3188, '/', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:00:41'),
(3189, '/servicedetail.php?id=9', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:02:01'),
(3190, '/contact', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:03:14'),
(3191, '/contact', '66.249.93.166', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-22 12:03:16'),
(3192, '/contact', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-22 12:03:17'),
(3193, '/contact', '66.102.8.232', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Mobile', 'Mountain View, California, United States', '2026-04-22 12:03:17'),
(3194, '/servicedetail.php?id=9', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:03:20'),
(3195, '/', '102.210.28.12', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 12:55:25'),
(3196, '/', '102.209.56.70', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 13:13:14'),
(3197, '/', '54.174.58.226', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-22 13:22:35'),
(3198, '/dashboard/index.php', '217.199.148.246', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-22 13:24:51'),
(3199, '/', '216.157.41.85', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Montreal, Quebec, Canada', '2026-04-22 13:47:26'),
(3200, '/', '18.158.189.225', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Frankfurt am Main, Hesse, Germany', '2026-04-22 13:47:28'),
(3201, '/', '216.157.40.68', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Portland, Oregon, United States', '2026-04-22 13:47:31'),
(3202, '/', '216.157.42.77', 'Mozilla/5.0 (compatible; HubSpot Crawler; HubSpot Domain check; +https://www.hubspot.com)', 'Desktop', 'Sydney, New South Wales, Australia', '2026-04-22 13:48:20'),
(3203, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-22 15:17:52'),
(3204, '/cookie', '57.141.20.44', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-22 17:53:46'),
(3205, '/careers', '57.141.20.28', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-22 22:45:54'),
(3206, '/', '66.249.64.102', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-23 01:07:07'),
(3207, '/portdetail.php?id=12', '17.22.253.195', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Desktop', 'Cupertino, California, United States', '2026-04-23 04:37:45'),
(3208, '/', '54.213.103.141', 'Opera/9.80 (X11; Linux x86_64; U; de) Presto/2.2.15 Version/10.00', 'Desktop', 'Boardman, Oregon, United States', '2026-04-23 07:13:07'),
(3209, '/', '68.183.152.78', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-23 08:59:55'),
(3210, '/', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:12:23'),
(3211, '/services', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:15:46'),
(3212, '/careers', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:15:57'),
(3213, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:16:08'),
(3214, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:16:14'),
(3215, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:16:17'),
(3216, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:23:31'),
(3217, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:33:20'),
(3218, '/jobdetail.php?id=1', '129.222.187.216', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 09:42:27'),
(3219, '/', '102.211.145.95', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:07:19'),
(3220, '/', '41.90.101.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:28:22'),
(3221, '/careers', '41.90.101.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:29:26'),
(3222, '/', '41.90.101.26', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:29:43'),
(3223, '/dashboard/', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:50:20'),
(3224, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:50:26'),
(3225, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:50:48'),
(3226, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 11:51:11'),
(3227, '/', '54.173.34.168', 'Mozilla/5.0 (compatible; SurdotlyBot/1.0; +http://sur.ly/bot.html)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-23 12:25:23'),
(3228, '/', '54.173.34.168', 'Mozilla/5.0 (compatible; SurdotlyBot/1.0; +http://sur.ly/bot.html)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-23 12:25:24'),
(3229, '/', '180.153.236.154', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-23 12:30:18'),
(3230, '/', '180.153.236.59', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-23 12:30:27'),
(3231, '/', '66.249.64.104', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.177 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-23 13:00:15'),
(3232, '/', '66.249.64.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-23 13:00:56'),
(3233, '/', '66.249.76.231', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-23 13:00:56'),
(3234, '/', '66.249.76.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Mobile', 'Mountain View, California, United States', '2026-04-23 13:00:56'),
(3235, '/', '66.249.76.231', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-23 13:00:56'),
(3236, '/', '5.133.192.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'Desktop', 'Stockholm, Stockholm, Sweden', '2026-04-23 13:59:42'),
(3237, '/', '8.47.96.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36,gzip(gfe)', 'Desktop', 'Rochester, New York, United States', '2026-04-23 14:45:03'),
(3238, '/', '93.158.90.73', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Mobile/15E148 Safari/604', 'Mobile', 'Stockholm, Stockholm, Sweden', '2026-04-23 14:50:04'),
(3239, '/', '41.81.153.71', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-23 14:55:30'),
(3240, '/', '193.186.4.137', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Paris, Ile-de-France, France', '2026-04-23 15:11:21'),
(3241, '/privacy', '57.141.20.7', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-23 16:22:31'),
(3242, '/', '180.153.236.58', 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0; 360Spider', 'Desktop', 'Shanghai, Shanghai, China', '2026-04-23 16:29:26'),
(3243, '/', '64.139.241.66', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36  TestNavPWA/1.14.9', 'Desktop', 'Statesboro, Georgia, United States', '2026-04-23 16:43:06'),
(3244, '/services', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-23 18:16:51'),
(3245, '/services', '159.138.49.22', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Desktop', 'Hong Kong, Hong Kong', '2026-04-23 18:17:41'),
(3246, '/servicedetail.php?id=3', '41.139.184.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-23 18:59:56'),
(3247, '/services', '41.139.184.95', 'WhatsApp/2.23.20.0', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-23 19:11:00'),
(3248, '/terms', '57.141.20.1', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-23 19:14:01'),
(3249, '/', '57.141.6.16', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-24 00:28:50'),
(3250, '/', '57.141.20.37', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'New York, New York, United States', '2026-04-24 07:52:03'),
(3251, '/', '34.248.38.169', 'Pandalytics/2.0 (https://domainsbot.com/pandalytics/)', 'Desktop', 'Dublin, Leinster, Ireland', '2026-04-24 08:44:06'),
(3252, '/', '72.14.201.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Mountain View, California, United States', '2026-04-24 09:15:09'),
(3253, '/dashboard/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:21:13'),
(3254, '/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:21:19'),
(3255, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:21:24'),
(3256, '/dashboard/inquiries', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:21:40'),
(3257, '/careers', '105.164.128.114', 'WhatsApp/2.23.20.0', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:30:58'),
(3258, '/careers', '129.222.187.147', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:32:14'),
(3259, '/jobdetail.php?id=1', '129.222.187.147', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:32:24'),
(3260, '/jobdetail.php?id=1', '129.222.187.147', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-24 09:43:53'),
(3261, '/careers', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 11:04:53'),
(3262, '/jobdetail.php?id=1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 11:04:58'),
(3263, '/services', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 11:05:24'),
(3264, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 11:06:02'),
(3265, '/', '118.179.156.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Dhaka, Dhaka Division, Bangladesh', '2026-04-24 12:10:48'),
(3266, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 12:29:08'),
(3267, '/about', '40.89.191.154', '', 'Desktop', 'Paris, ÃŽle-de-France, France', '2026-04-24 12:45:47'),
(3268, '/', '23.27.145.108', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Desktop', 'San Jose, California, United States', '2026-04-24 14:19:57'),
(3269, '/', '52.91.5.238', 'SonyEricssonT650i/R7AA Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-24 15:24:15'),
(3270, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:14:46'),
(3271, '/dashboard/customers', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:14:50'),
(3272, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:15:05'),
(3273, '/dashboard/invoice-view.php?id=3', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:15:10'),
(3274, '/dashboard/invoice-view.php?id=3', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:15:42'),
(3275, '/dashboard/invoice-view.php?id=3', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:15:43'),
(3276, '/dashboard/statement', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:18:00'),
(3277, '/dashboard/statement?from=2026-01-01&to=2026-04-24', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-24 16:18:10'),
(3278, '/careers', '57.141.6.18', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Atlanta, Georgia, United States', '2026-04-24 16:29:28'),
(3279, '/', '162.243.186.248', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Desktop', 'Clifton, New Jersey, United States', '2026-04-24 18:32:11'),
(3280, '/', '66.249.76.230', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Desktop', 'Mountain View, California, United States', '2026-04-25 00:22:31'),
(3281, '/portdetail.php?id=6', '52.167.144.158', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Desktop', 'Boydton, Virginia, United States', '2026-04-25 00:39:07'),
(3282, '/', '66.132.195.76', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'Ann Arbor, Michigan, United States', '2026-04-25 02:05:19'),
(3283, '/', '66.132.195.76', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Desktop', 'Ann Arbor, Michigan, United States', '2026-04-25 02:07:59');
INSERT INTO `page_visits` (`id`, `page_url`, `ip_address`, `user_agent`, `device_type`, `location`, `created_at`) VALUES
(3284, '/terms', '57.141.0.2', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Desktop', 'Ashburn, Virginia, United States', '2026-04-25 05:22:04'),
(3285, '/', '97.205.240.78', 'Mozilla/5.0 (X12; Linux x86_64) AppleWebKit/537.96 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Sacramento, California, United States', '2026-04-25 06:16:49'),
(3286, '/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:02'),
(3287, '/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:05'),
(3288, '/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:09'),
(3289, '/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:12'),
(3290, '/dashboard/', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:23'),
(3291, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:27'),
(3292, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:41'),
(3293, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:19:43'),
(3294, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:49:42'),
(3295, '/dashboard/products', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:49:46'),
(3296, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:50:11'),
(3297, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:50:13'),
(3298, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:52:55'),
(3299, '/dashboard/products', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:52:58'),
(3300, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:53:43'),
(3301, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:53:45'),
(3302, '/dashboard/products', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:54:40'),
(3303, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:56:01'),
(3304, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 08:56:03'),
(3305, '/dashboard/documents.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:01:20'),
(3306, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:01:44'),
(3307, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:01:52'),
(3308, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:04:09'),
(3309, '/careers', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:04:15'),
(3310, '/jobdetail.php?id=1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:04:17'),
(3311, '/jobdetail.php?id=1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:06:24'),
(3312, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:06:28'),
(3313, '/dashboard/application-view.php?id=1', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:08:04'),
(3314, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:08:50'),
(3315, '/dashboard/invoice-view.php?id=4', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:08:53'),
(3316, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:09:20'),
(3317, '/dashboard/products', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:09:34'),
(3318, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:09:53'),
(3319, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:09:56'),
(3320, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:14:35'),
(3321, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:14:56'),
(3322, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:14:57'),
(3323, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:15:05'),
(3324, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:19:02'),
(3325, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:19:05'),
(3326, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:19:07'),
(3327, '/dashboard/backup.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:19:09'),
(3328, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:19:11'),
(3329, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:21:04'),
(3330, '/dashboard/backup.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:21:28'),
(3331, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:21:56'),
(3332, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:28:14'),
(3333, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:28:19'),
(3334, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:30:41'),
(3335, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:30:49'),
(3336, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:31:00'),
(3337, '/dashboard/jobquestions/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:31:07'),
(3338, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:31:16'),
(3339, '/dashboard/editjob/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:31:22'),
(3340, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:31:28'),
(3341, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:32:12'),
(3342, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:32:16'),
(3343, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:35:53'),
(3344, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:38:13'),
(3345, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:40:04'),
(3346, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:45:11'),
(3347, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:48:12'),
(3348, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:50:56'),
(3349, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:51:01'),
(3350, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:51:58'),
(3351, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:52:01'),
(3352, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 09:56:41'),
(3353, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:00:31'),
(3354, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:01:02'),
(3355, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:07:24'),
(3356, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:07:28'),
(3357, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:12:16'),
(3358, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:15:24'),
(3359, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:00'),
(3360, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:01'),
(3361, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:04'),
(3362, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:08'),
(3363, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:11'),
(3364, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:24'),
(3365, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:21:26'),
(3366, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:22:32'),
(3367, '/dashboard/jobs', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:22:43'),
(3368, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:22:51'),
(3369, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:29:13'),
(3370, '/dashboard/jobapplications/1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:29:17'),
(3371, '/dashboard/application-view.php?id=1', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:29:34'),
(3372, '/dashboard/documents.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:29:49'),
(3373, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:29:58'),
(3374, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:30:03'),
(3375, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:32:19'),
(3376, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:32:23'),
(3377, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:33:32'),
(3378, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:35:24'),
(3379, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:35:32'),
(3380, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:36:22'),
(3381, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:36:22'),
(3382, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:37:19'),
(3383, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:37:19'),
(3384, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:37:38'),
(3385, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:39:54'),
(3386, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:41:33'),
(3387, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:41:36'),
(3388, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:41:37'),
(3389, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:41:38'),
(3390, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:41:45'),
(3391, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:42:47'),
(3392, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:43:33'),
(3393, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:43:34'),
(3394, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:43:34'),
(3395, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:46:43'),
(3396, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:46:45'),
(3397, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:46:52'),
(3398, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:48:39'),
(3399, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:48:43'),
(3400, '/dashboard/blog', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:49:06'),
(3401, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:49:11'),
(3402, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:54:47'),
(3403, '/dashboard/index.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:54:49'),
(3404, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:54:56'),
(3405, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:54:59'),
(3406, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 10:58:03'),
(3407, '/dashboard/dashboard', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 11:00:24'),
(3408, '/dashboard/employees.php', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 11:00:35'),
(3409, '/dashboard/customers', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 11:00:43'),
(3410, '/dashboard/invoices', '105.164.128.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Nairobi, Nairobi County, Kenya', '2026-04-25 11:00:50'),
(3411, '/dashboard/invoice-view.php?id=5', '105.164.128.114', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Mobile', 'Nairobi, Nairobi County, Kenya', '2026-04-25 11:01:02');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio`
--

CREATE TABLE `portfolio` (
  `id` int(11) NOT NULL,
  `port_title` varchar(255) NOT NULL,
  `port_desc` text NOT NULL,
  `port_detail` text NOT NULL,
  `port_url` varchar(255) DEFAULT NULL,
  `ufile` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio`
--

INSERT INTO `portfolio` (`id`, `port_title`, `port_desc`, `port_detail`, `port_url`, `ufile`) VALUES
(5, 'Data Analytics Dashboard for Financial Institution', 'Developed a comprehensive data analytics dashboard to visualize financial data and support decision-making.', 'Client Name: Financial Insights Corp.\r\nProject Overview: Built an interactive dashboard to aggregate and visualize financial metrics. The dashboard provides real-time insights into financial performance and trends.\r\nTechnologies Used: Tableau, SQL, Python, JavaScript\r\nKey Features: Real-time data updates, customizable reports, trend analysis, and data visualization.\r\nResults: Enabled quicker decision-making and strategic planning, leading to a 25% increase in operational efficiency.', NULL, '1971default.png'),
(6, 'Personal and Business Portfolios', 'Tailored portfolios that highlight your unique strengths and achievements.', 'We create custom personal and business portfolios designed to showcase your skills, projects, and accomplishments. Whether you need a standout personal brand or a compelling business presentation, our portfolios combine sleek design with effective content management to help you make a powerful impression.', 'https://laundry.timestentechnologies.co.ke', '3270Screenshot 2026-01-23 091822.png'),
(8, 'Property Management System', 'Streamline your property management with RentSmart. The all-in-one solution for landlords and property managers.', 'Powerful Features for Property Management\r\nEverything you need to manage your properties efficiently\r\nhttps://rentsmart.timestentechnologies.co.ke/', 'https://rentsmart.timestentechnologies.co.ke/', '7206Screenshot 2025-09-01 113550.png'),
(9, 'Clasyo â€“ School Management System (ERP)', 'Clasyo is an all-in-one school management ERP that simplifies academic, administrative, and financial operations through a centralized, user-friendly platform.', 'Clasyo automates student and staff management, admissions, attendance, examinations, fees, timetables, and reporting. With role-based access and secure data handling, it reduces manual work, improves operational efficiency, and supports institutions of all sizes.', 'https://clasyo.timestentechnologies.co.ke/', '3508Screenshot 2026-02-08 131043.png'),
(10, 'Fast Food Online Ordering Website', 'A modern fast food website designed to showcase menu items, enable seamless online ordering, and enhance customer engagement through a clean and responsive interface.', 'QuickBite is a fast food online ordering platform developed to provide a smooth and convenient digital experience for customers.\r\n\r\nThe website features:\r\n\r\nAn attractive and easy-to-navigate menu display\r\n\r\nOnline ordering functionality\r\n\r\nResponsive design optimized for mobile, tablet, and desktop\r\n\r\nClean UI/UX focused on speed and simplicity\r\n\r\nContact and location integration\r\n\r\nThis project demonstrates our expertise in developing user-friendly restaurant websites that help food businesses increase online visibility, streamline orders, and improve customer experience.', 'https://quickbites.wuaze.com/QuickBite', '0Screenshot 2026-02-27 152029.png'),
(11, 'Services Booking websites', 'A booking website is a web platform that allows users to schedule, reserve, or pay for services online â€” without needing to call or visit in person. Think of it as a 24/7 self-service front desk that never closes, never misses a message, and never keeps a customer waiting on hold.', 'A purpose-built online booking platform that allows customers to register, browse class schedules, reserve slots, and complete payment via M-Pesa â€” entirely online, without calling or visiting in person.\r\nThe system removes the friction of manual bookings and cash handling, replacing it with a smooth, mobile-friendly experience built specifically for the Kenyan market.Customer-Facing Frontend\r\nThe customer-facing side of the platform opens with a branded landing page showcasing the academy\'s programs, facilities, and clear calls to action. From there, customers can create an account and log in securely to access the full platform. Once inside, they can browse available classes and reserve slots in real time, as well as explore an online gear shop stocked with swimming products. The cart and checkout flow is powered by M-Pesa STK Push, allowing customers to pay instantly from their phone. A personal dashboard ties everything together, giving each customer a central place to view their upcoming bookings, order history, and manage their profile.\r\n\r\nAdmin Panel\r\nThe admin panel gives the academy\'s management team complete control over day-to-day operations through a secure, role-based login. Administrators can manage students and members, build out class schedules, and set capacity limits for each session. Booking oversight and attendance tracking keep management informed of who is showing up and when. The panel also covers the gear shop side of the business, with full product and inventory management, order tracking, and fulfillment tools. On the financial side, all payment records are logged and accessible through built-in reporting. A central dashboard surfaces key metrics and recent activity, giving admins an at-a-glance view of how the academy is performing at any given time.', 'https://swimgsacademy.co.ke', '3962Screenshot 2026-03-30 112455.png'),
(12, 'E-COMMERCE- SUPERSHOP', 'SuperShop is a multi-supplier B2B ecommerce and ordering platform built specifically for businesses in Kenya that buy from multiple suppliers at once. Instead of calling different vendors, sending WhatsApp messages, or placing orders across multiple websites, SuperShop brings everything into one place â€” a single storefront where buyers can browse products from different suppliers, build one cart, and complete a consolidated order in minutes.\r\n', 'What Was BuiltBuyer-Facing StorefrontThe buyer experience is built around speed and simplicity. Buyers land on a clean, organized storefront where products from multiple suppliers are listed and searchable. Filters allow buyers to narrow by supplier, category, or price range. Each product page carries full details including pricing in KES, stock availability, and supplier information. Buyers add products from different suppliers into a single unified cart and proceed through a streamlined checkout â€” with M-Pesa STK Push as the primary payment method. After placing an order, buyers receive instant confirmation and can track order status from their personal buyer dashboard, which also holds their full order history.Supplier PanelEach supplier on the platform has their own dedicated management panel. Suppliers can log in independently and manage their product listings â€” adding new items, updating prices, editing descriptions, and controlling stock levels. When a buyer places an order containing their products, the relevant supplier is notified and can manage fulfillment from their panel. This gives each vendor full autonomy over their catalog while keeping everything connected within the SuperShop ecosystem.Admin PanelThe platform administrator has oversight of the entire system. The admin panel covers supplier onboarding and management, buyer account oversight, full order management across all suppliers, payment verification and records, product and category management, and a dashboard showing platform-wide metrics including sales volumes, active suppliers, and order activity. The admin acts as the central controller ensuring smooth operations across the entire marketplace.', 'https://supershop.timestentechnologies.co.ke', '2039SUP1.png');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_media`
--

CREATE TABLE `portfolio_media` (
  `id` int(11) NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `media_type` enum('image','video','document') NOT NULL DEFAULT 'image',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `portfolio_media`
--

INSERT INTO `portfolio_media` (`id`, `portfolio_id`, `file_path`, `media_type`, `created_at`) VALUES
(2, 10, '2030_Screenshot2026-02-27152348.png', 'image', '2026-02-27 15:25:10'),
(3, 10, '8856_Screenshot2026-02-27152358.png', 'image', '2026-02-27 15:25:10'),
(4, 10, '2327_Screenshot2026-02-27152409.png', 'image', '2026-02-27 15:25:10'),
(5, 10, '8165_Screenshot2026-02-27152422.png', 'image', '2026-02-27 15:25:10'),
(6, 10, '7652_Screenshot2026-02-27152433.png', 'image', '2026-02-27 15:25:10'),
(7, 10, '1470_Screenshot2026-02-27152447.png', 'image', '2026-02-27 15:25:10'),
(15, 8, '4862_LISTING.png', 'image', '2026-03-05 09:49:48'),
(16, 8, '4867_r1.png', 'image', '2026-03-05 09:49:48'),
(17, 8, '1197_r2.png', 'image', '2026-03-05 09:49:48'),
(18, 8, '6525_r3.png', 'image', '2026-03-05 09:49:48'),
(19, 8, '5457_r4.png', 'image', '2026-03-05 09:49:48'),
(20, 8, '6876_r5.png', 'image', '2026-03-05 09:49:48'),
(21, 8, '2384_r6.png', 'image', '2026-03-05 09:49:48'),
(22, 8, '9485_r7.png', 'image', '2026-03-05 09:49:48'),
(23, 9, '7990_cl1.png', 'image', '2026-03-05 09:50:31'),
(24, 9, '2283_cl2.png', 'image', '2026-03-05 09:50:31'),
(25, 9, '9272_cl3.png', 'image', '2026-03-05 09:50:31'),
(26, 9, '6279_cl4.png', 'image', '2026-03-05 09:50:31'),
(27, 9, '6580_cl5.png', 'image', '2026-03-05 09:50:31'),
(28, 6, '2681_LA1.png', 'image', '2026-03-30 11:33:57'),
(29, 6, '6409_LA2.png', 'image', '2026-03-30 11:33:57'),
(30, 6, '5211_LA3.png', 'image', '2026-03-30 11:33:57'),
(31, 6, '9279_LA5.png', 'image', '2026-03-30 11:33:57'),
(32, 6, '4228_Screenshot2026-03-09152448.png', 'image', '2026-03-30 11:34:45'),
(33, 6, '8963_Screenshot2026-03-09152703.png', 'image', '2026-03-30 11:34:45'),
(34, 11, '8771_Screenshot2026-03-30112455.png', 'image', '2026-03-30 11:39:06'),
(35, 11, '3992_SM4.png', 'image', '2026-03-30 11:39:06'),
(36, 11, '2368_SW1.png', 'image', '2026-03-30 11:39:06'),
(37, 11, '7970_SW2.png', 'image', '2026-03-30 11:39:06'),
(38, 11, '3143_SW5.png', 'image', '2026-03-30 11:39:06'),
(39, 12, '5818_SUP.png', 'image', '2026-03-30 11:53:26'),
(40, 12, '9708_SUP1.png', 'image', '2026-03-30 11:53:26'),
(41, 12, '5300_SUP2.png', 'image', '2026-03-30 11:53:26'),
(42, 12, '7213_SUP3.png', 'image', '2026-03-30 11:53:26'),
(43, 12, '7492_SUP4.png', 'image', '2026-03-30 11:53:26');

-- --------------------------------------------------------

--
-- Table structure for table `referred_clients`
--

CREATE TABLE `referred_clients` (
  `id` int(11) NOT NULL,
  `referrer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('Pending','Converted','Paid') DEFAULT 'Pending',
  `commission_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `referred_clients`
--

INSERT INTO `referred_clients` (`id`, `referrer_id`, `name`, `email`, `phone`, `message`, `status`, `commission_amount`, `created_at`) VALUES
(1, 4, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'chombaalex2019@gmail.com', 'Pending', 0.00, '2026-04-11 17:37:07');

-- --------------------------------------------------------

--
-- Table structure for table `referrers`
--

CREATE TABLE `referrers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `token` varchar(100) NOT NULL,
  `points` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `referrers`
--

INSERT INTO `referrers` (`id`, `name`, `email`, `phone`, `token`, `points`, `created_at`) VALUES
(4, 'Alex Chomba Mwangi', 'chombaalex2019@gmail.com', '0718883983', 'ALEX3D0D', 100, '2026-04-11 17:06:38');

-- --------------------------------------------------------

--
-- Table structure for table `section_title`
--

CREATE TABLE `section_title` (
  `id` int(11) NOT NULL,
  `test_title` varchar(255) DEFAULT NULL,
  `test_text` text DEFAULT NULL,
  `enquiry_title` varchar(255) DEFAULT NULL,
  `enquiry_text` text DEFAULT NULL,
  `contact_title` varchar(255) DEFAULT NULL,
  `contact_text` text DEFAULT NULL,
  `port_title` varchar(255) DEFAULT NULL,
  `port_text` text DEFAULT NULL,
  `service_title` varchar(255) DEFAULT NULL,
  `service_text` text DEFAULT NULL,
  `why_title` varchar(255) DEFAULT NULL,
  `why_text` text DEFAULT NULL,
  `about_title` varchar(255) DEFAULT NULL,
  `about_text` text DEFAULT NULL,
  `vision_text` text DEFAULT NULL,
  `mission_text` text DEFAULT NULL,
  `values_text` text DEFAULT NULL,
  `impact_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_title`
--

INSERT INTO `section_title` (`id`, `test_title`, `test_text`, `enquiry_title`, `enquiry_text`, `contact_title`, `contact_text`, `port_title`, `port_text`, `service_title`, `service_text`, `why_title`, `why_text`, `about_title`, `about_text`, `vision_text`, `mission_text`, `values_text`, `impact_text`) VALUES
(1, 'What People say about Us', 'Hear from our satisfied clients who have experienced the Timesten Technologies difference. Our commitment to delivering exceptional service and tailored solutions has earned us the trust and loyalty of businesses across various industries.\r\n\r\nThese testimonials reflect our dedication to quality, innovation, and customer satisfaction. Let their words inspire confidence in choosing Timesten Kenya as your trusted partner for all your digital needs.', 'Enquiry', 'Have a question or need more details? We\'re here to assist. Fill out our enquiry form, and the team at Timesten Technologies will get back to you promptly. Whether it\'s about our services, pricing, or any other information, we\'re ready to provide the answers you need.\r\n\r\nYour journey to success starts with a simple enquiry reach out today!', 'Contact Us', 'Ready to take your business to the next level? Reach out to Timesten Technologies today. Whether you have a question, need more information about our services, or are ready to start a project, we\'re here to help.\r\n\r\nConnect with us, and let\'s discuss how we can work together to achieve your goals. Your success is just a message away!', 'Our Portfolio', 'Explore our portfolio to see the impact of our work. At Timesten Technologies, we take pride in delivering exceptional digital solutions across various industries. From web development to software integration, our projects showcase our commitment to quality, innovation, and client satisfaction.\r\n\r\nEach project we undertake is a testament to our expertise and our ability to turn challenges into opportunities. Discover how we\'ve helped businesses like yours achieve their goals and elevate their digital presence.', 'Our Services', 'We offer a range of digital solutions, including responsive web development, custom software, seamless integration, data analytics, secure software installation, and expert training. Let us enhance your business with our innovative services.', 'Why Choose Us?', 'We offer more than just services; we provide solutions that are tailored to your success.', 'About Timesten Technologies', 'We specialize in delivering top-tier digital solutions, including web and software development, integration, data analytics, software installation, and training. Our mission is to empower businesses with innovative technology that drives growth and efficiency. We focus on understanding your unique needs to provide customized solutions that align perfectly with your goals. Let us be your partner in navigating the digital landscape and achieving success.', 'To be the leading technology company in Africa and beyond, empowering businesses through innovative, reliable, and transformative digital solutions.', 'To provide high-end technology solutions that streamline business operations, enhance effectiveness and productivity, and optimize costs, enabling our clients to thrive in a digital-first world.', '1. Integrity - We act with honesty, transparency, and accountability in all our interactions.\r\n\r\n2. Excellence - We strive for high-quality solutions that exceed client expectations.\r\n\r\n3. Innovation - We continuously embrace new ideas, technologies, and approaches to drive business transformation.\r\n\r\n4. Customer-Centricity - Our clientsâ€™ success is our top priority; we deliver solutions tailored to their needs.\r\n\r\n5. Collaboration & Teamwork - We believe in the power of partnerships, teamwork, and knowledge sharing to achieve superior results.\r\n\r\n6. Ethics & Responsibility - We conduct business responsibly, respecting people, society, and the environment.', 'By leveraging cutting-edge technology, Timesten Technologies empowers businesses to operate more efficiently, reduce operational costs, and scale sustainably, contributing to economic growth and digital transformation across Africa and beyond.');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `service_title` varchar(255) NOT NULL,
  `service_desc` text NOT NULL,
  `service_detail` text NOT NULL,
  `service_url` varchar(255) DEFAULT NULL,
  `ufile` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `service_title`, `service_desc`, `service_detail`, `service_url`, `ufile`, `updated_at`) VALUES
(3, 'Web Development & SEO Optimization', 'Build a visually stunning, high-performance website optimized for search engines and enhanced with custom graphics.', 'Our web development services focus on creating responsive, user-friendly websites that rank well on search engines. We employ SEO best practices, fast loading times, and engaging visuals to ensure your site attracts and retains visitors.', '', '5550_5waysseowebdesigngotogether5e2945dd5df37.webp', '2024-08-18 12:49:59'),
(4, 'Smart ERP Systems for Agile Enterprises', 'Implement scalable ERP solutions that streamline operations, enhance data visibility, and support strategic growth.', 'Our ERP systems integrate core business functionsâ€”finance, HR, inventory, and salesâ€”into a unified platform. Tailored to your industry, these systems provide real-time analytics, automate workflows, and ensure compliance, empowering your team to make informed decisions.', '', '5212_ERP.jpg', '2024-08-18 12:49:59'),
(5, 'Seamless API Integration Services', 'Enhance system functionality by integrating with external APIs, improving user experience and operational efficiency.', 'Our Seamless API Integration Services in Kenya enable businesses to securely connect their applications with a wide range of third-party platforms to streamline operations and ensure real-time data synchronization. We integrate payment gateways such as M-Pesa, card payment processors, and online billing systems; CRM platforms; ERP systems; accounting software like QuickBooks; SMS and email marketing tools; WhatsApp Business API; inventory management systems; HR and payroll software; logistics and courier APIs; and social media platforms including Facebook, Instagram, and LinkedIn. Our API integration solutions eliminate manual data entry, reduce operational errors, improve workflow automation, and enhance reporting accuracy across departments. By implementing secure RESTful APIs, webhook automation, and cloud-based integrations, we help Kenyan SMEs and enterprises achieve faster data exchange, improved customer experience, and scalable digital transformation.', '', '5918interactive.png', '2024-08-18 12:49:59'),
(7, 'Graphic Design & Brand Identity Solutions', 'Develop a strong brand presence with our creative graphic design services.', 'From logos to marketing materials, we craft designs that reflect your brand\'s identity and resonate with your target audience. Our designs are tailored to communicate your message effectively across various platforms.', '', '3194_CustomGraphicDesignRedesignServicesforYourBrand.jpg', '2025-05-17 15:46:41'),
(8, 'CRM Development & Customer Experience Solutions', 'Provide custom CRM development, Salesforce integration, customer relationship management systems, and automation tools for sales and marketing.', 'We provide **CRM software development in Kenya** tailored to help SMEs, retail businesses, schools, and enterprises streamline customer management and improve sales performance. Our custom **customer relationship management systems** centralize leads, contacts, sales pipelines, communication history, quotations, and reporting into one secure platform. Through our professional **CRM integration services**, we seamlessly connect your CRM with ERP systems, accounting software, email marketing tools, WhatsApp Business API, SMS gateways, eCommerce platforms, and M-Pesa payment integrationâ€”ensuring smooth data flow across all departments. Our advanced **sales automation software** enables automated lead assignment, follow-up reminders, email and SMS marketing automation, sales funnel tracking, and real-time performance analytics to help businesses increase conversions and shorten sales cycles. With scalable cloud-based architecture, role-based access control, and intelligent customer insights, our **custom CRM development services** empower Kenyan businesses to enhance customer experience, boost productivity, and drive sustainable growth.', '', '5133_Strugglingwithconsistentleadgeneration.jpg', '2025-05-17 15:47:16'),
(9, 'Intelligent POS Systems for Retail & Hospitality', 'Transform customer transactions with feature-rich Point of Sale systems tailored to your business.', 'Our POS solutions support inventory management, multi-location syncing, customer loyalty, and real-time sales analytics. Whether you\\\'re in retail, food service, or hospitality, we provide both cloud-based and offline POS setups to streamline your front and back operations.', '', '4926_pos3.jpg', '2025-05-17 15:48:44'),
(10, 'School Management System (ERP)-Clasyo', 'All-in-one school management ERP that simplifies academic, administrative, and financial operations through a centralized, user-friendly platform.', 'Clasyo automates student and staff management, admissions, attendance, examinations, fees, timetables, and reporting. With role-based access and secure data handling, it reduces manual work, improves operational efficiency, and supports institutions of all sizes.', 'https://clasyo.timestentechnologies.co.ke/', '5360Screenshot 2026-02-08 131043.png', '2026-02-08 10:53:35'),
(11, 'Property Management System - Rensmart', 'Modern property management platform that streamlines rental operations, tenant management, and property administration for landlords and property managers.', 'RentSmart centralizes property listings, tenant onboarding, lease tracking, rent collection, maintenance requests, and reporting. With an intuitive interface and automated reminders, it helps property managers save time, reduce errors, and provide a seamless experience for tenants and landlords.', 'https://rentsmart.timestentechnologies.co.ke/', '9922_new.png', '2026-02-08 10:56:00'),
(12, 'Odoo Customization & Consultation', 'Optimize your business operations with expert Odoo customization and consultation. We help businesses tailor Odoo to their unique workflows, automate processes, and maximize productivity.', 'Our Odoo Customization and Consultation service helps businesses fully leverage the power of Odoo by tailoring the system to match their unique processes and operational needs. We analyze your business workflows and provide expert guidance on the best Odoo modules, implementation strategies, and system architecture. Our team develops custom modules, automates workflows, customizes user interfaces, and builds advanced reports and dashboards to improve efficiency and visibility. We also integrate Odoo with third-party applications, payment gateways, and external APIs to create a seamless business ecosystem. Additionally, we provide performance optimization, troubleshooting, system upgrades, and ongoing technical support to ensure your Odoo platform runs smoothly and scales with your business growth.', '', '9347_odoo8.webp', '2026-03-06 11:48:22');

-- --------------------------------------------------------

--
-- Table structure for table `service_media`
--

CREATE TABLE `service_media` (
  `id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `media_type` enum('image','video','document') NOT NULL DEFAULT 'image',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `service_media`
--

INSERT INTO `service_media` (`id`, `service_id`, `file_path`, `media_type`, `created_at`) VALUES
(20, 5, '9395_BoostSaleswithB2CEmailMarketingBestPractices.jpg', 'image', '2026-03-04 12:29:46'),
(21, 5, '1009_Manualvs_AutomatedWorkflows.jpg', 'image', '2026-03-04 12:29:46'),
(22, 5, '7324_AutomationvsManual_WhichWorksBest_.jpg', 'image', '2026-03-04 12:29:46'),
(23, 5, '3028_DriveInnovationAcrossCRMSCMFinance_TransformyourbusinessbyintegratingintelligentsystemslikePowerBIAIandautomationtoolstostreamlineoperationsboostefficiency._DigitalTransformation___', 'image', '2026-03-04 12:29:46'),
(24, 5, '7412_IntegratingBMSwithBusinessOperations_EfficiencyandInnovation.jpg', 'image', '2026-03-04 12:29:46'),
(25, 5, '1697_download6.jpg', 'image', '2026-03-04 12:29:46'),
(27, 5, '4484_download5.jpg', 'image', '2026-03-04 12:29:46'),
(28, 5, '9610_6KeyStepstoInfluencingEffectiveKnowledgeTransferinYourBusiness.jpg', 'image', '2026-03-04 12:29:46'),
(30, 3, '1005_SEO.jpg', 'image', '2026-03-04 14:30:04'),
(31, 3, '7063_SEO1.jpg', 'image', '2026-03-04 14:30:04'),
(32, 3, '2078_SEO2.jpg', 'image', '2026-03-04 14:30:04'),
(33, 3, '1776_WD.jpg', 'image', '2026-03-04 14:30:04'),
(34, 3, '6224_WD1.jpg', 'image', '2026-03-04 14:30:04'),
(35, 3, '7180_WD2.jpg', 'image', '2026-03-04 14:30:04'),
(36, 7, '1370_G.jpg', 'image', '2026-03-04 14:31:47'),
(37, 7, '4805_G1.jpg', 'image', '2026-03-04 14:31:47'),
(38, 7, '3602_G3.jpg', 'image', '2026-03-04 14:31:47'),
(39, 7, '1460_G4.jpg', 'image', '2026-03-04 14:31:47'),
(40, 7, '5951_G5.jpg', 'image', '2026-03-04 14:31:47'),
(41, 7, '5119_G6.jpg', 'image', '2026-03-04 14:31:47'),
(42, 7, '1218_G7.jpg', 'image', '2026-03-04 14:31:47'),
(43, 7, '2454_G8.jpg', 'image', '2026-03-04 14:31:47'),
(44, 7, '9006_G9.jpg', 'image', '2026-03-04 14:31:47'),
(45, 4, '4374_ERP.jpg', 'image', '2026-03-04 14:33:10'),
(46, 4, '1386_ERP1.jpg', 'image', '2026-03-04 14:33:10'),
(47, 4, '9583_ERP3.jpg', 'image', '2026-03-04 14:33:10'),
(48, 4, '8850_ERP4.jpg', 'image', '2026-03-04 14:33:10'),
(49, 4, '7890_ERP5.jpg', 'image', '2026-03-04 14:33:10'),
(50, 4, '1328_ERP6.jpg', 'image', '2026-03-04 14:33:10'),
(51, 4, '9447_ERP7.jpg', 'image', '2026-03-04 14:33:10'),
(58, 8, '9262_BS4.jpg', 'image', '2026-03-05 09:09:37'),
(60, 8, '3984_CRM.jpg', 'image', '2026-03-05 09:09:37'),
(61, 8, '4769_CRM1.jpg', 'image', '2026-03-05 09:09:37'),
(62, 8, '4312_EC.jpg', 'image', '2026-03-05 09:09:37'),
(63, 9, '2472_pos.jpg', 'image', '2026-03-05 09:16:33'),
(64, 9, '9983_pos1.jpg', 'image', '2026-03-05 09:16:33'),
(65, 9, '9970_pos2.jpg', 'image', '2026-03-05 09:16:33'),
(66, 9, '3958_pos3.jpg', 'image', '2026-03-05 09:16:33'),
(69, 11, '8528_OrangePurpleMinimalistHouseForSaleInstagramPost.png', 'image', '2026-03-05 09:21:59'),
(71, 11, '2099_homepage.png', 'image', '2026-03-05 09:22:34'),
(72, 11, '5324_invoice.png', 'image', '2026-03-05 09:22:34'),
(73, 11, '4172_LISTING.png', 'image', '2026-03-05 09:22:34'),
(76, 11, '1379_r1.png', 'image', '2026-03-05 09:48:25'),
(77, 11, '3044_r2.png', 'image', '2026-03-05 09:48:25'),
(78, 11, '8698_r3.png', 'image', '2026-03-05 09:48:25'),
(79, 11, '5356_r4.png', 'image', '2026-03-05 09:48:25'),
(80, 11, '5885_r5.png', 'image', '2026-03-05 09:48:25'),
(81, 11, '8908_r6.png', 'image', '2026-03-05 09:48:25'),
(82, 11, '5140_r7.png', 'image', '2026-03-05 09:48:25'),
(83, 10, '8623_cl1.png', 'image', '2026-03-05 09:51:35'),
(84, 10, '8520_cl2.png', 'image', '2026-03-05 09:51:35'),
(85, 10, '9854_cl3.png', 'image', '2026-03-05 09:51:35'),
(86, 10, '2663_cl4.png', 'image', '2026-03-05 09:51:35'),
(87, 10, '6336_cl5.png', 'image', '2026-03-05 09:51:35'),
(88, 12, '9940_odoo9.webp', 'image', '2026-03-06 14:50:12'),
(89, 12, '1610_odoo8.webp', 'image', '2026-03-06 14:50:12'),
(90, 12, '8391_odoo7.png', 'image', '2026-03-06 14:50:12'),
(91, 12, '8408_odoo6.jpg', 'image', '2026-03-06 14:50:12'),
(92, 12, '6427_odoo5.jpg', 'image', '2026-03-06 14:50:12'),
(93, 12, '3730_odoo4.jpg', 'image', '2026-03-06 14:50:12'),
(94, 12, '7882_odoo3.jpg', 'image', '2026-03-06 14:50:12'),
(95, 12, '2766_odoo2.webp', 'image', '2026-03-06 14:50:12'),
(96, 12, '2496_odoo1.png', 'image', '2026-03-06 14:50:12');

-- --------------------------------------------------------

--
-- Table structure for table `service_text`
--

CREATE TABLE `service_text` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_text`
--

INSERT INTO `service_text` (`id`, `title`, `text`) VALUES
(1, 'Service Text Title', 'Service text content here...');

-- --------------------------------------------------------

--
-- Table structure for table `siteconfig`
--

CREATE TABLE `siteconfig` (
  `id` int(11) NOT NULL,
  `site_title` varchar(255) DEFAULT NULL,
  `site_keyword` varchar(255) DEFAULT NULL,
  `site_about` text DEFAULT NULL,
  `site_footer` text DEFAULT NULL,
  `follow_text` text DEFAULT NULL,
  `site_desc` text DEFAULT NULL,
  `site_url` varchar(255) DEFAULT NULL,
  `show_preloader_name` tinyint(1) NOT NULL DEFAULT 1,
  `enable_preloader` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siteconfig`
--

INSERT INTO `siteconfig` (`id`, `site_title`, `site_keyword`, `site_about`, `site_footer`, `follow_text`, `site_desc`, `site_url`, `show_preloader_name`, `enable_preloader`) VALUES
(1, 'TimesTen Technologies', 'TimesTen, TimesTen tech, Technology,Tech, website, websites, seos, erp, erp, kenya, Timesten tech, Timesten kenya', '    TimesTen Technologies is dedicated to delivering top-tier technology services that help businesses succeed in the digital age. With a focus on quality, innovation, and customer satisfaction, we provide tailored solutions for your unique needs.', 'TimesTen Technologies . All rights reserved.', 'Connect with us on social media and stay updated with the latest news and services from TimesTen Technologies.', 'TimesTen Technologies is a leading provider of digital solutions, specializing in web development, software development, integration, data analytics, software installation, and training. We empower businesses with innovative technology to drive growth and efficiency.', 'https://timestentechnologies.co.ke', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sitecontact`
--

CREATE TABLE `sitecontact` (
  `id` int(11) NOT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `email1` varchar(100) DEFAULT NULL,
  `email2` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sitecontact`
--

INSERT INTO `sitecontact` (`id`, `phone1`, `phone2`, `email1`, `email2`, `address`, `longitude`, `latitude`) VALUES
(1, '0795155230', '0718883983', 'info@timestentechnologies.co.ke', 'timestentechnologies@gmail.com', 'Westlands , Nairobi Kenya 00100', 36.8219000, -1.2921000);

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE `slider` (
  `id` int(11) NOT NULL,
  `slide_title` varchar(255) NOT NULL,
  `slide_text` text NOT NULL,
  `ufile` varchar(255) DEFAULT NULL,
  `text_align` enum('left','right') NOT NULL DEFAULT 'left',
  `show_cartoon` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slider`
--

INSERT INTO `slider` (`id`, `slide_title`, `slide_text`, `ufile`, `text_align`, `show_cartoon`) VALUES
(2, 'Empowering Your Digital Transformation', 'Explore our portfolio of successful projects, where we\'ve delivered innovative web solutions, custom software, and data analytics tailored to our clients\' needs. See how our expertise can elevate your business and drive meaningful results.', '4892blog-6.jpg', 'right', 0),
(4, 'Transforming Ideas Into Powerful Digital Systems', 'We design and develop intelligent software solutions that simplify management, enhance efficiency, and unlock new opportunities for your business.', '3061blog-5.jpg', 'left', 0),
(5, 'Smart Systems for Schools, Property Managers & Growing Businesses', 'With Clasyo and RentSmart, we provide modern, cloud-based solutions that streamline operations, improve visibility, and maximize performance.', '7197thumb_3.jpg', 'left', 0);

-- --------------------------------------------------------

--
-- Table structure for table `social`
--

CREATE TABLE `social` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `fa` varchar(255) DEFAULT NULL,
  `social_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social`
--

INSERT INTO `social` (`id`, `name`, `fa`, `social_link`) VALUES
(1, 'Facebook', 'fa-facebook', 'https://www.facebook.com/share/19zZ8gSWYV/'),
(2, 'Twitter', 'fa-twitter', 'https://twitter.com'),
(3, 'LinkedIn', 'fa-linkedin', 'https://www.linkedin.com/company/timestentechnologies'),
(4, 'Instagram', 'fa-instagram', 'https://www.instagram.com/timestentechnologies?igsh=MXVjNHY5ejZtdXF2eg=='),
(5, 'YouTube', 'fa-youtube', 'https://youtube.com');

-- --------------------------------------------------------

--
-- Table structure for table `static`
--

CREATE TABLE `static` (
  `id` int(11) NOT NULL,
  `stitle` varchar(255) NOT NULL,
  `stext` text NOT NULL,
  `slider_mode` tinyint(1) NOT NULL DEFAULT 0,
  `show_cartoon` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `static`
--

INSERT INTO `static` (`id`, `stitle`, `stext`, `slider_mode`, `show_cartoon`) VALUES
(1, 'Innovative Solutions for Your Business', 'TimesTen Technologies, we provide cutting-edge web development, custom software solutions, and data analytics to drive your business forward. Our expertise and commitment to excellence ensure that your digital projects are not only successful but also set you apart in a competitive market. Partner with us to transform your ideas into reality and achieve your business goals with confidence.', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `testimony`
--

CREATE TABLE `testimony` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `position` varchar(255) NOT NULL,
  `ufile` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `testimony`
--

INSERT INTO `testimony` (`id`, `name`, `message`, `position`, `ufile`) VALUES
(5, '_Mercy Ndung\'u_', '\"Outstanding Service and Innovation!\"\r\nâ€œWorking with TimesTen Technologies transformed our business. Their custom POS system was exactly what we needed, and their team was responsive, professional, and truly innovative. Highly recommended!â€', 'Retail Business Owner', '5756174463497767fd0461ec1c4.png'),
(6, 'â€” John M.', '\"A Game Changer for Our Operations\"\r\nâ€œTheir smart ERP solution helped us streamline everything from inventory to payroll. We\'ve saved time and improved accuracy across the board. TimesTen truly understands business needs.â€', 'Operations Manager', '6527174463497767fd0461ec1c4.png'),
(7, '-Morgan K.', '\"Reliable Tech Partner\"\r\nâ€œWe\'ve collaborated with TimesTen Technologies on several web projects. Their team consistently delivers high-quality work on time and within budget. A reliable tech partner you can trust.â€', 'Digital Marketing Consultant', '3518174463497767fd0461ec1c4.png'),
(8, 'â€” David O.', '\"Insightful and Data-Driven Approach\"\r\nâ€œTheir AI-driven data analytics gave us powerful insights into our customer behavior. Weâ€™re now making smarter decisions thanks to the dashboards they built. Truly next-level service!â€', 'Head of Strategy', '9309174463497767fd0461ec1c4.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `nod` date DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `pod` date DEFAULT NULL,
  `dod` date DEFAULT NULL,
  `itd` text DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  `sc` varchar(255) DEFAULT NULL,
  `nok` varchar(255) DEFAULT NULL,
  `cv` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `role`, `nod`, `nationality`, `pod`, `dod`, `itd`, `sn`, `sc`, `nok`, `cv`) VALUES
(1, 'user', 'userpassword', 'User Role', '2000-01-01', 'Nationality', '2000-01-01', '2000-01-01', 'ITD Info', 'SN Info', 'SC Info', 'NOK Info', 'cv_file.png');

-- --------------------------------------------------------

--
-- Table structure for table `why_us`
--

CREATE TABLE `why_us` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `detail` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `why_us`
--

INSERT INTO `why_us` (`id`, `title`, `detail`) VALUES
(3, 'Expert Team', 'Our skilled professionals bring extensive experience and industry knowledge to deliver top-notch solutions tailored to your needs.'),
(5, ' Innovative Solutions', 'Leveraging the latest technologies, we offer cutting-edge services that keep you ahead in the digital landscape.'),
(6, 'Client-Centric', 'We focus on your unique requirements, providing customized solutions and ongoing support to ensure your success.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `backup_logs`
--
ALTER TABLE `backup_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `backup_schedule`
--
ALTER TABLE `backup_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_responses`
--
ALTER TABLE `chat_responses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_info`
--
ALTER TABLE `contact_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_categories`
--
ALTER TABLE `document_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doc_access_tokens`
--
ALTER TABLE `doc_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_token` (`token`),
  ADD KEY `idx_doc` (`doc_kind`,`doc_id`);

--
-- Indexes for table `email_settings`
--
ALTER TABLE `email_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_payments`
--
ALTER TABLE `employee_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_payment_deductions`
--
ALTER TABLE `employee_payment_deductions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enquiry_text`
--
ALTER TABLE `enquiry_text`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_customers`
--
ALTER TABLE `finance_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_expenses`
--
ALTER TABLE `finance_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_expense_categories`
--
ALTER TABLE `finance_expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_invoices`
--
ALTER TABLE `finance_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_invoice_no` (`invoice_no`);

--
-- Indexes for table `finance_invoice_items`
--
ALTER TABLE `finance_invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_payments`
--
ALTER TABLE `finance_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_products`
--
ALTER TABLE `finance_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_settings`
--
ALTER TABLE `invoice_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `job_application_answers`
--
ALTER TABLE `job_application_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `job_questions`
--
ALTER TABLE `job_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `logo`
--
ALTER TABLE `logo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_visits`
--
ALTER TABLE `page_visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_page_visits_created_at` (`created_at`),
  ADD KEY `idx_page_visits_page_url` (`page_url`),
  ADD KEY `idx_page_visits_device_type` (`device_type`),
  ADD KEY `idx_page_visits_ip_address` (`ip_address`);

--
-- Indexes for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portfolio_media`
--
ALTER TABLE `portfolio_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_portfolio_media_portfolio_id` (`portfolio_id`);

--
-- Indexes for table `referred_clients`
--
ALTER TABLE `referred_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `referrer_id` (`referrer_id`);

--
-- Indexes for table `referrers`
--
ALTER TABLE `referrers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `section_title`
--
ALTER TABLE `section_title`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_media`
--
ALTER TABLE `service_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_media_service_id` (`service_id`);

--
-- Indexes for table `service_text`
--
ALTER TABLE `service_text`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `siteconfig`
--
ALTER TABLE `siteconfig`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sitecontact`
--
ALTER TABLE `sitecontact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social`
--
ALTER TABLE `social`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static`
--
ALTER TABLE `static`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimony`
--
ALTER TABLE `testimony`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `why_us`
--
ALTER TABLE `why_us`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `backup_logs`
--
ALTER TABLE `backup_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `backup_schedule`
--
ALTER TABLE `backup_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `chat_responses`
--
ALTER TABLE `chat_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact_info`
--
ALTER TABLE `contact_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `document_categories`
--
ALTER TABLE `document_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doc_access_tokens`
--
ALTER TABLE `doc_access_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_payments`
--
ALTER TABLE `employee_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee_payment_deductions`
--
ALTER TABLE `employee_payment_deductions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enquiry_text`
--
ALTER TABLE `enquiry_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `finance_customers`
--
ALTER TABLE `finance_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `finance_expenses`
--
ALTER TABLE `finance_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `finance_expense_categories`
--
ALTER TABLE `finance_expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `finance_invoices`
--
ALTER TABLE `finance_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `finance_invoice_items`
--
ALTER TABLE `finance_invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `finance_payments`
--
ALTER TABLE `finance_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `finance_products`
--
ALTER TABLE `finance_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_application_answers`
--
ALTER TABLE `job_application_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `job_questions`
--
ALTER TABLE `job_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `logo`
--
ALTER TABLE `logo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `page_visits`
--
ALTER TABLE `page_visits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3412;

--
-- AUTO_INCREMENT for table `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `portfolio_media`
--
ALTER TABLE `portfolio_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `referred_clients`
--
ALTER TABLE `referred_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `referrers`
--
ALTER TABLE `referrers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `section_title`
--
ALTER TABLE `section_title`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `service_media`
--
ALTER TABLE `service_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `service_text`
--
ALTER TABLE `service_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `siteconfig`
--
ALTER TABLE `siteconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sitecontact`
--
ALTER TABLE `sitecontact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `slider`
--
ALTER TABLE `slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `social`
--
ALTER TABLE `social`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `static`
--
ALTER TABLE `static`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimony`
--
ALTER TABLE `testimony`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `why_us`
--
ALTER TABLE `why_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD CONSTRAINT `fk_job_applications_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_application_answers`
--
ALTER TABLE `job_application_answers`
  ADD CONSTRAINT `fk_answers_application` FOREIGN KEY (`application_id`) REFERENCES `job_applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_answers_question` FOREIGN KEY (`question_id`) REFERENCES `job_questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_questions`
--
ALTER TABLE `job_questions`
  ADD CONSTRAINT `fk_job_questions_job` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `referred_clients`
--
ALTER TABLE `referred_clients`
  ADD CONSTRAINT `referred_clients_ibfk_1` FOREIGN KEY (`referrer_id`) REFERENCES `referrers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
