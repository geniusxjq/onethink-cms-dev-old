<?php

namespace Addons\Schedule;
use Common\Controller\Addon;

/**

 * 计划任务插件
 * @author iszhang

*/
 
class ScheduleAddon extends Addon{

	public $info = array(
		'name'=>'Schedule',
		'title'=>'计划任务',
		'description'=>'执行计划任务插件',
		'status'=>1,
		'author' => 'geniusxjq(app880.com)',
		'url'=>'http://app880.com',
		'version'=>'0.1'
	);
	
	public $addon_install_info=array(
									 
		'install_sql'=>"DROP TABLE IF EXISTS `onethink_schedule`;
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
			) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;",

		'uninstall_sql'=>"DROP TABLE IF EXISTS `onethink_schedule`;"
  
									 
	);

	public $admin_list = array(
		'model'=>'Schedule',	//要查的表
		'fields'=>'*',			//要查的字段
		'map'=>'',				//查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
		'order'=>'id desc',		//排序,
		'listKey'=>array( 		//这里定义的是除了id序号外的表格里字段显示的表头名
			'id'=>'编号', 	
			'task_to_run'=>'执行函数',
			'schedule_type'=>'类型',
			'modifier'=>'执行频率',
			'dirlist'=>'周或月的一天或多天[dirlist]',
			'month'=>'年的一个月或多个月[month]',
			'start_datetime'=>'开始时间',
			'end_datetime'=>'失效时间',
			'last_run_time'=>'上次执行',
			'info'=>'简介',
	
		),
	);		
	
	public $custom_adminlist = 'adminlist.html';
	

	public function install(){
		return $this->installAddon($this->addon_install_info);
	}

	public function uninstall(){
		return $this->uninstallAddon($this->addon_install_info);
	}

	//实现的app_end钩子方法
	public function app_end($param){//print_r(date('Y-h-d H:i:s','1390284571'));
		$Schedule = D('Addons://Schedule/Schedule');
		//锁定自动执行 修正一下
		$lockfile = $Schedule->getLogPath() . '/schedule.lock';
		//锁定未过期 - 返回
		if( file_exists($lockfile) && ( (filemtime($lockfile))+60 > $_SERVER['REQUEST_TIME'] )){
			return ;
		} else {
			//重新生成锁文件
			touch($lockfile);
		}

		//忽略中断\忽略过期
		set_time_limit(0);
		ignore_user_abort(true);
		
		//执行计划任务
		$Schedule->runScheduleList($Schedule->getScheduleList());
		
		//解除锁定
		unlink($lockfile);
		return ;
	}
	
}