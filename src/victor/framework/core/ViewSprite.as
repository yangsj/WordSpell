package victor.framework.core
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import app.modules.TempleteSprite;
	
	import victor.framework.interfaces.IView;
	import victor.framework.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class ViewSprite extends TempleteSprite implements IView
	{
		protected var _data:Object;
		protected var rectangle:Rectangle;
		protected var _isInit:Boolean = false;

		public function ViewSprite()
		{
			super();

			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, int.MAX_VALUE );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			firstRun();
		}
		
		protected function firstRun():void
		{
			createSkin();
		}
		
		protected function removedFromStageHandler( event:Event ):void
		{
		}

		protected function addedToStageHandler( event:Event ):void
		{
		}
		
		protected function createSkin():void
		{
			if ( _isInit == false )
			{
				setSkinWithName( skinName );
				var rect:Rectangle = this.getBounds( this );
				rectangle = new Rectangle( rect.x, rect.y, rect.width, rect.height );
				onceInit();
			}
		}

		protected function onceInit():void
		{
		}

		public function dispose():void
		{
			DisplayUtil.removedFromParent( _skin );
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			_skin = null;
			_data = null;
		}

		public function hide():void
		{
			ViewStruct.removeChild( this );
		}

		public function show():void
		{
			throw new Error( "重写show" );
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data( value:Object ):void
		{
			_data = value;
		}

		/**
		 * 皮肤名称
		 */
		protected function get skinName():String
		{
			return "";
		}

		/**
		 * 指定资源加载的域名称（默认当前域）
		 */
		protected function get domainName():String
		{
			return "";
		}


	}
}
