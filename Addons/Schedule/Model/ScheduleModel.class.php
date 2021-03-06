<?php

namespace Addons\Schedule\Model;
use Think\Model;

/**
 * Schedule模型
 */
 
class ScheduleModel extends Model{
	private $MONTH_ARRAY 	= array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
	private $WEEK_ARRAY  	= array('Mon','Tue','Wed','Thu','Fri','Sat','Sun');
	
	private $model;
	private $schedule		= array();
	private $scheduleList 	= array();
	
	//判断一个schedule是否有效
	public function isValidSchedule($schedule = '') {
		if( empty($schedule) ) {
			$schedule = $this->schedule;
		}
		//task_to_run / schedule_type / start_datetime 必须
		if( empty($schedule['task_to_run']) || empty($schedule['schedule_type']) || empty($schedule['start_datetime']) ) {
			return false;
		}
		switch( strtoupper($schedule['schedule_type']) ) {
			case 'ONCE':
				return $this->_checkONCE($schedule);
			case 'MINUTE':
				return $this->_checkMINUTE($schedule);
			case 'HOURLY':
				return $this->_checkHOURLY($schedule);
			case 'DAILY':
				return $this->_checkDAILY($schedule);
			case 'WEEKLY':
				return $this->_checkWEEKLY($schedule);
			case 'MONTHLY':
				return $this->_checkMONTHLY($schedule);
			default:
				return false;
		}
	}
	
	//执行计划任务列表
	public function runScheduleList($scheduleList) {
		//dump($scheduleList);
		foreach( $scheduleList as $key => $schedule ) {
			$date = $this->calculateNextRunTime($schedule);
			if( $date != false && strtotime($date) <= strtotime(date('Y-m-d H:i:s')) ) {
				$this->runSchedule($schedule);
			}else {
				continue;
			}
		}
		return true;
	}	
	
	//执行任务计划
	public function runSchedule($schedule) {
		// 获取后台配置的计划任务
		$checkScheduleList = $this->getScheduleList();
		$checkScheduleList = $this->getSubByKey($checkScheduleList, 'task_to_run');
		if (!in_array($schedule['task_to_run'], $checkScheduleList)) {
			$str_log = "schedule_id = {$schedule['id']} 的任务不合法。";
			$this->_log($str_log);
			return false;
		}
		//解析task类型, 并运行task
		$task_to_run = explode('/',$schedule['task_to_run']);

		if($task_to_run[0] == 'addons'){
			//组装执行代码 - 执行addons下的model
			$function = 'D("Addons://Schedule/'.$task_to_run[1].'")';
			$str = "$function->{$task_to_run[2]}(" . $this->fill_params($task_to_run['params']) . ');';
			eval($str);
		}else
		if($task_to_run['type'] == 'model'){
			//组装执行代码
			$str = "D({$task_to_run[1]}, {$task_to_run[0]})->{$task_to_run[2]}(" . $this->fill_params($task_to_run['params']) . ');';
			eval($str);
		}else if($task_to_run['type'] == 'url') {
			//;
		}
		
		if(strtoupper($schedule['schedule_type']) == 'ONCE') {
			
			//ONCE类型的计划任务，将end_datetime设置为当前时间
			
			$schedule['end_datetime'] = date('Y-m-d H:i:s');
						
		}else {
			
			//非ONCE类型的计划任务， 防止由程序执行导致的启动时间的漂移
			
			if(in_array($schedule['schedule_type'], array('MINUTE', 'HOURLY'))) {
				
				//将last_run_time设置为当前时间（秒数设为0）
				
				$schedule['last_run_time'] = date('Y-m-d H:i:s',$this->setSecondToZero());
				
			}else {
				
				//将last_run_time设置为当前日期+预定时间
				
				$now_date = date('Y-m-d');
				$fixed_time = date('H:i:s', strtotime($schedule['start_datetime']));
				$schedule['last_run_time'] = $now_date . ' ' . $fixed_time;
				
			}
		}
		$this->saveSchedule($schedule);
		$str_log = "schedule_id = {$schedule['id']} 的任务已运行。";
		if(C('APP_DEBUG')){
			$str_log  .= "任务url为: {$schedule['task_to_run']} ，任务描述为: {$schedule['info']} 。";
		}
		$this->_log($str_log);
	}
	
