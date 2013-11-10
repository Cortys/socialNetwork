-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Host: rdbms
-- Erstellungszeit: 09. Nov 2013 um 18:49
-- Server Version: 5.5.31-log
-- PHP-Version: 5.2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `DB1458046`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groupCategories`
--

DROP TABLE IF EXISTS `groupCategories`;
CREATE TABLE IF NOT EXISTS `groupCategories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Name der Gruppenkategorie. "Freundschaft"',
  `nameRelational` varchar(30) DEFAULT NULL COMMENT 'Gruppenart zur Verwendung im Satz. "A und B sind Freunde"',
  `dateAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groupCategoryConnections`
--

DROP TABLE IF EXISTS `groupCategoryConnections`;
CREATE TABLE IF NOT EXISTS `groupCategoryConnections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` bigint(20) unsigned NOT NULL,
  `category` bigint(20) unsigned NOT NULL,
  `dateAdded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group` (`group`,`category`),
  KEY `group_2` (`group`),
  KEY `category` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groupConnections`
--

DROP TABLE IF EXISTS `groupConnections`;
CREATE TABLE IF NOT EXISTS `groupConnections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'Benutzer-Id',
  `group_id` bigint(20) unsigned NOT NULL COMMENT 'Gruppen-Id',
  `dateEnter` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Beitritt',
  `dateLeft` timestamp NULL DEFAULT NULL COMMENT 'Austritt',
  `dateSeen` timestamp NULL DEFAULT NULL COMMENT 'Zeitpunkt an dem die Gruppe zuletzt angesehen wurde.',
  `rights` tinyint(3) unsigned NOT NULL COMMENT 'Rechte der Benutzers in der Gruppe',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`user_id`,`group_id`,`rights`),
  KEY `dateSeen` (`dateSeen`),
  KEY `user` (`user_id`),
  KEY `group` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titel` varchar(100) NOT NULL COMMENT 'Gruppenname',
  `description` text NOT NULL COMMENT 'Beschreibung',
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
CREATE TABLE IF NOT EXISTS `media` (
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
-- Tabellenstruktur für Tabelle `messageAttachments`
--

DROP TABLE IF EXISTS `messageAttachments`;
CREATE TABLE IF NOT EXISTS `messageAttachments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `message` bigint(20) unsigned NOT NULL COMMENT 'Nachricht zu der der Anhang gehoert.',
  `media` bigint(20) unsigned NOT NULL COMMENT 'Inhalt des Anhangs.',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`message`),
  KEY `message` (`message`),
  KEY `media` (`media`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` mediumtext COMMENT 'Textbotschaft',
  `mood` tinyint(3) unsigned DEFAULT NULL COMMENT 'Stimmungswert',
  `user` bigint(20) unsigned NOT NULL COMMENT 'Eigentuemer der Nachricht.',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Zeitpunkt der Erstellung in aktueller Form.',
  `clonable` bigint(20) unsigned DEFAULT NULL COMMENT 'Gruppe/User, die die Nachricht klonen und weiterverbreiten kann.',
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `clonable` (`clonable`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
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
-- Tabellenstruktur für Tabelle `salts`
--

DROP TABLE IF EXISTS `salts`;
CREATE TABLE IF NOT EXISTS `salts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salt` varchar(128) NOT NULL COMMENT 'Salt im Klartext',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL COMMENT 'Angezeigter Benutzername',
  `email` varchar(100) NOT NULL COMMENT 'Mail',
  `description` text NOT NULL COMMENT 'Beschreibung',
  `password` varchar(128) NOT NULL COMMENT 'Passwort-Hash',
  `salt` int(11) unsigned NOT NULL COMMENT 'Verwendeter Salt aus salt-Tabelle',
  `pic` bigint(20) unsigned NOT NULL COMMENT 'Profilbild als media-id',
  `dateRegistration` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Zeitpunkt der Registrierung',
  `activate` varchar(128) DEFAULT NULL COMMENT 'Wenn gesetzt: Account noch nicht aktiviert. Sonst: Aktiv.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`email`),
  KEY `pic` (`pic`),
  KEY `salt` (`salt`),
  KEY `name` (`first_name`,`last_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
