# SQL-Front 5.1  (Build 4.16)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: onethink
# ------------------------------------------------------
# Server version 5.5.27

#
# Source for table onethink_action
#

DROP TABLE IF EXISTS `onethink_action`;
CREATE TABLE `onethink_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

#
# Dumping data for table onethink_action
#

INSERT INTO `onethink_action` VALUES (1,'user_login','用户登录','积分+10，每天一次','table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;','[user|get_nickname]在[time|time_format]登录了后台',1,1,1387181220);
INSERT INTO `onethink_action` VALUES (2,'add_article','发布文章','积分+5，每天上限5次','table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5','',2,0,1380173180);
INSERT INTO `onethink_action` VALUES (3,'review','评论','评论积分+1，无限制','table:member|field:score|condition:uid={$self}|rule:score+1','',2,1,1383285646);
INSERT INTO `onethink_action` VALUES (4,'add_document','发表文档','积分+10，每天上限5次','table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5','[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。',2,0,1386139726);
INSERT INTO `onethink_action` VALUES (5,'add_document_topic','发表讨论','积分+5，每天上限10次','table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10','',2,0,1383285551);
INSERT INTO `onethink_action` VALUES (6,'update_config','更新配置','新增或修改或删除配置','','',1,1,1383294988);
INSERT INTO `onethink_action` VALUES (7,'update_model','更新模型','新增或修改模型','','',1,1,1383295057);
INSERT INTO `onethink_action` VALUES (8,'update_attribute','更新属性','新增或更新或删除属性','','',1,1,1383295963);
INSERT INTO `onethink_action` VALUES (9,'update_channel','更新导航','新增或修改或删除导航','','',1,1,1383296301);
INSERT INTO `onethink_action` VALUES (10,'update_menu','更新菜单','新增或修改或删除菜单','','',1,1,1383296392);
INSERT INTO `onethink_action` VALUES (11,'update_category','更新分类','新增或修改或删除分类','','',1,1,1383296765);

#
# Source for table onethink_action_log
#

DROP TABLE IF EXISTS `onethink_action_log`;
CREATE TABLE `onethink_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

#
# Dumping data for table onethink_action_log
#

INSERT INTO `onethink_action_log` VALUES (120,1,1,2130706433,'member',1,'admin在2015-02-17 15:19登录了后台',1,1424157551);
INSERT INTO `onethink_action_log` VALUES (121,1,1,2130706433,'member',1,'admin在2015-02-17 15:33登录了后台',1,1424158422);
INSERT INTO `onethink_action_log` VALUES (122,1,1,2130706433,'member',1,'admin在2015-02-17 17:17登录了后台',1,1424164625);
INSERT INTO `onethink_action_log` VALUES (123,1,1,2130706433,'member',1,'admin在2015-02-17 19:45登录了后台',1,1424173532);
INSERT INTO `onethink_action_log` VALUES (124,1,1,2130706433,'member',1,'admin在2015-02-17 21:53登录了后台',1,1424181197);
INSERT INTO `onethink_action_log` VALUES (125,10,1,2130706433,'Menu',27,'操作url：/admin.php?s=/Menu/edit.html',1,1424185127);
INSERT INTO `onethink_action_log` VALUES (126,10,1,2130706433,'Menu',27,'操作url：/admin.php?s=/Menu/edit.html',1,1424186044);
INSERT INTO `onethink_action_log` VALUES (127,10,1,2130706433,'Menu',27,'操作url：/admin.php?s=/Menu/edit.html',1,1424186456);
INSERT INTO `onethink_action_log` VALUES (128,1,1,2130706433,'member',1,'admin在2015-02-17 23:27登录了后台',1,1424186851);

#
# Source for table onethink_addons
#

DROP TABLE IF EXISTS `onethink_addons`;
CREATE TABLE `onethink_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `url` varchar(255) DEFAULT '' COMMENT '插件作者首页链接',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  `is_locked` tinyint(1) DEFAULT '0' COMMENT '插件是否已被锁定',
  `sort` int(10) DEFAULT '0' COMMENT '已安装插件菜单排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COMMENT='插件表';

#
# Dumping data for table onethink_addons
#

INSERT INTO `onethink_addons` VALUES (2,'SiteStat','站点统计信息','统计站点的基础信息',1,'{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}','thinkphp','','0.1',1379512015,0,1,0);
INSERT INTO `onethink_addons` VALUES (3,'DevTeam','开发团队信息','开发团队成员信息',1,'{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}','thinkphp','','0.1',1379512022,0,1,0);
INSERT INTO `onethink_addons` VALUES (4,'SystemInfo','系统环境信息','用于显示一些服务器的信息',1,'{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}','thinkphp','','0.1',1379512036,0,1,0);
INSERT INTO `onethink_addons` VALUES (5,'Editor','前台编辑器','用于增强整站长文本的输入和显示',1,'{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}','thinkphp','','0.1',1379830910,0,1,0);
INSERT INTO `onethink_addons` VALUES (6,'Attachment','附件','用于文档模型上传附件',1,'null','thinkphp','','0.1',1379842319,1,1,12);
INSERT INTO `onethink_addons` VALUES (9,'SocialComment','通用社交化评论','集成了各种社交化评论插件，轻松集成到系统中。',0,'{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}','thinkphp','','0.1',1380273962,0,1,0);
INSERT INTO `onethink_addons` VALUES (15,'EditorForAdmin','后台编辑器','用于增强整站长文本的输入和显示',1,'{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}','thinkphp','','0.1',1383126253,0,1,0);
INSERT INTO `onethink_addons` VALUES (108,'Water','图片水印','用于为上传的图片添加水印',1,'{\"switch\":\"1\",\"water\":\"\",\"position\":\"9\"}','xjw129xjt','','0.1',1423563901,0,1,0);
INSERT INTO `onethink_addons` VALUES (114,'Sensitive','敏感词','敏感词过滤插件',1,'{\"is_open\":\"1\"}','geniusxjq(app880.com)','http://app880.com','0.1',1423640787,1,1,7);
INSERT INTO `onethink_addons` VALUES (118,'Mail','邮件订阅','邮件订阅插件',1,'null','geniusxjq(app880.com)','http://app880.com','0.1',1423650031,1,1,11);
INSERT INTO `onethink_addons` VALUES (123,'Schedule','计划任务','执行计划任务插件',1,'{\"random\":\"1\"}','geniusxjq(app880.com)','http://app880.com','0.1',1423675029,1,1,10);
INSERT INTO `onethink_addons` VALUES (135,'Friendlinks','友情链接','友情链接',1,'{\"random\":\"1\"}','geniusxjq(app880.com)','http://app880.com','0.1',1423825560,1,1,4);
INSERT INTO `onethink_addons` VALUES (136,'Advs','广告管理','广告插件',1,'null','onep2p','','0.1',1423825694,1,1,5);
INSERT INTO `onethink_addons` VALUES (137,'Advertising','广告位置','广告位插件',1,'null','onep2p','','0.1',1423825700,1,1,6);
INSERT INTO `onethink_addons` VALUES (140,'SyncLogin','第三方账号同步登陆','第三方账号同步登陆',1,'{\"type\":[\"Qq\"],\"meta\":\"\",\"QqKEY\":\"\",\"QqSecret\":\"\",\"SinaKEY\":\"\",\"SinaSecret\":\"\"}','yidian','','0.1',1423825967,0,0,0);
INSERT INTO `onethink_addons` VALUES (143,'ReturnTop','返回顶部','回到顶部美化，随机或指定显示，100款样式，每天一种换，天天都用新样式',1,'{\"random\":\"0\",\"current\":\"68\"}','thinkphp','','0.1',1423826511,0,0,0);
INSERT INTO `onethink_addons` VALUES (147,'BaiduShare','百度分享','用户将网站内容分享到第三方网站，第三方网站的用户点击专有的分享链接，从第三方网站带来社会化流量。',1,'{\"openbutton\":\"0\",\"buttonlist\":[\"mshare\",\"qzone\",\"tsina\",\"renren\",\"tqq\",\"tieba\"],\"button_size\":\"1\",\"openimg\":\"0\",\"imglist\":[\"mshare\",\"qzone\",\"tsina\",\"renren\",\"tqq\",\"tieba\"],\"img_size\":\"1\",\"openselect\":\"0\",\"selectlist\":[\"mshare\",\"qzone\",\"tsina\",\"renren\",\"tqq\",\"tieba\"]}','jesuspan','','0.1',1423837279,0,0,0);
INSERT INTO `onethink_addons` VALUES (151,'Wechat','微信','微信插件',1,'{\"url\":\"http:\\/\\/localhost\\/admin.php?s=\\/Home\\/Addons\\/execute\\/_addons\\/Wechat\\/_controller\\/Wechat\\/_action\\/index\\/ukey\\/VNSrn2MJcatu9vs.html\",\"ukey\":\"VNSrn2MJcatu9vs\",\"token\":\"4fkgsny7jYp06d5G9cbahoIltFJOVA\",\"appid\":\"\",\"appsecret\":\"\",\"codelogin\":\"0\",\"codeloginlocation\":null,\"default\":null,\"subscribe\":null,\"button\":null}','huay1','','1.0',1423925643,1,0,1);
INSERT INTO `onethink_addons` VALUES (153,'Guestbook','留言板','这是一个简单的留言板',1,'{\"display\":\"1\",\"messages_check\":\"1\"}','geniusxjq(app880.com)','http://app880.com','0.2',1423925886,1,0,2);
INSERT INTO `onethink_addons` VALUES (154,'Fancybox','图片弹出播放','让文章内容页的图片有弹出图片播放的效果',1,'{\"group\":\"1\",\"transitionIn\":\"fade\",\"transitionOut\":\"fade\",\"padding\":\"10\",\"hideOnContentClick\":\"true\",\"easingIn\":\"easeOutCubic\"}','che1988','','0.1',1423975760,0,0,0);
INSERT INTO `onethink_addons` VALUES (157,'Unslider','焦点图','焦点图',0,'{\"title\":\"Uslider\",\"display\":\"1\"}','cepljxiongjun','','0.1',1423988274,0,0,0);
INSERT INTO `onethink_addons` VALUES (158,'Vote','微投票','支持单选、多选的小投票插件。可以用来收集用户对某几个选项的意见。',1,'{\"defaultid\":\"0\",\"display\":\"1\"}','Microrain','','1.0',1423990253,1,0,3);
INSERT INTO `onethink_addons` VALUES (159,'Support','QQ客服','网站QQ客服插件',1,'{\"random\":\"1\",\"QqKEY\":\"\",\"AnliKEY\":\"\",\"sinaKEY\":\"\"}','高龙','','0.1',1424068041,0,0,0);
INSERT INTO `onethink_addons` VALUES (163,'ImportData','数据导入','这是一个用于从其他博客导入到OneThink的后台插件，目前支持WordPress,主要导入分类和文章！',1,'null','IT童老','','0.1',1424068706,1,0,8);
INSERT INTO `onethink_addons` VALUES (164,'Diyform','自定义表单','简单的自定义表单',1,'{\"key\":\"Xgs4YBmIANG7iHeQTF03XmR9SqWxRESw\",\"open_verify\":\"1\"}','凡人','','0.1',1424187451,1,0,9);

#
# Source for table onethink_advertising
#

DROP TABLE IF EXISTS `onethink_advertising`;
CREATE TABLE `onethink_advertising` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告位置名称',
  `type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告位置展示方式  0为默认展示一张',
  `width` char(20) NOT NULL DEFAULT '' COMMENT '广告位置宽度',
  `height` char(20) NOT NULL DEFAULT '' COMMENT '广告位置高度',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_advertising
