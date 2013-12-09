package app.modules.task.service
{
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemVo;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	import ff.task_accept_award_req_t;
	import ff.task_accept_award_ret_t;
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
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var packModel:PackModel;
		
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
			// 任务奖励领取成功
			regist( server_cmd_e.TASK_ACCEPT_AWARD_RET, takeRewardSuccessNotify, task_accept_award_ret_t );
		}
		
		// 任务完成奖励
		private function takeRewardSuccessNotify( resp:SocketResp ):void
		{
			var data:task_accept_award_ret_t = resp.data as task_accept_award_ret_t;
			var taskVo:TaskVo = new TaskVo();
			taskVo.id = data.task_id;
			taskVo.rewardMoney = data.coin_award;
			taskVo.rewardExp = data.exp_award;
			taskVo.propList = getRewardList( data.item_award );
			
			Tips.showCenter( "任务奖励领取成功！" );
			
			// 
			SoundManager.playEffectMusic( SoundType.REWARD_DIAMOND );
			
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.TaskCompleted ));
			
			// 重新更新列表
			pullTaskList();
		}
		
		// 任务列表数据通知
		private function taskInfoListNotify( resp:SocketResp ):void
		{
			var data:task_info_t = resp.data as task_info_t;
			var list:Array = data.task_list;
			var taskVo:TaskVo;
			taskModel.taskList.length = 0;
			for each ( var task:task_t in list )
			{
				taskVo = new TaskVo();
				taskVo.id = task.task_id;
				taskVo.type = task.task_type;
				taskVo.describe = task.desc;
				taskVo.status = task.status;
				taskVo.rewardExp = task.exp_award;
				taskVo.rewardMoney = task.coin_award;
				taskVo.propList = getRewardList( task.item_award );
				
				if ( !taskVo.isHide ) {
					if ( taskVo.isEd ) {
						taskModel.taskList.unshift( taskVo );
					} else {
						taskModel.taskList.push( taskVo );
					}
				}
			}
			dispatch( new TaskEvent( TaskEvent.UPDATE_LIST ));
		}
		
		// 任务完成通知
		private function taskCompleteNotify( resp:SocketResp ):void
		{
			var data:task_completed_ret_t = resp.data as task_completed_ret_t;
			
			// 更新金币值
//			if ( data.coin_award > 0 ) GameData.instance.updateAddMoney( data.coin_award );
//			
//			// 更新经验值
//			if ( data.exp_award > 0 ) GameData.instance.updateAddExp( data.exp_award );
			
//			var taskVo:TaskVo = new TaskVo();
//			taskVo.id = data.task_id;
//			taskVo.status = data.status;
//			taskVo.rewardMoney = data.coin_award;
//			taskVo.rewardExp = data.exp_award;
//			taskVo.propList = getRewardList( data.item_award );
//			
//			taskModel.cacheCompleteTask.push( taskVo );
//			
//			if ( !fightModel.isFighting )
//				dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
			
			Tips.showCenter( "你已经完成了一个新任务，可以领取任务奖励" );
		}
		
		private function getRewardList( dict:Dictionary ):Vector.<ItemVo>
		{
			var vec:Vector.<ItemVo> = new Vector.<ItemVo>();
			var itemVo:ItemVo;
			for ( var key:String in dict )
			{
				itemVo = new ItemVo();
				itemVo.type = int( key );
				itemVo.num = int(dict[ key ]);
				vec.push( itemVo );
				
				// 更新到背包中
//				packModel.addNumByType( itemVo.type, 1 );
			}
			return vec;
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
		
		public function takeReward( id:int ):void
		{
			var req:task_accept_award_req_t = new task_accept_award_req_t();
			req.task_id = id;
			call( client_cmd_e.TASK_ACCEPT_AWARD_REQ, req );
		}
		
	}
}