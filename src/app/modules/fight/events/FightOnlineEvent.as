package app.modules.fight.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-21
	 */
	public class FightOnlineEvent extends BaseEvent
	{
		public function FightOnlineEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 更新准备状态
		 */
		public static const UPDATE_READY:String = "update_ready";
		
		/**
		 * 退出（邀请）
		 */
		public static const QUIT_BATTLE:String = "quit_invite";
		
		/**
		 * 开始
		 */
		public static const START:String = "start";
		
	}
}