#

INSERT INTO `onethink_advertising` VALUES (1,'01',1,'01','01',1);

#
# Source for table onethink_advs
#

DROP TABLE IF EXISTS `onethink_advs`;
CREATE TABLE `onethink_advs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告名称',
  `position` int(11) NOT NULL COMMENT '广告位置',
  `advspic` int(11) NOT NULL COMMENT '图片地址',
  `advstext` text NOT NULL COMMENT '文字广告内容',
  `advshtml` text NOT NULL COMMENT '代码广告内容',
  `link` char(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `level` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_advs
#


#
# Source for table onethink_attachment
#

DROP TABLE IF EXISTS `onethink_attachment`;
CREATE TABLE `onethink_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

#
# Dumping data for table onethink_attachment
#


#
# Source for table onethink_attribute
#

DROP TABLE IF EXISTS `onethink_attribute`;
CREATE TABLE `onethink_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

#
# Dumping data for table onethink_attribute
#

INSERT INTO `onethink_attribute` VALUES (1,'uid','用户ID','int(10) unsigned NOT NULL ','num','0','',0,'',1,0,1,1384508362,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (2,'name','标识','char(40) NOT NULL ','string','','同一根节点下标识不重复',1,'',1,0,1,1383894743,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (3,'title','标题','char(80) NOT NULL ','string','','文档标题',1,'',1,0,1,1383894778,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (4,'category_id','所属分类','int(10) unsigned NOT NULL ','string','','',0,'',1,0,1,1384508336,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (5,'description','描述','char(140) NOT NULL ','textarea','','',1,'',1,0,1,1383894927,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (6,'root','根节点','int(10) unsigned NOT NULL ','num','0','该文档的顶级文档编号',0,'',1,0,1,1384508323,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (7,'pid','所属ID','int(10) unsigned NOT NULL ','num','0','父文档编号',0,'',1,0,1,1384508543,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (8,'model_id','内容模型ID','tinyint(3) unsigned NOT NULL ','num','0','该文档所对应的模型',0,'',1,0,1,1384508350,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (9,'type','内容类型','tinyint(3) unsigned NOT NULL ','select','2','',1,'1:目录\r\n2:主题\r\n3:段落',1,0,1,1384511157,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (10,'position','推荐位','smallint(5) unsigned NOT NULL ','checkbox','0','多个推荐则将其推荐值相加',1,'[DOCUMENT_POSITION]',1,0,1,1383895640,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (11,'link_id','外链','int(10) unsigned NOT NULL ','num','0','0-非外链，大于0-外链ID,需要函数进行链接与编号的转换',1,'',1,0,1,1383895757,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (12,'cover_id','封面','int(10) unsigned NOT NULL ','picture','0','0-无封面，大于0-封面图片ID，需要函数处理',1,'',1,0,1,1384147827,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (13,'display','可见性','tinyint(3) unsigned NOT NULL ','radio','1','',1,'0:不可见\r\n1:所有人可见',1,0,1,1386662271,1383891233,'',0,'','regex','',0,'function');
INSERT INTO `onethink_attribute` VALUES (14,'deadline','截至时间','int(10) unsigned NOT NULL ','datetime','0','0-永久有效',1,'',1,0,1,1387163248,1383891233,'',0,'','regex','',0,'function');
INSERT INTO `onethink_attribute` VALUES (15,'attach','附件数量','tinyint(3) unsigned NOT NULL ','num','0','',0,'',1,0,1,1387260355,1383891233,'',0,'','regex','',0,'function');
INSERT INTO `onethink_attribute` VALUES (16,'view','浏览量','int(10) unsigned NOT NULL ','num','0','',1,'',1,0,1,1383895835,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (17,'comment','评论数','int(10) unsigned NOT NULL ','num','0','',1,'',1,0,1,1383895846,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (18,'extend','扩展统计字段','int(10) unsigned NOT NULL ','num','0','根据需求自行使用',0,'',1,0,1,1384508264,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (19,'level','优先级','int(10) unsigned NOT NULL ','num','0','越高排序越靠前',1,'',1,0,1,1383895894,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (20,'create_time','创建时间','int(10) unsigned NOT NULL ','datetime','0','',1,'',1,0,1,1383895903,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (21,'update_time','更新时间','int(10) unsigned NOT NULL ','datetime','0','',0,'',1,0,1,1384508277,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (22,'status','数据状态','tinyint(4) NOT NULL ','radio','0','',0,'-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿',1,0,1,1384508496,1383891233,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (23,'parse','内容解析类型','tinyint(3) unsigned NOT NULL ','select','0','',0,'0:html\r\n1:ubb\r\n2:markdown',2,0,1,1384511049,1383891243,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (24,'content','文章内容','text NOT NULL ','editor','','',1,'',2,0,1,1383896225,1383891243,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (25,'template','详情页显示模板','varchar(100) NOT NULL ','string','','参照display方法参数的定义',1,'',2,0,1,1383896190,1383891243,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (26,'bookmark','收藏数','int(10) unsigned NOT NULL ','num','0','',1,'',2,0,1,1383896103,1383891243,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (27,'parse','内容解析类型','tinyint(3) unsigned NOT NULL ','select','0','',0,'0:html\r\n1:ubb\r\n2:markdown',3,0,1,1387260461,1383891252,'',0,'','regex','',0,'function');
INSERT INTO `onethink_attribute` VALUES (28,'content','下载详细描述','text NOT NULL ','editor','','',1,'',3,0,1,1383896438,1383891252,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (29,'template','详情页显示模板','varchar(100) NOT NULL ','string','','',1,'',3,0,1,1383896429,1383891252,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (30,'file_id','文件ID','int(10) unsigned NOT NULL ','file','0','需要函数处理',1,'',3,0,1,1383896415,1383891252,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (31,'download','下载次数','int(10) unsigned NOT NULL ','num','0','',1,'',3,0,1,1383896380,1383891252,'',0,'','','',0,'');
INSERT INTO `onethink_attribute` VALUES (32,'size','文件大小','bigint(20) unsigned NOT NULL ','num','0','单位bit',1,'',3,0,1,1383896371,1383891252,'',0,'','','',0,'');

#
# Source for table onethink_auth_extend
#

DROP TABLE IF EXISTS `onethink_auth_extend`;
CREATE TABLE `onethink_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

#
# Dumping data for table onethink_auth_extend
#

INSERT INTO `onethink_auth_extend` VALUES (1,1,1);
INSERT INTO `onethink_auth_extend` VALUES (1,1,2);
INSERT INTO `onethink_auth_extend` VALUES (1,2,1);
INSERT INTO `onethink_auth_extend` VALUES (1,2,2);
INSERT INTO `onethink_auth_extend` VALUES (1,3,2);

#
# Source for table onethink_auth_group
#

DROP TABLE IF EXISTS `onethink_auth_group`;
CREATE TABLE `onethink_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_auth_group
#

INSERT INTO `onethink_auth_group` VALUES (1,'admin',1,'默认用户组','',1,'2,7,8,9,10,11,12,13,14,15,16,17,18,79,211,217');
INSERT INTO `onethink_auth_group` VALUES (2,'admin',1,'测试用户','测试用户',1,'232,2,7,8,9,10,11,12,13,14,15,16,17,18,79,211,217');

#
# Source for table onethink_auth_group_access
#

DROP TABLE IF EXISTS `onethink_auth_group_access`;
CREATE TABLE `onethink_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_auth_group_access
#

