package app.modules.fight.view.spell
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class SpellEvent extends BaseEvent
	{
		public function SpellEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 输入完成
		 */
		public static const INPUT_OVER:String = "input_over";
		
	}
}