package app.modules.fight.panel.matching
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import app.utils.appStage;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightMatchingPanel extends BasePanel
	{
		public var txtPlayerSelf:TextField;
		
		public function FightMatchingPanel()
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
			return ["ui_matching" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightMatchingPanel";
		}
		
	}
}