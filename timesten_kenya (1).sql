-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2024 at 07:22 PM
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
-- Database: `timesten_kenya`
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
(1, 'admin', 'admin', NULL);

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
(4, 'Leveraging Data Analytics to Drive Informed Business Decisions', 'Learn how data analytics provides insights, predictive models, and visualization tools to enhance decision-making and business performance.', 'Introduction:\r\nData analytics plays a crucial role in today’s business landscape, offering insights that help companies make informed decisions and optimize their strategies.\r\n\r\nData Collection:\r\nEffective data collection involves gathering relevant and accurate information from various sources. Proper management ensures that the data is reliable and useful for analysis.\r\n\r\nData Analysis:\r\nAnalyzing data involves examining patterns and trends to uncover valuable insights. Techniques such as statistical analysis and data mining help businesses understand their data better.\r\n\r\nPredictive Analytics:\r\nPredictive analytics uses historical data to forecast future trends and behaviors. This helps businesses anticipate changes and make proactive decisions.\r\n\r\nVisualization:\r\nData visualization tools present complex data in an easy-to-understand format. Visualizations such as charts and graphs help stakeholders grasp insights quickly and make informed decisions.\r\n\r\nReal-World Examples:\r\nExplore case studies of businesses that have successfully used data analytics to drive their strategies and achieve their goals.\r\n\r\nConclusion:\r\nHarnessing the power of data analytics enables businesses to make strategic, data-driven decisions. Timesten Kenya offers expert analytics services to help you unlock the full potential of your data.', '2024-08-18 13:39:23', '1376interactive.png');

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
-- Table structure for table `logo`
--

