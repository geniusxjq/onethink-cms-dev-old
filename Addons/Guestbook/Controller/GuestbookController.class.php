<?php

namespace Addons\Guestbook\Controller;
use Home\Controller\AddonsController;

class GuestbookController extends AddonsController{
	
	function post_message() {
		
		$data['nickname'] = I('name');
		
		$data['contact'] = I('contact');
		
		$data['content'] =I('content');
		
		$data['starttime'] = NOW_TIME;
		
		if(is_login()){
			
			$data['nickname']=get_nickname();
			
		}else{
		
			empty($data['nickname'])&&$data['nickname']='游客';
		
		}
		
		empty($data['content'])&&$this->ajaxReturn('请输入留言！');

		//数据库操作
		$messageDB = M('Guestbook');
		
		$result = $messageDB->add($data);
		
		if($result){
			
			//$this->success('留言已提交！');
			$this->ajaxReturn('成功记录');
		}else{
			//$this->error('留言失败！');
			$this->ajaxReturn('失败记录');
		}
	}
}