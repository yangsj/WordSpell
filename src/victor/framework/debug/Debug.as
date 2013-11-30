package victor.framework.debug
{

	import flash.display.Stage;
	import flash.system.Capabilities;
	
	import victor.framework.interfaces.IDebug;

	/**
	 * @author
	 */
	public class Debug
	{
		private static var _ccInstance:IDebug;

		public static function warn( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				_ccInstance.warn( args );
			}
		}

		public static function error( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				_ccInstance.error( args );
			}
		}

		public static function debug( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				_ccInstance.debug( args );
			}
		}

		public static function printServer( ... args ):void
		{
			if ( _ccInstance && isDebug )
			{
				_ccInstance.printServer( args );
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
