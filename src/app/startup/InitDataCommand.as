package app.startup
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.Global;
	import app.events.GameEvent;
	import app.events.ViewEvent;
	import app.managers.LoaderManager;
	import app.modules.ViewName;
	import app.utils.log;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class InitDataCommand extends BaseCommand
	{
		public function InitDataCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var url:String = Global.serverURL + "application.xml?t=" + new Date().time;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler );
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			loader.load( new URLRequest( url ));
		}
		
		protected function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			removeEvent( loader );
			
			LoaderManager.instance.setApplicationConfig( new XML(loader.data));
			
			// 资源初始化完成
			dispatch( new GameEvent( GameEvent.DATA_INIT_COMPLETE ));
		}
		
		protected function errorHandler(event:IOErrorEvent):void
		{
			removeEvent( event.target as URLLoader );
			log( event.text );
		}
		
		private function removeEvent( loader:URLLoader ):void
		{
			if ( loader )
			{
				loader.removeEventListener(Event.COMPLETE, completeHandler );
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			}
		}
		
	}
}