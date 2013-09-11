package app.modules.fight.prop
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class PropVo
	{
		public function PropVo()
		{
		}
		
		/**
		 * 道具名称
		 */
		public var name:String;
		/**
		 * 道具类型
		 */
		public var type:int;
		/**
		 * 道具数量
		 */
		public var number:int;
		/**
		 * 使用间隔时间
		 */
		public var intervalTime:String;
		/**
		 * 需要消耗的金币值（无可用道具时使用）
		 */
		public var contMoney:int;
		/**
		 * 道具的皮肤id
		 */
		public var skinId:String;
		
	}
}