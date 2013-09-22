package app.modules.map.main
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.map.event.MapEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class MapWorldMediator extends BaseMediator
	{
		public function MapWorldMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( MapEvent.OPEN_SELECTED_ROUND, openSelectedRoundHandler, MapEvent );
		}
		
		private function openSelectedRoundHandler( event:MapEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.SelectedRoundPanel ));
		}
		
		
	}
}