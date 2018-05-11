DROP TABLE IF EXISTS user;
CREATE TABLE user
(
  `id`                    INT UNSIGNED      NOT NULL AUTO_INCREMENT        COMMENT '',
  `name`                  VARCHAR(256)      NOT NULL                       COMMENT '氏名',
  `email`                 VARCHAR(256)      NULL                           COMMENT 'メール',

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


DROP TABLE IF EXISTS u9_user;
CREATE TABLE u9_user
(
  `user_id`               INT UNSIGNED      NOT NULL                       COMMENT '利用者内部ID',
  `aipo_uid`              VARCHAR(64)       NOT NULL                       COMMENT 'AipoのユーザID',
  `add_month`             SMALLINT UNSIGNED NOT NULL                       COMMENT '有給追加月',
  `add_time`              REAL              NOT NULL DEFAULT 150.0         COMMENT '有給追加時間',

  `Created_at`            TIMESTAMP         NOT NULL  DEFAULT CURRENT_TIMESTAMP,
  `Updated_at`            TIMESTAMP         NULL,
  `Deleted_at`            TIMESTAMP         NULL,
  PRIMARY KEY (`user_id`),
  INDEX `I_AipoID` (`aipo_uid`)
)
COMMENT '有給追加時間管理';


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
