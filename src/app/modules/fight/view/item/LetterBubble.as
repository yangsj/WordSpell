package app.modules.fight.view.item
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.utils.appStage;
	
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
		private static const moveArea:Rectangle = new Rectangle(0, 0, 808, 298 );
		public static const WH:Number = 82;
		public static const HALF:Number = WH * 0.5;
		
		public var txtLetter:TextField;
		
		private var _data:LetterBubbleVo;
		private var _bitmapData:BitmapData;
		private var _point:Point = new Point();
		
		public function LetterBubble()
		{
			super();
			mouseChildren = false;
			buttonMode = true;
			setSkinWithName( "ui_Skin_Round_Bubble_" + int( Math.random() * 5 ) );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
			TickManager.doInterval( enterFrameHandler, 40 );
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
		protected function enterFrameHandler(event:Event = null):void
		{
			if ( x <= moveArea.x || x >= moveArea.x + moveArea.width ||  y <= moveArea.y || y >= moveArea.y + moveArea.height )
			{
				changeDirection();
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
//			dx = Math.random() < 0.5 ? int(Math.random() + 1) : -int(Math.random() + 1);
//			dy = Math.random() < 0.5 ? int(Math.random() + 1) : -int(Math.random() + 1);
			dx = Math.random() < 0.5 ? 1 : -1;
			dy = Math.random() < 0.5 ? 1 : -1;
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.CLICK, mouseHandler );
			TickManager.clearDoTime( enterFrameHandler );
		}
		
		/**
		 * 改变运动方向
		 */
		public function changeDirection( reverse:Boolean = false ):void
		{
			if ( parent )
			{
				if ( reverse )
				{
					var a:Number = dx;
					var b:Number = dy;
					dx *= -1;
					dy *= -1;
					if ( a == dx || b == dy )
					{
						trace("************************************");
					}
				}
				else // 到达边缘
				{
					dx *= Math.random() < 0.5 ? -1 : 1;
					dy *= Math.random() < 0.5 ? -1 : 1;
				}
			}
		}
		
		public function setData( vo:LetterBubbleVo ):void
		{
			_data = vo;
			txtLetter.visible = false;
			txtLetter.text = vo.letter;
			var bitmapData:BitmapData = new BitmapData(txtLetter.width, txtLetter.height, true, 0 );
			var bitmap:Bitmap = new Bitmap( bitmapData, "auto", true );
			bitmap.bitmapData.draw( txtLetter );
			bitmap.x = txtLetter.x;
			bitmap.y = txtLetter.y;
			txtLetter.parent.addChild( bitmap );
		}
		
		/**
		 * 选择
		 * @param value
		 * 
		 */
		public function selected( value:Boolean ):void
		{
			TickManager.clearDoTime( selected );
			if ( value )
			{
				mouseEnabled = false;
				dispatchEvent( new FightEvent( FightEvent.SELECTED_LETTER, _data, true ));
				TweenMax.to( this, 0.15, {scaleX:1.5, scaleY:1.5, ease: Back.easeIn, onUpdate:effectUpdate });
				TweenMax.to( this, 0.15, {scaleX:0.5, scaleY:0.5, ease: Back.easeOut, onUpdate:effectUpdate, onComplete:effectComplete, delay: 0.15 });
			}
		}
		
		private function effectUpdate():void
		{
			_skin.x = ( WH - _skin.width ) >> 1;
			_skin.y = ( WH - _skin.height ) >> 1;
		}
		
		private function effectComplete():void
		{
			DisplayUtil.removedFromParent( this );
		}
		
		/**
		 * 提示
		 */
		public function hint():void
		{
			this.alpha = 0.6;
			appStage.addEventListener(MouseEvent.MOUSE_DOWN, onStageHandler );
			appStage.addEventListener(KeyboardEvent.KEY_DOWN, onStageHandler );
		}
		
		private function onStageHandler( event:Event ):void
		{
			this.alpha = 1;
			appStage.removeEventListener(MouseEvent.CLICK, onStageHandler );
			appStage.removeEventListener(KeyboardEvent.KEY_DOWN, onStageHandler );
		}
		
		public function get data():LetterBubbleVo
		{
			return _data;
		}
		
		public function get bitmapData():BitmapData
		{
			if ( _bitmapData == null )
			{
				_bitmapData = new BitmapData( width, height, true, 0 );
				_bitmapData.draw( this );
			}
			return _bitmapData;
		}
		
		public function get point():Point
		{
			_point.x = x;
			_point.y = y;
			return _point;
		}
		
		public function get isEdgeLeft():Boolean
		{
			return x < moveArea.x + 15;
		}
		
		public function get isEdgeRight():Boolean
		{
			return x > moveArea.width - moveArea.x - 15;
		}
		
		public function get isEdgeUp():Boolean
		{
			return y < moveArea.x + 15;
		}
		
		public function get isEdgeDown():Boolean
		{
			return y > moveArea.height - moveArea.x - 15;
		}

		
	}
}