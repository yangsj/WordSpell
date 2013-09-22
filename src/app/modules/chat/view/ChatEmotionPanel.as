package app.modules.chat.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import app.modules.chat.event.ChatEvent;
	import app.utils.appStage;
	
	import victor.framework.core.ViewSprite;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class ChatEmotionPanel extends ViewSprite
	{
		private var _parentTarget:DisplayObjectContainer;
		
		public function ChatEmotionPanel( parentTarget:DisplayObjectContainer, posX:Number, posY:Number )
		{
			x = posX;
			y = posY;
			_parentTarget = parentTarget;
			super();
			alpha = 0;
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			var length:int = _skin.numChildren;
			for (var i:int = 0; i < length; i++)
			{
				var dis:Sprite = _skin.getChildByName("emotion_" + (i < 10 ? "0" : "") + i ) as Sprite;
				if ( dis == null )
					break;
				else
					dis.mouseChildren = false;
			}
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( targetName.indexOf("emotion_") != -1 )
			{
				dispatchEvent( new ChatEvent( ChatEvent.INPUT_EMOTION, "ui.chat." + targetName ));
			}
			hide();
		}
		
		override public function show():void
		{
			_parentTarget.addChild( this );
			appStage.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
		}
		
		override public function hide():void
		{
			super.hide();
			appStage.removeEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_ChatEmotion";
		}
		
	}
}