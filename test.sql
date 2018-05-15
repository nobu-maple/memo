DROP DATABASE IF EXISTS userManage;
CREATE DATABASE userManage;

DROP USER  appuser1@localhost;
CREATE USER appuser1@localhost IDENTIFIED WITH mysql_native_password BY 'appuser1_pass';
GRANT ALL PRIVILEGES on userManage.* to  appuser1@localhost;

USE userManage;

DROP TABLE IF EXISTS user;
CREATE TABLE user
(
  `id`                    INT UNSIGNED      NOT NULL AUTO_INCREMENT        COMMENT '',
  `name`                  VARCHAR(256)      NOT NULL                       COMMENT '氏名',
  `email`                 VARCHAR(256)      NULL                           COMMENT 'メール',
  `u9_add_month`          SMALLINT UNSIGNED NOT NULL                       COMMENT '有給追加月',
  `u9_add_time`           REAL              NOT NULL DEFAULT 150.0         COMMENT '有給追加時間 7.5h x 20day',

  `Created_at`            TIMESTAMP         NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `Updated_at`            TIMESTAMP         NULL,
  `Deleted_at`            TIMESTAMP         NULL,
  PRIMARY KEY (`id`)
)
COMMENT '社員';


DROP TABLE IF EXISTS u9;
CREATE TABLE u9
(
  `id`                    INT UNSIGNED      NOT NULL AUTO_INCREMENT        COMMENT '',
  `user_id`               INT UNSIGNED      NOT NULL                       COMMENT '利用者内部ID',
  `add_date`              TIMESTAMP         NOT NULL                       COMMENT '有給を追加した日',
  `u9_time`               REAL              NOT NULL DEFAULT 0.0           COMMENT '有給利用可能時間',
  `expire`                TIMESTAMP         NOT NULL                       COMMENT '有効期限日',

  `Created_at`            TIMESTAMP         NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `Updated_at`            TIMESTAMP         NULL,
  `Deleted_at`            TIMESTAMP         NULL,
  PRIMARY KEY (`id`),
  INDEX `I_UserID` (`user_id`)
)
COMMENT '有給利用可能時間管理';


DROP TABLE IF EXISTS aipo_relation;
CREATE TABLE aipo_relation
(
  `user_id`               INT UNSIGNED      NOT NULL                       COMMENT '利用者内部ID',
  `aipo_uid`              VARCHAR(64)       NOT NULL                       COMMENT 'AipoのユーザID',

  `Created_at`            TIMESTAMP         NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `Updated_at`            TIMESTAMP         NULL,
  `Deleted_at`            TIMESTAMP         NULL,
  PRIMARY KEY (`user_id`),
  INDEX `I_AipoID` (`aipo_uid`)
)
COMMENT 'Aipo連携用';


DROP TABLE IF EXISTS u9_hist;
CREATE TABLE u9_hist
(
  `id`                    INT UNSIGNED      NOT NULL AUTO_INCREMENT        COMMENT '',
  `u9_id`                 INT UNSIGNED      NOT NULL                       COMMENT '有給管理ID',
  `user_id`               INT UNSIGNED      NOT NULL                       COMMENT '利用者内部ID',

  `type`                  CHAR(1)           NOT NULL DEFAULT '0'           COMMENT '操作タイプ 0:有給利用、1：無給利用、9：有給廃棄',
  `use_time`              REAL              NOT NULL DEFAULT 0.0           COMMENT '有給利用時間',
  `use_date`              TIMESTAMP         NOT NULL                       COMMENT '有給利用日',
  `memo`                  VARCHAR(1024)     NULL                           COMMENT 'メモ',
  
  `accept`                TIMESTAMP         NOT NULL                       COMMENT '承認日時',
  `accept_type`           CHAR(1)           NOT NULL DEFAULT '0'           COMMENT '承認結果  0：承認、1：削除',
  `accept_user_id`        INT UNSIGNED      NOT NULL                       COMMENT '承認操作者',

  `Created_at`            TIMESTAMP         NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `Updated_at`            TIMESTAMP         NULL,
  `Deleted_at`            TIMESTAMP         NULL,
  PRIMARY KEY (`id`),
  INDEX `I_UserID` (`user_id`),
  INDEX `I_U9ID` (`u9_id`)
)
COMMENT '有給履歴';


DROP VIEW IF EXISTS u9_view;
CREATE VIEW u9_view
    AS
SELECT `user`.`id`
     , `user`.`name`
     , `user`.`email`
     , sum(`u9`.`u9_time`)
  FROM `user`     
  LEFT OUTER JOIN `u9` 
               ON `user`.`id` = `u9`.`user_id`
 GROUP BY `user`.`id`
        , `user`.`name`
	, `user`.`email`
;


show databases \G;
show tables \G;