INSERT INTO `onethink_auth_group_access` VALUES (3,1);

#
# Source for table onethink_auth_rule
#

DROP TABLE IF EXISTS `onethink_auth_rule`;
CREATE TABLE `onethink_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_auth_rule
#

INSERT INTO `onethink_auth_rule` VALUES (1,'admin',2,'Admin/Index/index','首页',1,'');
INSERT INTO `onethink_auth_rule` VALUES (2,'admin',2,'Admin/Article/index','内容',1,'');
INSERT INTO `onethink_auth_rule` VALUES (3,'admin',2,'Admin/User/index','用户',1,'');
INSERT INTO `onethink_auth_rule` VALUES (4,'admin',2,'Admin/Addons/index','扩展',1,'');
INSERT INTO `onethink_auth_rule` VALUES (5,'admin',2,'Admin/Config/group','系统',1,'');
INSERT INTO `onethink_auth_rule` VALUES (7,'admin',1,'Admin/article/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (8,'admin',1,'Admin/article/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (9,'admin',1,'Admin/article/setStatus','改变状态',1,'');
INSERT INTO `onethink_auth_rule` VALUES (10,'admin',1,'Admin/article/update','保存',1,'');
INSERT INTO `onethink_auth_rule` VALUES (11,'admin',1,'Admin/article/autoSave','保存草稿',1,'');
INSERT INTO `onethink_auth_rule` VALUES (12,'admin',1,'Admin/article/move','移动',1,'');
INSERT INTO `onethink_auth_rule` VALUES (13,'admin',1,'Admin/article/copy','复制',1,'');
INSERT INTO `onethink_auth_rule` VALUES (14,'admin',1,'Admin/article/paste','粘贴',1,'');
INSERT INTO `onethink_auth_rule` VALUES (15,'admin',1,'Admin/article/permit','还原',1,'');
INSERT INTO `onethink_auth_rule` VALUES (16,'admin',1,'Admin/article/clear','清空',1,'');
INSERT INTO `onethink_auth_rule` VALUES (17,'admin',1,'Admin/Article/examine','审核列表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (18,'admin',1,'Admin/article/recycle','回收站',1,'');
INSERT INTO `onethink_auth_rule` VALUES (19,'admin',1,'Admin/User/addaction','新增用户行为',1,'');
INSERT INTO `onethink_auth_rule` VALUES (20,'admin',1,'Admin/User/editaction','编辑用户行为',1,'');
INSERT INTO `onethink_auth_rule` VALUES (21,'admin',1,'Admin/User/saveAction','保存用户行为',1,'');
INSERT INTO `onethink_auth_rule` VALUES (22,'admin',1,'Admin/User/setStatus','变更行为状态',1,'');
INSERT INTO `onethink_auth_rule` VALUES (23,'admin',1,'Admin/User/changeStatus?method=forbidUser','禁用会员',1,'');
INSERT INTO `onethink_auth_rule` VALUES (24,'admin',1,'Admin/User/changeStatus?method=resumeUser','启用会员',1,'');
INSERT INTO `onethink_auth_rule` VALUES (25,'admin',1,'Admin/User/changeStatus?method=deleteUser','删除会员',1,'');
INSERT INTO `onethink_auth_rule` VALUES (26,'admin',1,'Admin/User/index','用户信息',1,'');
INSERT INTO `onethink_auth_rule` VALUES (27,'admin',1,'Admin/User/action','用户行为',1,'');
INSERT INTO `onethink_auth_rule` VALUES (28,'admin',1,'Admin/AuthManager/changeStatus?method=deleteGroup','删除',1,'');
INSERT INTO `onethink_auth_rule` VALUES (29,'admin',1,'Admin/AuthManager/changeStatus?method=forbidGroup','禁用',1,'');
INSERT INTO `onethink_auth_rule` VALUES (30,'admin',1,'Admin/AuthManager/changeStatus?method=resumeGroup','恢复',1,'');
INSERT INTO `onethink_auth_rule` VALUES (31,'admin',1,'Admin/AuthManager/createGroup','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (32,'admin',1,'Admin/AuthManager/editGroup','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (33,'admin',1,'Admin/AuthManager/writeGroup','保存用户组',1,'');
INSERT INTO `onethink_auth_rule` VALUES (34,'admin',1,'Admin/AuthManager/group','授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (35,'admin',1,'Admin/AuthManager/access','访问授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (36,'admin',1,'Admin/AuthManager/user','成员授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (37,'admin',1,'Admin/AuthManager/removeFromGroup','解除授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (38,'admin',1,'Admin/AuthManager/addToGroup','保存成员授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (39,'admin',1,'Admin/AuthManager/category','分类授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (40,'admin',1,'Admin/AuthManager/addToCategory','保存分类授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (41,'admin',1,'Admin/AuthManager/index','权限管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (42,'admin',1,'Admin/Addons/create','创建',1,'');
INSERT INTO `onethink_auth_rule` VALUES (43,'admin',1,'Admin/Addons/checkForm','检测创建',1,'');
INSERT INTO `onethink_auth_rule` VALUES (44,'admin',1,'Admin/Addons/preview','预览',1,'');
INSERT INTO `onethink_auth_rule` VALUES (45,'admin',1,'Admin/Addons/build','快速生成插件',1,'');
INSERT INTO `onethink_auth_rule` VALUES (46,'admin',1,'Admin/Addons/config','设置',1,'');
INSERT INTO `onethink_auth_rule` VALUES (47,'admin',1,'Admin/Addons/disable','禁用',1,'');
INSERT INTO `onethink_auth_rule` VALUES (48,'admin',1,'Admin/Addons/enable','启用',1,'');
INSERT INTO `onethink_auth_rule` VALUES (49,'admin',1,'Admin/Addons/install','安装',1,'');
INSERT INTO `onethink_auth_rule` VALUES (50,'admin',1,'Admin/Addons/uninstall','卸载',1,'');
INSERT INTO `onethink_auth_rule` VALUES (51,'admin',1,'Admin/Addons/saveconfig','更新配置',1,'');
INSERT INTO `onethink_auth_rule` VALUES (52,'admin',1,'Admin/Addons/adminList','插件后台列表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (53,'admin',1,'Admin/Addons/execute','URL方式访问插件',1,'');
INSERT INTO `onethink_auth_rule` VALUES (54,'admin',1,'Admin/Addons/index','插件管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (55,'admin',1,'Admin/Addons/hooks','钩子管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (56,'admin',1,'Admin/model/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (57,'admin',1,'Admin/model/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (58,'admin',1,'Admin/model/setStatus','改变状态',1,'');
INSERT INTO `onethink_auth_rule` VALUES (59,'admin',1,'Admin/model/update','保存数据',1,'');
INSERT INTO `onethink_auth_rule` VALUES (60,'admin',1,'Admin/Model/index','模型管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (61,'admin',1,'Admin/Config/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (62,'admin',1,'Admin/Config/del','删除',1,'');
INSERT INTO `onethink_auth_rule` VALUES (63,'admin',1,'Admin/Config/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (64,'admin',1,'Admin/Config/save','保存',1,'');
INSERT INTO `onethink_auth_rule` VALUES (65,'admin',1,'Admin/Config/group','网站设置',1,'');
INSERT INTO `onethink_auth_rule` VALUES (66,'admin',1,'Admin/Config/index','配置管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (67,'admin',1,'Admin/Channel/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (68,'admin',1,'Admin/Channel/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (69,'admin',1,'Admin/Channel/del','删除',1,'');
INSERT INTO `onethink_auth_rule` VALUES (70,'admin',1,'Admin/Channel/index','导航管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (71,'admin',1,'Admin/Category/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (72,'admin',1,'Admin/Category/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (73,'admin',1,'Admin/Category/remove','删除',1,'');
INSERT INTO `onethink_auth_rule` VALUES (74,'admin',1,'Admin/Category/index','分类管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (75,'admin',1,'Admin/file/upload','上传控件',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (76,'admin',1,'Admin/file/uploadPicture','上传图片',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (77,'admin',1,'Admin/file/download','下载',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (79,'admin',1,'Admin/article/batchOperate','导入',1,'');
INSERT INTO `onethink_auth_rule` VALUES (80,'admin',1,'Admin/Database/index?type=export','备份数据库',1,'');
INSERT INTO `onethink_auth_rule` VALUES (81,'admin',1,'Admin/Database/index?type=import','还原数据库',1,'');
INSERT INTO `onethink_auth_rule` VALUES (82,'admin',1,'Admin/Database/export','备份',1,'');
INSERT INTO `onethink_auth_rule` VALUES (83,'admin',1,'Admin/Database/optimize','优化表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (84,'admin',1,'Admin/Database/repair','修复表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (86,'admin',1,'Admin/Database/import','恢复',1,'');
INSERT INTO `onethink_auth_rule` VALUES (87,'admin',1,'Admin/Database/del','删除',1,'');
INSERT INTO `onethink_auth_rule` VALUES (88,'admin',1,'Admin/User/add','新增用户',1,'');
INSERT INTO `onethink_auth_rule` VALUES (89,'admin',1,'Admin/Attribute/index','属性管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (90,'admin',1,'Admin/Attribute/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (91,'admin',1,'Admin/Attribute/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (92,'admin',1,'Admin/Attribute/setStatus','改变状态',1,'');
INSERT INTO `onethink_auth_rule` VALUES (93,'admin',1,'Admin/Attribute/update','保存数据',1,'');
INSERT INTO `onethink_auth_rule` VALUES (94,'admin',1,'Admin/AuthManager/modelauth','模型授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (95,'admin',1,'Admin/AuthManager/addToModel','保存模型授权',1,'');
INSERT INTO `onethink_auth_rule` VALUES (96,'admin',1,'Admin/Category/move','移动',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (97,'admin',1,'Admin/Category/merge','合并',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (98,'admin',1,'Admin/Config/menu','后台菜单管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (99,'admin',1,'Admin/Article/mydocument','内容',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (100,'admin',1,'Admin/Menu/index','菜单管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (101,'admin',1,'Admin/other','其他',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (102,'admin',1,'Admin/Menu/add','新增',1,'');
INSERT INTO `onethink_auth_rule` VALUES (103,'admin',1,'Admin/Menu/edit','编辑',1,'');
INSERT INTO `onethink_auth_rule` VALUES (104,'admin',1,'Admin/Think/lists?model=article','文章管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (105,'admin',1,'Admin/Think/lists?model=download','下载管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (106,'admin',1,'Admin/Think/lists?model=config','配置管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (107,'admin',1,'Admin/Action/actionlog','行为日志',1,'');
INSERT INTO `onethink_auth_rule` VALUES (108,'admin',1,'Admin/User/updatePassword','修改密码',1,'');
INSERT INTO `onethink_auth_rule` VALUES (109,'admin',1,'Admin/User/updateNickname','修改昵称',1,'');
INSERT INTO `onethink_auth_rule` VALUES (110,'admin',1,'Admin/action/edit','查看行为日志',1,'');
INSERT INTO `onethink_auth_rule` VALUES (111,'admin',2,'Admin/article/index','文档列表',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (112,'admin',2,'Admin/article/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (113,'admin',2,'Admin/article/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (114,'admin',2,'Admin/article/setStatus','改变状态',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (115,'admin',2,'Admin/article/update','保存',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (116,'admin',2,'Admin/article/autoSave','保存草稿',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (117,'admin',2,'Admin/article/move','移动',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (118,'admin',2,'Admin/article/copy','复制',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (119,'admin',2,'Admin/article/paste','粘贴',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (120,'admin',2,'Admin/article/batchOperate','导入',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (121,'admin',2,'Admin/article/recycle','回收站',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (122,'admin',2,'Admin/article/permit','还原',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (123,'admin',2,'Admin/article/clear','清空',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (124,'admin',2,'Admin/User/add','新增用户',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (125,'admin',2,'Admin/User/action','用户行为',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (126,'admin',2,'Admin/User/addAction','新增用户行为',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (127,'admin',2,'Admin/User/editAction','编辑用户行为',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (128,'admin',2,'Admin/User/saveAction','保存用户行为',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (129,'admin',2,'Admin/User/setStatus','变更行为状态',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (130,'admin',2,'Admin/User/changeStatus?method=forbidUser','禁用会员',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (131,'admin',2,'Admin/User/changeStatus?method=resumeUser','启用会员',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (132,'admin',2,'Admin/User/changeStatus?method=deleteUser','删除会员',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (133,'admin',2,'Admin/AuthManager/index','权限管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (134,'admin',2,'Admin/AuthManager/changeStatus?method=deleteGroup','删除',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (135,'admin',2,'Admin/AuthManager/changeStatus?method=forbidGroup','禁用',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (136,'admin',2,'Admin/AuthManager/changeStatus?method=resumeGroup','恢复',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (137,'admin',2,'Admin/AuthManager/createGroup','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (138,'admin',2,'Admin/AuthManager/editGroup','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (139,'admin',2,'Admin/AuthManager/writeGroup','保存用户组',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (140,'admin',2,'Admin/AuthManager/group','授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (141,'admin',2,'Admin/AuthManager/access','访问授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (142,'admin',2,'Admin/AuthManager/user','成员授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (143,'admin',2,'Admin/AuthManager/removeFromGroup','解除授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (144,'admin',2,'Admin/AuthManager/addToGroup','保存成员授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (145,'admin',2,'Admin/AuthManager/category','分类授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (146,'admin',2,'Admin/AuthManager/addToCategory','保存分类授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (147,'admin',2,'Admin/AuthManager/modelauth','模型授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (148,'admin',2,'Admin/AuthManager/addToModel','保存模型授权',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (149,'admin',2,'Admin/Addons/create','创建',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (150,'admin',2,'Admin/Addons/checkForm','检测创建',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (151,'admin',2,'Admin/Addons/preview','预览',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (152,'admin',2,'Admin/Addons/build','快速生成插件',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (153,'admin',2,'Admin/Addons/config','设置',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (154,'admin',2,'Admin/Addons/disable','禁用',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (155,'admin',2,'Admin/Addons/enable','启用',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (156,'admin',2,'Admin/Addons/install','安装',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (157,'admin',2,'Admin/Addons/uninstall','卸载',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (158,'admin',2,'Admin/Addons/saveconfig','更新配置',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (159,'admin',2,'Admin/Addons/adminList','插件后台列表',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (160,'admin',2,'Admin/Addons/execute','URL方式访问插件',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (161,'admin',2,'Admin/Addons/hooks','钩子管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (162,'admin',2,'Admin/Model/index','模型管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (163,'admin',2,'Admin/model/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (164,'admin',2,'Admin/model/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (165,'admin',2,'Admin/model/setStatus','改变状态',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (166,'admin',2,'Admin/model/update','保存数据',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (167,'admin',2,'Admin/Attribute/index','属性管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (168,'admin',2,'Admin/Attribute/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (169,'admin',2,'Admin/Attribute/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (170,'admin',2,'Admin/Attribute/setStatus','改变状态',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (171,'admin',2,'Admin/Attribute/update','保存数据',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (172,'admin',2,'Admin/Config/index','配置管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (173,'admin',2,'Admin/Config/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (174,'admin',2,'Admin/Config/del','删除',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (175,'admin',2,'Admin/Config/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (176,'admin',2,'Admin/Config/save','保存',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (177,'admin',2,'Admin/Menu/index','菜单管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (178,'admin',2,'Admin/Channel/index','导航管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (179,'admin',2,'Admin/Channel/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (180,'admin',2,'Admin/Channel/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (181,'admin',2,'Admin/Channel/del','删除',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (182,'admin',2,'Admin/Category/index','分类管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (183,'admin',2,'Admin/Category/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (184,'admin',2,'Admin/Category/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (185,'admin',2,'Admin/Category/remove','删除',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (186,'admin',2,'Admin/Category/move','移动',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (187,'admin',2,'Admin/Category/merge','合并',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (188,'admin',2,'Admin/Database/index?type=export','备份数据库',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (189,'admin',2,'Admin/Database/export','备份',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (190,'admin',2,'Admin/Database/optimize','优化表',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (191,'admin',2,'Admin/Database/repair','修复表',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (192,'admin',2,'Admin/Database/index?type=import','还原数据库',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (193,'admin',2,'Admin/Database/import','恢复',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (194,'admin',2,'Admin/Database/del','删除',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (195,'admin',2,'Admin/other','其他',1,'');
INSERT INTO `onethink_auth_rule` VALUES (196,'admin',2,'Admin/Menu/add','新增',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (197,'admin',2,'Admin/Menu/edit','编辑',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (198,'admin',2,'Admin/Think/lists?model=article','应用',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (199,'admin',2,'Admin/Think/lists?model=download','下载管理',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (200,'admin',2,'Admin/Think/lists?model=config','应用',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (201,'admin',2,'Admin/Action/actionlog','行为日志',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (202,'admin',2,'Admin/User/updatePassword','修改密码',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (203,'admin',2,'Admin/User/updateNickname','修改昵称',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (204,'admin',2,'Admin/action/edit','查看行为日志',-1,'');
INSERT INTO `onethink_auth_rule` VALUES (205,'admin',1,'Admin/think/add','新增数据',1,'');
INSERT INTO `onethink_auth_rule` VALUES (206,'admin',1,'Admin/think/edit','编辑数据',1,'');
INSERT INTO `onethink_auth_rule` VALUES (207,'admin',1,'Admin/Menu/import','导入',1,'');
INSERT INTO `onethink_auth_rule` VALUES (208,'admin',1,'Admin/Model/generate','生成',1,'');
INSERT INTO `onethink_auth_rule` VALUES (209,'admin',1,'Admin/Addons/addHook','新增钩子',1,'');
INSERT INTO `onethink_auth_rule` VALUES (210,'admin',1,'Admin/Addons/edithook','编辑钩子',1,'');
INSERT INTO `onethink_auth_rule` VALUES (211,'admin',1,'Admin/Article/sort','文档排序',1,'');
INSERT INTO `onethink_auth_rule` VALUES (212,'admin',1,'Admin/Config/sort','排序',1,'');
INSERT INTO `onethink_auth_rule` VALUES (213,'admin',1,'Admin/Menu/sort','排序',1,'');
INSERT INTO `onethink_auth_rule` VALUES (214,'admin',1,'Admin/Channel/sort','排序',1,'');
INSERT INTO `onethink_auth_rule` VALUES (215,'admin',1,'Admin/Category/operate/type/move','移动',1,'');
INSERT INTO `onethink_auth_rule` VALUES (216,'admin',1,'Admin/Category/operate/type/merge','合并',1,'');
INSERT INTO `onethink_auth_rule` VALUES (217,'admin',1,'Admin/article/index','文档列表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (218,'admin',1,'Admin/think/lists','数据列表',1,'');
INSERT INTO `onethink_auth_rule` VALUES (219,'admin',1,'Admin/Addons/sort','已安装插件菜单排序',1,'');
INSERT INTO `onethink_auth_rule` VALUES (220,'admin',1,'Admin/AuthManager/accessUser','前台权限管理',1,'');
INSERT INTO `onethink_auth_rule` VALUES (221,'admin',1,'Admin/AuthManager/addNode','新增前台权限节点',1,'');
INSERT INTO `onethink_auth_rule` VALUES (232,'Home',1,'01','01',1,'');

#
# Source for table onethink_category
#

DROP TABLE IF EXISTS `onethink_category`;
CREATE TABLE `onethink_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

