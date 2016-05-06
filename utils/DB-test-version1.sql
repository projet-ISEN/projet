/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  28/04/2016 16:21:18                      */
/*==============================================================*/


drop table if exists choice;

drop table if exists club;

drop table if exists effectif;

drop table if exists event;

drop table if exists log;

drop table if exists member;

drop table if exists note_club;

drop table if exists process;

drop table if exists project_club;

drop table if exists projet;

drop table if exists recommendation;

drop table if exists role_link;

drop table if exists reunions;

drop table if exists role;

drop table if exists users;

drop table if exists year;

/*==============================================================*/
/* Table : choice                                               */
/*==============================================================*/
create table choice
(
   login                char(8) not null,
   club_id              char(36) not null,
   choice_number        int not null,
   primary key (login, club_id)
)
engine = innodb;

/*==============================================================*/
/* Table : club                                                 */
/*==============================================================*/
create table club
(
   club_id              char(36) not null,
   login                char(8) not null,
   club_name            char(40) not null,
   club_description     longtext,
   club_mail            char(30),
   actif                bool,
   blocknote            longtext,
   primary key (club_id)
)
engine = innodb;

/*==============================================================*/
/* Table : effectif                                             */
/*==============================================================*/
create table effectif
(
   club_id              char(36) not null,
   project_id           char(36) not null,
   nb_asked_min         int not null,
   nb_asked_max         int,
   primary key (club_id, project_id)
)
engine = innodb;

/*==============================================================*/
/* Table : event                                                */
/*==============================================================*/
create table event
(
   club_id              char(36) not null,
   id_event             char(36) not null,
   event_name           char(80),
   event_date           bigint,
   changed_date         bigint,
   nb_participant       smallint,
   place                char(80),
   cancelled            bool,
   event_description    longtext,
   feedback             longtext,
   primary key (club_id, id_event)
)
engine = innodb;

/*==============================================================*/
/* Table : log                                                  */
/*==============================================================*/
create table log
(
   timestamp            bigint not null,
   type                 char(20) not null,
   content              longtext not null,
   primary key (timestamp)
)
engine = innodb;

/*==============================================================*/
/* Table : member                                               */
/*==============================================================*/
create table member
(
   club_id              char(36) not null,
   login                char(8) not null,
   school_year          int not null,
   id_projet_club       char(36),
   project_id           char(36) not null,
   main_club            bool not null,
   member_mark          float,
   ex_member_not_wanted bool,
   recommandation       bool,
   project_validation   bool,
   member_comment       text,
   primary key (club_id, login, school_year)
)
engine = innodb;

/*==============================================================*/
/* Table : note_club                                            */
/*==============================================================*/
create table note_club
(
   club_id              char(36) not null,
   school_year          int not null,
   note_club            float not null,
   procurement_file     char(250),
   budget               float,
   primary key (club_id, school_year)
)
engine = innodb;

/*==============================================================*/
/* Table : process                                              */
/*==============================================================*/
create table process
(
   club_id              char(36) not null,
   process_id           char(36) not null,
   process_name         char(60) not null,
   process_link         char(100),
   primary key (club_id, process_id)
)
engine = innodb;

/*==============================================================*/
/* Table : project_club                                         */
/*==============================================================*/
create table project_club
(
   club_id              char(36) not null,
   id_projet_club       char(36) not null,
   name                 char(80) not null,
   link                 char(255),
   project_club_description longtext,
   primary key (club_id, id_projet_club)
)
engine = innodb;

/*==============================================================*/
/* Table : projet                                               */
/*==============================================================*/
create table projet
(
   project_id           char(36) not null,
   project_type         char(10) not null,
   project_description  longtext,
   primary key (project_id)
)
engine = innodb;

/*==============================================================*/
/* Table : recommendation                                       */
/*==============================================================*/
create table recommendation
(
   club_id              char(36) not null,
   login                char(8) not null,
   recommanded          bool,
   primary key (club_id, login)
)
engine = innodb;

