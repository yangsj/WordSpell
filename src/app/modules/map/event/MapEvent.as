package app.modules.map.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapEvent extends BaseEvent
	{
		public function MapEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 打开指定章节的关卡选择
		 */
		public static const OPEN_SELECTED_ROUND:String = "open_selected_round";
		
		/**
		 * 更新地图数据
		 */
		public static const UPDATE_MAP_DATA:String = "update_map_data";
		
		/**
		 * 获取到地图章节的详细数据
		 */
		public static const CHAPTER_DETAIL:String = "chapter_detail";
		
		
	}
}