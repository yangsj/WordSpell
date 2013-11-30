package victor.framework.debug
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Stage;
	
	import victor.framework.interfaces.IDebug;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-1
	 */
	public class CcInstance implements IDebug
	{
		public function warn( args:Array ):void
		{
			var msg:String = JSON.stringify( args );
			Cc.warn( msg );
			trace( "[warn]" + msg );
		}
		
		public function error( args:Array ):void
		{
			var msg:String = JSON.stringify( args );
			Cc.error( msg );
			trace( "[error]" + msg );
		}
		
		public function debug( args:Array ):void
		{
			var msg:String = JSON.stringify( args );
			Cc.debug( msg );
			trace( "[debug]" + msg );
		}
		
		public function printServer( args:Array ):void
		{
			var msg:String = JSON.stringify( args );
			Cc.ch( "server", msg );
			trace( "[server]" + msg );
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
}