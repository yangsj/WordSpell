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
		 * 章节列表
		 */
		public var chapterList:Vector.<ChapterVo>;

		/**
		 * 地图是否开启
		 */
		public function get isOpen():Boolean
		{
			return status == 1;
		}

		public function get mapName():String
		{
			return ["加拿大大熊湖","西澳大利亚沙漠","澳大利亚凯恩斯热带雨林","美国雷尼尔山","埃尔斯米尔岛","天空"][mapId];
		}
		
	}
}