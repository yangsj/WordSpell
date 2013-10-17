package app.modules.fight.panel.friend
{
	import flash.events.Event;
	
	import app.modules.fight.panel.search.FightSearchBasePanel;
	
	import victor.framework.components.scroll.GameScrollPanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightFriendPanel extends FightSearchBasePanel
	{
		
		public function FightFriendPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightFriendPanel";
		}
		
	}
}