package app.modules.panel.personal.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalEvent extends BaseEvent
	{
		public function PersonalEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 修改个人信息
		 */
		public static const CHANGE_INFO:String = "CHANGE_INFO";
		
	}
}