	//组装参数
    private function fill_params($params = '') {
   		$result = '';
    	if(is_array($params)) {
    		$flag = true;
	    	foreach ($params as $k => $v) {
	    		if($flag == true) {
	    			$result = $result . $this->format_params($v);
	    			$flag = false;
	    		}else {
	    			$result = $result . ',' . $this->format_params($v);
	    		}
	    	}
    	}else {
    		$result = $params;
    	}
    	return $result;
    }

    //格式化参数
    private function format_params($params) {
    	if(is_array($params)) {
	    	$result = 'Array(';
	    	foreach ($params as $k => $v) {
	    		$result = $result . "'$k'=>'$v',";
	    	}
	    	$result .= ')';
	    	return $result;
    	}else {
    		return '\'' . $params . '\'';
    	}
    }
    
	/**
	 * 取一个二维数组中的每个数组的固定的键知道的值来形成一个新的一维数组
	 * @param $pArray 一个二维数组
	 * @param $pKey 数组的键的名称
	 * @return 返回新的一维数组
	 */
	public function getSubByKey($pArray, $pKey="", $pCondition=""){
	    $result = array();
	    if(is_array($pArray)){
	        foreach($pArray as $temp_array){
	            if(is_object($temp_array)){
	                $temp_array = (array) $temp_array;
	            }
	            if((""!=$pCondition && $temp_array[$pCondition[0]]==$pCondition[1]) || ""==$pCondition) {
	                $result[] = (""==$pKey) ? $temp_array : isset($temp_array[$pKey]) ? $temp_array[$pKey] : "";
	            }
	        }
	        return $result;
	    }else{
	        return false;
	    }
	}    

	//删除计划任务
	public function del($id) {
		return $this->delete($id);
	}
	


	//保存一条任务计划到数据库
	//@return bool
	public function addSchedule($schedule = '') {
		if(empty($schedule)) {
			$schedule = $this->schedule;
		}
		//保存到数据库
		if( $this->isValidSchedule($schedule) ) {
			$schedule['start_datetime'] = date('Y-m-d H:i:s', $this->setSecondToZero($schedule['start_datetime']));
			$res = $this->add($schedule);
			$this->cleanCache();
			return $res;
		}else {
			return false;
		}
	}
	
	//更新一条任务计划
	public function saveSchedule($schedule = '') {
		if(empty($schedule)) {
			$schedule = $this->schedule;
		}
		//更新到数据库
		if( $this->isValidSchedule($schedule) ) {
			
			if(strtoupper($schedule['schedule_type']) == 'ONCE') {
				
				//ONCE类型的计划任务，将end_datetime和last_run_time设为相同
				
				$data['end_datetime'] = $schedule['end_datetime'];
				
				$data['last_run_time'] = $schedule['end_datetime'];
			
			}else{
				
				$data['last_run_time'] = $schedule['last_run_time'];
				
			}
			
			$map['id'] = $schedule['id'];
			$res = $this->where($map)->save($data);
			$this->cleanCache();
			return $res;
		}else {
			return false;
		}
	}

	//查询数据库，获取所有的计划任务（包括过期的）
	//@return array()
	public function getScheduleList() {
		$this->scheduleList = S ( 'getScheduleList' );
		if ($this->scheduleList === false) {
			$this->scheduleList = $this->order ( 'id' )->select ();
			S ( 'getScheduleList', $this->scheduleList ); // 缓存一周
		}
		return $this->scheduleList;
	}

