package app.modules.task.model
{
	import app.modules.model.vo.ItemVo;
	
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
		 * 任务状态(0默认状态|1正在进行中|2已完成|3已领取奖励)
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
		 * 奖励道具列表
		 */
		public var propList:Vector.<ItemVo>;
		
		/**
		 * 是否已经领取
		 */
		public function get isHide():Boolean
		{
			return status == 3;
		}
		
		/**
		 * 任务是否完成
		 */
		public function get isEd():Boolean
		{
			return status == 2;
		}
		
		/**
		 * 是否正在进行
		 */
		public function get isIng():Boolean
		{
			return status == 1;
		}
		
		/**
		 * 完整的任务描述（包含进度）
		 */
		public function get fullDescribe():String
		{
			return describe + ( isEd ? "（已完成）" : ( isHide ? "（已领取）" : "" ) );
		}
		
	}
}