package victor.framework.core
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import victor.framework.events.PanelEvent;
	import victor.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BasePanel extends BaseLoadView
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
		
		/**
		 * 是否鼠标可以穿透
		 */
		protected var isPenetrate:Boolean = false;
		
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
			SoundManager.playEffectMusic( SoundType.CLICK01 );
			hide();
			dispatchEvent( new PanelEvent( PanelEvent.CLOSE ));
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
			ViewStruct.addPanel( this, isPenetrate );
			transitionIn();
		}
		
		protected function transitionIn():void
		{
			mouseChildren = true;
//			this.scaleX = 0.1;
//			this.scaleY = 0.1;
			changePosAtOpen();
			this.z = 2000;
			this.alpha = 0;
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.3, { 	
//				scaleX: 1, 
//				scaleY: 1, 
				alpha: 1, 
//				onUpdate: changePosAtOpen, 
				z:0,
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
				TweenLite.killTweensOf( this );
				TweenLite.to( this, delay, { 
//					scaleX: 0.2, 
//					scaleY: 0.2, 
					alpha: 0, 
					ease: Back.easeIn, 
//					onUpdate: changePosAtHide,
					z:-500,
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
			dispatchEvent( new PanelEvent( PanelEvent.OPENED ));
		}

///////////////// getters/setters ////////////////////////////////

	}
}
