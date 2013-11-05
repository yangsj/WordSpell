package app.modules.fight
{
	
	/**
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class FightType
	{
		public function FightType()
		{
		}
		
		/**
		 * 简单（难度）（闯关）
		 */
		public static const MODE_EASY:uint = 1;
		/**
		 * 进阶（难度）（闯关）
		 */
		public static const MODE_MIDDLE:uint = 2;
		/**
		 * 达人（难度）（闯关）
		 */
		public static const MODE_ADVANCED:uint = 3;
		
		/**
		 * 练习
		 */
		public static const MODE_PRACTICE:int = 4;
		
		/**
		 * 对战
		 */
		public static const MODE_BATTLE:int = 5;
		
		
		
		/**
		 * 字母最长长度
		 */
		public static const MAX_LENGTH:int = 20;
		
	}
}