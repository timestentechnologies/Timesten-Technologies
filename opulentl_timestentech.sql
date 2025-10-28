-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 29, 2025 at 04:26 PM
-- Server version: 10.11.13-MariaDB-cll-lve
-- PHP Version: 8.4.10

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
(1, 'timestentechnologies@gmail.com', '$2a$12$Xxa.OXum4/p0kLOWEmUqt.95yORxvOmJrkZ6W3jzq.C1aEsqLbTiq', '2024-08-21 10:22:13');

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
(1, '688e3f1a6f68b-Timestenfavicon.png', '688e3f1a6f8a4-Timestenlogo.png');

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
(5, 'Data Analytics Dashboard for Financial Institution', 'Developed a comprehensive data analytics dashboard to visualize financial data and support decision-making.', 'Client Name: Financial Insights Corp.\r\nProject Overview: Built an interactive dashboard to aggregate and visualize financial metrics. The dashboard provides real-time insights into financial performance and trends.\r\nTechnologies Used: Tableau, SQL, Python, JavaScript\r\nKey Features: Real-time data updates, customizable reports, trend analysis, and data visualization.\r\nResults: Enabled quicker decision-making and strategic planning, leading to a 25% increase in operational efficiency.', '1971default.png'),
(6, 'Personal and Business Portfolios', 'Tailored portfolios that highlight your unique strengths and achievements.', 'We create custom personal and business portfolios designed to showcase your skills, projects, and accomplishments. Whether you need a standout personal brand or a compelling business presentation, our portfolios combine sleek design with effective content management to help you make a powerful impression.', '3971Screenshot 2024-08-18 200205.png'),
(8, 'Property Management System', 'Streamline your property management with RentSmart. The all-in-one solution for landlords and property managers.', 'Powerful Features for Property Management\r\nEverything you need to manage your properties efficiently\r\nhttps://rentsmart.timestentechnologies.co.ke/', '8509Screenshot 2025-08-02 194155.png');

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
(1, 'What People say about Us', 'Hear from our satisfied clients who have experienced the Timesten Technologies difference. Our commitment to delivering exceptional service and tailored solutions has earned us the trust and loyalty of businesses across various industries.\r\n\r\nThese testimonials reflect our dedication to quality, innovation, and customer satisfaction. Let their words inspire confidence in choosing Timesten Kenya as your trusted partner for all your digital needs.', 'Enquiry', 'Have a question or need more details? We\'re here to assist. Fill out our enquiry form, and the team at Timesten Technologies will get back to you promptly. Whether it\'s about our services, pricing, or any other information, we\'re ready to provide the answers you need.\r\n\r\nYour journey to success starts with a simple enquiry reach out today!', 'Contact Us', 'Ready to take your business to the next level? Reach out to Timesten Technologies today. Whether you have a question, need more information about our services, or are ready to start a project, we\'re here to help.\r\n\r\nConnect with us, and let\'s discuss how we can work together to achieve your goals. Your success is just a message away!', 'Our Portfolio', 'Explore our portfolio to see the impact of our work. At Timesten Technologies, we take pride in delivering exceptional digital solutions across various industries. From web development to software integration, our projects showcase our commitment to quality, innovation, and client satisfaction.\r\n\r\nEach project we undertake is a testament to our expertise and our ability to turn challenges into opportunities. Discover how we\'ve helped businesses like yours achieve their goals and elevate their digital presence.', 'Our Services', 'We offer a range of digital solutions, including responsive web development, custom software, seamless integration, data analytics, secure software installation, and expert training. Let us enhance your business with our innovative services.', 'Why Choose Timesten Kenya?', 'We offer more than just services; we provide solutions that are tailored to your success. Here\'s why we stand out:\r\n\r\nExpertise: Our team consists of seasoned professionals with extensive experience in web development, software development, and data analytics.\r\nCustomized Solutions: We understand that every business is unique, and we craft solutions that are perfectly aligned with your needs and goals.\r\nCommitment to Quality: We are dedicated to delivering high-quality services that not only meet but exceed your expectations.\r\nClient-Centric Approach: Your satisfaction is our priority. We work closely with you to ensure that every solution is a perfect fit for your business.\r\nComprehensive Services: From development to integration and training, we provide a complete suite of services that cover all your digital needs.\r\nChoose Timesten Kenya as your trusted partner and experience the difference in quality, commitment, and innovation.', 'About Timesten Technologies', 'We specialize in delivering top-tier digital solutions, including web and software development, integration, data analytics, software installation, and training. Our mission is to empower businesses with innovative technology that drives growth and efficiency. We focus on understanding your unique needs to provide customized solutions that align perfectly with your goals. Let us be your partner in navigating the digital landscape and achieving success.');

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
(3, 'Web Development & SEO Optimization', 'Build a visually stunning, high-performance website optimized for search engines and enhanced with custom graphics.', 'Our web development services focus on creating responsive, user-friendly websites that rank well on search engines. We employ SEO best practices, fast loading times, and engaging visuals to ensure your site attracts and retains visitors.', '5550_5waysseowebdesigngotogether5e2945dd5df37.webp', '2024-08-18 12:49:59'),
(4, 'Smart ERP Systems for Agile Enterprises', 'Implement scalable ERP solutions that streamline operations, enhance data visibility, and support strategic growth.', 'Our ERP systems integrate core business functionsâ€”finance, HR, inventory, and salesâ€”into a unified platform. Tailored to your industry, these systems provide real-time analytics, automate workflows, and ensure compliance, empowering your team to make informed decisions.', '2293thumb_5.jpg', '2024-08-18 12:49:59'),
(5, 'Seamless API Integration Services', 'Enhance system functionality by integrating with external APIs, improving user experience and operational efficiency.', 'We connect your applications to third-party services like payment gateways, CRM systems, and social media platforms. This integration automates processes, reduces manual data entry, and ensures real-time data synchronization across systems.', '5918interactive.png', '2024-08-18 12:49:59'),
(7, 'Graphic Design & Brand Identity Solutions', 'Develop a strong brand presence with our creative graphic design services.', 'From logos to marketing materials, we craft designs that reflect your brand\'s identity and resonate with your target audience. Our designs are tailored to communicate your message effectively across various platforms.', '4619_thebestgraphicdesignagencyinkenyawestlands1.webp', '2025-05-17 15:46:41'),
(8, 'AI-Driven Automation & Data Analytics', 'Leverage artificial intelligence to automate operations and gain powerful insights that fuel smarter business decisions.', 'We fuse the power of AI and advanced data analytics to optimize your business from the inside out. Our solutions automate repetitive tasksâ€”like data entry, reporting, and customer serviceâ€”while advanced analytics provide real-time dashboards, trend forecasts, and predictive modeling. Whether you\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'re optimizing workflows with robotic process automation (RPA) or uncovering hidden opportunities through data mining, our integrated platform empowers faster, smarter decision-making.\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nKey Features:\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nAI-driven workflow automation & chatbot development\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nPredictive analytics & machine learning insights\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nReal-time dashboards and KPI tracking\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nCustom reporting and data visualization\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\nSeamless integration with ERP, CRM, and third-party tools', '8361_AdobeStock600314909.jpeg', '2025-05-17 15:47:16'),
(9, 'Intelligent POS Systems for Retail & Hospitality', 'Transform customer transactions with feature-rich Point of Sale systems tailored to your business.', 'Our POS solutions support inventory management, multi-location syncing, customer loyalty, and real-time sales analytics. Whether you\'re in retail, food service, or hospitality, we provide both cloud-based and offline POS setups to streamline your front and back operations.', '5354_k1.jpg', '2025-05-17 15:48:44');

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
(1, 'TimesTen Technologies', 'TimesTen, TimesTen tech, Technology,Tech, website, websites, seos, erp, erp, kenya, Timesten tech, Timesten kenya', '  TimesTen Technologies is dedicated to delivering top-tier technology services that help businesses succeed in the digital age. With a focus on quality, innovation, and customer satisfaction, we provide tailored solutions for your unique needs.', 'TimesTen Technologies . All rights reserved.', 'Connect with us on social media and stay updated with the latest news and services from TimesTen Technologies.', 'TimesTen Technologies is a leading provider of digital solutions, specializing in web development, software development, integration, data analytics, software installation, and training. We empower businesses with innovative technology to drive growth and efficiency.', 'https://timestentechnologies.co.ke');

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
(1, '0718883983', '0748367201', 'timestentechnologies@gmail.com', 'timestenkenya@gmail.com', 36.8219000, -1.2921000);

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
(1, 'Innovative Solutions for Your Business', 'TimesTen Technologies, we provide cutting-edge web development, custom software solutions, and data analytics to drive your business forward. Our expertise and commitment to excellence ensure that your digital projects are not only successful but also set you apart in a competitive market. Partner with us to transform your ideas into reality and achieve your business goals with confidence.');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `section_title`
--
ALTER TABLE `section_title`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
