package victor.framework.core
{
	import app.events.ViewEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class BaseMediator extends Mediator
	{
		public function BaseMediator()
		{
			super();
		}
		
		protected function openView( viewName:String, data:Object = null ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, viewName, data ));
		}
		
		protected function closeView( viewName:String ):void
		{
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, viewName ));
		}
		
	}
}