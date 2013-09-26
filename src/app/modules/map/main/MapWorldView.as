package app.modules.map.main
{
	import flash.display.MovieClip;
	
	import app.modules.map.main.item.MapItem;
	import app.modules.map.model.MapVo;
	
	import victor.framework.core.BaseScene;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class MapWorldView extends BaseScene
	{
		private var mapListItem:Vector.<MapItem> = new Vector.<MapItem>();
		
		public var map0:MovieClip;
		public var map1:MovieClip;
		public var map2:MovieClip;
		public var map3:MovieClip;
		public var map4:MovieClip;
		public var map5:MovieClip;
		
		public function MapWorldView()
		{
			addedToStageHandler( null );
			
			initMapItem();
		}
		
		private function initMapItem():void
		{
			var tempList:Array = [ map0, map1, map2, map3, map4, map5 ];
			for ( var i:int = 0; i < 6; i++ )
				mapListItem.push( new MapItem( tempList[ i ] ));
		}
		
		public function setAndUpdateMap( list:Vector.<MapVo> ):void
		{
			if ( list )
			{
				for (var i:int = 0; i < list.length; i++ )
					mapListItem[i].setAndUpdateData( list[ i ] );
			}
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MainBackground";
		}
	}
}