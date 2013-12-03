package app.modules.login.register
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import app.modules.TempleteSprite;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MathUtil;
	import victor.framework.utils.appStage;
	import victor.framework.utils.safetyCall;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-9
	 */
	public class CheckboxPanel extends TempleteSprite implements IDisposable
	{
		public var mcBg:MovieClip;
		
		public var callBackFun:Function;
		
		private var tabControl:TabButtonControl;
		private var _isOpen:Boolean;
		
		public function CheckboxPanel()
		{
			setSkinWithName( "ui_Skin_CheckBoxPanel" );
			onCloseComplete();
			
//			addEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		override public function dispose():void
		{
			removeEventListener( MouseEvent.CLICK, onClickHandler );
			appStage.removeEventListener(MouseEvent.CLICK, onStageClickHandler );
			if ( tabControl )
				tabControl.dispose();
			tabControl = null;
			callBackFun = null;
		}
		
		public function tweenOpen():void
		{
			_isOpen = true;
			visible = true;
			scaleX = scaleY = 0.01;
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:1, scaleY:1, ease:Linear.easeNone, onComplete: onOpenComplete} );
		}
		
		public function tweenClose():void
		{
			_isOpen = false;
			appStage.removeEventListener(MouseEvent.CLICK, onStageClickHandler );
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:0.01, scaleY:0.01, ease:Linear.easeNone, onComplete:onCloseComplete} );
		}
		
		public function selectedForItem( index:int ):void
		{
			index = MathUtil.range( index - 1, 0, index );
			tabControl.setTargetByIndex(index);
		}
		
		public function setData( array:Array, isArea:Boolean = true ):void
		{
			var leng:int = array.length;
			tabControl ||= new TabButtonControl( tabControlHandler );
			for ( var i:int = 0; i < 20; i++ )
			{
				var mc:MovieClip = _skin.getChildByName("item" + i ) as MovieClip;
				if ( i < leng )
				{
					var ary:Array = array[ i ];
					mc.txtLabel.text = ary[ 0 ] + "";
					tabControl.addTarget( mc, ary );
				}
				else
				{
					DisplayUtil.removedFromParent( mc );
				}
			}
			tabControl.setTargetByIndex(0);
			mcBg.gotoAndStop( isArea ? 1 : 2 );
		}
		
		private function tabControlHandler( clickTarget:MovieClip, data:Object ):void
		{
			if ( data )
			{
				safetyCall( callBackFun, data );
			}
		}
		
		protected function onStageClickHandler(event:MouseEvent):void
		{
			tweenClose();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			event.stopPropagation();
		}
		
		private function onOpenComplete():void
		{
			_isOpen = true;
			appStage.addEventListener(MouseEvent.CLICK, onStageClickHandler );
		}
		
		private function onCloseComplete():void
		{
			_isOpen = false;
			visible = false;
			scaleX = scaleY = 0.01;
		}

		public function get isOpen():Boolean
		{
			return _isOpen;
		}

	}
}