	//计算一个sechedule的下次执行时间
	//@return: 'Y-m-d H:i:s'
	public function calculateNextRunTime($schedule) {
		//已过期
		if( (strtotime($schedule['end_datetime'])>0) && (strtotime($schedule['end_datetime']) < strtotime(date('Y-m-d H:i:s'))) ) {
			return false;
		}
		//还未启动
		if( strtotime($schedule['start_datetime']) > strtotime(date('Y-m-d H:i:s')) ) {
			return false;
		}
		//已执行
		if( strtotime($schedule['last_run_time']) > strtotime(date('Y-m-d H:i:s')) ) {
			return false;
		}
		
		switch( strtoupper($schedule['schedule_type']) ) {
			case 'ONCE':
				$datetime =  $this->_calculateONCE($schedule);
				break;
			case 'MINUTE':
				$datetime =  $this->_calculateMINUTE($schedule);
				break;
			case 'HOURLY':
				$datetime =  $this->_calculateHOURLY($schedule);
				break;
			case 'DAILY':
				$datetime =  $this->_calculateDAILY($schedule);
				break;
			case 'WEEKLY':
				$datetime =  $this->_calculateWEEKLY($schedule);
				break;
			case 'MONTHLY':
				$datetime =  $this->_calculateMONTHLY($schedule);
				break;
			default:
				return false;
		}
		return date('Y-m-d H:i:s', $datetime);
	}	

	/*
	* Setter & Getter
	*/
	public function getLogPath() {
		$logPath = DATA_PATH.'/schedule';
		if(!is_dir($logPath))
			@mkdir($logPath,0777);
		return $logPath;
	}
	
	public function getSchedule() {
		return $this->schedule;
	}

	public function setSchedule($schedule) {
		if( $this->isValidSchedule($schedule) ) {
			$this->schedule = $schedule;
			return  true;
		}else {
			return false;
		}
	}

	public function setTaskToRun($task_to_run) {
		$this->schedule['task_to_run'] = $task_to_run;
	}

	public function setScheduleType($schedule_type) {
		$this->schedule['schedule_type'] = $schedule_type;
	}

	public function setModifier($modifier) {
		$this->schedule['modifier'] = $modifier;
	}

	public function setDirlist($dirlist) {
		$this->schedule['dirlist'] = $dirlist;
	}

	public function setMonth($month) {
		$this->schedule['month'] = $month;
	}

	public function setStartDateTime($start_datetime) {
		$this->schedule['start_datetime'] = $start_datetime;
	}

	public function setEndDateTime($end_datetime) {
		$this->schedule['end_datetime'] = $end_datetime;
	}

	public function setLastRunTime($last_run_time) {
		$this->schedule['last_run_time'] = $last_run_time;
	}

	//根据计划频率检查一个schedule是否合法

	protected function _checkONCE($schedule) {
		if( !empty($schedule['start_datetime']) ) {
			return (bool)strtotime($schedule['start_datetime']);
		}else {
			return false;
		}
	}
	
	protected function _checkMINUTE($schedule) {
		if( !empty($schedule['modifier']) && is_numeric($schedule['modifier']) ) {
			return ( ($schedule['modifier'] >= 1) && ($schedule['modifier'] <= 1439) );
		}

		return true;
	}
	
	protected function _checkHOURLY($schedule) {
		if( !empty($schedule['modifier']) ) {
			return ( is_numeric($schedule['modifier']) && ($schedule['modifier'] >= 1) && ($schedule['modifier'] <= 23) );
		}

		return true;
	}
	
	protected function _checkDAILY($schedule) {
		if( !empty($schedule['modifier']) ) {
			return ( is_numeric($schedule['modifier']) && ($schedule['modifier'] >= 1) && ($schedule['modifier'] <= 365) );
		}

		return true;
	}
	
