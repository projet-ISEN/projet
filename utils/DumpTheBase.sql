-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 05 Mai 2016 à 17:19
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
('baboli17', '7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 2),
('baboli17', '7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 3),
('baboli17', '7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 1),
('qduche17', '7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 1),
('qduche17', '7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 3),
('qduche17', '7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 2);

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
('7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Don du sang', '', '', 1, NULL),
('7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Soutien Harteloire', '', '', 1, NULL),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau des Arts', '', '', 1, NULL),
('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Tournée info', '', '', 1, NULL),
('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Asso. sociale A.F.E.V.', '', '', 1, NULL),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau des sports', '', '', 1, NULL),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Gala', '', '', 1, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Bureau des élèves', '', '', 1, NULL),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club foyer', '', '', 1, NULL),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club musique', '', '', 1, NULL),
('7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Intégration', '', '', 1, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Capisen', '', '', 1, NULL),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Digital Design', '', '', 1, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'vrioua17', 'Club Elec', 'Le club éléctronique de l''ISEN', 'clubelec@isen.fr', 1, NULL),
('7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Web TV ISEN', '', '', 1, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Moviezen', 'Le club vidéo de l''ISEN', 'moviezen@isen.fr', 1, NULL),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau du développement durable', '', '', 1, NULL),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club glisse', '', '', 1, NULL),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Kengred', '', '', 1, NULL),
('7cbed4ba-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', '4L Trophy', '', '', 1, NULL),
('7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Encadrement sport extérieur', '', '', 1, NULL),
('7cbed548-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'AREI', '', '', 1, NULL),
('7cbed590-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Banque alimentaire', '', '', 1, NULL),
('7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Forums', '', '', 1, NULL),
('7cbed619-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'ISEN Immo', '', '', 1, NULL),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club Eva', '', '', 1, NULL),
('7cbed6a2-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club international', '', '', 1, NULL),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Pon Pon Nippon', '', '', 1, NULL),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Soutien ISEN', '', '', 1, NULL),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau de l''international', '', '', 1, NULL),
('7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Clubs externes', '', '', 1, NULL);

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
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 1, 2),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 3, 5),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 3, 5),
('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 0, 3),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 6, 8),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 5, 8),
('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 4, 5),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 4, 6),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 6, 8),
('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 12, 14),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 5, 9),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 2, 3),
('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 0, 2),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, 3),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 2, 5),
('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 0, 1),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 3, 6),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 2, 4),
('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 0, 1),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 10, 12),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 8, 10),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 8, 10),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 0, 2),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 3, 4),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 4, 6),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 4, 6),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 1, 2),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 3, 5),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 3, 6),
('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 3, 5),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, 3),
('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 3, 5),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, 2),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 1, 2),
('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 1, 2),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 2, 4),
('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 2, 3),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, 4),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 2, 4),
('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 2, 2),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 0, 2),
('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 0, 2),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 2, 5),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 2, 5),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 1, 3),
('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', '7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 0, 2);

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
  `project_id` char(36) NOT NULL,
  `main_club` tinyint(1) NOT NULL,
  `member_mark` float DEFAULT NULL,
  `ex_member_not_wanted` tinyint(1) DEFAULT NULL,
  `recommandation` tinyint(1) DEFAULT NULL,
  `project_validation` tinyint(1) DEFAULT NULL,
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
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'baboli17', 2016, NULL, '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 0, NULL, NULL, NULL, NULL, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'fduboi17', 2016, NULL, '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'pverba17', 2016, NULL, '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'qduche17', 2016, NULL, '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'gymorv17', 2016, NULL, '7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'mgoanv17', 2016, NULL, '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'gbiann17', 2016, NULL, '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 0, NULL, NULL, NULL, NULL, NULL),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'tcouss17', 2016, NULL, '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'ftoque17', 2016, NULL, '7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL),
('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'gbiann17', 2016, NULL, '7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 1, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `note_club`
--

DROP TABLE IF EXISTS `note_club`;
CREATE TABLE IF NOT EXISTS `note_club` (
  `club_id` char(36) NOT NULL,
  `school_year` int(11) NOT NULL,
  `note_club` float NOT NULL,
  `procurement_file` char(250) DEFAULT NULL,
  `budget` float DEFAULT NULL,
  PRIMARY KEY (`club_id`,`school_year`),
  KEY `fk_note_club2` (`school_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `club_id` char(36) NOT NULL,
  `id_projet_club` char(36) NOT NULL,
  `name` char(80) NOT NULL,
  `link` char(255) DEFAULT NULL,
  `project_club_description` longtext,
  PRIMARY KEY (`club_id`,`id_projet_club`)
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
('7cbd1a4b-0df3-11e6-9aa9-448a5b42bfcd', 'PR+', '{ "title": "Projet à responsabilité +",\n                      "objectif": "Transmettre son savoir-faire, son expérience",\n                      "exemple": "Poursuivre son ancien PR avec le nouveau responsable",\n                      "quota": "60",\n                      "eval": "Le responsable du club valide ou non un crédit ECTS"}'),
('7cbd3129-0df3-11e6-9aa9-448a5b42bfcd', 'PR', '{   "title": "Projet à responsabilité",\n                      "objectif": "Prendre des responsabilités, assurer l''encadrement et la prise de décision dans les activités d''un groupe ou d''une association",\n                      "exemple": "(Co-)Présider un club, organiser le SKISEN, animer l''une des principales actions de son club, entrainer une équipe sportive",\n                      "quota": "60",\n                      "eval": "Note (orale et dossier), compte dans la moyenne de l''année. La validation est obligatoire pour l''obtention du diplôme"}'),
('7cbd322e-0df3-11e6-9aa9-448a5b42bfcd', 'PA', '{   "title": "Projet d''accompagnement",\n                      "objectif": "Appuyer l''action d''un PR sur des tâches semi-complexes en relative autonomie",\n                      "exemple": "s''occuper d''une exposition du BDA, participation active à un club",\n                      "quota": "50",\n                      "eval": "Validation ou non validation"}'),
('7cbd3295-0df3-11e6-9aa9-448a5b42bfcd', 'PI', '{ "title": "Projet d''intégration (à lISEN",\n                      "objectif": "Se mettre au service ponctuellement d''un groupe ou d''une association",\n                      "exemple": "Participer au rangement des tables après des portes-ouvertes, aider l''équipe du Gala",\n                      "quota": "15",\n                      "eval": "Note de groupe comprise dans la moyenne de l''année"}');

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
('7cbc7230-0df3-11e6-9aa9-448a5b42bfcd', 'président'),
('7cbc83bf-0df3-11e6-9aa9-448a5b42bfcd', 'vice-président'),
('7cbc845d-0df3-11e6-9aa9-448a5b42bfcd', 'trésorier'),
('7cbc84a1-0df3-11e6-9aa9-448a5b42bfcd', 'secrétaire'),
('7cbc84e6-0df3-11e6-9aa9-448a5b42bfcd', 'membre');

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
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'pverba17', 2016, '7cbc7230-0df3-11e6-9aa9-448a5b42bfcd'),
('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'mgoanv17', 2016, '7cbc7230-0df3-11e6-9aa9-448a5b42bfcd'),
('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'tcouss17', 2016, '7cbc7230-0df3-11e6-9aa9-448a5b42bfcd'),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'qduche17', 2016, '7cbc83bf-0df3-11e6-9aa9-448a5b42bfcd'),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'fduboi17', 2016, '7cbc845d-0df3-11e6-9aa9-448a5b42bfcd'),
('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'qduche17', 2016, '7cbc84a1-0df3-11e6-9aa9-448a5b42bfcd');

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
  `school_staff` tinyint(1) DEFAULT NULL,
  `phone` char(12) DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`login`, `user_firstname`, `user_name`, `user_mail`, `is_administrator`, `school_staff`, `phone`) VALUES
('baboli17', 'brendan', 'abolivier', 'brendan.abolivier@isen-bretagne.fr', 0, 0, NULL),
('ejoly017', 'erwan', 'joly', 'erwan.joly@isen-bretagne.fr', 0, 0, NULL),
('fduboi17', 'florentin', 'dubois', 'florentin.dubois@isen-bretagne.fr', 0, 0, NULL),
('ftoque17', 'françois', 'toquer', 'françois.toquer@isen-bretagne.fr', 0, 0, NULL),
('gbiann17', 'gilles', 'biannic', 'gilles.biannic@isen-bretagne.fr', 0, 0, NULL),
('gymorv17', 'guy-yann', 'morvan', 'guy-yann.morvan@isen-bretagne.fr', 0, 0, NULL),
('mgoanv17', 'maxime', 'goanvic', 'maxime.goanvic@isen-bretagne.fr', 0, 0, NULL),
('pverba17', 'pierre', 'verbaere', 'pierre.verbaere@isen-bretagne.fr', 0, 0, NULL),
('qduche17', 'quentin', 'ducher', 'quentin.ducher@isen-bretagne.fr', 0, 0, NULL),
('rcolli17', 'rémi', 'collignon', 'remi.collignon@isen-bretagne.fr', 1, 1, NULL),
('tcouss17', 'thomas', 'coussot', 'thomas.coussot@isen-bretagne.fr', 0, 0, NULL),
('vrioua17', 'vincent', 'riouallon', 'vincent.riouallon@isen-bretagne.fr', 0, 1, NULL);

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
(2016);

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