/*==============================================================*/
/* Table : role_link                                            */
/*==============================================================*/
create table role_link
(
   club_id              char(36) not null,
   login                char(8) not null,
   school_year          int not null,
   id_role              char(36) not null,
   primary key (club_id, login, school_year, id_role)
)
engine = innodb;

/*==============================================================*/
/* Table : reunions                                             */
/*==============================================================*/
create table reunions
(
   club_id              char(36) not null,
   id_reunion           char(36) not null,
   reunion_date         bigint,
   reunion_order        char(250),
   reporting            char(250),
   internal_reunion     bool,
   primary key (club_id, id_reunion)
)
engine = innodb;

/*==============================================================*/
/* Table : role                                                 */
/*==============================================================*/
create table role
(
   id_role              char(36) not null,
   role                 char(40) not null,
   primary key (id_role)
)
engine = innodb;

/*==============================================================*/
/* Table : users                                                */
/*==============================================================*/
create table users
(
   login                char(8) not null,
   user_firstname       char(20) not null,
   user_name            char(20),
   user_mail            char(50) not null,
   is_administrator     bool,
   phone                char(12),
   primary key (login)
)
engine = innodb;

/*==============================================================*/
/* Table : year                                                 */
/*==============================================================*/
create table year
(
   school_year          int not null,
   primary key (school_year)
)
engine = innodb;

alter table choice add constraint fk_association_8 foreign key (login)
      references users (login) on delete restrict on update restrict;

alter table choice add constraint fk_association_9 foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table club add constraint fk_manage foreign key (login)
      references users (login) on delete restrict on update restrict;

alter table effectif add constraint fk_effectif foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table effectif add constraint fk_effectif2 foreign key (project_id)
      references projet (project_id) on delete restrict on update restrict;

alter table event add constraint fk_association_14 foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table member add constraint fk_affecte foreign key (id_projet_club)
      references project_club (club_id, id_projet_club) on delete restrict on update restrict;

alter table member add constraint fk_association_10 foreign key (login)
      references users (login) on delete restrict on update restrict;

alter table member add constraint fk_association_11 foreign key (school_year)
      references year (school_year) on delete restrict on update restrict;

alter table member add constraint fk_association_12 foreign key (project_id)
      references projet (project_id) on delete restrict on update restrict;

alter table member add constraint fk_compose foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table note_club add constraint fk_note_club foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table note_club add constraint fk_note_club2 foreign key (school_year)
      references year (school_year) on delete restrict on update restrict;

alter table process add constraint fk_association_17 foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table project_club add constraint fk_association_15 foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table recommendation add constraint fk_recommendation foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;

alter table recommendation add constraint fk_recommendation2 foreign key (login)
      references users (login) on delete restrict on update restrict;

alter table role_link add constraint fk_role_link foreign key (club_id, login, school_year)
      references member (club_id, login, school_year) on delete restrict on update restrict;

alter table role_link add constraint fk_role_link2 foreign key (id_role)
      references role (id_role) on delete restrict on update restrict;

alter table reunions add constraint fk_association_16 foreign key (club_id)
      references club (club_id) on delete restrict on update restrict;






INSERT INTO year (school_year) VALUES (2016);


INSERT INTO role (id_role, role) VALUES
  (UUID(), 'président'),
  (UUID(), 'vice-président'),
  (UUID(), 'trésorier'),
  (UUID(), 'secrétaire'),
  (UUID(), 'membre')
;