#
# Dumping data for table onethink_category
#

INSERT INTO `onethink_category` VALUES (1,'blog','博客',0,0,10,'','','','','','','','2,3','2','2,1',0,0,1,0,0,'1','',1379474947,1382701539,1,0,'');
INSERT INTO `onethink_category` VALUES (2,'default_blog','默认分类',1,1,10,'','','','','','','','2,3','2','2,1,3',0,1,1,0,1,'1','',1379475028,1386839751,1,0,'');

#
# Source for table onethink_channel
#

DROP TABLE IF EXISTS `onethink_channel`;
CREATE TABLE `onethink_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_channel
#

INSERT INTO `onethink_channel` VALUES (1,0,'首页','Index/index',1,1379475111,1379923177,1,0);
INSERT INTO `onethink_channel` VALUES (2,0,'博客','Article/index?category=blog',2,1379475131,1379483713,1,0);
INSERT INTO `onethink_channel` VALUES (3,0,'官网','http://www.onethink.cn',3,1379475154,1387163458,1,0);

#
# Source for table onethink_config
#

DROP TABLE IF EXISTS `onethink_config`;
CREATE TABLE `onethink_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_config
#

INSERT INTO `onethink_config` VALUES (1,'WEB_SITE_TITLE',1,'网站标题',1,'','网站标题前台显示标题',1378898976,1379235274,1,'OneThink',10);
INSERT INTO `onethink_config` VALUES (2,'WEB_SITE_DESCRIPTION',2,'网站描述',1,'','网站搜索引擎描述',1378898976,1379235841,1,'OneThink内容管理框架',14);
INSERT INTO `onethink_config` VALUES (3,'WEB_SITE_KEYWORD',2,'网站关键字',1,'','网站搜索引擎关键字',1378898976,1381390100,1,'ThinkPHP,OneThink',23);
INSERT INTO `onethink_config` VALUES (4,'WEB_SITE_CLOSE',4,'关闭站点',1,'0:关闭,1:开启','站点关闭后其他用户不能访问，管理员可以正常访问',1378898976,1379235296,1,'1',19);
INSERT INTO `onethink_config` VALUES (9,'CONFIG_TYPE_LIST',3,'配置类型列表',4,'','主要用于数据解析和页面表单的生成',1378898976,1379235348,1,'0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举',11);
INSERT INTO `onethink_config` VALUES (10,'WEB_SITE_ICP',1,'网站备案号',1,'','设置在网站底部显示的备案号，如“沪ICP备12007941号-2',1378900335,1379235859,1,'',26);
INSERT INTO `onethink_config` VALUES (11,'DOCUMENT_POSITION',3,'文档推荐位',2,'','文档推荐位，推荐到多个位置KEY值相加即可',1379053380,1379235329,1,'1:列表推荐\r\n2:频道推荐\r\n4:首页推荐',15);
INSERT INTO `onethink_config` VALUES (12,'DOCUMENT_DISPLAY',3,'文档可见性',2,'','文章可见性仅影响前台显示，后台不收影响',1379056370,1379235322,1,'0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见',20);
INSERT INTO `onethink_config` VALUES (13,'COLOR_STYLE',4,'后台色系',1,'default_color:默认\r\nblue_color:紫罗兰','后台颜色风格',1379122533,1379235904,1,'blue_color',29);
INSERT INTO `onethink_config` VALUES (20,'CONFIG_GROUP_LIST',3,'配置分组',4,'','配置分组',1379228036,1384418383,1,'1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:邮箱',21);
INSERT INTO `onethink_config` VALUES (21,'HOOKS_TYPE',3,'钩子的类型',4,'','类型 1-用于扩展显示内容，2-用于扩展业务处理',1379313397,1379313407,1,'1:视图\r\n2:控制器',27);
INSERT INTO `onethink_config` VALUES (22,'AUTH_CONFIG',3,'Auth配置',4,'','自定义Auth.class.php类配置',1379409310,1379409564,1,'AUTH_ON:1\r\nAUTH_TYPE:2',32);
INSERT INTO `onethink_config` VALUES (23,'OPEN_DRAFTBOX',4,'是否开启草稿功能',2,'0:关闭草稿功能\r\n1:开启草稿功能\r\n','新增文章时的草稿功能配置',1379484332,1379484591,1,'1',6);
INSERT INTO `onethink_config` VALUES (24,'DRAFT_AUTOSAVE_INTERVAL',0,'自动保存草稿时间',2,'','自动保存草稿的时间间隔，单位：秒',1379484574,1422631047,1,'60',12);
INSERT INTO `onethink_config` VALUES (25,'LIST_ROWS',0,'后台每页记录数',2,'','后台数据每页显示记录数',1379503896,1380427745,1,'10',35);
INSERT INTO `onethink_config` VALUES (26,'USER_ALLOW_REGISTER',4,'是否允许用户注册',3,'0:关闭注册\r\n1:允许注册','是否开放用户注册',1379504487,1379504580,1,'1',16);
INSERT INTO `onethink_config` VALUES (27,'CODEMIRROR_THEME',4,'预览插件的CodeMirror主题',4,'3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight','详情见CodeMirror官网',1379814385,1384740813,1,'ambiance',17);
INSERT INTO `onethink_config` VALUES (28,'DATA_BACKUP_PATH',1,'数据库备份根路径',4,'','路径必须以 / 结尾',1381482411,1381482411,1,'./Data/',24);
INSERT INTO `onethink_config` VALUES (29,'DATA_BACKUP_PART_SIZE',0,'数据库备份卷大小',4,'','该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M',1381482488,1381729564,1,'20971520',30);
INSERT INTO `onethink_config` VALUES (30,'DATA_BACKUP_COMPRESS',4,'数据库备份文件是否启用压缩',4,'0:不压缩\r\n1:启用压缩','压缩备份文件需要PHP环境支持gzopen,gzwrite函数',1381713345,1381729544,1,'1',34);
INSERT INTO `onethink_config` VALUES (31,'DATA_BACKUP_COMPRESS_LEVEL',4,'数据库备份文件压缩级别',4,'1:普通\r\n4:一般\r\n9:最高','数据库备份文件的压缩级别，该配置在开启压缩时生效',1381713408,1381713408,1,'9',36);
INSERT INTO `onethink_config` VALUES (32,'DEVELOP_MODE',4,'开启开发者模式',4,'0:关闭\r\n1:开启','是否开启开发者模式',1383105995,1383291877,1,'1',37);
INSERT INTO `onethink_config` VALUES (33,'ALLOW_VISIT',3,'不受限控制器方法',0,'','',1386644047,1422704535,1,'0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture',3);
INSERT INTO `onethink_config` VALUES (34,'DENY_VISIT',3,'超管专限控制器方法',0,'','仅超级管理员可访问的控制器方法',1386644141,1386644659,1,'0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree',4);
INSERT INTO `onethink_config` VALUES (35,'REPLY_LIST_ROWS',0,'回复列表每页条数',2,'','',1386645376,1387178083,1,'10',5);
INSERT INTO `onethink_config` VALUES (36,'ADMIN_ALLOW_IP',2,'后台允许访问IP',4,'','多个用逗号分隔，如果不配置表示不限制IP访问',1387165454,1387165553,1,'',38);
INSERT INTO `onethink_config` VALUES (37,'SHOW_PAGE_TRACE',4,'是否显示页面Trace',4,'0:关闭\r\n1:开启','是否显示页面Trace信息',1387165685,1387165685,1,'1',7);
INSERT INTO `onethink_config` VALUES (38,'MAIL_TYPE',4,'邮件方式',5,'0:SMTP模块发送','邮件发送方式。目前只支持SMTP方式',1410491198,1423723355,1,'0',22);
INSERT INTO `onethink_config` VALUES (39,'MAIL_SMTP_HOST',1,'SMTP服务器',5,'','邮箱服务器名称【如：smtp.qq.com】',1410491317,1422687078,1,'smtp.qq.com',25);
INSERT INTO `onethink_config` VALUES (40,'MAIL_SMTP_PORT',0,'SMTP服务器端口',5,'','端口一般为25',1410491384,1410491384,1,'25',28);
INSERT INTO `onethink_config` VALUES (41,'MAIL_SMTP_USER',1,'SMTP服务器用户名',5,'','邮箱用户名',1410491508,1410941682,1,'app880@foxmail.com',31);
INSERT INTO `onethink_config` VALUES (42,'MAIL_SMTP_PASS',1,'SMTP服务器密码',5,'邮箱密码','密码',1410491656,1410941695,1,'',33);
INSERT INTO `onethink_config` VALUES (43,'MAIL_SMTP_CE',1,'邮件发送测试',5,'','发送测试邮件用的，测试你的邮箱配置成功没有',1410491698,1410937656,1,'app880@foxmail.com',18);
INSERT INTO `onethink_config` VALUES (44,'MAIL_REPLY_EMAIL',1,'发件人邮箱',5,'','发件人邮箱，默认使用SMTP服务器用户名',1410925495,1422687971,1,'app880@foxmail.com',13);
INSERT INTO `onethink_config` VALUES (45,'MAIL_REPLY_NAME',1,'发件人名称',5,'','发件人名称，默认使用网站名称【WEB_SITE_TITLE 网站标题】',1422685995,1422688174,1,'嘘嘘',8);
INSERT INTO `onethink_config` VALUES (46,'WEB_SITE_NAME',0,'网站名称',1,'','网站名称',1422687631,1422687631,1,'app880.com',9);

