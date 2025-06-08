/*
* aioveu数据库
* MySQL5.x版本
*/

-- ----------------------------
-- 系统管理数据库
-- ----------------------------
CREATE DATABASE IF	NOT EXISTS aioveu_system DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- ----------------------------
-- OAuth2数据库
-- ----------------------------
CREATE DATABASE IF NOT EXISTS aioveu_oauth2_server DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- ----------------------------
-- 商城会员数据库
-- ----------------------------
CREATE DATABASE IF	NOT EXISTS aioveu_ums DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- ----------------------------
-- 商城商品数据库
-- ----------------------------
CREATE DATABASE IF	NOT EXISTS aioveu_pms DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- ----------------------------
-- 商城订单数据库
-- ----------------------------
CREATE DATABASE IF	NOT EXISTS aioveu_oms DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- ----------------------------
-- 商城营销数据库
-- ----------------------------
CREATE DATABASE IF	NOT EXISTS aioveu_sms DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;