package victor.framework.debug
{

	import flash.display.Stage;
	import flash.system.Capabilities;

	/**
	 * @author
	 */
	public class Debug
	{
		private static var _ccInstance:CcInstance;

		public static function warn( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.warn( msg );
				Trace( "[warn]" + msg );
			}
		}

		public static function error( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.error( msg );
				Trace( "[error]" + msg );
			}
		}

		public static function debug( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.debug( msg );
				Trace( "[debug]" + msg );
			}
		}

		public static function printData( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.info( msg );
				Trace( "[printData]" + msg );
			}
		}
		
		public static function Trace( ...args ):void
		{
			if ( _ccInstance && isDebug )
			{
				trace("[trace][" + args.join(",") + "]");
			}
		}

		/**
		 * 初始化舞台
		 */
		public static function initStage( stage:Stage, pass:String = " " ):void
		{
			_ccInstance = new CcInstance();
			_ccInstance.initStage( stage, pass );
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

import com.junkbyte.console.Cc;

import flash.display.Stage;

class CcInstance
{
	public function warn( ... args ):void
	{
		Cc.warn( args );
	}

	public function error( ... args ):void
	{
		Cc.error( args );
	}

	public function debug( ... args ):void
	{
		Cc.debug( args );
	}

	public function info( ... args ):void
	{
		Cc.info( args );
	}

	/**
	 * 初始化舞台
	 */
	public function initStage( stage:Stage, pass:String = " " ):void
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
