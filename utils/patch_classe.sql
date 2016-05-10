/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  10/05/2016 16:28:53                      */
/*==============================================================*/

drop table if exists classe;

/*==============================================================*/
/* Table : classe                                               */
/*==============================================================*/
create table classe
(
  school_year          int not null,
  login                char(8) not null,
  classe_name          char(20),
  primary key (school_year, login),

  FOREIGN KEY (school_year) REFERENCES year(school_year)
)
  engine = innodb;

/*
alter table classe add constraint fk_association_018 foreign key (school_year)
references year (school_year) on delete restrict on update restrict;

alter table classe add constraint fk_association_019 foreign key (login)
references users (login) on delete NO ACTION on update NO ACTION ;*/