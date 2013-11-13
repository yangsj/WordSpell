package app.modules.fight.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightAloneEvent extends BaseEvent
	{
		public function FightAloneEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
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
		 * 更新显示单词信息
		 */
		public static const UPDATE_WORD:String = "update_word";
		
		/**
		 * 显示增加金币动画
		 */
		public static const ADD_MONEY_EFFECT:String = "add_money_effect";
		
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