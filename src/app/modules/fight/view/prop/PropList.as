package app.modules.fight.view.prop
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class PropList extends Sprite
	{
		private static var _itemPoints:Vector.<Point>;
		private static var _propIndex:Array;
		
		private var vecItemSkin:Vector.<PropItem>;
		
		public function PropList()
		{
			super();
			
			x = 645;
			y = 480;
			
			if ( _propIndex == null )
			{
				var key:int = 0;
				_propIndex = [];
				for ( var i:int = 0; i < 4; i++ )
				{
					key = [ItemType.EXTRA_TIME, ItemType.HINT, ItemType.BROOM, ItemType.SKIP][i];
					_propIndex[key] = i;
				}
			}
			
			createListItems();
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
				item.x = 80 * i;
				addChild( item );
				vecItemSkin[ i ] = item;
			}
		}
		
		public function setData( itemList:Vector.<ItemVo> ):void
		{
			var leng:int = itemList.length;
			var item:PropItem;
			var itemVo:ItemVo;
			for (var i:int = 0; i < 4; i++ )
			{
				itemVo = itemList[ i ];
				item = vecItemSkin[ _propIndex[itemVo.type] ];
				item.setData( itemVo );
			}
			
			if ( _itemPoints == null )
			{
				_itemPoints = new Vector.<Point>(10);
				for ( i = 0; i < numChildren; i++ )
				{
					var dis:PropItem = this.getChildAt( i ) as PropItem;
					if ( dis )
						_itemPoints[ dis.itemVo.type ] = dis.localToGlobal( new Point( dis.width >> 1, dis.height>> 1));
				}
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