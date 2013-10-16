package app.modules.fight.view.prop
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemVo;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class PropList extends Sprite
	{
		private static var _itemPoints:Vector.<Point>;
		
		private var vecItemSkin:Vector.<PropItem>;
		
		public function PropList()
		{
			super();
			
			createListItems();
			
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			if ( _itemPoints == null )
			{
				_itemPoints = new Vector.<Point>();
				for (var i:int = 0; i < numChildren; i++ )
				{
					var dis:DisplayObject = this.getChildAt( i );
					_itemPoints[ i ] = dis.localToGlobal( new Point( dis.width >> 1, dis.height>> 1));
				}
			}
		}
		
		public function clear():void
		{
			for each ( var item:PropItem in vecItemSkin )
			{
				if ( item ) item.clearTimeout();
			}
		}
		
		private function createListItems():void
		{
			var item:PropItem;
			vecItemSkin = new Vector.<PropItem>( 4 );
			for (var i:int = 0; i < 4; i++ )
			{
				item = new PropItem();
				item.x = 74 * i;
				addChild( item );
				vecItemSkin[ i ] = item;
			}
			
		}
		
		public function setData( itemList:Vector.<ItemVo> ):void
		{
			var leng:int = itemList.length;
			var item:PropItem;
			for (var i:int = 0; i < 4; i++ )
			{
				item = vecItemSkin[ i ];
				item.setData( itemList[ i ] );
			}
		}
		
		public function refreshItem( itemVo:ItemVo ):void
		{
			if ( itemVo )
			{
				var item:PropItem = getItemByType( itemVo.type );
				if ( item )
					item.update( itemVo );
			}
		}
		
		private function getItemByType( type:int ):PropItem
		{
			for each ( var item:PropItem in vecItemSkin )
			{
				if ( item.itemVo && item.itemVo.type == type )
				{
					return item;
				}
			}
			return null;
		}

		public static function get itemPoints():Vector.<Point>
		{
			return _itemPoints;
		}

		
	}
}