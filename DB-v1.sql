/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  23/04/2016 14:19:47                      */
/*==============================================================*/


drop table if exists CHOICE;

drop table if exists CLUB;

drop table if exists EFFFECTIF;

drop table if exists EVENT;

drop table if exists LOG;

drop table if exists MEMBER;

drop table if exists NOTE_CLUB;

drop table if exists PROJECT_CLUB;

drop table if exists PROJET;

drop table if exists RECOMMENDATION;

drop table if exists REMPLI;

drop table if exists REUNIONS;

drop table if exists ROLE;

drop table if exists USERS;

drop table if exists YEAR;

/*==============================================================*/
/* Table : CHOICE                                               */
/*==============================================================*/
create table CHOICE
(
   LOGIN                char(8) not null,
   ID_CLUB              char(36) not null,
   CHOICE_NUMBER        int not null,
   primary key (LOGIN, ID_CLUB)
)
engine = InnoDB;

/*==============================================================*/
/* Table : CLUB                                                 */
/*==============================================================*/
create table CLUB
(
   ID_CLUB              char(36) not null,
   LOGIN                char(8) not null,
   CLUB_NAME            char(40) not null,
   CLUB_DESCRIPTION     longtext,
   CLUB_MAIL            char(30),
   ACTIF                bool,
   BLOCKNOTE            longtext,
   primary key (ID_CLUB)
)
engine = InnoDB;

/*==============================================================*/
/* Table : EFFFECTIF                                            */
/*==============================================================*/
create table EFFFECTIF
(
   ID_CLUB              char(36) not null,
   PROJECT_ID           char(36) not null,
   NB_ASKED_MIN         int not null,
   NB_ASKED_MAX         int,
   primary key (ID_CLUB, PROJECT_ID)
)
engine = InnoDB;

/*==============================================================*/
/* Table : EVENT                                                */
/*==============================================================*/
create table EVENT
(
   ID_CLUB              char(36) not null,
   ID_EVENT             char(36) not null,
   EVENT_NAME           char(80),
   EVENT_DATE           bigint,
   CHANGED_DATE         bigint,
   NB_PARTICIPANT       smallint,
   PLACE                char(80),
   CANCELLED            bool,
   EVENT_DESCRIPTION    longtext,
   FEEDBACK             longtext,
   primary key (ID_CLUB, ID_EVENT)
)
engine = InnoDB;

/*==============================================================*/
/* Table : LOG                                                  */
/*==============================================================*/
create table LOG
(
   TIME                 bigint not null,
   TYPE                 char(20) not null,
   CONTENT              longtext not null,
   primary key (TIME)
)
engine = InnoDB;

/*==============================================================*/
/* Table : MEMBER                                               */
/*==============================================================*/
create table MEMBER
(
   ID_CLUB              char(36) not null,
   LOGIN                char(8) not null,
   SCHOOL_YEAR          int not null,
   PRO_ID_CLUB          char(36),
   ID_PROJET_CLUB       char(36),
   PROJECT_ID           char(36) not null,
   MAIN_CLUB            bool not null,
   MUMBER_MARK          float,
   EX_MEMBER_NOT_WANTED bool,
   RECOMMANDATION       bool,
   PROJECT_VALIDATION   bool,
   primary key (ID_CLUB, LOGIN, SCHOOL_YEAR)
)
engine = InnoDB;

/*==============================================================*/
/* Table : NOTE_CLUB                                            */
/*==============================================================*/
create table NOTE_CLUB
(
   ID_CLUB              char(36) not null,
   SCHOOL_YEAR          int not null,
   NOTE_CLUB            float not null,
   PROCUREMENT_FILE     char(250),
   BUDGET               float,
   primary key (ID_CLUB, SCHOOL_YEAR)
)
engine = InnoDB;

/*==============================================================*/
/* Table : PROJECT_CLUB                                         */
/*==============================================================*/
create table PROJECT_CLUB
(
   ID_CLUB              char(36) not null,
   ID_PROJET_CLUB       char(36) not null,
   NAME                 char(80) not null,
   LINK                 char(255),
   PROJECT_CLUB_DESCRIPTION longtext,
   primary key (ID_CLUB, ID_PROJET_CLUB)
)
engine = InnoDB;

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create table PROJET
(
   PROJECT_ID           char(36) not null,
   PROJECT_TYPE         char(10) not null,
   PROJECT_DESCRIPTION  longtext,
   primary key (PROJECT_ID)
)
engine = InnoDB;

/*==============================================================*/
/* Table : RECOMMENDATION                                       */
/*==============================================================*/
create table RECOMMENDATION
(
   ID_CLUB              char(36) not null,
   LOGIN                char(8) not null,
   RECOMMANDED          bool,
   primary key (ID_CLUB, LOGIN)
)
engine = InnoDB;

