package victor.framework.core
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import app.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends LoadViewBase
	{
		
		/**
		 * 关闭按钮
		 */
		public var btnClose:InteractiveObject;
		/**
		 * 拖拽对象
		 */
		public var dragTarget:Sprite;
		
		private var hideX:Number;
		private var hideY:Number;
		
		public function BasePanel()
		{
		}
		
////////////// events handlers /////////////////
		
		protected function dragTargetMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				parent.setChildIndex(this, parent.numChildren - 1 );
				dragTarget.buttonMode = true;
				startDrag( false, new Rectangle(-rectangle.x, -rectangle.y, appStage.stageWidth - dragTarget.width, appStage.stageHeight - dragTarget.height));
				appStage.addEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				stopDrag();
				dragTarget.buttonMode = false;
				appStage.removeEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
		}
		
		private function btnCloseClickHandler(event:MouseEvent):void
		{
			hide();
		}

///////////// override functions ///////////////////////////
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event ); 
			
			if ( btnClose )
			{
				btnClose.addEventListener(MouseEvent.CLICK, btnCloseClickHandler );
				if (　btnClose.hasOwnProperty( "buttonMode" ) )
				{
					btnClose["buttonMode"] = true;
				}
			}
			
			if ( dragTarget )
				dragTarget.addEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler( event );
			
			if ( btnClose )
				btnClose.removeEventListener(MouseEvent.CLICK, btnCloseClickHandler );
			
			if ( dragTarget )
				dragTarget.removeEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
		}
		
		override final protected function addToParent():void
		{
			ViewStruct.addPanel( this );
			transitionIn();
		}
		
		protected function transitionIn():void
		{
			mouseChildren = true;
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			changePosAtOpen();
			TweenMax.killTweensOf( this );
			TweenMax.to( this, 0.5, { 	scaleX: 1, 
				scaleY: 1, 
				alpha: 1, 
				onUpdate: changePosAtOpen, 
				ease: Back.easeOut, 
				onComplete:openComplete 
			});
		}
		
		protected function transitionOut( delay:Number = 0.3 ):void
		{
			if ( delay > 0 )
			{
				mouseChildren = false;
				hideX = x;
				hideY = y;
				TweenMax.killTweensOf( this );
				TweenMax.to( this, delay, { scaleX: 0.2, 
					scaleY: 0.2, 
					alpha: 0, 
					ease: Back.easeIn, 
					onUpdate: changePosAtHide,
					onComplete:closeComplete
				});
			}
			else 
			{
				closeComplete();
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			btnClose = null;
			dragTarget = null;
		}

		override public function hide():void
		{
			transitionOut( 0.3 );
		}

////////////// private functions //////////////////////////////////
		
		private function changePosAtOpen():void
		{
			x = (( appStage.stageWidth - rectangle.width * scaleX ) >> 1 ) - rectangle.x * scaleX;
			y = (( appStage.stageHeight - rectangle.height * scaleX ) >> 1 ) - rectangle.y * scaleY;
		}
		
		private function changePosAtHide():void
		{
			x = hideX + (( rectangle.width - rectangle.width * scaleX ) >> 1 );
			y = hideY + (( rectangle.height - rectangle.height * scaleX ) >> 1 );
		}
		
		private function closeComplete():void
		{
			ViewStruct.removePanel( this );
		}
		
///////////////// protected functions //////////////////////////////
		
		protected function openComplete():void
		{
		}

///////////////// getters/setters ////////////////////////////////

	}
}
