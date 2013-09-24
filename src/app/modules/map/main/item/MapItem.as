package app.modules.map.main.item
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import app.core.Tips;
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class MapItem extends MapItemBase
	{
		private var mapVo:MapVo;
		
		public function MapItem( skin:MovieClip )
		{
			super( skin );
		}
		
		override protected function onClickHandler(event:MouseEvent):void
		{
			if ( isOpen )
				skin.dispatchEvent( new MapEvent( MapEvent.OPEN_SELECTED_ROUND, mapVo, true ));
			else Tips.showMouse( "该章节地图未激活！" );
		}
		
		public function setAndUpdateData( mapVo:MapVo ):void
		{
			this.mapVo = mapVo;
			skin.gotoAndStop( isOpen ? FRAME_OPEN : FRAME_CLOSE );
		}
		
		/**
		 * 地图开启的
		 */
		public function get isOpen():Boolean
		{
			return mapVo.isOpen;
		}
		
		/**
		 * 地图未开启
		 */
		public function get isClose():Boolean
		{
			return !mapVo.isOpen;
		}
		
		
	}
}