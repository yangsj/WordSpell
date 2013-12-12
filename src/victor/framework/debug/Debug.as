package victor.framework.debug
{

	import com.junkbyte.console.Cc;
	
	import flash.display.Stage;
	import flash.system.Capabilities;
	
	/**
	 * @author
	 */
	public class Debug
	{
		public static function warn( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.warn( msg );
				trace( "[warn]" + msg );
			}
		}

		public static function error( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.error( msg );
				trace( "[error]" + msg );
			}
		}

		public static function debug( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.debug( msg );
				trace( "[debug]" + msg );
			}
		}

		public static function printServer( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.ch( "server", msg, 2 );
				trace( "[server]" + msg );
			}
		}
		
		/**
		 * 初始化舞台
		 */
		public static function initStage( stage:Stage, pass:String = " " ):void
		{
			if ( isDebug )
			{
				Cc.config.style.backgroundAlpha = 0.7;
				Cc.startOnStage( stage, pass );
				Cc.commandLine = true;
				Cc.fpsMonitor = true;
				Cc.memoryMonitor = true;
				Cc.config.commandLineAllowed = true;
				Cc.config.alwaysOnTop = true;
				Cc.visible = false;
				Cc.width = stage.stageWidth - 50;
			}
		}
		
		/////////////////////
		
		private static var _isDebug:Boolean;
		/**
		 * 是否是调试状态
		 */
		public static function get isDebug():Boolean
		{
			if ( Capabilities.playerType == "StandAlone" )
				return true;
			return _isDebug;
		}
		
		public static function set isDebug( value:Boolean ):void
		{
			_isDebug = value;
		}
	}
}
