package victor.framework.core
{
	import app.events.ViewEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import victor.framework.events.PanelEvent;
	
	
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
		
		override public function onRegister():void
		{
			super.onRegister();
			// 打开view
			addViewListener( ViewEvent.SHOW_VIEW, showViewHandler, ViewEvent );
			// 关闭view
			addViewListener( ViewEvent.HIDE_VIEW, hideViewHandler, ViewEvent );
			// 开始加载资源
			addViewListener( PanelEvent.LOAD_START, loadStartHandler, PanelEvent );
			// 结束加载资源
			addViewListener( PanelEvent.LOAD_START, loadEnfHandler, PanelEvent );
		}
		
		private function loadEnfHandler( event:PanelEvent ):void
		{
			dispatch( new PanelEvent( PanelEvent.LOAD_END ));
		}
		
		private function loadStartHandler( event:PanelEvent ):void
		{
			dispatch( new PanelEvent( PanelEvent.LOAD_START ));
		}
		
		protected function hideViewHandler( event:ViewEvent ):void
		{
			closeView( event.viewName );
		}
		
		protected function showViewHandler( event:ViewEvent ):void
		{
			openView( event.viewName, event.data );
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