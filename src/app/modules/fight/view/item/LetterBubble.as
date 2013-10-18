package app.modules.fight.view.item
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import app.modules.TempleteSprite;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.model.vo.ItemType;
	import app.utils.TextUtil;
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
		private var moveArea:Rectangle = new Rectangle(41, 41, 808, 298 );
		
		public var txtLetter:TextField;
		
		private var _data:LetterBubbleVo;
		private var _bitmapData:BitmapData;
		private var _point:Point = new Point();
		
		public function LetterBubble()
		{
			super();
			setMoveArea();
			mouseChildren = false;
			buttonMode = true;
			setSkinWithName( "ui_Skin_Round_Bubble_" + int( Math.random() * 5 ) );
			
			txtLetter = TextUtil.cloneText( txtLetter );
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
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
			
			TickManager.doInterval( enterFrameHandler, 20 );
			
////		var scale:Number = 1;//Math.random() * 0.5 + 0.6;
//			var scale:Number = Math.random() * 0.3 + 0.8;
//			scaleX = scaleY = scale;
//			moveArea.width = moveArea.width + moveArea.x * 2 - width;
//			moveArea.height = moveArea.height + moveArea.y * 2 - height;
//			moveArea.x = width >> 1;
//			moveArea.y = height >> 1;
//			trace( moveArea );
			
			x = moveArea.x + moveArea.width * Math.random();
			y = moveArea.y + moveArea.height * Math.random();
			
			var dxx:Number = 0.3 + Math.random() * 0.3;
			var dxy:Number = 0.3 + Math.random() * 0.3;
			dx = Math.random() < 0.5 ? dxx : -dxx;
			dy = Math.random() < 0.5 ? dxy : -dxy;
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.CLICK, mouseHandler );
			TickManager.clearDoTime( enterFrameHandler );
		}
		
		public function setMoveArea( isAlone:Boolean = true ):void
		{
			moveArea.width = isAlone ? 808 : 404;
		}
		
		/**
		 * 改变运动方向
		 */
		public function changeDirection( direx:int = 0, direy:int = 0 ):void
		{
			if ( parent )
			{
				if ( direx == direx && direx == 0 )// 到达边缘
				{
					dx *= Math.random() < 0.5 ? -1 : 1;
					dy *= Math.random() < 0.5 ? -1 : 1;
				}
				else // 泡泡相碰
				{
					dx *= direx;
					dy *= direy;
					x += dx;
					y += dy;
				}
			}
		}
		
		public function setData( vo:LetterBubbleVo ):void
		{
			_data = vo;
			txtLetter.text = vo.itemType == 0 ? vo.letter : "道";
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
				dispatchEvent( new FightEvent( FightEvent.SELECTED_LETTER, this, true ));
				if ( _data.itemType == ItemType.DEFAULT )
				{
					TweenMax.to( this, 0.15, {scaleX:1.5, scaleY:1.5, ease: Back.easeIn });
					TweenMax.to( this, 0.15, {scaleX:0.5, scaleY:0.5, ease: Back.easeOut, onComplete:effectComplete, delay: 0.15 });
				}
			}
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