#
# Source for table onethink_diyform
#

DROP TABLE IF EXISTS `onethink_diyform`;
CREATE TABLE `onethink_diyform` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `diyname` varchar(200) NOT NULL DEFAULT '' COMMENT '自定义表单名称',
  `posttemplate` varchar(200) NOT NULL DEFAULT '' COMMENT '发布模板',
  `viewtemplate` varchar(200) NOT NULL DEFAULT '' COMMENT '内容模板',
  `listtemplate` varchar(200) NOT NULL DEFAULT '' COMMENT '列表模板',
  `table_name` varchar(50) NOT NULL DEFAULT '' COMMENT '数据表名',
  `public` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '前台列表和内容页公开：0：不公开，1：公开审核的，2：公开所有的',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础	' COMMENT '字段分组',
  `list_grid` text NOT NULL,
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='自定义表单';

#
# Dumping data for table onethink_diyform
#

INSERT INTO `onethink_diyform` VALUES (1,'用户资料','','','','user_profile',2,'{\"1\":[\"1\"]}','1:基础\t','id:ID\r\nqq:QQ',10);

#
# Source for table onethink_diyform_fields
#

DROP TABLE IF EXISTS `onethink_diyform_fields`;
CREATE TABLE `onethink_diyform_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `form_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '自定义表单id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='自定义表单字段表';

