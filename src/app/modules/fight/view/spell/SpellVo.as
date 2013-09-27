package app.modules.fight.view.spell
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellVo
	{
		public function SpellVo()
		{
		}
		
		/**
		 * 中文释义
		 */
		public var chinese:String = "中文";
		
		/**
		 * 英文单词
		 */
		public var english:String = "english";
		
		/**
		 * 单词的字母列表
		 */
		public function get letters():Array
		{
			return english.split( "" );
		}
		
		/**
		 * 字符长度
		 */
		public function get charsLength():int
		{
			return letters.length;
		}
		
	}
}