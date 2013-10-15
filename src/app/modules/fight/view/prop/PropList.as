package app.modules.fight.view.prop
{
	import flash.display.Sprite;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemVo;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class PropList extends Sprite
	{
		private var vecItemSkin:Vector.<PropItem>;
		
		public function PropList()
		{
			super();
			
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
		
	}
}