#
# Dumping data for table onethink_diyform_fields
#

INSERT INTO `onethink_diyform_fields` VALUES (1,'qq','qq','VarChar(30)','textarea','','用户qq',1,'',1,0,1,1424188059,1424187562,'',3,'','function','',3,'function');

#
# Source for table onethink_document
#

DROP TABLE IF EXISTS `onethink_document`;
CREATE TABLE `onethink_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

#
# Dumping data for table onethink_document
#

INSERT INTO `onethink_document` VALUES (1,1,'','01',2,0,'',0,0,2,2,0,0,0,1,0,0,0,0,0,0,1424071613,1424071613,-1);

#
# Source for table onethink_document_article
#

DROP TABLE IF EXISTS `onethink_document_article`;
CREATE TABLE `onethink_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

#
# Dumping data for table onethink_document_article
#

INSERT INTO `onethink_document_article` VALUES (1,0,'<em>01</em>','',0);

#
# Source for table onethink_document_download
#

DROP TABLE IF EXISTS `onethink_document_download`;
CREATE TABLE `onethink_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

#
# Dumping data for table onethink_document_download
#


#
# Source for table onethink_file
#

DROP TABLE IF EXISTS `onethink_file`;
CREATE TABLE `onethink_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文件表';

#
# Dumping data for table onethink_file
#

INSERT INTO `onethink_file` VALUES (1,'readme.txt','54e19a9159656.txt','2015-02-16/','txt','application/octet-stream',1295,'2cf1b2ad2a5cc2cd84832390f92155f9','d160fd26e536d54a84a7310907d5484c1462af0a',0,'',1424071312);

#
# Source for table onethink_friendlinks
#

DROP TABLE IF EXISTS `onethink_friendlinks`;
CREATE TABLE `onethink_friendlinks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '类别（1：图片，2：普通）',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '站点名称',
  `cover_id` int(10) NOT NULL COMMENT '图片ID',
  `link` char(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `level` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_friendlinks
#


#
# Source for table onethink_guestbook
#

DROP TABLE IF EXISTS `onethink_guestbook`;
CREATE TABLE `onethink_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(224) NOT NULL COMMENT '留言昵称',
  `contact` varchar(225) NOT NULL COMMENT '留言者联系方式',
  `content` varchar(225) NOT NULL COMMENT '留言内容',
  `starttime` int(10) NOT NULL COMMENT '留言时间',
  `is_reply` int(11) NOT NULL COMMENT '是否回复',
  `is_pass` int(11) NOT NULL COMMENT '是否通过',
  `r_content` varchar(225) NOT NULL COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_guestbook
#


#
# Source for table onethink_hooks
#

DROP TABLE IF EXISTS `onethink_hooks`;
CREATE TABLE `onethink_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_hooks
#

INSERT INTO `onethink_hooks` VALUES (1,'pageHeader','页面header钩子，一般用于加载插件CSS文件和代码',1,1423988201,'Unslider',1);
INSERT INTO `onethink_hooks` VALUES (3,'documentEditForm','添加编辑表单的 扩展内容钩子',1,0,'Attachment',1);
INSERT INTO `onethink_hooks` VALUES (4,'documentDetailAfter','文档末尾显示',1,1423983209,'Attachment,SocialComment,BaiduShare',1);
INSERT INTO `onethink_hooks` VALUES (5,'documentDetailBefore','页面内容前显示用钩子',1,0,'',1);
INSERT INTO `onethink_hooks` VALUES (6,'documentSaveComplete','保存文档数据后的扩展钩子',2,0,'Attachment',1);
INSERT INTO `onethink_hooks` VALUES (7,'documentEditFormContent','添加编辑表单的内容显示钩子',1,0,'Editor',1);
INSERT INTO `onethink_hooks` VALUES (8,'adminArticleEdit','后台内容编辑页编辑器',1,1378982734,'EditorForAdmin',1);
INSERT INTO `onethink_hooks` VALUES (13,'AdminIndex','首页小格子个性化显示',1,1382596073,'SiteStat,SystemInfo,DevTeam,Water,Mail,ImportData',1);
INSERT INTO `onethink_hooks` VALUES (14,'topicComment','评论提交方式扩展钩子。',1,1380163518,'Editor',1);
INSERT INTO `onethink_hooks` VALUES (16,'app_begin','应用开始',2,1384481614,'',1);
INSERT INTO `onethink_hooks` VALUES (27,'pageFooter','页面footer钩子，一般用于加载插件JS文件和JS代码',1,1422719676,'Mail,ReturnTop,Unslider,Support',1);
INSERT INTO `onethink_hooks` VALUES (29,'dealPicture','处理上传图片的钩子，在系统的Upload.class.php图片上传过程中调用，对上传的图片进行额外的处理。',2,1422726029,'Water',1);
INSERT INTO `onethink_hooks` VALUES (69,'app_end','应用结束',2,1423674478,'Schedule',1);
INSERT INTO `onethink_hooks` VALUES (86,'Friendlinks','调用（显示）友情链接的钩子',1,1423825560,'Friendlinks',1);
INSERT INTO `onethink_hooks` VALUES (87,'Advs','调用广告的钩子',1,1423825694,'Advs',1);
INSERT INTO `onethink_hooks` VALUES (89,'SyncLogin','调用第三方账号同步登陆的钩子',1,1423825967,'SyncLogin',1);
INSERT INTO `onethink_hooks` VALUES (101,'WechatAdminLogin','后台登陆页面钩子，用于微信二维码登陆',1,1423925643,'Wechat',1);
INSERT INTO `onethink_hooks` VALUES (102,'WechatIndexLogin','前台登陆页面钩子，用于微信二维码登陆',1,1423925643,'Wechat',1);
INSERT INTO `onethink_hooks` VALUES (104,'Guestbook','调用（显示）留言板的钩子',1,1423925886,'Guestbook',1);
INSERT INTO `onethink_hooks` VALUES (105,'Unslider','图片轮播（焦点图）插件钩子',1,1423988274,'Unslider',1);
INSERT INTO `onethink_hooks` VALUES (106,'Vote','调用（显示）投票插件的钩子',1,1423990253,'Vote',1);

#
# Source for table onethink_mail_history
#

DROP TABLE IF EXISTS `onethink_mail_history`;
CREATE TABLE `onethink_mail_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `from` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_mail_history
#


#
# Source for table onethink_mail_history_link
#

DROP TABLE IF EXISTS `onethink_mail_history_link`;
CREATE TABLE `onethink_mail_history_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) NOT NULL,
  `to` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_mail_history_link
#


#
# Source for table onethink_mail_list
#

DROP TABLE IF EXISTS `onethink_mail_list`;
CREATE TABLE `onethink_mail_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_mail_list
#

INSERT INTO `onethink_mail_list` VALUES (1,'836692464@qq.com',1,1424018069);

#
# Source for table onethink_mail_token
#

DROP TABLE IF EXISTS `onethink_mail_token`;
CREATE TABLE `onethink_mail_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `token` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_mail_token
#


#
# Source for table onethink_member
#

DROP TABLE IF EXISTS `onethink_member`;
CREATE TABLE `onethink_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员表';

#
# Dumping data for table onethink_member
#

INSERT INTO `onethink_member` VALUES (1,'admin',0,'0000-00-00','',50,59,0,1422599239,2130706433,1424186851,1);
INSERT INTO `onethink_member` VALUES (2,'xjq',0,'0000-00-00','',20,6,0,0,2130706433,1424148677,-1);
INSERT INTO `onethink_member` VALUES (3,'geniusxjq',0,'0000-00-00','',40,24,2130706433,1422700152,2130706433,1424151332,1);

