package app
{
	import flash.system.Capabilities;
	
	import app.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class GameConfig
	{
		
		/**
		 * 最大等级
		 */
		public static const MAX_LEVEL:int = 60;
		
		/**
		 * 主机地址
		 */
		public static var serverHost:String = "112.124.57.159";
		/**
		 * 主机端口
		 */
		public static var serverPort:int = 10242;
		
		/**
		 * 用户id
		 */
		public static var uid:int;
		
		/**
		 * 登陆key
		 */
		public static var key:String;
		
		
		public function GameConfig()
		{
		}
		
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
		
/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////          game url        ////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
		
		private static var _deployPath:String = "";
		
		/**
		 * 部署地址
		 */
		public static function get deployPath():String
		{
			if ( _deployPath == "" )
			{
				_deployPath = appStage.loaderInfo.url;
				_deployPath = _deployPath.replace(/\\/g, "/");
				_deployPath = _deployPath.substring(0, _deployPath.lastIndexOf("/") + 1);
			}
			return _deployPath;
		}
		
		public static function set deployPath( value:String ):void
		{
			_deployPath = value;
		}
		
	}
}