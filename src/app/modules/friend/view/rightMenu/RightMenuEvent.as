package app.modules.friend.view.rightMenu
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class RightMenuEvent extends BaseEvent
	{
		public function RightMenuEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 选择
		 */
		public static const SELECTED:String = "selected";
		
	}
}