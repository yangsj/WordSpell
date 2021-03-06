package app.modules.login.preloader
{
	import app.events.GameEvent;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.events.LoadEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PreloaderMediator extends BaseMediator
	{
		[Inject]
		public var view:PreloaderView;
		
		public function PreloaderMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( LoadEvent.LOAD_PROGRESS, loadProgressHandler, LoadEvent );
			
			addViewListener( LoadEvent.LOAD_COMPLETE, loadCompleted, LoadEvent );
		}
		
		private function loadProgressHandler( event:LoadEvent ):void
		{
			view.setProgressValue( Number( event.data ) );
		}
		
		private function loadCompleted( event:LoadEvent ):void
		{
			if ( view.data == 2 ) {
				dispatch( new GameEvent( GameEvent.MAIN_LOAD_COMPLETE ));
			}
		}
		
	}
}