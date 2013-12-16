package app.managers
{
	import flash.external.ExternalInterface;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-18
	 */
	public class ExternalManager
	{
		public function ExternalManager()
		{
		}
		
		public static function reload():void
		{
			callJs( "reload" );
		}
		
		public static function shareWeibo():void
		{
			callJs( "share_weibo", "分享到微博拿奖励!!!成功分享后宝石 +500" );
		}
		
		public static function callJs(...arg):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call.apply( null, arg );
			}
		}
		
	}
}