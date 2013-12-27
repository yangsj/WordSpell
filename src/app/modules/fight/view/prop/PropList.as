package app.modules.fight.view.prop
{
	import flash.display.Sprite;
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
		
		public var posType:int = PropItem.POS_LEFT;
		public var isPracticeMode:Boolean = false;
		
		public function PropList()
		{
			super();
			
//			x = 645;
//			y = 480;
			
			if ( _propIndex == null )
			{
				var key:int = 0;
				_propIndex = [];
				for ( var i:int = 0; i < 4; i++ )
				{
					key = [ItemType.BROOM, ItemType.HINT, ItemType.SKIP, ItemType.EXTRA_TIME][i];
					_propIndex[key] = i;
				}
			}
			
			createListItems();
		}
		
		public function setForBattle():void
		{
			x = 469;
			y = 110;
			posType = PropItem.POS_LEFT;
			isPracticeMode = false;
		}
		
		public function setForAlone():void
		{
			x = 869.7;
			y = 110;
			posType = PropItem.POS_RIGHT;
			isPracticeMode = false;
		}
		
		public function setFroPractice():void
		{
			setForAlone();
			isPracticeMode = true;
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
				item.y = i * 81;
				item.setData( itemVo.clone() );
				if ( isPracticeMode ) 
				{
					item.enabled( itemVo.type == ItemType.SKIP );
				}
				else 
				{
					item.enabled( true );
				}
			}
			recordItempoints( posType );
		}
		
		private function recordItempoints( pos:int = PropItem.POS_LEFT ):void
		{
			if ( stage )
			{
				_itemPoints = new Vector.<Point>(10);
				for ( var i:int  = 0; i < numChildren; i++ )
				{
					var dis:PropItem = this.getChildAt( i ) as PropItem;
					if ( dis ) 
					{
						dis.setPosType( pos );
						_itemPoints[ dis.data.type ] = dis.localToGlobal( new Point( dis["bgArea"].width >> 1, dis["bgArea"].height>> 1));
					}
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
				if ( item.data && item.data.type == type )
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