CREATE TABLE `logo` (
  `id` int(11) NOT NULL,
  `xfile` varchar(255) DEFAULT NULL,
  `ufile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `logo`
--

INSERT INTO `logo` (`id`, `xfile`, `ufile`) VALUES
(1, '766img-1.png', '4469logo-sm.png');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio`
--

CREATE TABLE `portfolio` (
  `id` int(11) NOT NULL,
  `port_title` varchar(255) NOT NULL,
  `port_desc` text NOT NULL,
  `port_detail` text NOT NULL,
  `ufile` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio`
--

INSERT INTO `portfolio` (`id`, `port_title`, `port_desc`, `port_detail`, `ufile`) VALUES
(3, 'E-commerce Website for Retailer', 'Developed a dynamic e-commerce platform for a retailer, featuring a seamless shopping experience and robust backend functionality.', 'Client Name: Retailer Inc.\r\nProject Overview: Created a fully functional e-commerce website to enhance online sales and customer engagement. The platform includes a user-friendly interface, secure payment options, and inventory management.\r\nTechnologies Used: PHP, MySQL, JavaScript, HTML/CSS, Bootstrap\r\nKey Features: Integrated shopping cart, product search and filter, user accounts, and order tracking.\r\nResults: Increased online sales by 30% and improved customer satisfaction with a more intuitive shopping experience.', '6864Screenshot 2024-08-18 172252.png'),
(4, 'Custom CRM System for Service Provider', 'Designed and developed a custom CRM system to streamline customer interactions and improve service delivery.', 'Client Name: Service Provider Ltd.\r\nProject Overview: Implemented a tailored CRM solution to manage client data, track interactions, and automate follow-ups. The system integrates with existing tools to enhance operational efficiency.\r\nTechnologies Used: Python, Django, PostgreSQL, JavaScript\r\nKey Features: Client management, automated email campaigns, detailed reporting, and analytics.\r\nResults: Reduced administrative workload by 40% and increased client retention through better service management.', '5537creative.png'),
(5, 'Data Analytics Dashboard for Financial Institution', 'Developed a comprehensive data analytics dashboard to visualize financial data and support decision-making.', 'Client Name: Financial Insights Corp.\r\nProject Overview: Built an interactive dashboard to aggregate and visualize financial metrics. The dashboard provides real-time insights into financial performance and trends.\r\nTechnologies Used: Tableau, SQL, Python, JavaScript\r\nKey Features: Real-time data updates, customizable reports, trend analysis, and data visualization.\r\nResults: Enabled quicker decision-making and strategic planning, leading to a 25% increase in operational efficiency.', '1971default.png'),
(6, 'Personal and Business Portfolios', 'Tailored portfolios that highlight your unique strengths and achievements.', 'We create custom personal and business portfolios designed to showcase your skills, projects, and accomplishments. Whether you need a standout personal brand or a compelling business presentation, our portfolios combine sleek design with effective content management to help you make a powerful impression.', '3971Screenshot 2024-08-18 200205.png');

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
  `about_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_title`
--

INSERT INTO `section_title` (`id`, `test_title`, `test_text`, `enquiry_title`, `enquiry_text`, `contact_title`, `contact_text`, `port_title`, `port_text`, `service_title`, `service_text`, `why_title`, `why_text`, `about_title`, `about_text`) VALUES
(1, 'What People say about Us', 'Hear from our satisfied clients who have experienced the Timesten Kenya difference. Our commitment to delivering exceptional service and tailored solutions has earned us the trust and loyalty of businesses across various industries.\r\n\r\nThese testimonials reflect our dedication to quality, innovation, and customer satisfaction. Let their words inspire confidence in choosing Timesten Kenya as your trusted partner for all your digital needs.', 'Enquiry', 'Have a question or need more details? We\'re here to assist. Fill out our enquiry form, and the team at Timesten Kenya will get back to you promptly. Whether it\'s about our services, pricing, or any other information, we\'re ready to provide the answers you need.\r\n\r\nYour journey to success starts with a simple enquiry—reach out today!', 'Contact Us', 'Ready to take your business to the next level? Reach out to Timesten Kenya today. Whether you have a question, need more information about our services, or are ready to start a project, we\'re here to help.\r\n\r\nConnect with us, and let’s discuss how we can work together to achieve your goals. Your success is just a message away!', 'Our Portfolio', 'Explore our portfolio to see the impact of our work. At Timesten Kenya, we take pride in delivering exceptional digital solutions across various industries. From web development to software integration, our projects showcase our commitment to quality, innovation, and client satisfaction.\r\n\r\nEach project we undertake is a testament to our expertise and our ability to turn challenges into opportunities. Discover how we’ve helped businesses like yours achieve their goals and elevate their digital presence.', 'Our Services', 'We offer a range of digital solutions, including responsive web development, custom software, seamless integration, data analytics, secure software installation, and expert training. Let us enhance your business with our innovative services.', 'Why Choose Timesten Kenya?', 'At Timesten Kenya, we offer more than just services; we provide solutions that are tailored to your success. Here\'s why we stand out:\r\n\r\nExpertise: Our team consists of seasoned professionals with extensive experience in web development, software development, and data analytics.\r\nCustomized Solutions: We understand that every business is unique, and we craft solutions that are perfectly aligned with your needs and goals.\r\nCommitment to Quality: We are dedicated to delivering high-quality services that not only meet but exceed your expectations.\r\nClient-Centric Approach: Your satisfaction is our priority. We work closely with you to ensure that every solution is a perfect fit for your business.\r\nComprehensive Services: From development to integration and training, we provide a complete suite of services that cover all your digital needs.\r\nChoose Timesten Kenya as your trusted partner and experience the difference in quality, commitment, and innovation.', 'About Timesten Kenya', 'At Timesten Kenya, we specialize in delivering top-tier digital solutions, including web and software development, integration, data analytics, software installation, and training. Our mission is to empower businesses with innovative technology that drives growth and efficiency. We focus on understanding your unique needs to provide customized solutions that align perfectly with your goals. Let us be your partner in navigating the digital landscape and achieving success.');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `service_title` varchar(255) NOT NULL,
  `service_desc` text NOT NULL,
  `service_detail` text NOT NULL,
  `ufile` varchar(255) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `service_title`, `service_desc`, `service_detail`, `ufile`, `updated_at`) VALUES
(3, 'Web Development', 'Create a compelling online presence with our expert web development services, designed to enhance user experience and engagement.', 'Overview: Our web development services include building responsive and visually appealing websites that perform seamlessly across all devices. We focus on delivering a high-quality user experience through custom design and robust functionality.\r\nKey Features: Responsive design, custom CMS, e-commerce integration, SEO optimization, and performance optimization.\r\nBenefits: Improve user engagement, increase traffic, and enhance brand visibility with a professionally developed website that meets your specific needs.\r\nTechnology Used: HTML5, CSS3, JavaScript, PHP, and various CMS platforms like WordPress and Joomla.\r\nClient Impact: Clients benefit from a modern, scalable website that supports their business goals and adapts to changing market trends.\r\n', '7506blog-8.jpg', '2024-08-18 12:49:59'),
(4, 'Custom Software Development', 'Transform your business operations with our custom software solutions, tailored to meet your unique requirements and enhance efficiency.', 'Overview: We develop bespoke software solutions that cater specifically to your business needs, offering enhanced functionality, integration, and scalability. Our approach ensures that the software evolves with your business.\r\nKey Features: Custom application development, integration with existing systems, scalability, and robust security features.\r\nBenefits: Streamline operations, improve productivity, and gain a competitive edge with software that is designed to fit perfectly with your business processes.\r\nTechnology Used: Java, Python, .NET, SQL, and cloud platforms.\r\nClient Impact: Businesses experience increased efficiency and flexibility, with software that supports their growth and adapts to their evolving needs.\r\n', '2293thumb_5.jpg', '2024-08-18 12:49:59'),
(5, 'Data Analytics', 'Unlock valuable insights from your data with our comprehensive analytics services, designed to drive strategic decision-making and business growth.', 'Overview: Our data analytics services provide in-depth analysis and visualization of your data to help you understand trends, make informed decisions, and optimize your strategies. We turn raw data into actionable insights.\r\nKey Features: Data collection and management, advanced statistical analysis, custom reporting, and interactive dashboards.\r\nBenefits: Make data-driven decisions, identify opportunities for growth, and enhance operational efficiency with clear and actionable insights.\r\nTechnology Used: Tableau, Power BI, SQL, R, and Python.\r\nClient Impact: Clients gain a deeper understanding of their business metrics, leading to improved strategies and better overall performance.\r\n', '5918interactive.png', '2024-08-18 12:49:59');

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
  `site_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siteconfig`
--

INSERT INTO `siteconfig` (`id`, `site_title`, `site_keyword`, `site_about`, `site_footer`, `follow_text`, `site_desc`, `site_url`) VALUES
(1, 'TimesTen Kenya', 'Kenya, TimesTen, Technology', 'TimesTen Kenya is dedicated to delivering top-tier technology services that help businesses succeed in the digital age. With a focus on quality, innovation, and customer satisfaction, we provide tailored solutions for your unique needs.', '© 2024 TimesTen Kenya. All rights reserved.', 'Connect with us on social media and stay updated with the latest news and services from TimesTen Kenya.', 'TimesTen Kenya is a leading provider of digital solutions, specializing in web development, software development, integration, data analytics, software installation, and training. We empower businesses with innovative technology to drive growth and efficiency.', 'https://timestenkenya.com');

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
  `longitude` decimal(10,7) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sitecontact`
--

INSERT INTO `sitecontact` (`id`, `phone1`, `phone2`, `email1`, `email2`, `longitude`, `latitude`) VALUES
(1, '0718883983', '0748367201', 'timestenkenya@gmail.com', 'chombaalex2019@gmail.com', 36.8219000, -1.2921000);

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE `slider` (
  `id` int(11) NOT NULL,
  `slide_title` varchar(255) NOT NULL,
  `slide_text` text NOT NULL,
  `ufile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slider`
--

INSERT INTO `slider` (`id`, `slide_title`, `slide_text`, `ufile`) VALUES
(2, 'Empowering Your Digital Transformation', 'Explore our portfolio of successful projects, where we’ve delivered innovative web solutions, custom software, and data analytics tailored to our clients\' needs. See how our expertise can elevate your business and drive meaningful results.', '537user-illustarator-2.png');

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
(1, 'Facebook', 'fa-facebook', 'https://facebook.com'),
(2, 'Twitter', 'fa-twitter', 'https://twitter.com'),
(3, 'LinkedIn', 'fa-linkedin', 'https://linkedin.com'),
(4, 'Instagram', 'fa-instagram', 'https://instagram.com'),
(5, 'YouTube', 'fa-youtube', 'https://youtube.com');

-- --------------------------------------------------------

--
-- Table structure for table `static`
--

CREATE TABLE `static` (
  `id` int(11) NOT NULL,
  `stitle` varchar(255) NOT NULL,
  `stext` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `static`
--

INSERT INTO `static` (`id`, `stitle`, `stext`) VALUES
(1, 'Innovative Solutions for Your Business', 'At Timesten Kenya, we provide cutting-edge web development, custom software solutions, and data analytics to drive your business forward. Our expertise and commitment to excellence ensure that your digital projects are not only successful but also set you apart in a competitive market. Partner with us to transform your ideas into reality and achieve your business goals with confidence.');

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
(2, 'Alex Mwangi', 'We had an outstanding experience working with TimesTen Kenya. Their attention to detail and expertise in web development greatly contributed to the success of our project. Highly recommended for any tech needs!', 'CEO, Tech Innovations', '4045f.jpg'),
(3, ' John Smith', 'TimesTen Kenya delivered exceptional software solutions tailored to our specific requirements. Their professionalism and commitment to quality were evident throughout the project. A true partner in technology!', 'CTO, Global Solutions', '8471avatar-1.png'),
(4, 'Emily Johnson', 'Our collaboration with TimesTen Kenya was incredibly smooth. They provided invaluable insights and support in data analytics that significantly improved our marketing strategies. A reliable and innovative team!', 'Marketing Director, Creative Hub', '5096e.jpg');

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
-- Indexes for table `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_info`
--
ALTER TABLE `contact_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enquiry_text`
--
ALTER TABLE `enquiry_text`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logo`
--
ALTER TABLE `logo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `contact_info`
--
ALTER TABLE `contact_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `enquiry_text`
--
ALTER TABLE `enquiry_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `logo`
--
ALTER TABLE `logo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `section_title`
--
ALTER TABLE `section_title`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `why_us`
--
ALTER TABLE `why_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