#
# Source for table onethink_menu
#

DROP TABLE IF EXISTS `onethink_menu`;
CREATE TABLE `onethink_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_menu
#

INSERT INTO `onethink_menu` VALUES (1,'首页',0,1,'Index/index',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (2,'内容',0,2,'Article/index',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (3,'文档列表',2,0,'article/index',1,'','内容',0,1);
INSERT INTO `onethink_menu` VALUES (4,'新增',3,0,'article/add',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (5,'编辑',3,0,'article/edit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (6,'改变状态',3,0,'article/setStatus',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (7,'保存',3,0,'article/update',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (8,'保存草稿',3,0,'article/autoSave',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (9,'移动',3,0,'article/move',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (10,'复制',3,0,'article/copy',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (11,'粘贴',3,0,'article/paste',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (12,'导入',3,0,'article/batchOperate',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (13,'回收站',2,0,'article/recycle',1,'','内容',0,1);
INSERT INTO `onethink_menu` VALUES (14,'还原',13,0,'article/permit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (15,'清空',13,0,'article/clear',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (16,'用户',0,3,'User/index',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (17,'用户信息',16,0,'User/index',0,'','用户管理',0,1);
INSERT INTO `onethink_menu` VALUES (18,'新增用户',17,0,'User/add',0,'添加新用户','',0,1);
INSERT INTO `onethink_menu` VALUES (19,'用户行为',16,0,'User/action',0,'','行为管理',0,1);
INSERT INTO `onethink_menu` VALUES (20,'新增用户行为',19,0,'User/addaction',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (21,'编辑用户行为',19,0,'User/editaction',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (22,'保存用户行为',19,0,'User/saveAction',0,'\"用户->用户行为\"保存编辑和新增的用户行为','',0,1);
INSERT INTO `onethink_menu` VALUES (23,'变更行为状态',19,0,'User/setStatus',0,'\"用户->用户行为\"中的启用,禁用和删除权限','',0,1);
INSERT INTO `onethink_menu` VALUES (24,'禁用会员',19,0,'User/changeStatus?method=forbidUser',0,'\"用户->用户信息\"中的禁用','',0,1);
INSERT INTO `onethink_menu` VALUES (25,'启用会员',19,0,'User/changeStatus?method=resumeUser',0,'\"用户->用户信息\"中的启用','',0,1);
INSERT INTO `onethink_menu` VALUES (26,'删除会员',19,0,'User/changeStatus?method=deleteUser',0,'\"用户->用户信息\"中的删除','',0,1);
INSERT INTO `onethink_menu` VALUES (27,'权限管理',16,0,'AuthManager/index',0,'','用户管理',0,1);
INSERT INTO `onethink_menu` VALUES (28,'删除',27,0,'AuthManager/changeStatus?method=deleteGroup',0,'删除用户组','',0,1);
INSERT INTO `onethink_menu` VALUES (29,'禁用',27,0,'AuthManager/changeStatus?method=forbidGroup',0,'禁用用户组','',0,1);
INSERT INTO `onethink_menu` VALUES (30,'恢复',27,0,'AuthManager/changeStatus?method=resumeGroup',0,'恢复已禁用的用户组','',0,1);
INSERT INTO `onethink_menu` VALUES (31,'新增',27,0,'AuthManager/createGroup',0,'创建新的用户组','',0,1);
INSERT INTO `onethink_menu` VALUES (32,'编辑',27,0,'AuthManager/editGroup',0,'编辑用户组名称和描述','',0,1);
INSERT INTO `onethink_menu` VALUES (33,'保存用户组',27,0,'AuthManager/writeGroup',0,'新增和编辑用户组的\"保存\"按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (34,'授权',27,0,'AuthManager/group',0,'\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组','',0,1);
INSERT INTO `onethink_menu` VALUES (35,'访问授权',27,0,'AuthManager/access',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (36,'成员授权',27,0,'AuthManager/user',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (37,'解除授权',27,0,'AuthManager/removeFromGroup',0,'\"成员授权\"列表页内的解除授权操作按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (38,'保存成员授权',27,0,'AuthManager/addToGroup',0,'\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)','',0,1);
INSERT INTO `onethink_menu` VALUES (39,'分类授权',27,0,'AuthManager/category',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (40,'保存分类授权',27,0,'AuthManager/addToCategory',0,'\"分类授权\"页面的\"保存\"按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (41,'模型授权',27,0,'AuthManager/modelauth',0,'\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (42,'保存模型授权',27,0,'AuthManager/addToModel',0,'\"分类授权\"页面的\"保存\"按钮','',0,1);
INSERT INTO `onethink_menu` VALUES (43,'扩展',0,7,'Addons/index',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (44,'插件管理',43,1,'Addons/index',0,'','扩展',0,1);
INSERT INTO `onethink_menu` VALUES (45,'创建',44,0,'Addons/create',0,'服务器上创建插件结构向导','',0,1);
INSERT INTO `onethink_menu` VALUES (46,'检测创建',44,0,'Addons/checkForm',0,'检测插件是否可以创建','',0,1);
INSERT INTO `onethink_menu` VALUES (47,'预览',44,0,'Addons/preview',0,'预览插件定义类文件','',0,1);
INSERT INTO `onethink_menu` VALUES (48,'快速生成插件',44,0,'Addons/build',0,'开始生成插件结构','',0,1);
INSERT INTO `onethink_menu` VALUES (49,'设置',44,0,'Addons/config',0,'设置插件配置','',0,1);
INSERT INTO `onethink_menu` VALUES (50,'禁用',44,0,'Addons/disable',0,'禁用插件','',0,1);
INSERT INTO `onethink_menu` VALUES (51,'启用',44,0,'Addons/enable',0,'启用插件','',0,1);
INSERT INTO `onethink_menu` VALUES (52,'安装',44,0,'Addons/install',0,'安装插件','',0,1);
INSERT INTO `onethink_menu` VALUES (53,'卸载',44,0,'Addons/uninstall',0,'卸载插件','',0,1);
INSERT INTO `onethink_menu` VALUES (54,'更新配置',44,0,'Addons/saveconfig',0,'更新插件配置处理','',0,1);
INSERT INTO `onethink_menu` VALUES (55,'插件后台列表',44,0,'Addons/adminList',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (56,'URL方式访问插件',44,0,'Addons/execute',0,'控制是否有权限通过url访问插件控制器方法','',0,1);
INSERT INTO `onethink_menu` VALUES (57,'钩子管理',43,2,'Addons/hooks',0,'','扩展',0,1);
INSERT INTO `onethink_menu` VALUES (58,'模型管理',68,3,'Model/index',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (59,'新增',58,0,'model/add',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (60,'编辑',58,0,'model/edit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (61,'改变状态',58,0,'model/setStatus',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (62,'保存数据',58,0,'model/update',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (63,'属性管理',68,0,'Attribute/index',1,'网站属性配置。','',0,1);
INSERT INTO `onethink_menu` VALUES (64,'新增',63,0,'Attribute/add',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (65,'编辑',63,0,'Attribute/edit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (66,'改变状态',63,0,'Attribute/setStatus',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (67,'保存数据',63,0,'Attribute/update',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (68,'系统',0,4,'Config/group',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (69,'网站设置',68,1,'Config/group',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (70,'配置管理',68,4,'Config/index',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (71,'编辑',70,0,'Config/edit',0,'新增编辑和保存配置','',0,1);
INSERT INTO `onethink_menu` VALUES (72,'删除',70,0,'Config/del',0,'删除配置','',0,1);
INSERT INTO `onethink_menu` VALUES (73,'新增',70,0,'Config/add',0,'新增配置','',0,1);
INSERT INTO `onethink_menu` VALUES (74,'保存',70,0,'Config/save',0,'保存配置','',0,1);
INSERT INTO `onethink_menu` VALUES (75,'菜单管理',68,5,'Menu/index',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (76,'导航管理',68,6,'Channel/index',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (77,'新增',76,0,'Channel/add',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (78,'编辑',76,0,'Channel/edit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (79,'删除',76,0,'Channel/del',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (80,'分类管理',68,2,'Category/index',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (81,'编辑',80,0,'Category/edit',0,'编辑和保存栏目分类','',0,1);
INSERT INTO `onethink_menu` VALUES (82,'新增',80,0,'Category/add',0,'新增栏目分类','',0,1);
INSERT INTO `onethink_menu` VALUES (83,'删除',80,0,'Category/remove',0,'删除栏目分类','',0,1);
INSERT INTO `onethink_menu` VALUES (84,'移动',80,0,'Category/operate/type/move',0,'移动栏目分类','',0,1);
INSERT INTO `onethink_menu` VALUES (85,'合并',80,0,'Category/operate/type/merge',0,'合并栏目分类','',0,1);
INSERT INTO `onethink_menu` VALUES (86,'备份数据库',68,0,'Database/index?type=export',0,'','数据备份',0,1);
INSERT INTO `onethink_menu` VALUES (87,'备份',86,0,'Database/export',0,'备份数据库','',0,1);
INSERT INTO `onethink_menu` VALUES (88,'优化表',86,0,'Database/optimize',0,'优化数据表','',0,1);
INSERT INTO `onethink_menu` VALUES (89,'修复表',86,0,'Database/repair',0,'修复数据表','',0,1);
INSERT INTO `onethink_menu` VALUES (90,'还原数据库',68,0,'Database/index?type=import',0,'','数据备份',0,1);
INSERT INTO `onethink_menu` VALUES (91,'恢复',90,0,'Database/import',0,'数据库恢复','',0,1);
INSERT INTO `onethink_menu` VALUES (92,'删除',90,0,'Database/del',0,'删除备份文件','',0,1);
INSERT INTO `onethink_menu` VALUES (93,'其他',0,5,'other',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (96,'新增',75,0,'Menu/add',0,'','系统设置',0,1);
INSERT INTO `onethink_menu` VALUES (98,'编辑',75,0,'Menu/edit',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (106,'行为日志',16,0,'Action/actionlog',0,'','行为管理',0,1);
INSERT INTO `onethink_menu` VALUES (108,'修改密码',16,0,'User/updatePassword',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (109,'修改昵称',16,0,'User/updateNickname',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (110,'查看行为日志',106,0,'action/edit',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (112,'新增数据',58,0,'think/add',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (113,'编辑数据',58,0,'think/edit',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (114,'导入',75,0,'Menu/import',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (115,'生成',58,0,'Model/generate',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (116,'新增钩子',57,0,'Addons/addHook',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (117,'编辑钩子',57,0,'Addons/edithook',0,'','',0,1);
INSERT INTO `onethink_menu` VALUES (118,'文档排序',3,0,'Article/sort',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (119,'排序',70,0,'Config/sort',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (120,'排序',75,0,'Menu/sort',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (121,'排序',76,0,'Channel/sort',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (122,'数据列表',58,0,'think/lists',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (123,'审核列表',3,0,'Article/examine',1,'','',0,1);
INSERT INTO `onethink_menu` VALUES (124,'已安装插件菜单排序',44,0,'Addons/sort',1,'已安装插件菜单排序','',0,1);
INSERT INTO `onethink_menu` VALUES (125,'前台权限管理',27,0,'AuthManager/accessUser',0,'','',0,0);
INSERT INTO `onethink_menu` VALUES (126,'新增前台权限节点',27,0,'AuthManager/addNode',0,'','',0,0);

#
# Source for table onethink_model
#

DROP TABLE IF EXISTS `onethink_model`;
CREATE TABLE `onethink_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

