package app.modules.model
{
	import app.events.GameEvent;
	import app.modules.model.vo.ItemVo;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class PackModel extends Actor
	{
		private var _hasPackItems:Boolean;
		private var _itemList:Vector.<ItemVo>;
		
		public function PackModel()
		{
			super();
		}
		
		/**
		 * 添加指定物品的数量
		 * @param itemId
		 * @param addNum
		 */
		public function addNum( itemId:int, addNum:int ):void
		{
			var index:int = getIndexById( itemId );
			if ( index != -1 )
			{
				var itemVo:ItemVo = itemList[ index ];
				itemVo.num += addNum;
				
				updateItems();
			}
		}
		
		/**
		 * 更新指定物品的数据
		 * @param itemVo
		 */
		public function updateItem( itemVo:ItemVo ):void
		{
			var index:int = getIndexById( itemVo.id );
			if ( index == -1 )
				itemList.push( itemVo );
			else itemList[ index ] = itemVo;
			
			updateItems();
		}
		
		/**
		 * 通过id获取指定物品在背包里的排序
		 * @param id
		 * @return 
		 */
		public function getIndexById( id:int ):int
		{
			var itemVo:ItemVo;
			for ( var key:String in itemList )
			{
				itemVo = itemList[key];
				if ( itemVo && itemVo.id == id )
					return int( key );
			}
			return -1;
		}
		
		private function updateItems():void
		{
			dispatch( new GameEvent( GameEvent.UPDATE_PACK_ITEMS ));
		}
		
		///////////// getters/setters 
		
		/**
		 * 物品列表数据
		 */
		public function get itemList():Vector.<ItemVo>
		{
			return _itemList ||= new Vector.<ItemVo>();
		}

		/**
		 * 是否获取过背包物品数据
		 */
		public function get hasPackItems():Boolean
		{
			return _hasPackItems;
		}

		/**
		 * @private
		 */
		public function set hasPackItems(value:Boolean):void
		{
			_hasPackItems = _hasPackItems ? true : value;
		}


	}
}