	protected function _checkWEEKLY($schedule) {
		$flag = true;
		if( !empty($schedule['modifier']) ) {
			if( !is_numeric($schedule['modifier']) ) {
				return false;
			}
			$flag = ($schedule['modifier'] >= 1) && ($schedule['modifier'] <= 52);
		}
		if( ($flag != false) && !empty($schedule['dirlist']) ) {
			if($schedule['dirlist'] == '*') {
				return true;
			}else {
				$dirlist = explode(',', str_replace(' ', '',$schedule['dirlist']));
				foreach($dirlist as $v) {
					$flag = $flag && in_array($v, $this->WEEK_ARRAY);
					if($flag == false) {
//						dump($v);
						return false;
					}//End if
				}//End foreach
			}//End else
		}
		return $flag;
	}
	
	protected function _checkMONTHLY($schedule) {
		// modifier为LASTDAY时month必须，否则可选
		// modifier为（FIRST,SECOND,THIRD,FOURTH,LAST）之一时：dirlist必须在MON～SUN、*中
		// modifier为1～12时dirlist可选. 1～31和空为有效值（默认是1）
		if( !empty($schedule['modifier'])) {
			//modifier为LASTDAY时month必须，否则可选
			if( strtoupper($schedule['modifier']) == 'LASTDAY' ) {
				if(empty($schedule['month'])) {
					return false;
				}
			}else if( in_array(strtoupper($schedule['modifier']),array('FIRST','SECOND','THIRD','FOURTH','LAST')) ) {				
				//modifier为FIRST,SECOND,THIRD,FOURTH,LAST之一时，dirlist必须在MON～SUN、*中
				if($schedule['dirlist'] !='*'){
					$flag = true;
					$dirlist = explode(',', str_replace(' ', '',$schedule['dirlist']));
					foreach($dirlist as $v) {
						$flag = $flag && in_array($v, $this->WEEK_ARRAY);
						if($flag == false) {
//							dump($v);
							return false;
						}//End if
					}//End foreach
				}//End if...else
			}elseif ( is_numeric($schedule['modifier']) && ($schedule['modifier'] >= 1) && ($schedule['modifier'] <= 12) ) {
				//modifier为1～12时dirlist可选. 空、1～31为有效值（‘空’默认是1）
				if( !empty($schedule['dirlist']) ) {
					$flag = true;
					$dirlist = explode(',', str_replace(' ', '',$schedule['dirlist']));
					foreach($dirlist as $v) {
						$flag = $flag && (is_numeric($v) && ($v >= 1) && ($v <= 31));
						if($flag == false) {
//							dump($v);
							return false;
						}
					}//End foreach
				}
				return true;
			}else {
				//modifier错误
				return false;
			}
			
			//month的有效值为JAN～DEC和*(每个月).默认为*
			if( !empty($schedule['month']) ) {
				if($schedule['month'] == '*') {
					return true;
				}else {
					$flag = true;
					$month = explode(',', str_replace(' ', '', $schedule['month']));
					foreach($month as $v) {
						$flag = $flag && in_array($v, $this->MONTH_ARRAY);
						if($flag == false) {
							return false;
						}
					}//End foreach
				}//End if...else
			}
			
		}else {
			//modifier必须
			return false;
		}
		return true;
	}

	/*
	 * 根据计划频率计算一个schedule的下次执行时间
	 */
	protected function _calculateONCE($schedule) {
		return $this->_getStartDateTime($schedule);
	}

	protected function _calculateMINUTE($schedule) {
		//获取计划频率
		$modifier = empty($schedule['modifier']) ? 1 : $schedule['modifier'];

		//当last_run_time不为空且大于start_datetime时，以last_run_time为基准时间。否则，以start_datetime为基准时间.
		if( !empty($schedule['last_run_time']) && (strtotime($schedule['last_run_time']) > strtotime($schedule['start_datetime']))) {
			$date = is_string($schedule['last_run_time']) ? strtotime($schedule['last_run_time']) : $schedule['last_run_time'];
		}else {
			$date = $this->_getStartDateTime($schedule);
		}
		
		return mktime(date('H',$date),date('i',$date) + $modifier,date('s',$date),date('m',$date),date('d',$date),date('Y',$date));
	}

