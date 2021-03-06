<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.thinkphp.cn>
// +----------------------------------------------------------------------

/**
 * 前台路由配置文件
 * 所有除开系统级别的前台配置
 */
return array(
			 
   'URL_ROUTER_ON'=>true,	
   
   'URL_ROUTE_RULES'=>array(
		
		//投票插件路由
		'Vote/:id' =>'home/addons/execute?_addons=Vote&_controller=ViewVote&_action=index',
		'ViewVote/:id' =>'home/addons/execute?_addons=Vote&_controller=ViewVote&_action=ViewVoteResult',
    ),
   
);
