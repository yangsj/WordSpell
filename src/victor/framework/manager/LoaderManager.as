package victor.framework.manager
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import app.GameConfig;
	
	import victor.framework.debug.Debug;
	import victor.utils.ArrayUtil;
	import victor.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-27
	 */
	public class LoaderManager
	{
		private static var _instance:LoaderManager;

		public static function get instance():LoaderManager
		{
			return _instance ||= new LoaderManager;
		}

		public static function getObj( linkName:String, domainName:String = "" ):Object
		{
			return instance.getObj( linkName, domainName );
		}

		public static function getClass( linkName:String, domainName:String = "" ):Class
		{
			return instance.getClass( linkName, domainName );
		}

		public static function getUrl( name:String ):String
		{
			return instance.getUrl( name );
		}

		///////////////////////////////////////////////////////

		private static const dictResLoaded:Dictionary = new Dictionary();
		private static const dictResList:Dictionary = new Dictionary();
		private static const dictContext:Dictionary = new Dictionary();
		private static const dictLoaderContext:Dictionary = new Dictionary();
		/**
		 * 若已经加载firstLoad资源则加载该配置
		 * 第二阶段资源加载1
		 */
		private static const mainLoad1:Array = [];
		/**
		 * 若没有加载firstLoad里的资源，则加载
		 * 第二阶段资源加载2
		 */
		private static const mainLoad2:Array = [];
		/**
		 * 第一阶段资源加载
		 */
		private static const firstLoad:Array = [];

		private static const context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );

		private static var loader:Loader;
		
		///////////////////////////////////////////////////////

		public function LoaderManager()
		{
		}

		public function setApplicationConfig( applicationXml:XML ):void
		{
			GameConfig.VERSION = applicationXml.app[0].@version;
			var xmllist:XMLList = applicationXml.asset;
			for each ( var xml:XML in xmllist )
			{
				var name:String = String( xml.@id );
				var url:String = String( xml.@src );
				var version:String = String( xml.@version );
				var first:int = int( xml.@first );
				var path:String = GameConfig.deployPath + url;
				
				dictResList[ name ] = path;
				if ( first > 0 )
				{
					if ( first == 1 )
					{
						firstLoad.push( name );
					}
					else if ( first == 2 )
					{
						mainLoad1.push( name );
					}
					mainLoad2.push( name );
				}
			}
		}

		/**
		 * 第一阶段资源加载
		 * @param completeCallBack
		 * @param progressCallBack
		 * @param domainName
		 * 
		 */
		public function startFirstLoad( completeCallBack:Function = null, progressCallBack:Function = null, domainName:String = "" ):void
		{
			mainLoad2.length = 0;
			load( firstLoad, completeCallBack, progressCallBack, domainName );
		}

		/**
		 * 主资源加载（第二阶段）
		 * @param completeCallBack
		 * @param progressCallBack
		 * @param domainName
		 */
		public function startMainLoad( completeCallBack:Function = null, progressCallBack:Function = null, domainName:String = "" ):void
		{
			var mainLoad:Array = mainLoad2.length == 0 ? mainLoad1 : mainLoad2;
			load( mainLoad, completeCallBack, progressCallBack, domainName );
		}

		public function load( resNameAry:Array, completeCallBack:Function = null, progressCallBack:Function = null, domainName:String = "" ):void
		{
			var ary:Array = ArrayUtil.cloneArray( resNameAry );
			var totalNum:int = ary.length;
			var loadNum:int = 0;
			if ( loader == null )
			{
				loader = new Loader();
			}
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, errorHandler );

			loadItem();

			function loadItem():void
			{
				if ( ary.length > 0 )
				{
					try
					{
						var name:String = ary.shift();
						if ( dictResLoaded[ name ])
						{
							loadItem();
						}
						else
						{
							var url:String = dictResList[ name ];
							Debug.debug( "加载[" + name + "]url=" + url );
							dictResLoaded[ name ] = url;
							loader.load( new URLRequest( url ), getLoaderContext( domainName ));
						}
					}
					catch ( e:* )
					{
						completeHandler( null );
					}
				}
				else
				{
					safetyCall( completeCallBack );
					loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, completeHandler );
					loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
					loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, errorHandler );
				}
			}

			function completeHandler( event:Event ):void
			{
				loadNum++;
				loadItem();
			}

			function progressHandler( event:ProgressEvent ):void
			{
				var perent:Number = event.bytesLoaded / event.bytesTotal;
				perent = perent * ( 1 / totalNum ) + ( loadNum / totalNum );
				safetyCall( progressCallBack, perent );
			}

			function errorHandler( event:IOErrorEvent ):void
			{
				Debug.error( event.text );
				completeHandler( null );
			}
		}

		public function getObj( linkName:String, domainName:String = "" ):Object
		{
			try
			{
				return new ( getClass( linkName, domainName ))();
			}
			catch ( e:Error )
			{
				Debug.error( "LoaderManager.instance.getObj: [" + linkName + "]=" + linkName + "/[" + domainName + "]=" + domainName );
			}
			return null;
		}

		public function getClass( linkName:String, domainName:String = "" ):Class
		{
			try
			{
				var tempContext:LoaderContext = getLoaderContext( domainName );

				if ( tempContext == null )
					return getDefinitionByName( linkName ) as Class;

				else
					return tempContext.applicationDomain.getDefinition( linkName ) as Class;
			}
			catch ( e:Error )
			{
				Debug.error( "LoaderManager.instance.getClass: [" + linkName + "]=" + linkName + "/[" + domainName + "]=" + domainName );
			}
			return null;
		}

		private function getLoaderContext( domainName:String ):LoaderContext
		{
			if ( domainName )
			{
				var tempContext:LoaderContext = dictLoaderContext[ domainName ] as LoaderContext;
				if ( tempContext == null )
				{
					tempContext = new LoaderContext( false, new ApplicationDomain());
					dictLoaderContext[ domainName ] = tempContext;
				}
				return tempContext;
			}
			return context;
		}

		public function getUrl( name:String ):String
		{
			return dictResList[ name ];
		}

	}
}
