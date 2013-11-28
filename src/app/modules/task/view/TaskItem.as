package app.modules.task.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.events.ViewEvent;
	import app.modules.TempleteSprite;
	import app.modules.ViewName;
	import app.modules.task.model.TaskVo;
	import app.utils.TextUtil;
	
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MathUtil;
	
	
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
		
		private var bitmapDes:Bitmap;
		
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
			txtDes = TextUtil.cloneText( txtDes );
			txtDes.visible = false;
			mouseChildren = false;
			mouseEnabled = false;
			cacheAsBitmap = true;
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		private function addListeners():void
		{
			addEventListener( Event.REMOVED, removedFromParentHandeler );
			addEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		private function removeListeners():void
		{
			removeEventListener( Event.REMOVED, removedFromParentHandeler );
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function removedFromParentHandeler(event:Event):void
		{
			removeListeners();
			
			if ( vecPools ) vecPools.push( this );
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.TaskCompleted, null, true ));
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
				if ( bitmapDes ) {
					if ( bitmapDes.bitmapData )
						bitmapDes.bitmapData.dispose();
					DisplayUtil.removedFromParent( bitmapDes );
				}
				bitmapDes = new Bitmap( new BitmapData( txtDes.width, txtDes.height, true, 0 ));
				bitmapDes.bitmapData.draw( txtDes );
				bitmapDes.x = txtDes.x;
				bitmapDes.y = txtDes.y;
				_skin.addChild( bitmapDes );
			}
		}
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}