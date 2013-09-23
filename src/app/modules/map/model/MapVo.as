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
		 * 关卡列表
		 */
		public var roundList:Vector.<RoundVo>;
		
		public function addRoundVo( roundVo:RoundVo ):void
		{
			roundList ||= new Vector.<RoundVo>();
			roundList.push( roundVo );
		}
		
	}
}