#
# Dumping data for table onethink_model
#

INSERT INTO `onethink_model` VALUES (1,'document','基础文档',0,'',1,'{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}','1:基础','','','','','','id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除',0,'','',1383891233,1384507827,1,'MyISAM');
INSERT INTO `onethink_model` VALUES (2,'article','文章',1,'',1,'{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}','1:基础,2:扩展','','','','','','',0,'','',1383891243,1422705220,1,'MyISAM');
INSERT INTO `onethink_model` VALUES (3,'download','下载',1,'',1,'{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}','1:基础,2:扩展','','','','','','',0,'','',1383891252,1387260449,1,'MyISAM');

#
# Source for table onethink_module
#

DROP TABLE IF EXISTS `onethink_module`;
CREATE TABLE `onethink_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '模块名',
  `alias` varchar(30) NOT NULL COMMENT '中文名',
  `version` varchar(20) NOT NULL COMMENT '版本号',
  `is_com` tinyint(4) NOT NULL COMMENT '是否商业版',
  `show_nav` tinyint(4) NOT NULL COMMENT '是否显示在导航栏中',
  `summary` varchar(200) NOT NULL COMMENT '简介',
  `developer` varchar(50) NOT NULL COMMENT '开发者',
  `website` varchar(200) NOT NULL COMMENT '网址',
  `entry` varchar(50) NOT NULL COMMENT '前台入口',
  `is_setup` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否已安装',
  `sort` int(11) NOT NULL COMMENT '模块排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `name_2` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='模块管理表';

#
# Dumping data for table onethink_module
#

INSERT INTO `onethink_module` VALUES (24,'Group','群组','1.0.0',0,1,'群组模块，允许用户建立自己的圈子','','','Group/index/index',1,0);
INSERT INTO `onethink_module` VALUES (25,'Home','主页','1.0.0',0,1,'首页模块，主要用于展示网站内容','','','Home/index/index',1,0);

#
# Source for table onethink_picture
#

DROP TABLE IF EXISTS `onethink_picture`;
CREATE TABLE `onethink_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_picture
#


#
# Source for table onethink_schedule
#

DROP TABLE IF EXISTS `onethink_schedule`;
CREATE TABLE `onethink_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_to_run` varchar(255) NOT NULL COMMENT '计划任务执行方法',
  `schedule_type` varchar(255) NOT NULL COMMENT '执行频率',
  `modifier` varchar(255) DEFAULT NULL COMMENT '执行频率,类型为MONTHLY时必须；ONCE时无效；其他时为可选，默认为1',
  `dirlist` varchar(255) DEFAULT NULL COMMENT '指定周或月的一天或多天。只与WEEKLY和MONTHLY共同使用时有效，其他时忽略。',
  `month` varchar(255) DEFAULT NULL COMMENT '指定一年中的一个月或多个月.只在schedule_type=MONTHLY时有效，其他时忽略。当modifier=LASTDAY时必须，其他时可选。有效值：Jan - Dec，默认为*(每个月)',
  `start_datetime` datetime NOT NULL COMMENT '开始时间',
  `end_datetime` datetime DEFAULT NULL COMMENT '结束时间',
  `last_run_time` datetime DEFAULT NULL COMMENT '最近执行时间',
  `info` varchar(255) DEFAULT NULL COMMENT '对计划任务的简要描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_schedule
#


#
# Source for table onethink_sensitive
#

DROP TABLE IF EXISTS `onethink_sensitive`;
CREATE TABLE `onethink_sensitive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_sensitive
#

INSERT INTO `onethink_sensitive` VALUES (1,'草你妈',1,1423663669);
INSERT INTO `onethink_sensitive` VALUES (2,'操你妹',1,1423663710);
INSERT INTO `onethink_sensitive` VALUES (3,'操你奶奶',1,1423663710);
INSERT INTO `onethink_sensitive` VALUES (4,'草你娘',1,1423663710);
INSERT INTO `onethink_sensitive` VALUES (5,'他奶奶',1,1423895656);

#
# Source for table onethink_sync_login
#

DROP TABLE IF EXISTS `onethink_sync_login`;
CREATE TABLE `onethink_sync_login` (
  `uid` int(11) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_sync_login
#


#
# Source for table onethink_ucenter_admin
#

DROP TABLE IF EXISTS `onethink_ucenter_admin`;
CREATE TABLE `onethink_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

#
# Dumping data for table onethink_ucenter_admin
#


#
# Source for table onethink_ucenter_app
#

DROP TABLE IF EXISTS `onethink_ucenter_app`;
CREATE TABLE `onethink_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

#
# Dumping data for table onethink_ucenter_app
#


#
# Source for table onethink_ucenter_member
#

DROP TABLE IF EXISTS `onethink_ucenter_member`;
CREATE TABLE `onethink_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Dumping data for table onethink_ucenter_member
#

INSERT INTO `onethink_ucenter_member` VALUES (1,'admin','ecfb4272feb1d1fd11fc719c45b5e21d','836692464@qq.com','',1422599239,2130706433,1424186851,2130706433,1422599239,1);
INSERT INTO `onethink_ucenter_member` VALUES (2,'xjq','bbe81237a2de1471f322ae25b0132dfc','app880@foxmail.com','',1422698522,2130706433,1424148677,2130706433,1422698522,1);
INSERT INTO `onethink_ucenter_member` VALUES (3,'geniusxjq','bbe81237a2de1471f322ae25b0132dfc','geniusxjq@126.com','',1422699641,2130706433,1424151332,2130706433,1422699641,1);

#
# Source for table onethink_ucenter_setting
#

DROP TABLE IF EXISTS `onethink_ucenter_setting`;
CREATE TABLE `onethink_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

#
# Dumping data for table onethink_ucenter_setting
#


#
# Source for table onethink_url
#

DROP TABLE IF EXISTS `onethink_url`;
CREATE TABLE `onethink_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

#
# Dumping data for table onethink_url
#


#
# Source for table onethink_user_profile
#

DROP TABLE IF EXISTS `onethink_user_profile`;
CREATE TABLE `onethink_user_profile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `ifcheck` tinyint(1) NOT NULL DEFAULT '0',
  `qq` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Dumping data for table onethink_user_profile
#

INSERT INTO `onethink_user_profile` VALUES (1,1424187708,1,'');

#
# Source for table onethink_userdata
#

DROP TABLE IF EXISTS `onethink_userdata`;
CREATE TABLE `onethink_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_userdata
#


#
# Source for table onethink_vote
#

DROP TABLE IF EXISTS `onethink_vote`;
CREATE TABLE `onethink_vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` char(80) NOT NULL COMMENT '标题',
  `description` text COMMENT '描述',
  `options` text NOT NULL COMMENT '添加各种投票选项',
  `explanation` varchar(256) DEFAULT NULL COMMENT '备注',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `voteconfig` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_vote
#


#
# Source for table onethink_wechat_message
#

DROP TABLE IF EXISTS `onethink_wechat_message`;
CREATE TABLE `onethink_wechat_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `msgid` int(64) unsigned NOT NULL COMMENT '信息ID',
  `type` varchar(100) NOT NULL COMMENT '信息类型',
  `content` text NOT NULL COMMENT '信息内容',
  `user` varchar(250) NOT NULL COMMENT '用户名&标识',
  `time` int(10) unsigned NOT NULL COMMENT '接收时间',
  `is_reply` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否回复',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table onethink_wechat_message
#


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
