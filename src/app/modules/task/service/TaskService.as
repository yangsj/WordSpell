package app.modules.task.service
{
	import flash.utils.Dictionary;
	
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	
	import ff.server_cmd_e;
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
			regist( server_cmd_e.TASK_INFO_RET, taskInfoListNotify, task_info_t );
		}
		
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
		
	}
}