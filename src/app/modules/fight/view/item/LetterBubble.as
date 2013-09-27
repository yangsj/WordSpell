package app.modules.fight.view.item
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.fight.events.FightEvent;
	
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MathUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class LetterBubble extends TempleteSprite
	{
		private static const moveArea:Rectangle = new Rectangle(41, 41, 808, 298 );
		
		public var txtLetter:TextField;
		
		public function LetterBubble()
		{
			super();
			mouseChildren = false;
			buttonMode = true;
			setSkinWithName( "ui_Skin_Round_Bubble_" + int( Math.random() * 5 ) );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.MOUSE_OVER )
			{
				parent.setChildIndex( this, parent.numChildren - 1 );
			}
			else if ( type == MouseEvent.CLICK )
			{
				selected( true );
			}
		}
		
		private var dx:Number = 1;
		private var dy:Number = 1;
		protected function enterFrameHandler(event:Event):void
		{
			if ( x <= moveArea.x || x >= moveArea.x + moveArea.width ||  y <= moveArea.y || y >= moveArea.y + moveArea.height )
			{
				dx *= Math.random() < 0.5 ? -1 : 1;
				dy *= Math.random() < 0.5 ? -1 : 1;
			}
			x += dx;
			y += dy;
			
			x = MathUtil.range( x, moveArea.x, moveArea.x + moveArea.width );
			y = MathUtil.range( y, moveArea.y, moveArea.y + moveArea.height );
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			x = moveArea.x + moveArea.width * Math.random();
			y = moveArea.y + moveArea.height * Math.random();
			dx = Math.random() < 0.5 ? Math.random() * 0.7 + 0.3 : -(Math.random() * 0.7 + 0.3);
			dy = Math.random() < 0.5 ? Math.random() * 0.7 + 0.3 : -(Math.random() * 0.7 + 0.3);
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		public function setLabel( letter:String ):void
		{
			txtLetter.text = letter.toLocaleUpperCase();
		}
		
		public function get letter():String
		{
			return txtLetter.text.toLocaleLowerCase();
		}
		
		public function selected( value:Boolean ):void
		{
			TickManager.clearDoTime( selected );
			if ( value )
			{
				mouseEnabled = false;
				dispatchEvent( new FightEvent( FightEvent.SELECTED_LETTER, letter, true ));
				TweenMax.to( this, 0.15, {scaleX:1.5, scaleY:1.5, ease: Back.easeIn });
				TweenMax.to( this, 0.15, {scaleX:0.5, scaleY:0.5, ease: Back.easeOut, onComplete:effectComplete, delay: 0.15 });
			}
		}
		
		private function effectComplete():void
		{
			TweenMax.killTweensOf( this );
			DisplayUtil.removedFromParent( this );
		}
		
	}
}