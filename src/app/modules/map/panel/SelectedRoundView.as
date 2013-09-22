package app.modules.map.panel
{
	import flash.display.Sprite;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundView extends BasePanel
	{
		public function SelectedRoundView()
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xff0000, 0.8);
			sprite.graphics.drawRect( 0, 0, 550, 400 );
			sprite.graphics.endFill();
			dragTarget = sprite;
			addChild( sprite );
			mouseEnabled = false;
			
			sprite = new Sprite();
			sprite.graphics.beginFill(0);
			sprite.graphics.drawRect(0,0,30,30);
			sprite.graphics.endFill();
			sprite.buttonMode = true;
			sprite.x = width - sprite.width - 5;
			sprite.y = 5;
			btnClose = sprite;
			addChild( btnClose );
		}
		
		
	}
}