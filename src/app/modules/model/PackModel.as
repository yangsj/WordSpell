package app.modules.model
{
	import app.modules.model.vo.ItemVo;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class PackModel extends Actor
	{
		public function PackModel()
		{
			super();
		}
		
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
		
		public function updateItem( itemVo:ItemVo ):void
		{
			var index:int = getIndexById( itemVo.id );
			if ( index == -1 )
				itemList.push( itemVo );
			else itemList[ index ] = itemVo;
			
			updateItems();
		}
		
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
			
		}
		
		///////////// getters/setters 
		
		private var _itemList:Vector.<ItemVo>;
		
		public function get itemList():Vector.<ItemVo>
		{
			return _itemList ||= new Vector.<ItemVo>();
		}

	}
}