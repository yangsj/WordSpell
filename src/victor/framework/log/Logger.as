package victor.framework.log
{

	import flash.display.Stage;

	/**
	 * @author
	 */
	public class Logger
	{
		private static var _ccInstance:CcInstance;

		public static function warn( ... args ):void
		{
			if ( _ccInstance )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.warn( msg );
				trace( "[warn]" + msg );
			}
		}

		public static function error( ... args ):void
		{
			if ( _ccInstance )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.error( msg );
				trace( "[error]" + msg );
			}
		}

		public static function debug( ... args ):void
		{
			if ( _ccInstance )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.debug( msg );
				trace( "[debug]" + msg );
			}
		}

		public static function printData( ... args ):void
		{
			if ( _ccInstance )
			{
				var msg:String = JSON.stringify( args );
				_ccInstance.info( msg );
				trace( "[printData]" + msg );
			}
		}
		
		public static function Trace( ...args ):void
		{
			if ( _ccInstance )
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
		Cc.visible = true;
		Cc.width = stage.stageWidth - 50;
	}

}
