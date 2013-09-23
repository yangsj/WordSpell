package app.modules.task.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-23
	 */
	public class TaskVo
	{
		public function TaskVo()
		{
		}
		
		/**
		 * 任务id
		 */
		public var id:int;
		/**
		 * 任务类型
		 */
		public var type:int;
		/**
		 * 任务描述
		 */
		public var describe:String;
		/**
		 * 任务状态
		 */
		public var status:int;
		/**
		 * 奖励经验值
		 */
		public var rewardExp:int;
		/**
		 * 奖励的货币
		 */
		public var rewardMoney:int;
		/**
		 * 奖励道具id
		 */
		public var rewardPropId:int;
		/**
		 * 奖励道具数量
		 */
		public var rewardPropNum:int;
		
		/**
		 * 任务目标
		 */
		public var progressTarget:int;
		/**
		 * 任务完成当前进度
		 */
		public var progressCurrent:int;
		/**
		 * 任务需要达成的总量
		 */
		public var progressTotal:int;
		
	}
}