/*==============================================================*/
/* Table : REMPLI                                               */
/*==============================================================*/
create table REMPLI
(
   ID_CLUB              char(36) not null,
   LOGIN                char(8) not null,
   SCHOOL_YEAR          int not null,
   ID_ROLE              char(36) not null,
   primary key (ID_CLUB, LOGIN, SCHOOL_YEAR, ID_ROLE)
)
engine = InnoDB;

/*==============================================================*/
/* Table : REUNIONS                                             */
/*==============================================================*/
create table REUNIONS
(
   ID_CLUB              char(36) not null,
   ID_REUNION           char(36) not null,
   REUNION_DATE         bigint,
   REUNION_ORDER        char(250),
   REPORTING            char(250),
   INTERNAL_REUNION     bool,
   primary key (ID_CLUB, ID_REUNION)
)
engine = InnoDB;

/*==============================================================*/
/* Table : ROLE                                                 */
/*==============================================================*/
create table ROLE
(
   ID_ROLE              char(36) not null,
   ROLE                 char(40) not null,
   primary key (ID_ROLE)
)
engine = InnoDB;

/*==============================================================*/
/* Table : USERS                                                */
/*==============================================================*/
create table USERS
(
   LOGIN                char(8) not null,
   USER_FIRSTNAME       char(20) not null,
   USER_NAME            char(20),
   USER_MAIL            char(50) not null,
   IS_EVALUATOR         bool,
   PHONE                char(12),
   primary key (LOGIN)
)
engine = InnoDB;

/*==============================================================*/
/* Table : YEAR                                                 */
/*==============================================================*/
create table YEAR
(
   SCHOOL_YEAR          int not null,
   primary key (SCHOOL_YEAR)
)
engine = InnoDB;

alter table CHOICE add constraint FK_ASSOCIATION_8 foreign key (LOGIN)
      references USERS (LOGIN) on delete restrict on update restrict;

alter table CHOICE add constraint FK_ASSOCIATION_9 foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table CLUB add constraint FK_MANAGE foreign key (LOGIN)
      references USERS (LOGIN) on delete restrict on update restrict;

alter table EFFFECTIF add constraint FK_EFFFECTIF foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table EFFFECTIF add constraint FK_EFFFECTIF2 foreign key (PROJECT_ID)
      references PROJET (PROJECT_ID) on delete restrict on update restrict;

alter table EVENT add constraint FK_ASSOCIATION_14 foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table MEMBER add constraint FK_AFFECTE foreign key (PRO_ID_CLUB, ID_PROJET_CLUB)
      references PROJECT_CLUB (ID_CLUB, ID_PROJET_CLUB) on delete restrict on update restrict;

alter table MEMBER add constraint FK_ASSOCIATION_10 foreign key (LOGIN)
      references USERS (LOGIN) on delete restrict on update restrict;

alter table MEMBER add constraint FK_ASSOCIATION_11 foreign key (SCHOOL_YEAR)
      references YEAR (SCHOOL_YEAR) on delete restrict on update restrict;

alter table MEMBER add constraint FK_ASSOCIATION_12 foreign key (PROJECT_ID)
      references PROJET (PROJECT_ID) on delete restrict on update restrict;

alter table MEMBER add constraint FK_COMPOSE foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table NOTE_CLUB add constraint FK_NOTE_CLUB foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table NOTE_CLUB add constraint FK_NOTE_CLUB2 foreign key (SCHOOL_YEAR)
      references YEAR (SCHOOL_YEAR) on delete restrict on update restrict;

alter table PROJECT_CLUB add constraint FK_ASSOCIATION_15 foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table RECOMMENDATION add constraint FK_RECOMMENDATION foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;

alter table RECOMMENDATION add constraint FK_RECOMMENDATION2 foreign key (LOGIN)
      references USERS (LOGIN) on delete restrict on update restrict;

alter table REMPLI add constraint FK_REMPLI foreign key (ID_CLUB, LOGIN, SCHOOL_YEAR)
      references MEMBER (ID_CLUB, LOGIN, SCHOOL_YEAR) on delete restrict on update restrict;

alter table REMPLI add constraint FK_REMPLI2 foreign key (ID_ROLE)
      references ROLE (ID_ROLE) on delete restrict on update restrict;

alter table REUNIONS add constraint FK_ASSOCIATION_16 foreign key (ID_CLUB)
      references CLUB (ID_CLUB) on delete restrict on update restrict;




INSERT INTO year (SCHOOL_YEAR) VALUES (2016);


INSERT INTO users (LOGIN, USER_FIRSTNAME, USER_NAME, USER_MAIL, IS_EVALUATOR, PHONE) VALUES
  ('rcolli17', 'rémi', 'collignon', 'remi.collignon@isen-bretagne.fr', 0, NULL ),
  ('vrioua17', 'vincent', 'riouallon', 'vincent.riouallon@isen-bretagne.fr', 0, NULL );


INSERT INTO role (ID_ROLE, ROLE) VALUES
  (UUID(), 'président'),
  (UUID(), 'vice-président'),
  (UUID(), 'trésorier'),
  (UUID(), 'secrétaire'),
  (UUID(), 'membre')