INSERT INTO projet (project_id, project_type, project_description) VALUES
  (UUID(), 'PR+', '{ "title": "Projet à responsabilité +",
                      "objectif": "Transmettre son savoir-faire, son expérience",
                      "exemple": "Suivre son ancien PR avec le nouveau responsable",
                      "quota": "60 h",
                      "eval": "Le responsabel du club valide ou non un crédit ECTS"}'),
  (UUID(), 'PR', '{   "title": "Projet à responsabilité",
                      "objectif": "Prendre des responsabilités, assurer l\'encadrement et la prise de décision dans les activités d\'un groupe ou d\'une association",
                      "exemple": "(Co-)Présider un club, organiser le SKISEN, animer l\'une des principales actions de son club, entrainer une équipe sportive",
                      "quota": "60 h",
                      "eval": "Note (orale et dossier), compte dans le moyenne de l\'année. La validation est obligatoire pour l\'obtention du diplome"}'),
  (UUID(), 'PA', '{   "title": "Projet d\'accompagnement",
                      "objectif": "Appuyer l\'action d\'un PR sur des tâches semi-complexes en relative autonomie",
                      "exemple": "s\'occuper d\'une exposition du BDA, participation active à un club",
                      "quota": "50 h",
                      "eval": "Validation ou non validation"}'),
  (UUID(), 'PI', '{ title: "Projet d\'intégration (à l\ISEN",
                      "objectif": "Se mettre au service ponctuellement d\'un groupe ou d\'une association",
                      "exemple": "Participer au rangement des tables après des portes-ouvertes, aider l\'équipe du Gala",
                      "quota": "15 h",
                      "eval": "Note de groupe comprise dans la moyenne de l\'année"}');




--
-- Contenu de la table `users`
--

INSERT INTO `users` (`login`, `user_firstname`, `user_name`, `user_mail`, `is_administrator`, `phone`) VALUES
('ejoly017', 'erwan', 'joly', 'erwan.joly@isen-bretagne.fr', 0, NULL),
('fduboi17', 'florentin', 'dubois', 'florentin.dubois@isen-bretagne.fr', 0, NULL),
('ftoque17', 'françois', 'toquer', 'françois.toquer@isen-bretagne.fr', 0, NULL),
('gbiann17', 'gilles', 'biannic', 'gilles.biannic@isen-bretagne.fr', 0, NULL),
('mgoanv17', 'maxime', 'goanvic', 'maxime.goanvic@isen-bretagne.fr', 0, NULL),
('pverba17', 'pierre', 'verbaere', 'pierre.verbaere@isen-bretagne.fr', 0, NULL),
('qduche17', 'quentin', 'ducher', 'quentin.ducher@isen-bretagne.fr', 0, NULL),
('gymorv17', 'guy-yann', 'morvan', 'guy-yann.morvan@isen-bretagne.fr', 0, NULL),
('rcolli17', 'rémi', 'collignon', 'remi.collignon@isen-bretagne.fr', 1, NULL),
('tcouss17', 'thomas', 'coussot', 'thomas.coussot@isen-bretagne.fr', 0, NULL),
('vrioua17', 'vincent', 'riouallon', 'vincent.riouallon@isen-bretagne.fr', 0, NULL),
('baboli17', 'brendan', 'abolivier', 'brendan.abolivier@isen-bretagne.fr', 0, NULL);



