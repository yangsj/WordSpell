package app.modules.task.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.Text;
	import app.events.ViewEvent;
	import app.modules.TempleteSprite;
	import app.modules.ViewName;
	import app.modules.task.model.TaskVo;
	
	import victor.framework.utils.DisplayUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-5
	 */
	public class TaskItem extends TempleteSprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var txtDes:TextField;
		/**
		 * 1帧为常态|2为正在进行|3已完成
		 */
		public var bgStatus:MovieClip;
		
		private var bitmapCon:Sprite;
		private var bitmapDes:Bitmap;
		private var bitmapMask:Shape;
		private var time:Number = 0;
		private var endMoveX:Number = 0;
		private var txtWidth:Number = 0;
		
		// 创建对象池
		private static const vecPools:Vector.<TaskItem> = new Vector.<TaskItem>();
		public static function get itemInstance():TaskItem
		{
			if ( vecPools && vecPools.length > 0 )
				return vecPools.shift();
			return new TaskItem();
		}
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function TaskItem()
		{
			setSkinWithName( "ui_Skin_TaskItem" );
			txtDes = Text.cloneText( txtDes );
			txtDes.visible = false;
			mouseChildren = false;
//			mouseEnabled = false;
//			cacheAsBitmap = true;
			buttonMode = true;
			
			txtWidth = txtDes.width;
			
			bitmapCon = new Sprite();
			_skin.addChild( bitmapCon );

			bitmapMask = new Shape();
			bitmapMask.graphics.beginFill( 0 );
			bitmapMask.graphics.drawRect( txtDes.x - 4, 0, txtDes.width, height );
			bitmapMask.graphics.endFill();
			bitmapCon.mask = bitmapMask;
			_skin.addChild( bitmapMask );
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		private function addListeners():void
		{
			addEventListener( Event.REMOVED, removedFromParentHandeler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( MouseEvent.CLICK, onClickHandler );
			addEventListener( MouseEvent.ROLL_OVER, rollMouseHandler );
			addEventListener( MouseEvent.ROLL_OUT , rollMouseHandler );
		}
		
		private function removeListeners():void
		{
			removeEventListener( Event.REMOVED, removedFromParentHandeler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		private function startMoveDes( isLoop:Boolean = false ):void
		{
			if ( time > 0 )
			{
				if ( bitmapDes ) {
					bitmapDes.x = txtDes.x;
					TweenLite.to( bitmapDes, time, {
														x:endMoveX, 
														ease:Linear.easeNone, 
														onComplete:startMoveDes, 
														onCompleteParams:[ true ], 
														delay: isLoop ? 0.5 : 0 
													});
				}
			}
		}
		
		private function stopMoveDes():void
		{
			if ( bitmapDes ) {
				bitmapDes.x = txtDes.x;
				TweenLite.killTweensOf( bitmapDes );
			}
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function removedFromParentHandeler(event:Event):void
		{
			removeListeners();
			
			if ( vecPools ) vecPools.push( this );
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			stopMoveDes();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.TaskCompleted, null, true ));
		}
		
		protected function rollMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.ROLL_OVER ) {
				startMoveDes();
			} else if ( event.type == MouseEvent.ROLL_OUT ) {
				stopMoveDes();
			}
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function setData( vo:TaskVo ):void
		{
//			bgStatus.gotoAndStop( MathUtil.range(vo.status + 1, 1, 3) );
			bgStatus.gotoAndStop( vo.isComplete ? 3 : 1 );
			addListeners();
			
			if (  txtDes.htmlText != vo.fullDescribe )
			{
				txtDes.htmlText = vo.fullDescribe;
				txtDes.width = txtDes.textWidth + 10;
				if ( bitmapDes ) {
					if ( bitmapDes.bitmapData )
						bitmapDes.bitmapData.dispose();
					DisplayUtil.removedFromParent( bitmapDes );
				}
				bitmapDes = new Bitmap( new BitmapData( txtDes.width, txtDes.height, true, 0 ));
				bitmapDes.bitmapData.draw( txtDes );
				bitmapDes.x = txtDes.x;
				bitmapDes.y = txtDes.y;
				bitmapCon.addChild( bitmapDes );
				
				endMoveX = txtDes.x;
				time = 0;
				
				if ( bitmapDes.width > txtWidth )
				{
					var diff:Number = ( bitmapDes.width - txtWidth );
					endMoveX = endMoveX - diff;
					time = diff / 60;
//					startMoveDes();
				}
			}
		}
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}