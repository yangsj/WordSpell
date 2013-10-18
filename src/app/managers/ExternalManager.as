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
		
		public static function callJs(...arg):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call.apply( null, arg );
			}
		}
		
	}
}