INSERT INTO club (club_id, login, club_name, club_description, club_mail, actif) VALUES
  ('7cbeab9e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Don du sang', '', '', 1),
  ('7cbece9d-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Soutien Harteloire', '', '', 1),
  ('7cbecf95-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau des Arts', '', '', 1),
  ('7cbecff8-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Tournée info', '', '', 1),
  ('7cbed049-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Asso. sociale A.F.E.V.', '', '', 1),
  ('7cbed09a-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau des sports', '', '', 1),
  ('7cbed0e3-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Gala', '', '', 1),
  ('7cbed127-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau des élèves', '', '', 1),
  ('7cbed174-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club foyer', '', '', 1),
  ('7cbed1bd-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club musique', '', '', 1),
  ('7cbed206-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Intégration', '', '', 1),
  ('7cbed24e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Capisen', '', '', 1),
  ('7cbed29b-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Digital Design', '', '', 1),
  ('7cbed2e4-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club Elec', 'Le club éléctronique de l\'ISEN', 'clubelec@isen.fr', 1),
  ('7cbed346-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Web TV ISEN', '', '', 1),
  ('7cbed38f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Moviezen', 'Le club vidéo de l\'ISEN', 'moviezen@isen.fr', 1),
  ('7cbed3e0-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau du développement durable', '', '', 1),
  ('7cbed429-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club glisse', '', '', 1),
  ('7cbed472-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Kengred', '', '', 1),
  ('7cbed4ba-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', '4L Trophy', '', '', 1),
  ('7cbed503-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Encadrement sport extérieur', '', '', 1),
  ('7cbed548-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'AREI', '', '', 1),
  ('7cbed590-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Banque alimentaire', '', '', 1),
  ('7cbed5d5-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Forums', '', '', 1),
  ('7cbed619-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'ISEN Immo', '', '', 1),
  ('7cbed65e-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club Eva', '', '', 1),
  ('7cbed6a2-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Club international', '', '', 1),
  ('7cbed6e6-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Pon Pon Nippon', '', '', 1),
  ('7cbed72f-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Soutien ISEN', '', '', 1),
  ('7cbed778-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Bureau de l\'international', '', '', 1),
  ('7cbed7bc-0df3-11e6-9aa9-448a5b42bfcd', 'rcolli17', 'Clubs externes', '', '', 1);


--
-- Contenu de la table `choice`
--

INSERT INTO `choice` (`login`, `club_id`, `choice_number`) VALUES
('qduche17', (SELECT club_id FROM club WHERE club.club_name="Bureau des élèves"), 1),
('qduche17', (SELECT club_id FROM club WHERE club.club_name="Soutien ISEN"), 2),
('qduche17', (SELECT club_id FROM club WHERE club.club_name="Club Elec"), 3),
('baboli17', (SELECT club_id FROM club WHERE club.club_name="Soutien ISEN"), 1),
('baboli17', (SELECT club_id FROM club WHERE club.club_name="Bureau des élèves"), 2),
('baboli17', (SELECT club_id FROM club WHERE club.club_name="Moviezen"), 3);


--
-- Contenu de la table `member`
--

INSERT INTO `member` (`club_id`, `login`, `school_year`, `id_projet_club`, `project_id`, `main_club`, `member_mark`, `ex_member_not_wanted`, `recommandation`, `project_validation`, `member_comment`) VALUES
((SELECT club_id FROM club WHERE club.club_name="Bureau des élèves"), 'fduboi17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Bureau des élèves"), 'pverba17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR+"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Bureau des élèves"), 'qduche17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PA"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Capisen"), 'gymorv17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PA"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Capisen"), 'mgoanv17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR+"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Club Elec"), 'gbiann17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR"), 0, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Club Elec"), 'tcouss17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Moviezen"), 'ftoque17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR+"), 1, NULL, NULL, NULL, NULL, NULL),
((SELECT club_id FROM club WHERE club.club_name="Moviezen"), 'gbiann17', 2016, NULL, (SELECT project_id FROM projet WHERE project_type="PR"), 1, NULL, NULL, NULL, NULL, NULL);




