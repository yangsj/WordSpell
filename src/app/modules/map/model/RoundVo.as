package app.modules.map.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class RoundVo
	{
		public function RoundVo()
		{
		}
		
		/**
		 * 当前关所在的地图id
		 */
		public var mapId:int;
		/**
		 * 当前关卡id
		 */
		public var roundId:int;
		/**
		 * 当前关卡名称
		 */
		public var roundName:String;
		/**
		 * 星级评分
		 */
		public var starNum:int = 0;
		/**
		 * 是否开启
		 */
		public var isOpen:Boolean;
	}
}