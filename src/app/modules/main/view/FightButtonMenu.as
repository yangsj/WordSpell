package app.modules.main.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import app.events.ViewEvent;
	import app.modules.TempleteSprite;
	import app.modules.ViewName;
	import app.utils.appStage;
	
	import victor.framework.utils.DisplayUtil;
	
	
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
			
			addEventListener( MouseEvent.MOUSE_DOWN, onClickHandler, int.MAX_VALUE );
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			appStage.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			appStage.removeEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( isOpen( targetName ) && parent )
			{
				parent.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, targetName ));
			}
			DisplayUtil.removedFromParent( this );
		}
		
		private function isOpen( targetName:String ):Boolean
		{
			return [ ViewName.FightFriendPanel, ViewName.FightSearchPanel, ViewName.FightMatchingPanel ].indexOf( targetName ) != -1;
		}
	}
}