	protected function _calculateHOURLY($schedule) {
		//获取计划频率
		$modifier = empty($schedule['modifier']) ? 1 : $schedule['modifier'];

		//当last_run_time不为空时，根据last_run_time计算下次运行时间。否则，根据start_datetime计算.
		if( !empty($schedule['last_run_time']) && (strtotime($schedule['last_run_time']) > strtotime($schedule['start_datetime']))) {
			$date = is_string($schedule['last_run_time']) ? strtotime($schedule['last_run_time']) : $schedule['last_run_time'];
		}else {
			$date = $this->_getStartDateTime($schedule);
		}
		
		return mktime(date('H',$date) + $modifier,date('i',$date),date('s',$date),date('m',$date),date('d',$date),date('Y',$date));
	}

	protected function _calculateDAILY($schedule) {
		//获取计划频率
		$modifier = empty($schedule['modifier']) ? 1 : $schedule['modifier'];

		//当last_run_time不为空时，根据last_run_time计算下次运行时间。否则，根据start_datetime计算.
		if( !empty($schedule['last_run_time']) && (strtotime($schedule['last_run_time']) > strtotime($schedule['start_datetime']))) {
			$date = is_string($schedule['last_run_time']) ? strtotime($schedule['last_run_time']) : $schedule['last_run_time'];
		}else {
			$date = $this->_getStartDateTime($schedule);
		}
		
		return mktime(date('H',$date),date('i',$date),date('s',$date),date('m',$date),date('d',$date) + $modifier,date('Y',$date));
	}

	protected function _calculateWEEKLY($schedule) {
		//获取计划频率
		$modifier = empty($schedule['modifier']) ? 1 : $schedule['modifier'];

		//当last_run_time不为空时，以last_run_time为基准时间。否则，根据start_datetime计算基准时间.
		if( !empty($schedule['last_run_time']) && (strtotime($schedule['last_run_time']) > strtotime($schedule['start_datetime'])) ) {
			$date = is_string($schedule['last_run_time']) ? strtotime($schedule['last_run_time']) : $schedule['last_run_time'];
			$base_time_type = 'last_run_time';
		}else {
			$date = $this->_getStartDateTime($schedule);
			$base_time_type = 'start_datetime';
		}
				
		//判断当前日期是否符合周数要求
		//计算方法：((当前日期的周数 - 基准日期的周数) % modifier == 0)
		if( (($this->_getWeekID() - $this->_getWeekID($date)) % $schedule['modifier']) == 0 ) {
			//组装dirlist数组
			if(empty($schedule['dirlist'])) {
				//当dirlist为空时,默认为周一
				$schedule['dirlist'] = array('Mon');
			}elseif ($schedule['dirlist'] == '*') {
				//当dirlist==*时，每天执行
				$schedule['dirlist'] = $this->WEEK_ARRAY;
			}else {
				$schedule['dirlist'] = explode(',', str_replace(' ','',$schedule['dirlist']));
			}
			//判断今天是否在dirlist中。
			if( in_array(date('D'), $schedule['dirlist']) ) {
				//判断今天是否已经执行过当前计划。如果否，根据基准时间计算执行时间（DATE为今天，TIME来自基准时间）
				if( ($base_time_type == 'last_run_time') && ( date('Y-m-d',$date) == date('Y-m-d')) ) {
					;
				}else {
					return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d'),date('Y'));
				}
			}
		}
		//如果当前日期不符合周数或星期的要求、或今天已经执行过，返回明天的同一时间（保证该条计划任务现在不被执行）
		return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d') + 1,date('Y'));
	}

