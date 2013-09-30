-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 30. Sep 2013 um 09:00
-- Server Version: 5.5.33
-- PHP-Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `socialNetwork`
--
-- CREATE DATABASE IF NOT EXISTS `socialNetwork` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
-- USE `socialNetwork`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `attachment`
--

DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `message` bigint(20) unsigned NOT NULL COMMENT 'Nachricht zu der der Anhang gehoert.',
  `media` bigint(20) unsigned NOT NULL COMMENT 'Inhalt des Anhangs.',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`message`),
  KEY `message` (`message`),
  KEY `media` (`media`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Name der Gruppenkategorie. "Freundschaft"',
  `nameRelational` varchar(30) DEFAULT NULL COMMENT 'Gruppenart zur Verwendung im Satz. "A und B sind Freunde"',
  `dateAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `categoryConnection`
--

DROP TABLE IF EXISTS `categoryConnection`;
CREATE TABLE `categoryConnection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` bigint(20) unsigned NOT NULL,
  `category` bigint(20) unsigned NOT NULL,
  `dateAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group` (`group`,`category`),
  KEY `group_2` (`group`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Gruppenname',
  `desc` text NOT NULL COMMENT 'Beschreibung',
  `pic` bigint(20) unsigned NOT NULL COMMENT 'Gruppenbild',
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Erstellungszeit der Gruppe',
  `dateDeleted` timestamp NULL DEFAULT NULL COMMENT 'Wenn gelÃ¶scht: Loeschzeitpunkt. Sonst: null.',
  PRIMARY KEY (`id`),
  KEY `pic` (`pic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location` varchar(512) NOT NULL COMMENT 'Dateiname',
  `hash` varchar(128) NOT NULL COMMENT 'Hash der Datei',
  `type` varchar(50) DEFAULT NULL COMMENT 'Dateityp',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`location`),
  KEY `hash` (`hash`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `member`
--

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` bigint(20) unsigned NOT NULL COMMENT 'Benutzer-Id',
  `group` bigint(20) unsigned NOT NULL COMMENT 'Gruppen-Id',
  `dateEnter` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Beitritt',
  `dateLeft` timestamp NULL DEFAULT NULL COMMENT 'Austritt',
  `dateSeen` timestamp NULL DEFAULT NULL COMMENT 'Zeitpunkt an dem die Gruppe zuletzt angesehen wurde.',
  `rights` tinyint(3) unsigned NOT NULL COMMENT 'Rechte der Benutzers in der Gruppe',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`user`,`group`,`rights`),
  KEY `dateSeen` (`dateSeen`),
  KEY `user` (`user`),
  KEY `group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `text` mediumtext COMMENT 'Textbotschaft',
  `mood` tinyint(3) unsigned DEFAULT NULL COMMENT 'Stimmungswert',
  `user` bigint(20) unsigned NOT NULL COMMENT 'Eigentuemer der Nachricht.',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Zeitpunkt der Erstellung in aktueller Form.',
  `clonable` bigint(20) unsigned DEFAULT NULL COMMENT 'Gruppe/User, die die Nachricht klonen und weiterverbreiten kann.',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `clonable` (`clonable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` bigint(20) unsigned NOT NULL COMMENT 'Gruppe in der gepostet wurde.',
  `message` bigint(20) unsigned NOT NULL COMMENT 'Nachricht-Id.',
  `user` bigint(20) unsigned NOT NULL COMMENT 'Benutzer der postet.',
  `repliesTo` bigint(20) unsigned DEFAULT NULL COMMENT 'Antwort auf anderen Post? Wen ja, Id.',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'zeitpunkt der VerÃ¶ffentlichung.',
  PRIMARY KEY (`id`),
  KEY `group` (`group`,`message`,`user`,`repliesTo`),
  KEY `message` (`message`),
  KEY `user` (`user`),
  KEY `repliesTo` (`repliesTo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `salt`
--

DROP TABLE IF EXISTS `salt`;
CREATE TABLE `salt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salt` varchar(128) NOT NULL COMMENT 'Salt im Klartext',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Angezeigter Benutzername',
  `mail` varchar(100) NOT NULL COMMENT 'Mail',
  `desc` text NOT NULL COMMENT 'Beschreibung',
  `pw` varchar(128) NOT NULL COMMENT 'Passwort-Hash',
  `salt` int(11) unsigned NOT NULL COMMENT 'Verwendeter Salt aus salt-Tabelle',
  `pic` bigint(20) unsigned NOT NULL COMMENT 'Profilbild als media-id',
  `dateRegistration` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Zeitpunkt der Registrierung',
  `activate` varchar(128) DEFAULT NULL COMMENT 'Wenn gesetzt: Account noch nicht aktiviert. Sonst: Aktiv.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`),
  KEY `name` (`name`,`activate`),
  KEY `pic` (`pic`),
  KEY `salt` (`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `attachment`
--
ALTER TABLE `attachment`
  ADD CONSTRAINT `attachment_ibfk_2` FOREIGN KEY (`media`) REFERENCES `media` (`id`),
  ADD CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`message`) REFERENCES `message` (`id`);

--
-- Constraints der Tabelle `categoryConnection`
--
ALTER TABLE `categoryConnection`
  ADD CONSTRAINT `categoryconnection_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `categoryconnection_ibfk_1` FOREIGN KEY (`group`) REFERENCES `group` (`id`);

--
-- Constraints der Tabelle `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`pic`) REFERENCES `media` (`id`);

--
-- Constraints der Tabelle `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_2` FOREIGN KEY (`group`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`clonable`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_4` FOREIGN KEY (`repliesTo`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`group`) REFERENCES `group` (`id`),
  ADD CONSTRAINT `post_ibfk_2` FOREIGN KEY (`message`) REFERENCES `message` (`id`),
  ADD CONSTRAINT `post_ibfk_3` FOREIGN KEY (`user`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`salt`) REFERENCES `salt` (`id`),
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`pic`) REFERENCES `media` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
