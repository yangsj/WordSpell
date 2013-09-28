package app.modules.fight.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightEvent extends BaseEvent
	{
		public function FightEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		
		/**
		 * 选择字母
		 */
		public static const SELECTED_LETTER:String = "selected_letter";
		
		/**
		 * 移除字母
		 */
		public static const REMOVED_LETTER:String = "removed_letter";
		
		/**
		 * 时间结束
		 */
		public static const TIME_OVER:String = "time_over";
		
		
		/**
		 * 更新显示单词信息
		 */
		public static const UPDATE_WORD:String = "update_word";
		/**
		 * 显示答案
		 */
		public static const SHOW_ANSWER:String = "show_answer";
		
		//////////////// notify
		
		/**
		 * 关卡开始通知
		 */
		public static const NOTIFY_START_ROUND:String = "notify_start_round";
		/**
		 * 关卡结束通知
		 */
		public static const NOTIFY_END_ROUND:String = "notify_end_round";
		/**
		 * 下一个单词通知
		 */
		public static const NOTIFY_NEXT_WORD:String = "notify_next_word";
		
	}
}