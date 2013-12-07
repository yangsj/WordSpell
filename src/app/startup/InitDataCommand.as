package app.startup
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.GameConfig;
	import app.core.Tips;
	import app.events.GameEvent;
	import app.managers.LoaderManager;
	import app.sound.SoundManager;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
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
			var url:String = GameConfig.deployPath + "application.xml?t=" + new Date().time;
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
			Debug.error( event.text );
			Tips.showCenter( "application.xml load error" );
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