	protected function _calculateMONTHLY($schedule) {
		//当last_run_time不为空时，以last_run_time为基准时间。否则，根据start_datetime计算基准时间.
		if( !empty($schedule['last_run_time']) && (strtotime($schedule['last_run_time']) > strtotime($schedule['start_datetime'])) ) {
			$date = is_string($schedule['last_run_time']) ? strtotime($schedule['last_run_time']) : $schedule['last_run_time'];
			$base_time_type = 'last_run_time';
		}else {
			$date = $this->_getStartDateTime($schedule);
			$base_time_type = 'start_datetime';
		}
		
		//设置month数组
		if( empty($schedule['month']) || $schedule['month'] == '*') {
			$schedule['month'] = $this->MONTH_ARRAY;
		}else {
			$schedule['month'] = explode(',', str_replace(' ','',$schedule['month']));
		}
		
		//modifier为LASTDAY时
		if( strtoupper($schedule['modifier']) == 'LASTDAY' ) {
						
			//判断月份是否符合要求、且当前日期为月的最后一天
			if( in_array(date('M'), $schedule['month']) && $this->_isLastDayOfMonth() ) {
				//判断今天是否已经执行过当前计划。如果否，根据基准时间计算执行时间（DATE为今天，TIME来自基准时间）
				if( ($base_time_type == 'last_run_time') && ( date('Y-m-d',$date) == date('Y-m-d')) ) {
					;
				}else {
					return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d'),date('Y'));
				}
			}
		//modifier为FIRST,SECOND,THIRD,FOURTH,LAST之一时
		}elseif ( in_array(strtoupper($schedule['modifier']),array('FIRST','SECOND','THIRD','FOURTH','LAST')) ) {
			//判断当前月份是否符合要求
			if( in_array(date('M'), $schedule['month']) ) {
				//设置dirlist数组(星期)
				if ($schedule['dirlist'] == '*') {
					$schedule['dirlist'] = $this->WEEK_ARRAY;
				}else {
					$schedule['dirlist'] = explode(',', str_replace(' ','',$schedule['dirlist']));
				}
				
				//判断星期是否符合要求
				if( in_array(date('D'), $schedule['dirlist']) ) {
					//判断第x个是否符合要求
					if($this->_isDayIDOfMonth($schedule['modifier'])) {
						//判断今天是否已经执行过当前计划。如果否，根据基准时间计算执行时间（DATE为今天，TIME来自基准时间）
						if( ($base_time_type == 'last_run_time') && ( date('Y-m-d',$date) == date('Y-m-d')) ) {
							;
						}else {
							return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d'),date('Y'));
						}
					}
				}
			}
		//modifier为1～12时
		}elseif ( is_numeric($schedule['modifier']) ) {
			//判断当前月份是否符合要求
			if( ($this->_getMonthDif($date) % $schedule['modifier']) == 0 ) {
				//组装dirlist数组
				if(empty($schedule['dirlist'])) {
					$schedule['dirlist'] = array('1');
				} else{
					$schedule['dirlist'] = explode(',', str_replace(' ','',$schedule['dirlist']));
				}

				//判断当期日期是否符合要求
				if( in_array(date('d'),$schedule['dirlist']) || in_array(date('j'),$schedule['dirlist']) ) {
					//判断今天是否已经执行过当前计划。如果否，根据基准时间计算执行时间（DATE为今天，TIME来自基准时间）
					if( ($base_time_type == 'last_run_time') && ( date('Y-m-d',$date) == date('Y-m-d')) ) {
						;
					}else {
						return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d'),date('Y'));
					}
				}
			}
		}
		
		//如果当前日期不符合月份/星期/日期的要求、或今天已经执行过，返回明天的同一时间（保证该条计划任务现在不被执行）
		return mktime(date('H',$date),date('i',$date),date('s',$date),date('m'),date('d') + 1,date('Y'));
	}