;



INSERT INTO projet (PROJECT_ID, PROJECT_TYPE, PROJECT_DESCRIPTION) VALUES
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



INSERT INTO club (ID_CLUB, LOGIN, CLUB_NAME, CLUB_DESCRIPTION, CLUB_MAIL, ACTIF) VALUES
  (UUID(), 'rcolli17', 'Don du sang', '', '', 1),
  (UUID(), 'rcolli17', 'Soutien Harteloire', '', '', 1),
  (UUID(), 'rcolli17', 'Bureau des Arts', '', '', 1),
  (UUID(), 'rcolli17', 'Tournée info', '', '', 1),
  (UUID(), 'rcolli17', 'Asso. sociale A.F.E.V.', '', '', 1),
  (UUID(), 'rcolli17', 'Bureau des sports', '', '', 1),
  (UUID(), 'rcolli17', 'Gala', '', '', 1),
  (UUID(), 'rcolli17', 'Bureau des élèves', '', '', 1),
  (UUID(), 'rcolli17', 'Club foyer', '', '', 1),
  (UUID(), 'rcolli17', 'Club musique', '', '', 1),
  (UUID(), 'rcolli17', 'Intégration', '', '', 1),
  (UUID(), 'rcolli17', 'Capisen', '', '', 1),
  (UUID(), 'rcolli17', 'Digital Design', '', '', 1),
  (UUID(), 'rcolli17', 'Club Elec', 'Le club éléctronique de l\'ISEN', 'clubelec@isen.fr', 1),
  (UUID(), 'rcolli17', 'Web TV ISEN', '', '', 1),
  (UUID(), 'rcolli17', 'Moviezen', 'Le club vidéo de l\'ISEN', 'moviezen@isen.fr', 1),
  (UUID(), 'rcolli17', 'Bureau du développement durable', '', '', 1),
  (UUID(), 'rcolli17', 'Club glisse', '', '', 1),
  (UUID(), 'rcolli17', 'Kengred', '', '', 1),
  (UUID(), 'rcolli17', '4L Trophy', '', '', 1),
  (UUID(), 'rcolli17', 'Encadrement sport extérieur', '', '', 1),
  (UUID(), 'rcolli17', 'AREI', '', '', 1),
  (UUID(), 'rcolli17', 'Banque alimentaire', '', '', 1),
  (UUID(), 'rcolli17', 'Forums', '', '', 1),
  (UUID(), 'rcolli17', 'ISEN Immo', '', '', 1),
  (UUID(), 'rcolli17', 'Club Eva', '', '', 1),
  (UUID(), 'rcolli17', 'Club international', '', '', 1),
  (UUID(), 'rcolli17', 'Pon Pon Nippon', '', '', 1),
  (UUID(), 'rcolli17', 'Soutien ISEN', '', '', 1),
  (UUID(), 'rcolli17', 'Bureau de l\'international', '', '', 1)
;




INSERT INTO efffectif (ID_CLUB, PROJECT_ID, NB_ASKED_MIN, NB_ASKED_MAX)
  VALUES  ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Soutien ISEN"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 0, 2),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Soutien ISEN"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 0, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club foyer"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"),  2, 3),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club foyer"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR+"), 5, 9),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club foyer"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"),  0, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Gala"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 4, 6),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Gala"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 6, 8),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Gala"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 12, 14),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Eva"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 2, 4),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Eva"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 2, 3),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club musique"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 1, 3),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club musique"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 2, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club musique"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 0, 1),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des Arts"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"),  3, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des Arts"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR+"), 1, 2),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des Arts"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"),  3, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des Arts"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"),  0, 3),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des sports"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 6, 8),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des sports"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 5, 8),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau des sports"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 4, 5),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club glisse"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 1, 3),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club glisse"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 3, 5),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau du développement durable"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 3, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau du développement durable"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 3, 6),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau du développement durable"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 3, 5),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Pon Pon Nippon"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 1, 4),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Pon Pon Nippon"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 2, 4),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Pon Pon Nippon"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 2, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Kengred"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 1, 2),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Kengred"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 1, 2),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Kengred"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 1, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Digital Design"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"), 3, 6),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Digital Design"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"), 2, 4),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Digital Design"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"), 0, 1),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Elec"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR+"), 10, 12),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Elec"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"),  8, 10),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Elec"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"),  8, 10),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Club Elec"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"),  0, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Moviezen"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR+"), 3, 4),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Moviezen"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"),  4, 6),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Moviezen"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"),  4, 6),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Moviezen"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"),  1, 2),

          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau de l'international"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR+"), 2, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau de l'international"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PR"),  2, 5),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau de l'international"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PA"),  1, 3),
          ( (SELECT ID_CLUB FROM club WHERE club.CLUB_NAME="Bureau de l'international"),
            (SELECT PROJECT_ID FROM projet WHERE PROJECT_TYPE="PI"),  0, 2)
;

