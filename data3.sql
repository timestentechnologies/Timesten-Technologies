-- Create database
CREATE DATABASE IF NOT EXISTS my_database;
USE my_database;

-- Table: section_title
CREATE TABLE IF NOT EXISTS section_title (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    test_title VARCHAR(255) DEFAULT NULL,
    test_text TEXT DEFAULT NULL,
    enquiry_title VARCHAR(255) DEFAULT NULL,
    enquiry_text TEXT DEFAULT NULL,
    contact_title VARCHAR(255) DEFAULT NULL,
    contact_text TEXT DEFAULT NULL,
    port_title VARCHAR(255) DEFAULT NULL,
    port_text TEXT DEFAULT NULL,
    service_title VARCHAR(255) DEFAULT NULL,
    service_text TEXT DEFAULT NULL,
    why_title VARCHAR(255) DEFAULT NULL,
    why_text TEXT DEFAULT NULL,
    about_title VARCHAR(255) DEFAULT NULL,
    about_text TEXT DEFAULT NULL
);

-- Table: sitecontact
CREATE TABLE IF NOT EXISTS sitecontact (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    phone1 VARCHAR(20) DEFAULT NULL,
    phone2 VARCHAR(20) DEFAULT NULL,
    email1 VARCHAR(100) DEFAULT NULL,
    email2 VARCHAR(100) DEFAULT NULL,
    longitude DECIMAL(10, 7) DEFAULT NULL,
    latitude DECIMAL(10, 7) DEFAULT NULL
);

-- Table: siteconfig
CREATE TABLE IF NOT EXISTS siteconfig (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    site_title VARCHAR(255) DEFAULT NULL,
    site_keyword VARCHAR(255) DEFAULT NULL,
    site_about TEXT DEFAULT NULL,
    site_footer TEXT DEFAULT NULL,
    follow_text TEXT DEFAULT NULL,
    site_desc TEXT DEFAULT NULL,
    site_url VARCHAR(255) DEFAULT NULL
);

-- Table: logo
CREATE TABLE IF NOT EXISTS logo (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    xfile VARCHAR(255) DEFAULT NULL,
    ufile VARCHAR(255) DEFAULT NULL
);

-- Table: social
CREATE TABLE IF NOT EXISTS social (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) DEFAULT NULL,
    fa VARCHAR(255) DEFAULT NULL,
    social_link VARCHAR(255) DEFAULT NULL
);

-- Table: admin
CREATE TABLE IF NOT EXISTS admin (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    last_login TIMESTAMP NULL DEFAULT NULL
);

-- Table: static
CREATE TABLE IF NOT EXISTS static (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stitle VARCHAR(255) NOT NULL,
    stext TEXT NOT NULL
);

-- Table: why_us
CREATE TABLE IF NOT EXISTS why_us (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);

-- Table: service
CREATE TABLE IF NOT EXISTS service (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_title VARCHAR(255) NOT NULL,
    service_desc TEXT NOT NULL,
    service_detail TEXT NOT NULL
);

-- Table: portfolio
CREATE TABLE IF NOT EXISTS portfolio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    port_title VARCHAR(255) NOT NULL,
    port_desc TEXT NOT NULL,
    port_detail TEXT NOT NULL,
    ufile VARCHAR(255) NOT NULL
);

-- Table: testimonial
CREATE TABLE IF NOT EXISTS testimony (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    position VARCHAR(255) NOT NULL,
    ufile VARCHAR(255) NOT NULL
);

-- Table: contact_info
CREATE TABLE IF NOT EXISTS contact_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Table: service_text
CREATE TABLE IF NOT EXISTS service_text (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    text TEXT NOT NULL
);

-- Table: enquiry_text
CREATE TABLE IF NOT EXISTS enquiry_text (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    text TEXT NOT NULL
);

-- Table: user
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    nod DATE DEFAULT NULL,
    nationality VARCHAR(255) DEFAULT NULL,
    pod DATE DEFAULT NULL,
    dod DATE DEFAULT NULL,
    itd TEXT DEFAULT NULL,
    sn VARCHAR(255) DEFAULT NULL,
    sc VARCHAR(255) DEFAULT NULL,
    nok VARCHAR(255) DEFAULT NULL,
    cv VARCHAR(255) DEFAULT NULL
);

-- Table: blog
CREATE TABLE IF NOT EXISTS blog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blog_title VARCHAR(255) NOT NULL,
    blog_desc TEXT NOT NULL,
    blog_detail TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ufile VARCHAR(255) DEFAULT NULL
);

