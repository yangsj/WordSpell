package app.modules.chat.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import app.core.SpriteClip;
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
		
		private const points:Array = [new Point(36.5,7.8),new Point(61.8,8.8),new Point(87.5,8.8),new Point(111.1,6.8),new Point(136.15,6.3),new Point(163,5.8),new Point(10.35,34.55),new Point(36.5,34.55),new Point(61.8,30.55),new Point(87.5,34.55),new Point(111.1,32.15),new Point(138.15,32.55),new Point(163,31.85),new Point(8.85,59),new Point(36.5,60.2),new Point(61.05,59.9),new Point(87.5,58),new Point(111.1,59),new Point(137.9,59.5),new Point(163,58.9),new Point(10.05,86.95),new Point(36.5,88.35),new Point(61.05,86.95),new Point(87.5,88.15),new Point(110.85,86.75),new Point(136.4,86.95),new Point(164,89.25),new Point(10.35,7.8)];
		
		public function ChatEmotionPanel( parentTarget:DisplayObjectContainer, posX:Number, posY:Number )
		{
			x = posX;
			y = posY;
			_parentTarget = parentTarget;
			super();
//			alpha = 0;
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			var clip:SpriteClip;
			var point:Point;
			var key:String;
			var length:int = points.length;
			for (var i:int = 1; i <= length; i++ )
			{
				point = points[ i - 1 ];
				key = "emotion_" + (i < 10 ? "0" : "") + i;
				clip = new SpriteClip( "ui.chat." + key );
				clip.x = point.x;
				clip.y = point.y;
				clip.name = key;
				clip.mouseChildren = false;
				_skin.addChild( clip );
			}
			
//			var length:int = _skin.numChildren;
//			for (var i:int = 0; i < length; i++)
//			{
//				var dis:Sprite = _skin.getChildByName("emotion_" + (i < 10 ? "0" : "") + i ) as Sprite;
//				if ( dis == null )
//					break;
//				else
//					dis.mouseChildren = false;
//			}
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