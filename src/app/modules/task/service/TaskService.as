package app.modules.task.service
{
	import app.data.GameData;
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	import ff.task_completed_ret_t;
	import ff.task_info_req_t;
	import ff.task_info_t;
	import ff.task_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskService extends BaseService
	{
		[Inject]
		public var taskModel:TaskModel;
		
		public function TaskService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 任务列表数据通知
			regist( server_cmd_e.TASK_INFO_RET, taskInfoListNotify, task_info_t );
			// 任务完成通知
			regist( server_cmd_e.TASK_COMPLETED_RET, taskCompleteNotify, task_completed_ret_t );
		}
		
		// 任务列表数据通知
		private function taskInfoListNotify( resp:SocketResp ):void
		{
			var data:task_info_t = resp.data as task_info_t;
			var list:Array = data.task_list;
			var taskVo:TaskVo;
			for each ( var task:task_t in list )
			{
				taskVo = new TaskVo();
				taskVo.id = task.task_id;
				taskVo.type = task.task_type;
				taskVo.describe = task.desc;
				taskVo.status = task.status;
				taskVo.rewardExp = task.exp_award;
				taskVo.rewardMoney = task.coin_award;
				
				taskModel.taskList.push( taskVo );
			}
		}
		
		// 任务完成通知
		private function taskCompleteNotify( resp:SocketResp ):void
		{
			var data:task_completed_ret_t = resp.data as task_completed_ret_t;
			
			// 更新金币值
			if ( data.coin_award > 0 ) GameData.instance.updateAddMoney( data.coin_award );
			
			// 更新经验值
			if ( data.exp_award > 0 ) GameData.instance.updateAddExp( data.exp_award );
		}
		
		////////////////////// publics 
		
		/**
		 * 拉取任务列表
		 */
		public function pullTaskList():void
		{
			var req:task_info_req_t = new task_info_req_t();
			call( client_cmd_e.TASK_INFO_REQ, req );
		}
		
		
	}
}