-- Table: slider
CREATE TABLE IF NOT EXISTS slider (
    id INT AUTO_INCREMENT PRIMARY KEY,
    slide_title VARCHAR(255) NOT NULL,
    slide_text TEXT NOT NULL,
    ufile VARCHAR(255) DEFAULT NULL
);

-- Insert sample data into section_title
INSERT INTO section_title (id, test_title, test_text, enquiry_title, enquiry_text, contact_title, contact_text, port_title, port_text, service_title, service_text, why_title, why_text, about_title, about_text)
VALUES
(1, 'Test Title', 'Test text here...', 'Enquiry Title', 'Enquiry text here...', 'Contact Title', 'Contact text here...', 'Portfolio Title', 'Portfolio text here...', 'Service Title', 'Service text here...', 'Why Title', 'Why text here...', 'About Title', 'About text here...');

-- Insert sample data into sitecontact
INSERT INTO sitecontact (id, phone1, phone2, email1, email2, longitude, latitude)
VALUES
(1, '123-456-7890', '098-765-4321', 'info@example.com', 'support@example.com', 36.8219, -1.2921);

-- Insert sample data into siteconfig
INSERT INTO siteconfig (site_title, site_keyword, site_about, site_footer, follow_text, site_desc, site_url)
VALUES
('TimesTen Kenya', 'Kenya, TimesTen, Technology', 'About TimesTen Kenya...', 'Footer text here...', 'Follow us on social media...', 'Description of TimesTen Kenya...', 'https://timestenkenya.com');

-- Insert sample data into logo
INSERT INTO logo (xfile, ufile)
VALUES
('xlogo.png','logo.png');

-- Insert sample data into social
INSERT INTO social (name, fa, social_link)
VALUES
('Facebook', 'fa-facebook', 'https://facebook.com'),
('Twitter', 'fa-twitter', 'https://twitter.com'),
('LinkedIn', 'fa-linkedin', 'https://linkedin.com'),
('Instagram', 'fa-instagram', 'https://instagram.com'),
('YouTube', 'fa-youtube', 'https://youtube.com');

-- Insert sample data into admin
INSERT INTO admin (username, password, last_login)
VALUES
('admin', 'admin', NULL); -- Note: Passwords should be hashed in production

-- Insert sample data into static
INSERT INTO static (stitle, stext)
VALUES
('Static Title', 'Static content here...');

-- Insert sample data into why_us
INSERT INTO why_us (title, detail)
VALUES
('Why Us Title', 'Why us detail here...');

-- Insert sample data into service
INSERT INTO service (service_title, service_desc, service_detail)
VALUES
('Service Title', 'Service description here...', 'Detailed service information here...');

-- Insert sample data into portfolio
INSERT INTO portfolio (port_title, port_desc, port_detail, ufile)
VALUES
('Portfolio Title', 'Portfolio description here...', 'Detailed portfolio information here...', 'portfolio_image.png');

-- Insert sample data into testimonial
INSERT INTO testimony (name, message, position, ufile)
VALUES
('John Doe', 'Testimonial message here...', 'Position', 'portfolio_image.png');

-- Insert sample data into contact_info
INSERT INTO contact_info (phone, email)
VALUES
('123-456-7890', 'contact@example.com');

-- Insert sample data into service_text
INSERT INTO service_text (title, text)
VALUES
('Service Text Title', 'Service text content here...');

-- Insert sample data into enquiry_text
INSERT INTO enquiry_text (title, text)
VALUES
('Enquiry Text Title', 'Enquiry text content here...');

-- Insert sample data into user
INSERT INTO user (username, password, role, nod, nationality, pod, dod, itd, sn, sc, nok, cv)
VALUES
('user', 'userpassword', 'User Role', '2000-01-01', 'Nationality', '2000-01-01', '2000-01-01', 'ITD Info', 'SN Info', 'SC Info', 'NOK Info', 'cv_file.png');

-- Insert sample data into blog
INSERT INTO blog (blog_title, blog_desc, blog_detail, created_at, ufile)
VALUES
('Sample Blog Title', 'This is a short description of the blog post.', 'This is a detailed description of the blog post content.', NOW(), 'sample_blog_image.png');

-- Insert sample data into slider
INSERT INTO slider (slide_title, slide_text, ufile)
VALUES
('Slide Title', 'Slide text content here...', 'slide_image.png');
