package app.modules.fight.panel.ready
{
	import flash.display.Sprite;
	
	import app.utils.appStage;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightReadyPanel extends BasePanel
	{
		public function FightReadyPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			if ( btnClose == null )
			{
				var sprite:Sprite = new Sprite();
				sprite.graphics.beginFill(0);
				sprite.graphics.drawRect(-100,0,100,100);
				sprite.graphics.endFill();
				sprite.x = appStage.stageWidth;
				addChild( sprite );
				btnClose = sprite;
			}
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