	//获取开始时间
	//@return timestamp
	protected function _getStartDateTime($schedule) {
		if( !empty($schedule['start_datetime']) ) {
			return strtotime($schedule['start_datetime']);
		}else {
			return false;
		}
	}
	
	//判断当前日期是否为当前月的最后一天
	protected function _isLastDayOfMonth($date = '') {
		if (empty($date)) {
			$date = strtotime(date('Y-m-d H:i:s'));
		}
		$date = is_string($date) ? strtotime($date) : $date;
		return ( date('m',$date) != date('m',mktime(date('H',$date),date('i',$date),date('s',$date),date('m',$date),date('d',$date) + 1,date('Y',$date))) );
	}
	
	//判断当前日期是否为当前月的第x个星期x
	protected function _isDayIDOfMonth($key, $date = '') {
		if (empty($date)) {
			$date = strtotime(date('Y-m-d H:i:s'));
		}
		$date = is_string($date) ? strtotime($date) : $date;
		
		$index = 0;
		switch( strtoupper($key) ) {
			case 'FIRST':
				$index = 1;
				break;
			case 'SECOND':
				$index = 2;
				break;
			case 'THIRD':
				$index = 3;
				break;
			case 'FOURTH':
				$index = 4;
				break;
			case 'LAST':
				$index = 0;
				break;
			default:
				return false;
		}
		if($index != 0) {
			return ((date('m',$date) == date('m',mktime(date('H',$date),date('i',$date),date('s',$date),date('m',$date),date('d',$date) - (7 * ($index-1)),date('Y',$date)))) && 
			(date('m',$date) != date('m',mktime(date('H',$date),date('i',$date),date('s',$date),date('m',$date),date('d',$date) - (7 * ($index)),date('Y',$date)))));
		}else {
			return (date('m',$date) != date('m',mktime(date('H',$date),date('i',$date),date('s',$date),date('m',$date),date('d',$date) + 7,date('Y',$date))));
		}
	}

	//返回自2007年01月01日来的周数
	protected function _getWeekID($date = '') {
		$date_base = strtotime('2007-01-01');//2007-01-01为周一，定为第一周
		//输入日期为空时，使用当前时间
		if(empty($date)) {
			$date = strtotime(date('Y-m-d'));
		}else {
			$date = is_string($date) ? strtotime($date) : $date;
		}
		return (int)floor(($date - $date_base)/3600/24/7) + 1;
	}
	
	//返回自2007年01月01日来的月数
	protected function _getMonthDif($date1, $date2 = '') {
		$date1 = is_string($date1) ? strtotime($date1) : $date1;
		$date2 = empty($date2) ? date('Y-m-d') : $date2;
		$date2 = is_string($date2) ? strtotime($date2) : $date2;
		
		return ((date('Y',$date2) - date('Y',$date1)) * 12 + (date('n',$date2) - date('n',$date1)) );
	}
	
	//日志文件
	protected function _log($str) {
		$filename = $this->getLogPath() . '/schedule_' . date('Y-m-d') . '.log';
		
		$str = '[' . date('Y-m-d H:i:s') . '] ' . $str;
		$str .= "\r\n";
		
		$handle = fopen($filename, 'a');
		fwrite($handle, $str);
		fclose($handle);
	}
	
	//将给定时间的秒数置为0; 参数为空时，使用当前时间
	protected function setSecondToZero($date_time = NULL) {
		if(empty($date_time)) {
			$date_time = date('Y-m-d H:i:s');
		}
		$date_time = is_string($date_time) ? strtotime($date_time) : $date_time;
		return mktime(date('H', $date_time), 
					  date('i', $date_time),
					  0,
					  date('m', $date_time),
					  date('d', $date_time),
					  date('Y', $date_time));
	}

	/**
	 * 清除缓存
	 * @return void
	 */
	public function cleanCache() {
		S ( 'getScheduleList', null );
	}	

}
