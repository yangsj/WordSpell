package app.modules.main.view
{
	import app.events.ViewEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIMediator extends BaseMediator
	{
		[Inject]
		public var view:MainUIView;
		
		public function MainUIMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( ViewEvent.SHOW_VIEW, showViewHandler, ViewEvent );
			
		}
		
		private function showViewHandler( event:ViewEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, event.viewName ) );
		}
		
	}
}