package app.modules.friend.view.rightMenu
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import app.managers.LoaderManager;
	import app.utils.appStage;
	import app.utils.safetyCall;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class RightMenu extends Sprite
	{
		private static var _instance:RightMenu;
		public static function get instance():RightMenu
		{
			return _instance ||= new RightMenu();
		}
		
		private var _skinBg:Sprite;
		private var _itemCon:Sprite;
		private var _itemPool:Vector.<RightMenuItem>;
		private var _isNull:Boolean = true;
		private var _callBack:Function;
		
		public function RightMenu()
		{
			_instance = this;
		}
		
		public function removed(type:int = -1):void
		{
			DisplayUtil.removedFromParent( this );
			if ( type != -1 )
				safetyCall( _callBack, type );
			_callBack = null;
		}
		
		public function setList( list:Vector.<Array>, callBack:Function = null ):void
		{
			if ( list )
			{
				_callBack = callBack;
				create();
				createMenuList( list );
			}
		}
		
		private function create():void
		{
			if ( _isNull )
			{
				_skinBg = LoaderManager.getObj( "ui_Skin_RightMenuBg" ) as Sprite;
				addChild( _skinBg );
				
				_itemCon = new Sprite();
				_itemCon.x = 5;
				_itemCon.y = 5;
				addChild( _itemCon );
				
				_itemPool = new Vector.<RightMenuItem>( 15 );
			}
		}
		
		private function createMenuList( list:Vector.<Array> ):void
		{
			
			var px:Number = appStage.mouseX;
			var py:Number = appStage.mouseY;
			var length:int = list.length;
			var item:RightMenuItem;
			DisplayUtil.removedAll( _itemCon, false );
			for (var i:int = 0; i < length; i++ )
			{
				item = getItemByIndex( i );
				item.setVo( list[ i ] );
				_itemCon.addChild( item );
			}
			if ( px + width + 5 > appStage.stageWidth && px - width - 5 > 0 )
				px -= (width - 5);
			if ( py + height > appStage.stageHeight )
				py = appStage.stageHeight - height;
			
			x = px;
			y = py;
			ViewStruct.addChild( this, ViewStruct.RIGHT_MENU );
			
			appStage.addEventListener( MouseEvent.MOUSE_DOWN, stageClickHandler );
		}
		
		protected function stageClickHandler(event:MouseEvent):void
		{
			if (!( event.target is RightMenuItem ))
			{
				appStage.removeEventListener( MouseEvent.MOUSE_DOWN, stageClickHandler );
				removed();
			}
		}
		
		private function getItemByIndex(index:int):RightMenuItem
		{
			var item:RightMenuItem = _itemPool[index] as RightMenuItem;
			if ( item == null )
			{
				item = new RightMenuItem();
				item.y = item.height * index;
				_itemPool[ index ] = item;
			}
			return item;
		}
		
		
	}
}