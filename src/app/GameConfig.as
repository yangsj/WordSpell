package app
{
	import app.modules.login.login.vo.LoginVo;
	
	import victor.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class GameConfig
	{
		public static var VERSION:String = "null";
		/**
		 * 密码是否使用md5加密
		 */
		public static var IS_MD5:Boolean = false;
		
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
		public static var uid:String;
		
		/**
		 * 登陆key
		 */
		public static var key:String;
		
		
		public function GameConfig()
		{
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
		
		/////////// static vars
		
		/**
		 * 是否可以直接登陆[ 若是页面已给玩家的uid和key则直接登录  ]
		 */
		public static function get canImmediateLogin():Boolean
		{
			return Boolean( uid ) && Boolean( key );
		}
		
		public static function get immediateLoginVo():LoginVo
		{
			var loginVo:LoginVo = new LoginVo();
			loginVo.accountName = uid;
			loginVo.password = key;
			return loginVo;
		}
		
	}
}