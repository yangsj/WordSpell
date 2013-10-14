package app.modules.friend.view
{
	import flash.display.Sprite;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class FriendView extends BasePanel
	{
		public function FriendView()
		{
			super();
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0);
			sprite.graphics.drawRect(0,0,30,30);
			sprite.graphics.endFill();
			sprite.buttonMode = true;
			sprite.x = width - sprite.width - 5;
			sprite.y = 5;
			btnClose = sprite;
			addChild( btnClose );
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			addChild( btnClose );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_friend"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FriendMainView";
		}
		
	}
}