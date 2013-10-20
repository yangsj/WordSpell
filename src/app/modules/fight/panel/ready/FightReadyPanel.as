package app.modules.fight.panel.ready
{
	import flash.display.Sprite;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightReadyPanel extends BasePanel
	{
		private var itemLeft:FightReadyItem;
		private var itemRight:FightReadyItem;
		
		public var player1:Sprite;
		public var player2:Sprite;
		
		public function FightReadyPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			itemLeft = new FightReadyItem( player1 );
			itemRight = new FightReadyItem( player2 );
			player2.mouseChildren = false;
			player2.mouseEnabled = false;
		}
		
		public function setAndRefresh( ):void
		{
			itemLeft.setData();
			itemRight.setData();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_ready" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightReadyPanel";
		}
	}
}