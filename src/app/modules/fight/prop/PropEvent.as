package app.modules.fight.prop
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class PropEvent extends BaseEvent
	{
		public function PropEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 道具使用
		 */
		public static const USE_PROP:String = "use_prop";
		
	}
}