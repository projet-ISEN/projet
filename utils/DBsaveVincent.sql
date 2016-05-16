-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 16 Mai 2016 à 15:48
-- Version du serveur :  5.7.9
-- Version de PHP :  5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `projetm1`
--

-- --------------------------------------------------------

--
-- Structure de la table `choice`
--

DROP TABLE IF EXISTS `choice`;
CREATE TABLE IF NOT EXISTS `choice` (
  `login` char(8) NOT NULL,
  `club_id` char(36) NOT NULL,
  `choice_number` int(11) NOT NULL,
  PRIMARY KEY (`login`,`club_id`),
  KEY `fk_association_9` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `choice`
--

INSERT INTO `choice` (`login`, `club_id`, `choice_number`) VALUES
('aauffr20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('aauffr20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('aauffr20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('ablond19', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('ablond19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('ablond19', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 3),
('acariv20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('acariv20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('acariv20', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 2),
('aclave19', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 1),
('aclave19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 3),
('aclave19', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 2),
('afouca19', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 3),
('afouca19', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('afouca19', '7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 2),
('alegue19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('alegue19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('alegue19', '7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 3),
('alinig20', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('alinig20', '7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 3),
('alinig20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 1),
('alucas20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('alucas20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('alucas20', 'ab0df346-15be-11e6-8c14-363366383662', 3),
('amarde20', '7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 3),
('amarde20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('amarde20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('apreme19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('apreme19', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 3),
('apreme19', 'ab0df2e2-15be-11e6-8c14-363366383662', 2),
('aregna20', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('aregna20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('aregna20', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cbaron19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('cbaron19', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cbaron19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cboyer19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cboyer19', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cboyer19', '7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('cgallo19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('cgallo19', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cgallo19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cgroll19', '7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cgroll19', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cgroll19', '7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 1),
('cheuve19', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cheuve19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cheuve19', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 1),
('cpoiss19', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('cpoiss19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 3),
('cpoiss19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 1),
('dcrenn19', '7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 2),
('dcrenn19', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('dcrenn19', '7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 3),
('echeva19', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 3),
('echeva19', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 1),
('echeva19', '7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 2),
('elesao20', '7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 2),
('elesao20', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('elesao20', '7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 3),
('equill19', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('equill19', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 3),
('equill19', 'ab0df318-15be-11e6-8c14-363366383662', 2),
('eroue020', '7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 1),
('eroue020', '7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 3),
('eroue020', '7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 2),
('erouza20', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 3),
('erouza20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 1),
('erouza20', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 2),
('fcheva19', '7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 2),
('fcheva19', '7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 3),
('fcheva19', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('flucas19', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 2),
('flucas19', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('flucas19', '7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 3),
('ftanne19', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 3),
('ftanne19', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 1),
('ftanne19', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 2),
('fthiba20', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('fthiba20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 3),
('fthiba20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('gedern19', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 3),
('gedern19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('gedern19', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 2),
('gletro19', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('gletro19', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 3),
('gletro19', '7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 2),
('glibou19', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 1),
('glibou19', '7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 3),
('glibou19', '7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 2),
('gmonne20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('gmonne20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('gmonne20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('jbenez19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('jbenez19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('jbenez19', 'ab0df318-15be-11e6-8c14-363366383662', 3),
('jboise20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 1),
('jboise20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 2),
('jboise20', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 3),
('jdiver19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('jdiver19', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 1),
('jdiver19', '7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('jperra19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 2),
('jperra19', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 3),
('jperra19', '7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 1),
('lguegu20', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('lguegu20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 3),
('lguegu20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 2),
('llemag19', '7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 1),
('llemag19', '7cbed4ba-0df3-11e6-9aa9-448a5b42bfcd', 3),
('llemag19', '7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('llemeu20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 2),
('llemeu20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 1),
('llemeu20', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 3),
('lpouch20', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('lpouch20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 2),
('lpouch20', '7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 3),
('mbouad20', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('mbouad20', 'ab0df152-15be-11e6-8c14-363366383662', 3),
('mbouad20', 'ab0df2e2-15be-11e6-8c14-363366383662', 2),
('mferra20', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 1),
('mferra20', '7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 2),
('mferra20', 'ab0df2e2-15be-11e6-8c14-363366383662', 3),
('mgauth17', '7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 1),
('mgauth17', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 3),
('mgauth17', 'ab0df346-15be-11e6-8c14-363366383662', 2),
('mlariv19', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('mlariv19', '7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 3),
('mlariv19', '7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 1),
('mlegal19', '7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 3),
('mlegal19', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 2),
('mlegal19', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 1),
('nbaron19', '7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 1),
('nbaron19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('nbaron19', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 2),
('nkorpe19', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 2),
('nkorpe19', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 3),
('nkorpe19', '7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 1),
('nserio19', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('nserio19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('nserio19', '7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 1),
('oburti19', '7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 3),
('oburti19', '7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 1),
('oburti19', '7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 2),
('panton20', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('panton20', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 3),
('panton20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 2),
('papich20', '7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 2),
('papich20', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 3),
('papich20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 1),
('pedieu20', '7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 2),
('pedieu20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('pedieu20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 3),
('pleple19', '7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 2),
('pleple19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('pleple19', '7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 3),
('qsolli20', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 3),
('qsolli20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 1),
('qsolli20', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 2),
('sheng020', '7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 2),
('sheng020', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 1),
('sheng020', '7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('slevro20', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 3),
('slevro20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('slevro20', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('tbaron20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('tbaron20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('tbaron20', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 3),
('tlelie20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('tlelie20', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('tlelie20', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 3),
('tmal0019', '7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 2),
('tmal0019', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 1),
('tmal0019', '7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 3),
('tpicar20', '7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 3),
('tpicar20', '7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 1),
('tpicar20', '7cbed6a2-0df3-11e6-9aa9-448a5b42bfcd', 2),
('vprin020', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 2),
('vprin020', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 1),
('vprin020', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('vsilva19', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 3),
('vsilva19', '7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 1),
('vsilva19', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 2),
('wbeaup20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 1),
('wbeaup20', '7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 3),
('wbeaup20', 'ab0df318-15be-11e6-8c14-363366383662', 2),
('ydumor20', '7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 3),
('ydumor20', '7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 2),
('ydumor20', '7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 1),
('yleflo20', '7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 1),
('yleflo20', '7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 2),
('yleflo20', '7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 3);

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

DROP TABLE IF EXISTS `classe`;
CREATE TABLE IF NOT EXISTS `classe` (
  `school_year` int(11) NOT NULL,
  `login` char(8) NOT NULL,
  `classe_name` char(20) DEFAULT NULL,
  PRIMARY KEY (`school_year`,`login`),
  KEY `fk_association_19` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `classe`
--

INSERT INTO `classe` (`school_year`, `login`, `classe_name`) VALUES
(2016, 'gbiann17', 'Personnel'),
(2016, 'mgoanv17', 'Personnel'),
(2016, 'tcouss17', 'Personnel'),
(2016, 'vrioua17', 'Personnel');

-- --------------------------------------------------------

--
-- Structure de la table `club`
--

DROP TABLE IF EXISTS `club`;
CREATE TABLE IF NOT EXISTS `club` (
  `club_id` char(36) NOT NULL,
  `login` char(8) NOT NULL,
  `club_name` char(40) NOT NULL,
  `club_description` longtext,
  `club_mail` char(30) DEFAULT NULL,
  `actif` tinyint(1) DEFAULT NULL,
  `blocknote` longtext,
  PRIMARY KEY (`club_id`),
  KEY `fk_manage` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `club`
--

INSERT INTO `club` (`club_id`, `login`, `club_name`, `club_description`, `club_mail`, `actif`, `blocknote`) VALUES
('7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Don du sang', '', '', 1, NULL),
('7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Soutien Harteloire', '', '', 1, NULL),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Bureau des Arts', '', '', 1, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Tournée info', '', '', 1, NULL),
('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Asso. sociale A.F.E.V.', '', '', 1, NULL),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Bureau des sports', '', '', 1, NULL),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Gala', '', '', 1, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Bureau des élèves', '', '', 1, NULL),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Club foyer', '', '', 1, NULL),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club musique', '', '', 1, NULL),
('7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Intégration', '', '', 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Capisen', '', '', 1, NULL),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Digital Design', '', '', 1, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Club Elec', 'Le club éléctronique de l''ISEN', 'clubelec@isen.fr', 1, NULL),
('7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Web TV ISEN', '', '', 1, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Moviezen', 'Le club vidéo de l''ISEN', 'moviezen@isen.fr', 1, NULL),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau du développement durable', '', '', 1, NULL),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club glisse', '', '', 1, NULL),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Kengred', '', '', 1, NULL),
('7cbed4ba-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', '4L Trophy', '', '', 1, NULL),
('7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Encadrement sport extérieur', '', '', 1, NULL),
('7cbed548-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'AREI', '', '', 1, NULL),
('7cbed590-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Banque alimentaire', '', '', 1, NULL),
('7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Forums', '', '', 1, NULL),
('7cbed619-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'ISEN Immo', '', '', 1, NULL),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Club Eva', '', '', 1, NULL),
('7cbed6a2-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club international', '', '', 1, NULL),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Pon Pon Nippon', '', '', 1, NULL),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Soutien ISEN', '', '', 1, NULL),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Bureau de l''international', '', '', 1, NULL),
('7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Clubs externes', '', '', 1, NULL),
('ab0df152-15be-11e6-8c14-363366383662', 'rcolli17', 'Wiki-radio', '', '', 1, NULL),
('ab0df2e2-15be-11e6-8c14-363366383662', 'rcolli17', 'Culture celtique', '', '', 1, NULL),
('ab0df318-15be-11e6-8c14-363366383662', 'vrioua17', 'What the flub', '', '', 1, NULL),
('ab0df346-15be-11e6-8c14-363366383662', 'rcolli17', 'Association des rennais', '', '', 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `effectif`
--

DROP TABLE IF EXISTS `effectif`;
CREATE TABLE IF NOT EXISTS `effectif` (
  `club_id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `nb_asked_min` int(11) NOT NULL,
  `nb_asked_max` int(11) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`project_id`),
  KEY `fk_effectif2` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `effectif`
--

INSERT INTO `effectif` (`club_id`, `project_id`, `nb_asked_min`, `nb_asked_max`) VALUES
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, 2),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 3, 5),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 3, 5),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 0, 3),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 6, 8),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 5, 8),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 4, 5),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 4, 6),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 6, 8),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 12, 14),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 5, 9),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 2, 3),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 0, 2),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, 3),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 2, 5),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 0, 1),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 3, 6),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 2, 4),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 0, 1),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 10, 12),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 8, 10),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 8, 10),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 0, 2),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 3, 4),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 4, 6),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 4, 6),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 1, 2),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 3, 5),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 3, 6),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 3, 5),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, 3),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 3, 5),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, 2),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, 2),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 1, 2),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 2, 4),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 2, 3),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, 4),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 2, 4),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 2, 2),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 0, 2),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 0, 2),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 2, 5),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 2, 5),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, 3),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'd6b8fac7-1818-11e6-8166-d850e61e53c9', 0, 2);

-- --------------------------------------------------------

--
-- Structure de la table `event`
--

DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `club_id` char(36) NOT NULL,
  `id_event` char(36) NOT NULL,
  `event_name` char(80) DEFAULT NULL,
  `event_date` bigint(20) DEFAULT NULL,
  `changed_date` bigint(20) DEFAULT NULL,
  `nb_participant` smallint(6) DEFAULT NULL,
  `place` char(80) DEFAULT NULL,
  `cancelled` tinyint(1) DEFAULT NULL,
  `event_description` longtext,
  `feedback` longtext,
  PRIMARY KEY (`club_id`,`id_event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `timestamp` bigint(20) NOT NULL,
  `type` char(20) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `log`
--

INSERT INTO `log` (`timestamp`, `type`, `content`) VALUES
(14631753331395, 'error', '{"err":"No matching route with method: GET and url: clubEvaluator","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14631756814690, 'error', '{"err":"No matching route with method: GET and url: clubEvaluator","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14631805130452, 'error', '{"err":"No matching route with method: GET and url: choices","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14631805683200, 'error', '{"err":"No matching route with method: GET and url: choices","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14631807426881, 'error', '{"err":"No matching route with method: GET and url: clubEvaluator","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14631808141022, 'error', '{"err":"No matching route with method: GET and url: clubEvaluator","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632167288204, 'error', '{"err":"No matching route with method: GET and url: repartition","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632168063250, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632168268701, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632168278005, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632168985875, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632169286461, 'error', '{"err":"No matching route with method: GET and url: clubEvaluator","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632298894154, 'error', '{"err":"No matching route with method: GET and url: repartition","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632587712043, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14632587729010, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14633219550576, 'error', '{"err":"No matching route with method: GET and url: repartition","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14633257215127, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}'),
(14633257235630, 'error', '{"err":"No matching route with method: GET and url: repartition\\/2017","file":"C:\\\\wamp64\\\\www\\\\projetm1\\\\api\\\\API\\\\Router.php","line":46}');

-- --------------------------------------------------------

--
-- Structure de la table `member`
--

DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `club_id` char(36) NOT NULL,
  `login` char(8) NOT NULL,
  `school_year` int(11) NOT NULL,
  `id_projet_club` char(36) DEFAULT NULL,
  `project_id` char(36) DEFAULT NULL,
  `main_club` tinyint(1) NOT NULL,
  `member_mark` float DEFAULT NULL,
  `ex_member_not_wanted` tinyint(1) DEFAULT NULL,
  `recommandation` tinyint(1) DEFAULT NULL,
  `project_validation` tinyint(1) DEFAULT '1',
  `member_comment` text,
  PRIMARY KEY (`club_id`,`login`,`school_year`),
  KEY `fk_affecte` (`id_projet_club`),
  KEY `fk_association_10` (`login`),
  KEY `fk_association_11` (`school_year`),
  KEY `fk_association_12` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `member`
--

INSERT INTO `member` (`club_id`, `login`, `school_year`, `id_projet_club`, `project_id`, `main_club`, `member_mark`, `ex_member_not_wanted`, `recommandation`, `project_validation`, `member_comment`) VALUES
('7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 'mlariv19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'cvanco19', 2016, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'nbaron19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'nbaron19', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, 1, 0, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'elefau19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'flucas19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'gbreto19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'glibou19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'vgauth19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 'bflury19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 'fcheva19', 2016, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 0, NULL),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'flucas19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'gletro19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'afouca19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'ldemeo19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'tlefla19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'nkorpe19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'dcrenn19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'oburti19', 2016, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 'bflury19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'alucas20', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'alucas20', 2017, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'amarde20', 2015, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'amarde20', 2016, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'amarde20', 2017, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'cgallo19', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'ldemeo19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'mgoanv17', 2016, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'pedieu20', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, 1, NULL),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'aclave19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'aauffr20', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, 1, 0, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'ablond19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, 9, NULL, NULL, 1, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'ablond19', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, 1, NULL, 0, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'apreme19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'fduboi17', 2016, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'gbiann17', 2016, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'mderri19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'pleple19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 2016, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'tcouss18', 2016, NULL, 'd6b8f8d7-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 2016, NULL, 'd6b37f9f-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 'tmal0019', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 'vsilva19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'nbaron19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'nbaron19', 2017, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, 1, 0, NULL),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'gbreto19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'jdiver19', 2016, NULL, 'd6b8fa87-1818-11e6-8166-d850e61e53c9', 1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `note_club`
--

DROP TABLE IF EXISTS `note_club`;
CREATE TABLE IF NOT EXISTS `note_club` (
  `club_id` char(36) NOT NULL,
  `school_year` int(11) NOT NULL,
  `note_club` float DEFAULT NULL,
  `procurement_file` char(250) DEFAULT NULL,
  `budget` float DEFAULT NULL,
  `lock_member_mark` tinyint(1) DEFAULT '1',
  `lock_member_project_validation` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`club_id`,`school_year`),
  KEY `fk_note_club2` (`school_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `note_club`
--

INSERT INTO `note_club` (`club_id`, `school_year`, `note_club`, `procurement_file`, `budget`, `lock_member_mark`, `lock_member_project_validation`) VALUES
('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 2016, NULL, NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `process`
--

DROP TABLE IF EXISTS `process`;
CREATE TABLE IF NOT EXISTS `process` (
  `club_id` char(36) NOT NULL,
  `process_id` char(36) NOT NULL,
  `process_name` char(60) NOT NULL,
  `process_link` char(100) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `project_club`
--

DROP TABLE IF EXISTS `project_club`;
CREATE TABLE IF NOT EXISTS `project_club` (
  `id_projet_club` char(36) NOT NULL,
  `club_id` char(36) NOT NULL,
  `name` char(80) NOT NULL,
  `link` char(255) DEFAULT NULL,
  `project_club_description` longtext,
  PRIMARY KEY (`id_projet_club`),
  KEY `fk_association_15` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

DROP TABLE IF EXISTS `projet`;
CREATE TABLE IF NOT EXISTS `projet` (
  `project_id` char(36) NOT NULL,
  `project_type` char(10) NOT NULL,
  `project_description` longtext,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projet`
--

INSERT INTO `projet` (`project_id`, `project_type`, `project_description`) VALUES
('d6b37f9f-1818-11e6-8166-d850e61e53c9', 'PR+', '{ "title": "Projet à responsabilité +",\r\n                      "objectif": "Transmettre son savoir-faire, son expérience",\r\n                      "exemple": "Suivre son ancien PR avec le nouveau responsable",\r\n                      "quota": "60 h",\r\n                      "eval": "Le responsabel du club valide ou non un crédit ECTS"}'),
('d6b8f8d7-1818-11e6-8166-d850e61e53c9', 'PR', '{   "title": "Projet à responsabilité",\r\n                      "objectif": "Prendre des responsabilités, assurer l''encadrement et la prise de décision dans les activités d''un groupe ou d''une association",\r\n                      "exemple": "(Co-)Présider un club, organiser le SKISEN, animer l''une des principales actions de son club, entrainer une équipe sportive",\r\n                      "quota": "60 h",\r\n                      "eval": "Note (orale et dossier), compte dans le moyenne de l''année. La validation est obligatoire pour l''obtention du diplome"}'),
('d6b8fa87-1818-11e6-8166-d850e61e53c9', 'PA', '{   "title": "Projet d''accompagnement",\r\n                      "objectif": "Appuyer l''action d''un PR sur des tâches semi-complexes en relative autonomie",\r\n                      "exemple": "s''occuper d''une exposition du BDA, participation active à un club",\r\n                      "quota": "50 h",\r\n                      "eval": "Validation ou non validation"}'),
('d6b8fac7-1818-11e6-8166-d850e61e53c9', 'PI', '{ "title": "Projet d''intégration (à l''ISEN)",\r\n                      "objectif": "Se mettre au service ponctuellement d''un groupe ou d''une association",\r\n                      "exemple": "Participer au rangement des tables après des portes-ouvertes, aider l''équipe du Gala",\r\n                      "quota": "15 h",\r\n                      "eval": "Note de groupe comprise dans la moyenne de l''année"}');

-- --------------------------------------------------------

--
-- Structure de la table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
CREATE TABLE IF NOT EXISTS `recommendation` (
  `club_id` char(36) NOT NULL,
  `login` char(8) NOT NULL,
  `recommanded` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`login`),
  KEY `fk_recommendation2` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `reunions`
--

DROP TABLE IF EXISTS `reunions`;
CREATE TABLE IF NOT EXISTS `reunions` (
  `club_id` char(36) NOT NULL,
  `id_reunion` char(36) NOT NULL,
  `reunion_date` bigint(20) DEFAULT NULL,
  `reunion_order` char(250) DEFAULT NULL,
  `reporting` char(250) DEFAULT NULL,
  `internal_reunion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`id_reunion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id_role` char(36) NOT NULL,
  `role` char(40) NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `role`
--

INSERT INTO `role` (`id_role`, `role`) VALUES
('4b0ff703-1951-11e6-bcfc-448a5b42bfcd', 'président'),
('4b100c3f-1951-11e6-bcfc-448a5b42bfcd', 'vice-président'),
('4b100ca5-1951-11e6-bcfc-448a5b42bfcd', 'trésorier'),
('4b100ccc-1951-11e6-bcfc-448a5b42bfcd', 'secrétaire'),
('4b100cee-1951-11e6-bcfc-448a5b42bfcd', 'membre');

-- --------------------------------------------------------

--
-- Structure de la table `role_link`
--

DROP TABLE IF EXISTS `role_link`;
CREATE TABLE IF NOT EXISTS `role_link` (
  `club_id` char(36) NOT NULL,
  `login` char(8) NOT NULL,
  `school_year` int(11) NOT NULL,
  `id_role` char(36) NOT NULL,
  PRIMARY KEY (`club_id`,`login`,`school_year`,`id_role`),
  KEY `fk_role_link2` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `role_link`
--

INSERT INTO `role_link` (`club_id`, `login`, `school_year`, `id_role`) VALUES
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'mgoanv17', 2016, '4b0ff703-1951-11e6-bcfc-448a5b42bfcd'),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'gbiann17', 2016, '4b0ff703-1951-11e6-bcfc-448a5b42bfcd');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `login` char(8) NOT NULL,
  `user_firstname` char(20) NOT NULL,
  `user_name` char(20) DEFAULT NULL,
  `user_mail` char(50) NOT NULL,
  `is_administrator` tinyint(1) DEFAULT NULL,
  `phone` char(12) DEFAULT NULL,
  `school_staff` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`login`, `user_firstname`, `user_name`, `user_mail`, `is_administrator`, `phone`, `school_staff`) VALUES
('aauffr20', 'Antoine', 'AUFFRET', 'antoine.auffret@isen-bretagne.fr', 0, NULL, 0),
('ablond19', 'Antoine', 'BLONDEAU', 'antoine.blondeau@isen-bretagne.fr', 0, '0670169118', 0),
('acariv20', 'Alexandre', 'CARIVENC', 'alexandre.carivenc@isen-bretagne.fr', 0, '0604404604', 0),
('aclave19', 'Alexandre', 'CLAVEAU', 'alexandre.claveau@isen-bretagne.fr', 0, NULL, 0),
('adome019', 'Adrien', 'DOME', 'adrien.dome@isen-bretagne.fr', 0, NULL, 0),
('afouca19', 'Agathe', 'FOUCAULT', 'agathe.foucault@isen-bretagne.fr', 0, NULL, 0),
('ahusse20', 'Ahmad', 'HUSSEIN', 'ahmad.hussein@isen-bretagne.fr', 0, NULL, 0),
('alegue19', 'Antoine', 'LE GUERN', 'antoine.le-guern@isen-bretagne.fr', 0, '0684087472', 0),
('alinig20', 'Adrien', 'LINIGER', 'adrien.liniger@isen-bretagne.fr', 0, NULL, 0),
('alucas20', 'Antoine', 'LUCAS', 'antoine.lucas@isen-bretagne.fr', 0, NULL, 0),
('amarde20', 'Axel', 'MARDELAY', 'axel.mardelay@isen-bretagne.fr', 0, '0624450028', 0),
('apreme19', 'Arnaud', 'PREMEL-CABIC', 'arnaud.premel-cabic@isen-bretagne.fr', 0, NULL, 0),
('aregna20', 'Audrey', 'REGNAULT', 'audrey.regnault@isen-bretagne.fr', 0, '0658889781', 0),
('asorre19', 'Alexandre', 'SORRE', 'alexandre.sorre@isen-bretagne.fr', 0, NULL, 0),
('bflury19', 'Bastien', 'FLURY', 'bastien.flury@isen-bretagne.fr', 0, NULL, 0),
('cbaron19', 'Corentin', 'BARON', 'corentin.baron@isen-bretagne.fr', 0, NULL, 0),
('cboyer19', 'Carl', 'BOYER', 'carl.boyer@isen-bretagne.fr', 0, '0644254776', 0),
('cgallo19', 'Claire', 'GALLOT', 'claire.gallot@isen-bretagne.fr', 0, NULL, 0),
('cgroll19', 'Céline', 'GROLLEAU', 'celine.grolleau@isen-bretagne.fr', 0, NULL, 0),
('cheuve19', 'Clara', 'HEUVELINE', 'clara.heuveline@isen-bretagne.fr', 0, NULL, 0),
('cpoiss19', 'Clément', 'POISSON', 'clement.poisson@isen-bretagne.fr', 0, NULL, 0),
('cvanco19', 'Christophe', 'VANCO', 'christophe.vanco@isen-bretagne.fr', 0, '0663488992', 0),
('dcrenn19', 'Denis', 'CRENN', 'denis.crenn@isen-bretagne.fr', 0, NULL, 0),
('echeva19', 'Elise', 'CHEVALIER', 'elise.chevalier@isen-bretagne.fr', 0, NULL, 0),
('elefau19', 'Enora', 'LE FAUCHEUR', 'enora.le-faucher@isen-bretagne.fr', 0, NULL, 0),
('elesao20', 'Elsa', 'LE SAOUT', 'elsa.le-saout@isen-bretagne.fr', 0, NULL, 0),
('equill19', 'Eloi', 'QUILLET', 'eloi.quillet@isen-bretagne.fr', 0, NULL, 0),
('eroue020', 'Estelle', 'ROUE', 'estelle.roue@isen-bretagne.fr', 0, NULL, 0),
('erouza20', 'Etienne', 'ROUZAUT', 'etienne.rouzaut@isen-bretagne.fr', 0, NULL, 0),
('fcheva19', 'Floriane', 'CHEVALLIER', 'floriane.chevallier@isen-bretagne.fr', 0, NULL, 0),
('fduboi17', 'Florentin', 'DUBOIS', 'florentin.dubois@isen-bretagne.fr', 0, '', 0),
('fguill20', 'Florian', 'GUILLERME', 'florian.guillerme@isen-bretagne.fr', 0, NULL, 0),
('flucas19', 'Florian', 'LUCAS', 'florian.lucas@isen-bretagne.fr', 0, NULL, 0),
('ftanne19', 'Florian', 'TANNEAU', 'florian.tanneau@isen-bretagne.fr', 0, NULL, 0),
('fthiba20', 'Florian', 'THIBAUD', 'florian.thibaud@isen-bretagne.fr', 0, NULL, 0),
('gbiann17', 'Gilles', 'BIANNIC', 'gilles.biannic@isen-bretagne.fr', 0, NULL, 0),
('gbreto19', 'Gaétan', 'BRETON', 'gaetan.breton@isen-bretagne.fr', 0, NULL, 0),
('gedern19', 'Gaël', 'EDERN', 'gael.edern@isen-bretagne.fr', 0, NULL, 0),
('glecam20', 'Gurvan', 'LE CAM', 'gurvan.le-cam@isen-bretagne.fr', 0, NULL, 0),
('glecor19', 'Guillaume', 'LE CORRE', 'guillaume.le-corre@isen-bretagne.fr', 0, NULL, 0),
('gletro19', 'Gwendal', 'LE TROADEC', 'gwendal.le-troadec@isen-bretagne.fr', 0, NULL, 0),
('glibou19', 'Gaetan', 'LIBOUBAN', 'gaetan.libouban@isen-bretagne.fr', 0, NULL, 0),
('gmonne20', 'Guillaume', 'MONNERAIS', 'guillaume.monnerais@isen-bretagne.fr', 0, NULL, 0),
('jbenez19', 'Jocelyn', 'BENEZETH', 'jocelyn.benezeth@isen-bretagne.fr', 0, NULL, 0),
('jboise20', 'Jeremy', 'BOISELET', 'jeremy.boiselet@isen-bretagne.fr', 0, NULL, 0),
('jdiver19', 'Julien', 'DIVERREZ', 'julien.diverrez@isen-bretagne.fr', 0, NULL, 0),
('jperra19', 'Julien', 'PERRAULT', 'julien.perrault@isen-bretagne.fr', 0, NULL, 0),
('jwalla20', 'Josselin', 'WALLAS', 'josselin.wallas@isen-bretagne.fr', 0, NULL, 0),
('kaupee19', 'Kévin', 'AUPEE', 'kevin.aupee@isen-bretagne.fr', 0, NULL, 0),
('ldemeo19', 'Loïs', 'DEMEOCQ', 'lois.demeocq@isen-bretagne.fr', 0, NULL, 0),
('ldorie20', 'Lea', 'DORIER', 'lea.dorier@isen-bretagne.fr', 0, NULL, 0),
('lfrelo20', 'Lucie', 'FRELOT', 'lucie.frelot@isen-bretagne.fr', 0, NULL, 0),
('lgilbe20', 'Loïc', 'GILBERT', 'loic.gilbert@isen-bretagne.fr', 0, NULL, 0),
('lgramo20', 'Laurena', 'GRAMOSO', 'laurena.gramoso@isen-bretagne.fr', 0, NULL, 0),
('lguegu20', 'Loïc', 'GUEGUEN', 'loic.gueguen@isen-bretagne.fr', 0, '', 0),
('llemag19', 'Lucie', 'LEMAGNEN', 'lucie.lemagnen@isen-bretagne.fr', 0, '0770594291', 0),
('llemeu20', 'Lancelot', 'LE MEUR', 'lancelot.le-meur@isen-bretagne.fr', 0, NULL, 0),
('lpouch20', 'Léo', 'POUCHARD', 'leo.pouchard@isen-bretagne.fr', 0, NULL, 0),
('mbouad20', 'Mouloud', 'BOUADI', 'mouloud.bouadi@isen-bretagne.fr', 0, NULL, 0),
('mcabon', 'Mikael', 'Cabon', 'mikael.cabon@isen-bretagne.fr', 0, '0298038403', 1),
('mderri19', 'Martial', 'DERRIEN', 'martial.derrien@isen-bretagne.fr', 0, NULL, 0),
('mferra20', 'Maylis', 'FERRAND', 'maylis.ferrand@isen-bretagne.fr', 0, NULL, 0),
('mgauth17', 'Mathieu', 'GAUTHIER', 'mathieu.gauthier@isen-bretagne.fr', 0, NULL, 0),
('mgoanv17', 'Maxime', 'Maxime', 'maxime.maxime@isen-bretagne.fr', 0, NULL, 0),
('mlariv19', 'Morgan', 'LARIVAIN', 'morgan.larivain@isen-bretagne.fr', 0, NULL, 0),
('mlegal19', 'Maxime', 'LE GALL', 'maxime.le-gall@isen-bretagne.fr', 0, NULL, 0),
('mroued20', 'Manon', 'ROUEDE', 'manon.rouede@isen-bretagne.fr', 0, NULL, 0),
('nbaron19', 'Nolwenn', 'BARON', 'nolwenn.baron@isen-bretagne.fr', 0, NULL, 0),
('nkorpe19', 'Nicolas', 'KORPET', 'nicolas.korpet@isen-bretagne.fr', 0, NULL, 0),
('nserio19', 'Nora', 'SERIOUI', 'nora.serioui@isen-bretagne.fr', 0, NULL, 0),
('oburti19', 'Olivier', 'BURTIN', 'olivier.burtin@isen-bretagne.fr', 0, NULL, 0),
('panton20', 'Pierre', 'ANTONACCI', 'pierre.antonacci@isen-bretagne.fr', 0, NULL, 0),
('papich20', 'Pierre-Alain', 'PICHON', 'pierre-alain.pichon@isen-bretagne.fr', 0, NULL, 0),
('pedieu20', 'Pierre-Emmanuel', 'DIEUDONNE', 'pierre-emmanuel.dieudonne@isen-bretagne.fr', 0, NULL, 0),
('plcast20', 'Pierre-Louis', 'CASTAGNET', 'pierre-louis.castagnet@isen-bretagne.fr', 0, NULL, 0),
('pleple19', 'Pierrick', 'LE PLENIER', 'pierrick.le-plenier@isen-bretagne.fr', 0, NULL, 0),
('qsolli20', 'Quentin', 'SOLLIER', 'quentin.sollier@isen-bretagne.fr', 0, '0627115774', 0),
('rcolli17', 'Rémi', 'COLLIGNON', 'remi.collignon@isen-bretagne.fr', 1, '0647335579', 1),
('rcroya20', 'Ryan', 'CROYAL', 'ryan.croyal@isen-bretagne.fr', 0, NULL, 0),
('sheng020', 'Sully', 'HENG', 'sully.heng@isen-bretagne.fr', 0, NULL, 0),
('slevro20', 'Simon', 'LEVRON', 'simon.levron@isen-bretagne.fr', 0, NULL, 0),
('tbaron20', 'Titouan', 'BARON', 'titouan.baron@isen-bretagne.fr', 0, NULL, 0),
('tcones20', 'Thomas', 'CONESA', 'thomas.conesa@isen-bretagne.fr', 0, NULL, 0),
('tcouss17', 'thomas', 'Coussot', 'Thomas.Coussot@isen-bretagne.fr', 0, NULL, 0),
('tcouss18', 'Thomas', 'Coussot', 'Thomas.Coussot@isen-bretagne.fr', 0, NULL, 0),
('tlefla19', 'Theo', 'LE FLAHAT', 'theo.le-flahat@isen-bretagne.fr', 0, NULL, 0),
('tlelie20', 'Tristan', 'LELIEVRE-ROPERS', 'tristan.lelievre-ropers@isen-bretagne.fr', 0, NULL, 0),
('tmal0019', 'Thibault', 'MAL', 'thibault.mal@isen-bretagne.fr', 0, NULL, 0),
('tpicar20', 'Tanguy', 'PICART', 'tanguy.picart@isen-bretagne.fr', 0, NULL, 0),
('vgauth19', 'Vincent', 'GAUTHIE', 'vincent.gauthie@isen-bretagne.fr', 0, NULL, 0),
('vprin020', 'Virgile', 'PRIN', 'virgile.prin@isen-bretagne.fr', 0, NULL, 0),
('vrioua17', 'Vincent', 'RIOUALLON', 'vincent.riouallon@isen-bretagne.fr', 1, NULL, 1),
('vsilva19', 'Virgile', 'SILVANT', 'virgile.silvant@isen-bretagne.fr', 0, NULL, 0),
('wbeaup20', 'William', 'BEAUPERIN', 'william.beauperin@isen-bretagne.fr', 0, NULL, 0),
('ydumor20', 'Yohann', 'DUMORTIER', 'yohann.dumortier@isen-bretagne.fr', 0, NULL, 0),
('yleflo20', 'Yves', 'LE FLOCH', 'yves.le-floch@isen-bretagne.fr', 0, '0786047291', 0);

-- --------------------------------------------------------

--
-- Structure de la table `year`
--

DROP TABLE IF EXISTS `year`;
CREATE TABLE IF NOT EXISTS `year` (
  `school_year` int(11) NOT NULL,
  PRIMARY KEY (`school_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `year`
--

INSERT INTO `year` (`school_year`) VALUES
(2015),
(2016),
(2017);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `choice`
--
ALTER TABLE `choice`
  ADD CONSTRAINT `fk_association_8` FOREIGN KEY (`login`) REFERENCES `users` (`login`),
  ADD CONSTRAINT `fk_association_9` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `classe`
--
ALTER TABLE `classe`
  ADD CONSTRAINT `fk_association_18` FOREIGN KEY (`school_year`) REFERENCES `year` (`school_year`),
  ADD CONSTRAINT `fk_association_19` FOREIGN KEY (`login`) REFERENCES `users` (`login`);

--
-- Contraintes pour la table `club`
--
ALTER TABLE `club`
  ADD CONSTRAINT `fk_manage` FOREIGN KEY (`login`) REFERENCES `users` (`login`);

--
-- Contraintes pour la table `effectif`
--
ALTER TABLE `effectif`
  ADD CONSTRAINT `fk_effectif` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  ADD CONSTRAINT `fk_effectif2` FOREIGN KEY (`project_id`) REFERENCES `projet` (`project_id`);

--
-- Contraintes pour la table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `fk_association_14` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `fk_affecte` FOREIGN KEY (`id_projet_club`) REFERENCES `project_club` (`id_projet_club`),
  ADD CONSTRAINT `fk_association_10` FOREIGN KEY (`login`) REFERENCES `users` (`login`),
  ADD CONSTRAINT `fk_association_11` FOREIGN KEY (`school_year`) REFERENCES `year` (`school_year`),
  ADD CONSTRAINT `fk_association_12` FOREIGN KEY (`project_id`) REFERENCES `projet` (`project_id`),
  ADD CONSTRAINT `fk_compose` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `note_club`
--
ALTER TABLE `note_club`
  ADD CONSTRAINT `fk_note_club` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  ADD CONSTRAINT `fk_note_club2` FOREIGN KEY (`school_year`) REFERENCES `year` (`school_year`);

--
-- Contraintes pour la table `process`
--
ALTER TABLE `process`
  ADD CONSTRAINT `fk_association_17` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `project_club`
--
ALTER TABLE `project_club`
  ADD CONSTRAINT `fk_association_15` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `recommendation`
--
ALTER TABLE `recommendation`
  ADD CONSTRAINT `fk_recommendation` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  ADD CONSTRAINT `fk_recommendation2` FOREIGN KEY (`login`) REFERENCES `users` (`login`);

--
-- Contraintes pour la table `reunions`
--
ALTER TABLE `reunions`
  ADD CONSTRAINT `fk_association_16` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`);

--
-- Contraintes pour la table `role_link`
--
ALTER TABLE `role_link`
  ADD CONSTRAINT `fk_role_link` FOREIGN KEY (`club_id`,`login`,`school_year`) REFERENCES `member` (`club_id`, `login`, `school_year`),
  ADD CONSTRAINT `fk_role_link2` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
