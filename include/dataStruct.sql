-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 29. Sep 2013 um 21:21
-- Server Version: 5.5.33
-- PHP-Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `socialNetwork`
--
CREATE DATABASE IF NOT EXISTS `socialNetwork` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `socialNetwork`;

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
  KEY `id` (`id`,`message`)
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
  KEY `group` (`group`,`category`)
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
  `dateDeleted` timestamp NULL DEFAULT NULL COMMENT 'Wenn gelöscht: Loeschzeitpunkt. Sonst: null.',
  PRIMARY KEY (`id`)
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
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`location`),
  KEY `hash` (`hash`)
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
  `rights` tinyint(3) unsigned NOT NULL COMMENT 'Rechte der Benutzers in der Gruppe',
  PRIMARY KEY (`id`),
  KEY `id` (`id`,`user`,`group`,`rights`)
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
  KEY `user` (`user`)
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
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'zeitpunkt der Veröffentlichung.',
  PRIMARY KEY (`id`),
  KEY `group` (`group`,`message`,`user`,`repliesTo`)
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
  `salt` int(11) NOT NULL COMMENT 'Verwendeter Salt aus salt-Tabelle',
  `pic` bigint(20) unsigned NOT NULL COMMENT 'Profilbild als media-id',
  `dateRegistration` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Zeitpunkt der Registrierung',
  `activate` varchar(128) DEFAULT NULL COMMENT 'Wenn gesetzt: Account noch nicht aktiviert. Sonst: Aktiv.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`),
  KEY `name` (`name`,`activate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
