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
		 * 开启状态（0未开启，1已开启）
		 */
		public var status:int;
		
		/**
		 * 关卡列表
		 */
		public var roundList:Vector.<ChapterVo>;

		/**
		 * 地图是否开启
		 */
		public function get isOpen():Boolean
		{
			return status == 1;
		}

		
	}
}