package app.modules.map.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapVo
	{
		public function MapVo()
		{
		}
		
		/**
		 * 地图id
		 */
		public var mapId:int;
		/**
		 * 地图名称
		 */
		public var mapName:String;
		
		/**
		 * 地图是否开启
		 */
		public var isOpen:Boolean;
		
		/**
		 * 关卡列表
		 */
		public var roundList:Vector.<ChapterVo>;
		
		public function addRoundVo( roundVo:ChapterVo ):void
		{
			roundList ||= new Vector.<ChapterVo>();
			roundList.push( roundVo );
		}
		
	}
}