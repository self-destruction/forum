-- creating db
CREATE DATABASE IF NOT EXISTS `forum`;
USE `forum`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(60) NOT NULL,
  `hash` CHAR(64) NOT NULL,
  `role` ENUM('admin', 'user') NOT NULL DEFAULT 'user',
  `isBlocked` BOOLEAN NOT NULL DEFAULT FALSE,
  `description` TEXT DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastLogin` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE UNIQUE INDEX `idx_user_login`
  ON `forum`.`user`(`login`);

DROP TABLE IF EXISTS `theme`;
CREATE TABLE IF NOT EXISTS `theme` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `tags` TEXT DEFAULT NULL,
  `status` ENUM('opened', 'closed', 'blocked') NOT NULL DEFAULT 'opened',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`) REFERENCES `forum`.`user`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INT(11) UNSIGNED NOT NULL,
  `themeId` INT(11) UNSIGNED NOT NULL,
  `text` TEXT DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`userId`) REFERENCES `forum`.`user`(`id`),
  FOREIGN KEY (`themeId`) REFERENCES `forum`.`theme`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `picture`;
CREATE TABLE IF NOT EXISTS `picture` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `messageId` INT(11) UNSIGNED NOT NULL,
  `path` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`messageId`) REFERENCES `forum`.`message`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;