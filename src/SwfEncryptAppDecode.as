package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import victor.core.SwfEncrypt;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-17
	 */
	public class SwfEncryptAppDecode extends Sprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		private var urlStream:URLStream;
		private var loader:Loader;
		private var decodeBytes:ByteArray;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function SwfEncryptAppDecode()
		{
			if ( stage ) initApp( null );
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		protected function initApp(event:Event):void
		{
			var url:String = "WordsSpell.swf";
			this.urlStream = new URLStream();
			this.urlStream.load(new URLRequest( url ));
			this.urlStream.addEventListener(Event.COMPLETE, this.onStreamComplete);
		}
		
		private function onStreamComplete(event:Event) : void
		{
			var _loc_2:ByteArray = null;
			this.urlStream.removeEventListener(Event.COMPLETE, this.onStreamComplete);
			
			_loc_2 = new ByteArray();
			this.urlStream.readBytes(_loc_2);
//			this.decodeBytes = SwfEncrypt.instance.decode(_loc_2);
//			
//			var fileReference:FileReference = new FileReference();
//			fileReference.save( SwfEncrypt.instance.encode( decodeBytes ), "App2.swf" );
			
			decodeBytes = _loc_2;
			
			loader = new Loader();
			loader.loadBytes( decodeBytes, new LoaderContext( false, ApplicationDomain.currentDomain) );
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderByteCompleted );
		}
		
		protected function loaderByteCompleted(event:Event):void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderByteCompleted );
			stage.addChild( loader );
		}		
		
	}
}