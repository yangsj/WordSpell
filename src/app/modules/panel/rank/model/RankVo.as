package app.modules.panel.rank.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-25
	 */
	public class RankVo
	{
		public function RankVo()
		{
		}
		
		/**
		 * 类型：1=周|2=月|3=综合|4=财富|5=丰收
		 */
		public var type:int;
		
		/**
		 * 排名
		 */
		public var rank:int;
		/**
		 * 昵称
		 */
		public var name:String;
		/**
		 * 等级
		 */
		public var level:int;
		/**
		 * 有效期
		 */
		public var validity:String;
		/**
		 * 荣誉
		 */
		public var honor:String;
		
	}
}