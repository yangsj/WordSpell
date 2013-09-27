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
		 * 更新显示单词信息
		 */
		public static const UPDATE_WORD:String = "update_word";
		/**
		 * 显示答案
		 */
		public static const SHOW_ANSWER:String = "show_answer";
		
	}
}