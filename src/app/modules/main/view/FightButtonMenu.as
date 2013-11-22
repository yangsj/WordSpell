package app.modules.main.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.events.MouseEvent;
	
	import app.events.ViewEvent;
	import app.modules.TempleteSprite;
	import app.modules.ViewName;
	import app.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-18
	 */
	public class FightButtonMenu extends TempleteSprite
	{
		
		public function FightButtonMenu()
		{
			super();
			setSkinWithName( "ui_Skin_FightButtonMenu" );
			
			x = 621;
			y = 460;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( isOpen( targetName ) ) {
				dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, targetName, null, true ));
			}
			hide();
		}
		
		private function isOpen( targetName:String ):Boolean
		{
			return [ ViewName.FightFriendPanel, ViewName.FightSearchPanel, ViewName.FightMatchingPanel ].indexOf( targetName ) != -1;
		}
		
		private function openCompleted():void
		{
			appStage.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
			TweenLite.killTweensOf( this );
			this.scaleX = 1;
			this.scaleY = 1;
			this.visible = true;
		}
		
		private function hideCompleted():void
		{
			appStage.removeEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
			TweenLite.killTweensOf( this );
			this.scaleX = 0.01;
			this.scaleY = 0.01;
			this.visible = false;
		}
		
		public function show():void
		{
			hideCompleted();
			this.visible = true;
			TweenLite.to( this, 0.3, {scaleX:1, scaleY:1, onComplete:openCompleted, ease:Back.easeOut });
		}
		
		public function hide():void
		{
			openCompleted();
			TweenLite.to( this, 0.3, {scaleX:0.01, scaleY:0.01, onComplete:hideCompleted, ease:Back.easeIn });
		}
		
	}
}