-- SQL to add tags and display_order columns to service and portfolio tables
-- Run this in your database to add the new fields

-- Add columns to service table
ALTER TABLE `service`
ADD COLUMN IF NOT EXISTS `tags` VARCHAR(255) DEFAULT NULL COMMENT 'Comma-separated tags',
ADD COLUMN IF NOT EXISTS `tag_colors` VARCHAR(255) DEFAULT NULL COMMENT 'Comma-separated tag colors (orange,purple,blue,green,teal,red,yellow,pink,cyan,indigo)',
ADD COLUMN IF NOT EXISTS `display_order` INT(11) DEFAULT 0 COMMENT 'Display order (lower = first)';

-- Add columns to portfolio table
ALTER TABLE `portfolio`
ADD COLUMN IF NOT EXISTS `tags` VARCHAR(255) DEFAULT NULL COMMENT 'Comma-separated tags',
ADD COLUMN IF NOT EXISTS `tag_colors` VARCHAR(255) DEFAULT NULL COMMENT 'Comma-separated tag colors (orange,purple,blue,green,teal,red,yellow,pink,cyan,indigo)',
ADD COLUMN IF NOT EXISTS `display_order` INT(11) DEFAULT 0 COMMENT 'Display order (lower = first)';

-- Create index for faster ordering
CREATE INDEX IF NOT EXISTS idx_service_display_order ON `service`(`display_order`);
CREATE INDEX IF NOT EXISTS idx_portfolio_display_order ON `portfolio`(`display_order`);
