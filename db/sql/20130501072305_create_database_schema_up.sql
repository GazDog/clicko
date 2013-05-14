
CREATE TABLE `users` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `agencyid` INT,
 `isadministrator` TINYINT(1) DEFAULT 0 NOT NULL,
 `firstname` VARCHAR(64) NOT NULL,
 `lastname` VARCHAR(64) NOT NULL,
 `phone` VARCHAR(64) NOT NULL,
 `email` VARCHAR(64) NOT NULL,
 `accesslevel` INT DEFAULT 1 NOT NULL,
 `statusid` INT DEFAULT 1 NOT NULL,
 `password` VARCHAR(256) NOT NULL,
 `salt` VARCHAR(256) NOT NULL,
 `passwordresettoken` VARCHAR(256),
 `passwordresetat` DATETIME,
 `isconfirmed` TINYINT(1) DEFAULT 0 NOT NULL,
 `emailconfirmationtoken` VARCHAR(256),
 `lastloginat` DATETIME,
 `logincount` INT DEFAULT 0 NOT NULL,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `agencies` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(64) NOT NULL,
 `streetnumber` VARCHAR(16),
 `streetname` VARCHAR(64),
 `suburb` VARCHAR(32),
 `phone` VARCHAR(16),
 `email` VARCHAR(64),
 `statusid` INT DEFAULT 1 NOT NULL,
 `accesslevel` INT DEFAULT 1 NOT NULL,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `customers` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `agencyid` INT NOT NULL,
 `name` VARCHAR(64) NOT NULL,
 `website` VARCHAR(64) NOT NULL,
 `phone` VARCHAR(16),
 `email` VARCHAR(64),
 `statusid` INT DEFAULT 1 NOT NULL,
 `accesslevel` INT DEFAULT 1 NOT NULL,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `publishers` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `customerid` INT NOT NULL,
 `name` VARCHAR(64) NOT NULL,
 `website` VARCHAR(64) NOT NULL,
 `contactname` VARCHAR(64) NOT NULL,
 `phone` VARCHAR(16),
 `email` VARCHAR(64),
 `statusid` INT DEFAULT 1 NOT NULL,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `campaigns` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `customerid` INT NOT NULL,
 `name` VARCHAR(64) NOT NULL,
 `startat` DATETIME,
 `finishat` DATETIME,
 `creatoruserid` INT NOT NULL,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `assets` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `campaignid` INT NOT NULL,
 `publisherid` INT NOT NULL,
 `name` VARCHAR(64) NOT NULL,
 `sourceurl` VARCHAR(128) NOT NULL,
 `destinationurl` VARCHAR(128) NOT NULL,
 `startat` DATETIME,
 `finishat` DATETIME,
 `notes` TEXT,
 `createdat` DATETIME,
 `updatedat` DATETIME,
 `deletedat` DATETIME
);
CREATE TABLE `clicks` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `assetid` INT NOT NULL,
 `ipaddress` VARCHAR(32) NOT NULL,
 `browser` VARCHAR(32) NOT NULL,
 `browserversion` VARCHAR(16) NOT NULL,
 `createdat` DATETIME
);
CREATE TABLE `actions` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `entitytype` VARCHAR(16) NOT NULL,
 `entityid` INT NOT NULL,
 `createdat` DATETIME
);
CREATE TABLE `changes` (
 `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 `actionid` INT NOT NULL,
 `oldvalue` VARCHAR(64) NOT NULL,
 `newvalue` VARCHAR(64) NOT NULL
);