INSERT INTO effectif (club_id, project_id, nb_asked_min, nb_asked_max)
  VALUES  ( (SELECT club_id FROM club WHERE club.club_name="Soutien ISEN"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 0, 2),
          ( (SELECT club_id FROM club WHERE club.club_name="Soutien ISEN"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 0, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Club foyer"),
            (SELECT project_id FROM projet WHERE project_type="PR"),  2, 3),
          ( (SELECT club_id FROM club WHERE club.club_name="Club foyer"),
            (SELECT project_id FROM projet WHERE project_type="PR+"), 5, 9),
          ( (SELECT club_id FROM club WHERE club.club_name="Club foyer"),
            (SELECT project_id FROM projet WHERE project_type="PA"),  0, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Gala"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 4, 6),
          ( (SELECT club_id FROM club WHERE club.club_name="Gala"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 6, 8),
          ( (SELECT club_id FROM club WHERE club.club_name="Gala"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 12, 14),

          ( (SELECT club_id FROM club WHERE club.club_name="Club Eva"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 2, 4),
          ( (SELECT club_id FROM club WHERE club.club_name="Club Eva"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 2, 3),

          ( (SELECT club_id FROM club WHERE club.club_name="Club musique"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 1, 3),
          ( (SELECT club_id FROM club WHERE club.club_name="Club musique"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 2, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Club musique"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 0, 1),

          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des Arts"),
            (SELECT project_id FROM projet WHERE project_type="PR"),  3, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des Arts"),
            (SELECT project_id FROM projet WHERE project_type="PR+"), 1, 2),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des Arts"),
            (SELECT project_id FROM projet WHERE project_type="PA"),  3, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des Arts"),
            (SELECT project_id FROM projet WHERE project_type="PI"),  0, 3),

          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des sports"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 6, 8),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des sports"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 5, 8),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau des sports"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 4, 5),

          ( (SELECT club_id FROM club WHERE club.club_name="Club glisse"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 1, 3),
          ( (SELECT club_id FROM club WHERE club.club_name="Club glisse"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 3, 5),

          ( (SELECT club_id FROM club WHERE club.club_name="Bureau du développement durable"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 3, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau du développement durable"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 3, 6),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau du développement durable"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 3, 5),

          ( (SELECT club_id FROM club WHERE club.club_name="Pon Pon Nippon"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 1, 4),
          ( (SELECT club_id FROM club WHERE club.club_name="Pon Pon Nippon"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 2, 4),
          ( (SELECT club_id FROM club WHERE club.club_name="Pon Pon Nippon"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 2, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Kengred"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 1, 2),
          ( (SELECT club_id FROM club WHERE club.club_name="Kengred"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 1, 2),
          ( (SELECT club_id FROM club WHERE club.club_name="Kengred"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 1, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Digital Design"),
            (SELECT project_id FROM projet WHERE project_type="PR"), 3, 6),
          ( (SELECT club_id FROM club WHERE club.club_name="Digital Design"),
            (SELECT project_id FROM projet WHERE project_type="PA"), 2, 4),
          ( (SELECT club_id FROM club WHERE club.club_name="Digital Design"),
            (SELECT project_id FROM projet WHERE project_type="PI"), 0, 1),

          ( (SELECT club_id FROM club WHERE club.club_name="Club Elec"),
            (SELECT project_id FROM projet WHERE project_type="PR+"), 10, 12),
          ( (SELECT club_id FROM club WHERE club.club_name="Club Elec"),
            (SELECT project_id FROM projet WHERE project_type="PR"),  8, 10),
          ( (SELECT club_id FROM club WHERE club.club_name="Club Elec"),
            (SELECT project_id FROM projet WHERE project_type="PA"),  8, 10),
          ( (SELECT club_id FROM club WHERE club.club_name="Club Elec"),
            (SELECT project_id FROM projet WHERE project_type="PI"),  0, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Moviezen"),
            (SELECT project_id FROM projet WHERE project_type="PR+"), 3, 4),
          ( (SELECT club_id FROM club WHERE club.club_name="Moviezen"),
            (SELECT project_id FROM projet WHERE project_type="PR"),  4, 6),
          ( (SELECT club_id FROM club WHERE club.club_name="Moviezen"),
            (SELECT project_id FROM projet WHERE project_type="PA"),  4, 6),
          ( (SELECT club_id FROM club WHERE club.club_name="Moviezen"),
            (SELECT project_id FROM projet WHERE project_type="PI"),  1, 2),

          ( (SELECT club_id FROM club WHERE club.club_name="Bureau de l'international"),
            (SELECT project_id FROM projet WHERE project_type="PR+"), 2, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau de l'international"),
            (SELECT project_id FROM projet WHERE project_type="PR"),  2, 5),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau de l'international"),
            (SELECT project_id FROM projet WHERE project_type="PA"),  1, 3),
          ( (SELECT club_id FROM club WHERE club.club_name="Bureau de l'international"),
            (SELECT project_id FROM projet WHERE project_type="PI"),  0, 2)
;
