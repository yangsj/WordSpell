package app.modules.fight.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class LetterBubbleVo
	{

		/**
		 * 字母出现的顺序( 0开始
		 */
		public var index:int;
		/**
		 * 字母id
		 */
		public var id:int;
		/**
		 * 字母
		 */
		public var letter:String;
		/**
		 * 道具类型
		 * @see app.modules.model.vo.ItemType
		 */
		public var itemType:int;
		
		/**
		 * 小写字母
		 */
		public function get lowerCase():String
		{
			return letter.toLocaleLowerCase();
		}
		
		/**
		 * 大写字母
		 */
		public function get upperCase():String
		{
			return letter.toLocaleUpperCase();
		}
		
	}
}