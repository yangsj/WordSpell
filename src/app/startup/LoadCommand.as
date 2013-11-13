package app.startup
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.GameConfig;
	import app.events.LoadEvent;
	import app.events.ViewEvent;
	import app.managers.LoaderManager;
	import app.modules.ViewName;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class LoadCommand extends BaseCommand
	{
		public function LoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var url:String = GameConfig.deployPath + "application.xml?t=" + new Date().time;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler );
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			loader.load( new URLRequest( url ));
			
			Debug.debug( url );
		}
		
		protected function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			removeEvent( loader );
			
			
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Preloader ));
			
			LoaderManager.instance.setApplicationConfig( new XML(loader.data));
			
			LoaderManager.instance.startMainLoad( loaderCompleteCallBack, loaderProgressCallBack );
		}
		
		protected function errorHandler(event:IOErrorEvent):void
		{
			removeEvent( event.target as URLLoader );
			Debug.debug( event.text );
		}
		
		private function removeEvent( loader:URLLoader ):void
		{
			if ( loader )
			{
				loader.removeEventListener(Event.COMPLETE, completeHandler );
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			}
		}
		
		private function loaderCompleteCallBack():void
		{
			Debug.debug( "登陆资源加载完毕！！！" );
			dispatch( new LoadEvent( LoadEvent.LOAD_COMPLETE ));
		}
		
		private function loaderProgressCallBack( perent:Number ):void
		{
			Debug.debug ( "loaderProgressCallBack: " + perent );
			dispatch( new LoadEvent( LoadEvent.LOAD_PROGRESS, perent ));
		}
		
	}
}