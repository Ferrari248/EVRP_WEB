/*
Navicat MySQL Data Transfer

Source Server         : mysql_localhost
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : evrp

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2022-03-27 21:25:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_charging_station`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_charging_station`;
CREATE TABLE `tbl_charging_station` (
  `pid` char(5) NOT NULL,
  `lng` double NOT NULL,
  `lat` double NOT NULL,
  `location_zh` varchar(200) DEFAULT NULL,
  `info_detail` text,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_charging_station
-- ----------------------------
INSERT INTO `tbl_charging_station` VALUES ('ab123', '121.229424', '31.203304', '上海市青浦区嘉松中路3899号', '卡行天下上海物流园');
INSERT INTO `tbl_charging_station` VALUES ('e0001', '121.550189', '31.336811', '上海市杨浦区殷行街道军工路2670号', '安悦充电军工路超级充电站');
INSERT INTO `tbl_charging_station` VALUES ('e0002', '121.439944', '31.186053', '上海市徐汇区中山西路与三汇路交叉口高架桥荫停车场内', '国家电网充电站(漕溪站)');
INSERT INTO `tbl_charging_station` VALUES ('e0003', '121.58782', '31.261689', '上海市浦东新区张杨路3680号', '国家电网充电站(新金桥设施管理有限公司)');
INSERT INTO `tbl_charging_station` VALUES ('e0004', '121.308622', '31.232308', '上海市闵行区华翔路3795号', '星星充电站(华翔路)');
INSERT INTO `tbl_charging_station` VALUES ('e0005', '121.376386', '31.177014', '上海市闵行区吴中路1599号', '特来电充电站(万象城)');
INSERT INTO `tbl_charging_station` VALUES ('e5uut', '121.729563', '31.401934', '上海市崇明区G40沪陕高速长兴岛服务区', '国家电网充电站');
INSERT INTO `tbl_charging_station` VALUES ('ei4te', '121.732128', '31.545807', '上海市崇明区陈海公路灶花堂服务区', '国家电网充电站');
INSERT INTO `tbl_charging_station` VALUES ('ejlxs', '121.651039', '31.032425', '上海市浦东新区沪南公路与海泉街交叉路口', '新场古镇-停车场');

-- ----------------------------
-- Table structure for `tbl_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `pid` char(5) NOT NULL,
  `lng` double NOT NULL,
  `lat` double NOT NULL,
  `demand` int(11) NOT NULL,
  `atime` varchar(10) NOT NULL,
  `pen` double NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `location_zh` varchar(200) DEFAULT NULL,
  `info_detail` text,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('c0001', '121.205416', '31.055989', '200', '10:00', '0.001', '13199998888', '上海市松江区广富林街道文汇路1008弄105号', '菜鸟驿站(四期站)');
INSERT INTO `tbl_customer` VALUES ('c0002', '121.463261', '31.262059', '150', '10:20', '0.001', null, '上海市静安区芷江西路488号五月花生活广场F1', '菜鸟驿站(上海普善店)');
INSERT INTO `tbl_customer` VALUES ('c0003', '121.551715', '31.212369', '80', '11:00', '0.001', null, '上海市浦东新区牡丹路90号', '菜鸟驿站(牡丹路店)');
INSERT INTO `tbl_customer` VALUES ('c0004', '121.525533', '31.243065', '95', '10:45', '0.001', '13199338855', '上海市浦东新区栖霞路107号', '菜鸟驿站');
INSERT INTO `tbl_customer` VALUES ('c0005', '121.276399', '31.330242', '173', '11:53', '0.001', '13144996688', '上海市嘉定区宝安公路3705弄-112~104号', '菜鸟驿站');
INSERT INTO `tbl_customer` VALUES ('c9998', '121.57117', '31.372805', '500', '11:50', '0.02', null, '申非路119号2层', '信欣物流(上海)有限公司');
INSERT INTO `tbl_customer` VALUES ('c9vpz', '121.46462218800472', '31.040405953144425', '400', '11:30', '0.001', '13288886666', '上海市虹梅南路5880号', '华东师范大学研究生公寓菜鸟驿站');
INSERT INTO `tbl_customer` VALUES ('caqwe', '121.624377', '31.551682', '600', '11:50', '0.02', '(021)59423866', '堡镇大通路390号', '时岛物流');
INSERT INTO `tbl_customer` VALUES ('cfho6', '121.788066', '31.178527', '400', '11:50', '0.01', '(021)68853641', '上海市浦东新区海天一路300号', '经贸国际货运实业有限公司');
INSERT INTO `tbl_customer` VALUES ('cvimp', '121.334952', '31.223999', '200', '9:20', '0.001', '', '上海市闵行区吴漕路898', '蔬香农庄');
INSERT INTO `tbl_customer` VALUES ('cw1pw', '121.4333', '31.2222', '200', '9:20', '0.001', '', '上海市长宁区愚园路1203弄30号', '菜鸟驿站');

-- ----------------------------
-- Table structure for `tbl_distance`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_distance`;
CREATE TABLE `tbl_distance` (
  `pfrom` char(5) NOT NULL,
  `pto` char(5) NOT NULL,
  `dist` int(11) NOT NULL,
  `calc_type` double NOT NULL,
  PRIMARY KEY (`pfrom`,`pto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_distance
-- ----------------------------
INSERT INTO `tbl_distance` VALUES ('ab123', 'c0001', '18701', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c0002', '26203', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c0003', '35432', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c0004', '31307', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c0005', '19959', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c9998', '45721', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'c9vpz', '36011', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'caqwe', '95218', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'cfho6', '62449', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'cvimp', '11403', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'cw1pw', '11346', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e0001', '39478', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e0002', '23586', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e0003', '37642', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e0004', '10424', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e0005', '18107', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'e5uut', '60176', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'ei4te', '82627', '-1');
INSERT INTO `tbl_distance` VALUES ('ab123', 'ejlxs', '55301', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'ab123', '18716', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c0002', '40104', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c0003', '43326', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c0004', '42494', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c0005', '38243', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c9998', '60503', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'c9vpz', '29604', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'caqwe', '107693', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'cfho6', '63068', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'cvimp', '27236', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'cw1pw', '27179', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e0001', '52719', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e0002', '31065', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e0003', '48086', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e0004', '27644', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e0005', '24921', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'e5uut', '72651', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'ei4te', '95102', '-1');
INSERT INTO `tbl_distance` VALUES ('c0001', 'ejlxs', '49095', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'ab123', '26231', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c0001', '39835', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c0003', '13153', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c0004', '9236', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c0005', '22354', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c9998', '21144', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'c9vpz', '28717', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'caqwe', '70300', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'cfho6', '41922', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'cvimp', '15529', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'cw1pw', '15529', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e0001', '14017', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e0002', '11064', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e0003', '15571', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e0004', '18351', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e0005', '15257', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'e5uut', '35258', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'ei4te', '57709', '-1');
INSERT INTO `tbl_distance` VALUES ('c0002', 'ejlxs', '36460', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'ab123', '35205', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c0001', '43087', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c0002', '12925', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c0004', '5886', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c0005', '34822', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c9998', '22604', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'c9vpz', '27557', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'caqwe', '67135', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'cfho6', '29621', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'cvimp', '23913', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'cw1pw', '23913', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e0001', '17137', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e0002', '14361', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e0003', '8303', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e0004', '28131', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e0005', '20321', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'e5uut', '32093', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'ei4te', '54544', '-1');
INSERT INTO `tbl_distance` VALUES ('c0003', 'ejlxs', '25875', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'ab123', '31097', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c0001', '41936', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c0002', '8211', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c0003', '5349', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c0005', '30108', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c9998', '20396', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'c9vpz', '28344', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'caqwe', '66622', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'cfho6', '34524', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'cvimp', '19919', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'cw1pw', '19919', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e0001', '14509', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e0002', '12410', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e0003', '7500', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e0004', '24075', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e0005', '17382', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'e5uut', '31580', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'ei4te', '54031', '-1');
INSERT INTO `tbl_distance` VALUES ('c0004', 'ejlxs', '30387', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'ab123', '19934', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c0001', '38003', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c0002', '22311', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c0003', '35174', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c0004', '31049', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c9998', '30695', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'c9vpz', '40892', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'caqwe', '88419', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'cfho6', '62082', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'cvimp', '15198', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'cw1pw', '15198', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e0001', '31082', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e0002', '25865', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e0003', '36694', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e0004', '12991', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e0005', '22498', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'e5uut', '53377', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'ei4te', '75828', '-1');
INSERT INTO `tbl_distance` VALUES ('c0005', 'ejlxs', '57394', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'ab123', '45568', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c0001', '60663', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c0002', '21209', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c0003', '21848', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c0004', '19089', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c0005', '30779', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'c9vpz', '47030', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'caqwe', '60783', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'cfho6', '34446', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'cvimp', '35131', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'cw1pw', '35131', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e0001', '14109', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e0002', '31071', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e0003', '15054', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e0004', '37052', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e0005', '36109', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'e5uut', '25741', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'ei4te', '48192', '-1');
INSERT INTO `tbl_distance` VALUES ('c9998', 'ejlxs', '40372', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'ab123', '35668', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c0001', '29145', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c0002', '28043', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c0003', '27181', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c0004', '29051', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c0005', '40467', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'c9998', '47270', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'caqwe', '92391', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'cfho6', '40611', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'cvimp', '26698', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'cw1pw', '23009', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e0001', '40434', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e0002', '18288', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e0003', '33206', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e0004', '30437', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e0005', '20036', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'e5uut', '57349', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'ei4te', '79800', '-1');
INSERT INTO `tbl_distance` VALUES ('c9vpz', 'ejlxs', '22566', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'ab123', '93934', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c0001', '106120', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c0002', '69257', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c0003', '66093', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c0004', '64744', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c0005', '87460', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c9998', '59921', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'c9vpz', '91949', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'cfho6', '65074', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'cvimp', '83111', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'cw1pw', '83111', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e0001', '60452', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e0002', '76386', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e0003', '59531', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e0004', '86561', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e0005', '81566', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'e5uut', '38009', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'ei4te', '12260', '-1');
INSERT INTO `tbl_distance` VALUES ('caqwe', 'ejlxs', '81994', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'ab123', '64286', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c0001', '65055', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c0002', '42220', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c0003', '30114', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c0004', '35121', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c0005', '62992', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c9998', '35453', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'c9vpz', '43642', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'caqwe', '66502', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'cvimp', '52849', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'cw1pw', '52849', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e0001', '35984', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e0002', '41218', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e0003', '28886', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e0004', '57067', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e0005', '48141', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'e5uut', '31460', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'ei4te', '53911', '-1');
INSERT INTO `tbl_distance` VALUES ('cfho6', 'ejlxs', '30062', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'ab123', '12426', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c0001', '27598', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c0002', '16481', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c0003', '24877', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c0004', '20752', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c0005', '16250', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c9998', '36271', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'c9vpz', '27032', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'caqwe', '85333', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'cfho6', '51612', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'cw1pw', '57', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e0001', '29756', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e0002', '12228', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e0003', '27084', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e0004', '5352', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e0005', '8662', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'e5uut', '50291', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'ei4te', '72742', '-1');
INSERT INTO `tbl_distance` VALUES ('cvimp', 'ejlxs', '44830', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'ab123', '11514', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c0001', '27334', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c0002', '15549', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c0003', '24386', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c0004', '20261', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c0005', '15246', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c9998', '35339', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'c9vpz', '23132', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'caqwe', '84405', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'cfho6', '51612', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'cvimp', '161', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e0001', '28824', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e0002', '12228', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e0003', '26593', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e0004', '4440', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e0005', '8662', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'e5uut', '49363', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'ei4te', '71814', '-1');
INSERT INTO `tbl_distance` VALUES ('cw1pw', 'ejlxs', '44830', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'ab123', '39994', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c0001', '53414', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c0002', '14711', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c0003', '18052', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c0004', '15784', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c0005', '30733', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c9998', '13277', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'c9vpz', '41475', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'caqwe', '62374', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'cfho6', '36037', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'cvimp', '29292', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'cw1pw', '29292', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'e0002', '23822', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'e0003', '11307', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'e0004', '32114', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'e0005', '28860', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'e5uut', '27332', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'ei4te', '49783', '-1');
INSERT INTO `tbl_distance` VALUES ('e0001', 'ejlxs', '37386', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'ab123', '23790', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c0001', '31060', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c0002', '10880', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c0003', '14266', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c0004', '12880', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c0005', '25918', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c9998', '31213', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'c9vpz', '18230', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'caqwe', '77852', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'cfho6', '39740', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'cvimp', '12498', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'cw1pw', '12498', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'e0001', '23271', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'e0003', '18090', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'e0004', '16716', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'e0005', '7299', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'e5uut', '42810', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'ei4te', '65261', '-1');
INSERT INTO `tbl_distance` VALUES ('e0002', 'ejlxs', '32958', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'ab123', '37889', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c0001', '48070', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c0002', '15173', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c0003', '8625', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c0004', '7583', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c0005', '36224', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c9998', '15259', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'c9vpz', '34169', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'caqwe', '59990', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'cfho6', '27862', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'cvimp', '26597', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'cw1pw', '26597', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'e0001', '9867', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'e0002', '18336', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'e0004', '30815', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'e0005', '23516', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'e5uut', '24948', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'ei4te', '47399', '-1');
INSERT INTO `tbl_distance` VALUES ('e0003', 'ejlxs', '27423', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'ab123', '9551', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c0001', '26540', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c0002', '18368', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c0003', '27597', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c0004', '23472', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c0005', '13781', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c9998', '37691', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'c9vpz', '30008', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'caqwe', '87383', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'cfho6', '55197', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'cvimp', '3606', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'cw1pw', '3549', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'e0001', '31643', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'e0002', '15751', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'e0003', '29807', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'e0005', '12104', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'e5uut', '52341', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'ei4te', '74792', '-1');
INSERT INTO `tbl_distance` VALUES ('e0004', 'ejlxs', '48415', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'ab123', '18119', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c0001', '24904', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c0002', '15368', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c0003', '20664', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c0004', '17828', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c0005', '22430', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c9998', '35863', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'c9vpz', '20348', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'caqwe', '83027', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'cfho6', '46305', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'cvimp', '8602', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'cw1pw', '8602', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'e0001', '28053', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'e0002', '7141', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'e0003', '23420', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'e0004', '12888', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'e5uut', '47985', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'ei4te', '70436', '-1');
INSERT INTO `tbl_distance` VALUES ('e0005', 'ejlxs', '39555', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'ab123', '90462', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c0001', '102648', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c0002', '65785', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c0003', '62621', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c0004', '61272', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c0005', '83988', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c9998', '56449', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'c9vpz', '88477', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'caqwe', '35120', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'cfho6', '61602', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'cvimp', '79639', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'cw1pw', '79639', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'e0001', '56980', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'e0002', '72914', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'e0003', '56059', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'e0004', '83089', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'e0005', '78094', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'ei4te', '22529', '-1');
INSERT INTO `tbl_distance` VALUES ('e5uut', 'ejlxs', '78522', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'ab123', '81902', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c0001', '94088', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c0002', '57225', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c0003', '54061', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c0004', '52712', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c0005', '75428', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c9998', '47889', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'c9vpz', '79917', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'caqwe', '12724', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'cfho6', '53042', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'cvimp', '71079', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'cw1pw', '71079', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e0001', '48420', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e0002', '64354', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e0003', '47499', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e0004', '74529', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e0005', '69534', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'e5uut', '25977', '-1');
INSERT INTO `tbl_distance` VALUES ('ei4te', 'ejlxs', '69962', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'ab123', '55752', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c0001', '49524', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c0002', '36988', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c0003', '26116', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c0004', '31672', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c0005', '57781', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c9998', '41704', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'c9vpz', '23654', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'caqwe', '82862', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'cfho6', '27702', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'cvimp', '45545', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'cw1pw', '45545', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e0001', '37313', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e0002', '33484', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e0003', '28094', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e0004', '49763', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e0005', '40372', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'e5uut', '47820', '-1');
INSERT INTO `tbl_distance` VALUES ('ejlxs', 'ei4te', '70271', '-1');

-- ----------------------------
-- Table structure for `tbl_place`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_place`;
CREATE TABLE `tbl_place` (
  `pid` char(5) NOT NULL,
  `ptype` tinyint(4) NOT NULL,
  `lng` double NOT NULL,
  `lat` double NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_place
-- ----------------------------
INSERT INTO `tbl_place` VALUES ('ab123', '1', '121.229424', '31.203304');
INSERT INTO `tbl_place` VALUES ('c0001', '2', '121.205416', '31.055989');
INSERT INTO `tbl_place` VALUES ('c0002', '2', '121.463261', '31.262059');
INSERT INTO `tbl_place` VALUES ('c0003', '2', '121.551715', '31.212369');
INSERT INTO `tbl_place` VALUES ('c0004', '2', '121.525533', '31.243065');
INSERT INTO `tbl_place` VALUES ('c0005', '2', '121.276399', '31.330242');
INSERT INTO `tbl_place` VALUES ('c9998', '2', '121.57117', '31.372805');
INSERT INTO `tbl_place` VALUES ('c9vpz', '2', '121.46462218800472', '31.040405953144425');
INSERT INTO `tbl_place` VALUES ('caqwe', '2', '121.624377', '31.551682');
INSERT INTO `tbl_place` VALUES ('cfho6', '2', '121.788066', '31.178527');
INSERT INTO `tbl_place` VALUES ('cvimp', '2', '121.334952', '31.223999');
INSERT INTO `tbl_place` VALUES ('cw1pw', '2', '121.4333', '31.2222');
INSERT INTO `tbl_place` VALUES ('e0001', '3', '121.550189', '31.336811');
INSERT INTO `tbl_place` VALUES ('e0002', '3', '121.439944', '31.186053');
INSERT INTO `tbl_place` VALUES ('e0003', '3', '121.58782', '31.261689');
INSERT INTO `tbl_place` VALUES ('e0004', '3', '121.308622', '31.232308');
INSERT INTO `tbl_place` VALUES ('e0005', '3', '121.376386', '31.177014');
INSERT INTO `tbl_place` VALUES ('e5uut', '3', '121.729563', '31.401934');
INSERT INTO `tbl_place` VALUES ('ei4te', '3', '121.732128', '31.545807');
INSERT INTO `tbl_place` VALUES ('ejlxs', '3', '121.651039', '31.032425');

-- ----------------------------
-- Table structure for `tbl_rout`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_rout`;
CREATE TABLE `tbl_rout` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `gtime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `get_result` tinyint(4) NOT NULL,
  `chrome_len` int(11) DEFAULT NULL,
  `alg` char(4) DEFAULT NULL,
  `exec_time` double DEFAULT NULL,
  `hit_cache_time` int(11) DEFAULT NULL,
  `hit_cache_rate` double DEFAULT NULL,
  `best_objv` varchar(10) DEFAULT NULL,
  `use_car_num` int(11) DEFAULT NULL,
  `rent` varchar(10) DEFAULT NULL,
  `electricity` varchar(10) DEFAULT NULL,
  `time_pen` varchar(10) DEFAULT NULL,
  `best_chrome` text,
  `cir2_list` text,
  `solution_list` text,
  `show_info_text` text,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_rout
-- ----------------------------
INSERT INTO `tbl_rout` VALUES ('1', '2022-03-20 15:04:18', '1', '6', '枚举算法', '0.496', '875', '72.92', '386.77', '1', '300', '58.74', '28.03', '[5, 2, 4, 3, 1, 6]', '[[0, 5, 2, 4, 3, 1, 0]]', '[[\'ab123\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c0001\', \'ab123\']]', '车辆路径信息xxxxxxxx...');
INSERT INTO `tbl_rout` VALUES ('2', '2022-03-21 09:02:46', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_rout` VALUES ('3', '2022-03-22 09:57:16', '1', '6', '枚举算法', '0.315', '875', '72.92', '386.77', '1', '300', '58.74', '28.03', '[5, 2, 4, 3, 1, 6]', '[[0, 5, 2, 4, 3, 1, 0]]', '[[\'ab123\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从节点ab123出发，行驶19959米，到节点c0005，历时40分钟。\n2.从节点c0005出发，行驶22311米，到节点c0002，历时45分钟。\n3.从节点c0002出发，行驶9236米，到节点c0004，历时18分钟。\n4.从节点c0004出发，行驶5349米，到节点c0003，历时11分钟。\n5.从节点c0003出发，行驶43087米，到节点c0001，历时86分钟。\n6.从节点c0001出发，行驶18716米，到节点ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('4', '2022-03-22 13:23:36', '1', '6', '枚举算法', '0.217', '875', '72.92', '386.77', '1', '300', '58.74', '28.03', '[5, 2, 4, 3, 1, 6]', '[[0, 5, 2, 4, 3, 1, 0]]', '[[\'ab123\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从节点配送中心ab123出发，行驶19959米，到节点客户点c0005，历时40分钟。\n2.从节点客户点c0005出发，行驶22311米，到节点客户点c0002，历时45分钟。\n3.从节点客户点c0002出发，行驶9236米，到节点客户点c0004，历时18分钟。\n4.从节点客户点c0004出发，行驶5349米，到节点客户点c0003，历时11分钟。\n5.从节点客户点c0003出发，行驶43087米，到节点客户点c0001，历时86分钟。\n6.从节点客户点c0001出发，行驶18716米，到节点配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('5', '2022-03-22 13:25:25', '1', '6', '枚举算法', '0.3', '875', '72.92', '386.77', '1', '300', '58.74', '28.03', '[5, 2, 4, 3, 1, 6]', '[[0, 5, 2, 4, 3, 1, 0]]', '[[\'ab123\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶19959米，到客户点c0005，历时40分钟。\n2.从客户点c0005出发，行驶22311米，到客户点c0002，历时45分钟。\n3.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n4.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n5.从客户点c0003出发，行驶43087米，到客户点c0001，历时86分钟。\n6.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('6', '2022-03-24 10:09:10', '1', '7', '枚举算法', '1.816', '6684', '77.36', '396.61', '1', '300', '65.85', '30.76', '[6, 2, 4, 3, 5, 1, 7]', '[[0, 6, 2, 4, 3, 5, 1, 0]]', '[[\'ab123\', \'cw1pw\', \'c0002\', \'c0004\', \'c0003\', \'c0005\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶11346米，到客户点cw1pw，历时23分钟。\n2.从客户点cw1pw出发，行驶15549米，到客户点c0002，历时31分钟。\n3.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n4.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n5.从客户点c0003出发，行驶34822米，到客户点c0005，历时70分钟。\n6.从客户点c0005出发，行驶38003米，到客户点c0001，历时76分钟。\n7.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('7', '2022-03-24 14:35:19', '1', '7', '枚举算法', '0.214', '5212', '72.71', '684.45', '2', '600', '81.67', '2.78', '[1, 5, 7, 6, 2, 4, 3]', '[[0, 1, 0, 5, 0], [0, 6, 2, 4, 3, 9, 0]]', '[[\'ab123\', \'c0001\', \'ab123\', \'c0005\', \'ab123\'], [\'ab123\', \'cw1pw\', \'c0002\', \'c0004\', \'c0003\', \'e0003\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶18701米，到客户点c0001，历时37分钟。\n2.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n3.从配送中心ab123出发，行驶19959米，到客户点c0005，历时40分钟。\n4.从客户点c0005出发，行驶19934米，到配送中心ab123，历时40分钟。\n|车辆2：\n1.从配送中心ab123出发，行驶11346米，到客户点cw1pw，历时23分钟。\n2.从客户点cw1pw出发，行驶15549米，到客户点c0002，历时31分钟。\n3.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n4.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n5.从客户点c0003出发，行驶8303米，到充电站e0003，历时17分钟。\n6.从充电站e0003出发，行驶37889米，到配送中心ab123，历时76分钟。\n');
INSERT INTO `tbl_rout` VALUES ('8', '2022-03-24 15:15:21', '1', '6', '枚举算法', '0.048', '0', '0', '464.42', '1', '300', '68.72', '95.7', '[1, 5, 6, 2, 4, 3]', '[[0, 1, 5, 10, 6, 2, 4, 3, 0]]', '[[\'ab123\', \'c0001\', \'c0005\', \'e0004\', \'cw1pw\', \'c0002\', \'c0004\', \'c0003\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶18701米，到客户点c0001，历时37分钟。\n2.从客户点c0001出发，行驶38243米，到客户点c0005，历时76分钟。\n3.从客户点c0005出发，行驶12991米，到充电站e0004，历时26分钟。\n4.从充电站e0004出发，行驶3549米，到客户点cw1pw，历时7分钟。\n5.从客户点cw1pw出发，行驶15549米，到客户点c0002，历时31分钟。\n6.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n7.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n8.从客户点c0003出发，行驶35205米，到配送中心ab123，历时70分钟。\n');
INSERT INTO `tbl_rout` VALUES ('9', '2022-03-24 15:23:06', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_rout` VALUES ('11', '2022-03-24 15:27:24', '1', '7', '枚举算法', '4.796', '0', '0', '476.49', '1', '300', '77.3', '99.19', '[7, 5, 2, 4, 3, 6, 1]', '[[0, 11, 7, 5, 2, 4, 3, 6, 1, 0]]', '[[\'ab123\', \'e0004\', \'cw1pw\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c3b1g\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶10424米，到充电站e0004，历时21分钟。\n2.从充电站e0004出发，行驶3549米，到客户点cw1pw，历时7分钟。\n3.从客户点cw1pw出发，行驶15246米，到客户点c0005，历时30分钟。\n4.从客户点c0005出发，行驶22311米，到客户点c0002，历时45分钟。\n5.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n6.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n7.从客户点c0003出发，行驶25120米，到客户点c3b1g，历时50分钟。\n8.从客户点c3b1g出发，行驶46206米，到客户点c0001，历时92分钟。\n9.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('12', '2022-03-24 15:48:46', '1', '8', '枚举算法', '22.898', '56817', '80.57', '476.49', '1', '300', '77.3', '99.19', '[7, 5, 2, 4, 3, 6, 1, 8]', '[[0, 11, 7, 5, 2, 4, 3, 6, 1, 0]]', '[[\'ab123\', \'e0004\', \'cw1pw\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c3b1g\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶10424米，到充电站e0004，历时21分钟。\n2.从充电站e0004出发，行驶3549米，到客户点cw1pw，历时7分钟。\n3.从客户点cw1pw出发，行驶15246米，到客户点c0005，历时30分钟。\n4.从客户点c0005出发，行驶22311米，到客户点c0002，历时45分钟。\n5.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n6.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n7.从客户点c0003出发，行驶25120米，到客户点c3b1g，历时50分钟。\n8.从客户点c3b1g出发，行驶46206米，到客户点c0001，历时92分钟。\n9.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('13', '2022-03-24 17:01:41', '1', '9', '枚举算法', '201.535', '534601', '82.99', '487.76', '1', '300', '77.53', '110.23', '[7, 8, 5, 2, 4, 3, 6, 1, 9]', '[[0, 7, 8, 12, 5, 2, 4, 3, 6, 1, 0]]', '[[\'ab123\', \'cvimp\', \'cw1pw\', \'e0004\', \'c0005\', \'c0002\', \'c0004\', \'c0003\', \'c3b1g\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶11403米，到客户点cvimp，历时23分钟。\n2.从客户点cvimp出发，行驶57米，到客户点cw1pw，历时0分钟。\n3.从客户点cw1pw出发，行驶4440米，到充电站e0004，历时9分钟。\n4.从充电站e0004出发，行驶13781米，到客户点c0005，历时28分钟。\n5.从客户点c0005出发，行驶22311米，到客户点c0002，历时45分钟。\n6.从客户点c0002出发，行驶9236米，到客户点c0004，历时18分钟。\n7.从客户点c0004出发，行驶5349米，到客户点c0003，历时11分钟。\n8.从客户点c0003出发，行驶25120米，到客户点c3b1g，历时50分钟。\n9.从客户点c3b1g出发，行驶46206米，到客户点c0001，历时92分钟。\n10.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('14', '2022-03-27 13:58:40', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_rout` VALUES ('15', '2022-03-27 14:15:08', '1', '13', '遗传算法', '2.987', '46359', '88.39', '1649.1', '3', '900', '240.88', '508.22', '[ 8  4 13  5  2  6  3  7 12 10 11  9  1]', '[[0, 8, 18, 4, 0], [0, 5, 2, 6, 3, 7, 0], [0, 10, 11, 9, 1, 0]]', '[[\'ab123\', \'caqwe\', \'ei4te\', \'c0004\', \'ab123\'], [\'ab123\', \'c0005\', \'c0002\', \'c9998\', \'c0003\', \'c9vpz\', \'ab123\'], [\'ab123\', \'cvimp\', \'cw1pw\', \'cfho6\', \'c0001\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶95218米，到客户点caqwe，历时190分钟。\n2.从客户点caqwe出发，行驶12260米，到充电站ei4te，历时25分钟。\n3.从充电站ei4te出发，行驶52712米，到客户点c0004，历时105分钟。\n4.从客户点c0004出发，行驶31097米，到配送中心ab123，历时62分钟。\n|车辆2：\n1.从配送中心ab123出发，行驶19959米，到客户点c0005，历时40分钟。\n2.从客户点c0005出发，行驶22311米，到客户点c0002，历时45分钟。\n3.从客户点c0002出发，行驶21144米，到客户点c9998，历时42分钟。\n4.从客户点c9998出发，行驶21848米，到客户点c0003，历时44分钟。\n5.从客户点c0003出发，行驶27557米，到客户点c9vpz，历时55分钟。\n6.从客户点c9vpz出发，行驶35668米，到配送中心ab123，历时71分钟。\n|车辆3：\n1.从配送中心ab123出发，行驶11403米，到客户点cvimp，历时23分钟。\n2.从客户点cvimp出发，行驶57米，到客户点cw1pw，历时0分钟。\n3.从客户点cw1pw出发，行驶51612米，到客户点cfho6，历时103分钟。\n4.从客户点cfho6出发，行驶65055米，到客户点c0001，历时130分钟。\n5.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n');
INSERT INTO `tbl_rout` VALUES ('16', '2022-03-27 15:06:23', '1', '13', '遗传算法', '1.593', '47866', '91.87', '1639.35', '3', '900', '230.18', '509.17', '[10, 11, 2, 6, 5, 13, 7, 9, 1, 12, 8, 3, 4]', '[[0, 10, 11, 2, 6, 5, 0], [0, 7, 9, 13, 1, 0], [0, 8, 18, 3, 4, 0]]', '[[\'ab123\', \'cvimp\', \'cw1pw\', \'c0002\', \'c9998\', \'c0005\', \'ab123\'], [\'ab123\', \'c9vpz\', \'cfho6\', \'e0002\', \'c0001\', \'ab123\'], [\'ab123\', \'caqwe\', \'ei4te\', \'c0003\', \'c0004\', \'ab123\']]', '|车辆1：\n1.从配送中心ab123出发，行驶11403米，到客户点cvimp，历时23分钟。\n2.从客户点cvimp出发，行驶57米，到客户点cw1pw，历时0分钟。\n3.从客户点cw1pw出发，行驶15549米，到客户点c0002，历时31分钟。\n4.从客户点c0002出发，行驶21144米，到客户点c9998，历时42分钟。\n5.从客户点c9998出发，行驶30779米，到客户点c0005，历时62分钟。\n6.从客户点c0005出发，行驶19934米，到配送中心ab123，历时40分钟。\n|车辆2：\n1.从配送中心ab123出发，行驶36011米，到客户点c9vpz，历时72分钟。\n2.从客户点c9vpz出发，行驶40611米，到客户点cfho6，历时81分钟。\n3.从客户点cfho6出发，行驶41218米，到充电站e0002，历时82分钟。\n4.从充电站e0002出发，行驶31060米，到客户点c0001，历时62分钟。\n5.从客户点c0001出发，行驶18716米，到配送中心ab123，历时37分钟。\n|车辆3：\n1.从配送中心ab123出发，行驶95218米，到客户点caqwe，历时190分钟。\n2.从客户点caqwe出发，行驶12260米，到充电站ei4te，历时25分钟。\n3.从充电站ei4te出发，行驶54061米，到客户点c0003，历时108分钟。\n4.从客户点c0003出发，行驶5886米，到客户点c0004，历时12分钟。\n5.从客户点c0004出发，行驶31097米，到配送中心ab123，历时62分钟。\n');
INSERT INTO `tbl_rout` VALUES ('17', '2022-03-27 18:23:41', '1', '13', '遗传算法', '2.75', '47042', '90.41', '1626.02', '3', '900', '238.3', '487.72', '[10, 11, 9, 7, 13, 8, 12, 5, 2, 6, 4, 3, 1]', '[[0, 10, 11, 9, 7, 0], [0, 8, 18, 0], [0, 5, 2, 6, 4, 3, 1, 0]]', '[[\'ab123\', \'cvimp\', \'cw1pw\', \'cfho6\', \'c9vpz\', \'ab123\'], [\'ab123\', \'caqwe\', \'ei4te\', \'ab123\'], [\'ab123\', \'c0005\', \'c0002\', \'c9998\', \'c0004\', \'c0003\', \'c0001\', \'ab123\']]', '***车辆1：$$$1) 从卡行天下上海物流园（上海市青浦区嘉松中路3899号）出发，行驶11403米，到蔬香农庄（上海市闵行区吴漕路898），历时23分钟。$$$2) 从蔬香农庄（上海市闵行区吴漕路898）出发，行驶57米，到菜鸟驿站（上海市长宁区愚园路1203弄30号），历时0分钟。$$$3) 从菜鸟驿站（上海市长宁区愚园路1203弄30号）出发，行驶51612米，到经贸国际货运实业有限公司（上海市浦东新区海天一路300号），历时103分钟。$$$4) 从经贸国际货运实业有限公司（上海市浦东新区海天一路300号）出发，行驶43642米，到华东师范大学研究生公寓菜鸟驿站（上海市虹梅南路5880号），历时87分钟。$$$5) 从华东师范大学研究生公寓菜鸟驿站（上海市虹梅南路5880号）出发，行驶35668米，到卡行天下上海物流园（上海市青浦区嘉松中路3899号），历时71分钟。***车辆2：$$$1) 从卡行天下上海物流园（上海市青浦区嘉松中路3899号）出发，行驶95218米，到时岛物流（堡镇大通路390号），历时190分钟。$$$2) 从时岛物流（堡镇大通路390号）出发，行驶12260米，到国家电网充电站（上海市崇明区陈海公路灶花堂服务区），历时25分钟。$$$3) 从国家电网充电站（上海市崇明区陈海公路灶花堂服务区）出发，行驶81902米，到卡行天下上海物流园（上海市青浦区嘉松中路3899号），历时164分钟。***车辆3：$$$1) 从卡行天下上海物流园（上海市青浦区嘉松中路3899号）出发，行驶19959米，到菜鸟驿站（上海市嘉定区宝安公路3705弄-112~104号），历时40分钟。$$$2) 从菜鸟驿站（上海市嘉定区宝安公路3705弄-112~104号）出发，行驶22311米，到菜鸟驿站(上海普善店)（上海市静安区芷江西路488号五月花生活广场F1），历时45分钟。$$$3) 从菜鸟驿站(上海普善店)（上海市静安区芷江西路488号五月花生活广场F1）出发，行驶21144米，到信欣物流(上海)有限公司（申非路119号2层），历时42分钟。$$$4) 从信欣物流(上海)有限公司（申非路119号2层）出发，行驶19089米，到菜鸟驿站（上海市浦东新区栖霞路107号），历时38分钟。$$$5) 从菜鸟驿站（上海市浦东新区栖霞路107号）出发，行驶5349米，到菜鸟驿站(牡丹路店)（上海市浦东新区牡丹路90号），历时11分钟。$$$6) 从菜鸟驿站(牡丹路店)（上海市浦东新区牡丹路90号）出发，行驶43087米，到菜鸟驿站(四期站)（上海市松江区广富林街道文汇路1008弄105号），历时86分钟。$$$7) 从菜鸟驿站(四期站)（上海市松江区广富林街道文汇路1008弄105号）出发，行驶18716米，到卡行天下上海物流园（上海市青浦区嘉松中路3899号），历时37分钟。');

-- ----------------------------
-- Table structure for `tbl_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_vehicle`;
CREATE TABLE `tbl_vehicle` (
  `vid` int(11) NOT NULL AUTO_INCREMENT,
  `plate_number` varchar(10) NOT NULL,
  `driver` varchar(10) NOT NULL,
  PRIMARY KEY (`vid`),
  UNIQUE KEY `u_plate_number` (`plate_number`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tbl_vehicle
-- ----------------------------
INSERT INTO `tbl_vehicle` VALUES ('1', '沪A-D99988', '赵勇');
INSERT INTO `tbl_vehicle` VALUES ('2', '沪A-D99977', '钱军');
INSERT INTO `tbl_vehicle` VALUES ('21', '沪A-D23479', '孙丽');
INSERT INTO `tbl_vehicle` VALUES ('23', '沪A-D39989', '李经纬');
INSERT INTO `tbl_vehicle` VALUES ('24', '沪A-D39389', '洪智');
INSERT INTO `tbl_vehicle` VALUES ('25', '沪A-D38687', '李娜');
INSERT INTO `tbl_vehicle` VALUES ('27', '沪A-D99Y79', '韩信');
INSERT INTO `tbl_vehicle` VALUES ('31', '沪A-F99989', '马朝勇');
